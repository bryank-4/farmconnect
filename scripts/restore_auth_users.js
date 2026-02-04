import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
    console.error('Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env');
    process.exit(1);
}

// Create Supabase Admin client
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
    auth: {
        autoRefreshToken: false,
        persistSession: false
    }
});

// Parse auth.users data from backup file
function parseAuthUsers() {
    const backupFile = path.join(__dirname, '..', 'backup.sql');
    const content = fs.readFileSync(backupFile, 'utf8');
    const lines = content.split('\n');

    let inCopyBlock = false;
    const users = [];

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];

        // Find the COPY auth.users line
        if (line.startsWith('COPY auth.users')) {
            inCopyBlock = true;
            console.log('Found auth.users COPY block at line', i + 1);
            continue;
        }

        // End of COPY block
        if (inCopyBlock && line === '\\.') {
            console.log('End of auth.users COPY block');
            break;
        }

        // Parse user data
        if (inCopyBlock && line.trim()) {
            const parts = line.split('\t');
            if (parts.length >= 34) {
                const user = {
                    id: parts[1],
                    email: parts[4],
                    encrypted_password: parts[5],
                    email_confirmed_at: parts[6] === '\\N' ? null : parts[6],
                    created_at: parts[19],
                    updated_at: parts[20],
                    raw_app_meta_data: parts[16],
                    raw_user_meta_data: parts[17]
                };

                // Only add users with valid email and password
                if (user.email && user.encrypted_password && user.encrypted_password !== '\\N') {
                    users.push(user);
                }
            }
        }
    }

    return users;
}

async function restoreAuthUsers() {
    try {
        console.log('Parsing auth.users from backup...');
        const users = parseAuthUsers();

        console.log(`\nFound ${users.length} users to restore`);
        console.log('\nUsers found:');
        users.forEach((user, idx) => {
            console.log(`${idx + 1}. ${user.email} (ID: ${user.id})`);
        });

        console.log('\n⚠️  IMPORTANT: Password hashes cannot be directly imported.');
        console.log('The Supabase Admin API does not support importing encrypted_password hashes.');
        console.log('\nYou have two options:\n');
        console.log('Option 1: Ask users to use "Forgot Password" to reset their passwords');
        console.log('Option 2: Create users with a temporary password (e.g., "TempPass123!") and notify them to change it\n');

        // For demonstration, let's create users with a temporary password
        const TEMP_PASSWORD = 'TempPassword123!';

        console.log(`\nDo you want to create these users with temporary password: "${TEMP_PASSWORD}"?`);
        console.log('(They will need to change it on first login)\n');

        // Create users using Admin API
        let created = 0;
        let skipped = 0;

        for (const user of users) {
            try {
                // Check if user already exists
                const { data: existingUser } = await supabase.auth.admin.getUserById(user.id);

                if (existingUser) {
                    console.log(`✓ User ${user.email} already exists, skipping`);
                    skipped++;
                    continue;
                }

                // Create user with Admin API
                const { data, error } = await supabase.auth.admin.createUser({
                    email: user.email,
                    password: TEMP_PASSWORD,
                    email_confirm: true, // Auto-confirm email
                    user_metadata: user.raw_user_meta_data ? JSON.parse(user.raw_user_meta_data) : {}
                });

                if (error) {
                    console.error(`✗ Failed to create ${user.email}:`, error.message);
                } else {
                    console.log(`✓ Created user: ${user.email}`);
                    created++;
                }

            } catch (err) {
                console.error(`✗ Error processing ${user.email}:`, err.message);
            }
        }

        console.log(`\n=== Summary ===`);
        console.log(`Created: ${created}`);
        console.log(`Skipped (already exist): ${skipped}`);
        console.log(`Total: ${users.length}`);

        if (created > 0) {
            console.log(`\n⚠️  IMPORTANT: All created users have the temporary password: "${TEMP_PASSWORD}"`);
            console.log('They should change it immediately after logging in.');
        }

    } catch (err) {
        console.error('Error restoring auth users:', err);
    }
}

restoreAuthUsers();
