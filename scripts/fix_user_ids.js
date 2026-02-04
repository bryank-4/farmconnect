import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';
import pg from 'pg';
import { fileURLToPath } from 'url';

const { Client } = pg;

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

// Database client
const authFile = path.join(__dirname, '..', 'temp_auth.txt');
let password;
try {
    password = fs.readFileSync(authFile, 'utf8').trim();
} catch (e) {
    console.error('Could not read temp_auth.txt');
    process.exit(1);
}

const encodedPassword = encodeURIComponent(password);
const connectionString = `postgres://postgres.bwoplpubgeglssfwswbl:${encodedPassword}@aws-1-eu-west-1.pooler.supabase.com:6543/postgres`;

const dbClient = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false },
});

const userEmails = [
    'admin1@example.com',
    'mkulima3@example.com',
    'buyer1@example.com',
    'kariukialfred68@gmail.com',
    'mshiru24@gmail.com',
    'mkulima1@example.com',
    'buyer2@example.com',
    'mkulima2@example.com',
    'bryankinyua4@gmail.com'
];

async function fixUserIdMismatch() {
    try {
        console.log('Connecting to database...');
        await dbClient.connect();

        console.log('Checking user ID mismatches...\n');

        let fixed = 0;
        let errors = 0;

        for (const email of userEmails) {
            try {
                // Get the actual auth user ID from Supabase
                const { data: { users }, error: listError } = await supabase.auth.admin.listUsers();

                if (listError) {
                    console.error(`Error listing users:`, listError.message);
                    continue;
                }

                const authUser = users.find(u => u.email === email);

                if (!authUser) {
                    console.log(`⚠️  Auth user not found: ${email}`);
                    continue;
                }

                // Check if public.users has this user with correct ID
                const checkResult = await dbClient.query(
                    'SELECT id FROM public.users WHERE email = $1',
                    [email]
                );

                if (checkResult.rows.length === 0) {
                    console.log(`⚠️  No profile found for: ${email}`);
                    continue;
                }

                const publicUserId = checkResult.rows[0].id;

                if (publicUserId === authUser.id) {
                    console.log(`✓ IDs match for ${email}`);
                } else {
                    console.log(`🔧 Fixing ID mismatch for ${email}`);
                    console.log(`   Auth ID: ${authUser.id}`);
                    console.log(`   Public ID: ${publicUserId}`);

                    // Update the public.users ID to match auth ID
                    await dbClient.query(
                        'UPDATE public.users SET id = $1 WHERE email = $2',
                        [authUser.id, email]
                    );

                    console.log(`   ✓ Updated to: ${authUser.id}`);
                    fixed++;
                }

            } catch (err) {
                console.error(`✗ Error processing ${email}:`, err.message);
                errors++;
            }
        }

        console.log(`\n=== Summary ===`);
        console.log(`Fixed: ${fixed}`);
        console.log(`Errors: ${errors}`);
        console.log(`Total checked: ${userEmails.length}`);

        if (fixed > 0) {
            console.log(`\n✅ User IDs synchronized! Try logging in again.`);
        }

    } catch (err) {
        console.error('Error:', err);
    } finally {
        await dbClient.end();
    }
}

fixUserIdMismatch();
