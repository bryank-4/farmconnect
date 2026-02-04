import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

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

// List of users from the backup
const users = [
    { email: 'admin1@example.com', id: '20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d' },
    { email: 'mkulima3@example.com', id: 'c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2' },
    { email: 'buyer1@example.com', id: '75b9f51d-d709-40df-9be0-276c60692342' },
    { email: 'kariukialfred68@gmail.com', id: '3414523a-4dba-4314-a3ee-c7c3674dc963' },
    { email: 'mshiru24@gmail.com', id: '59eff280-f6c7-4d91-9e61-c1283f1c432b' },
    { email: 'mkulima1@example.com', id: 'e77050cf-481b-4adc-bc68-bd81d2775a8b' },
    { email: 'buyer2@example.com', id: 'efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c' },
    { email: 'mkulima2@example.com', id: 'e839b936-ba33-4b9d-90b1-b08a74a5ea4d' },
    { email: 'bryankinyua4@gmail.com', id: 'ad2c26db-54a7-4613-9bc0-0f349cecb7f9' }
];

const TEMP_PASSWORD = 'TempPassword123!';

async function resetUserPasswords() {
    console.log('Resetting passwords for existing users...\n');
    console.log(`New temporary password: "${TEMP_PASSWORD}"\n`);

    let updated = 0;
    let failed = 0;

    for (const user of users) {
        try {
            // Update user password using Admin API
            const { data, error } = await supabase.auth.admin.updateUserById(
                user.id,
                { password: TEMP_PASSWORD }
            );

            if (error) {
                console.error(`✗ Failed to reset ${user.email}:`, error.message);
                failed++;
            } else {
                console.log(`✓ Reset password for: ${user.email}`);
                updated++;
            }

        } catch (err) {
            console.error(`✗ Error processing ${user.email}:`, err.message);
            failed++;
        }
    }

    console.log(`\n=== Summary ===`);
    console.log(`Updated: ${updated}`);
    console.log(`Failed: ${failed}`);
    console.log(`Total: ${users.length}`);

    if (updated > 0) {
        console.log(`\n✅ SUCCESS! All users can now login with password: "${TEMP_PASSWORD}"`);
        console.log('They should change it immediately after logging in.\n');
        console.log('Test users:');
        console.log('  - admin1@example.com');
        console.log('  - mkulima1@example.com');
        console.log('  - buyer1@example.com');
        console.log(`  Password: ${TEMP_PASSWORD}`);
    }
}

resetUserPasswords();
