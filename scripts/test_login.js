import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
    console.error('Missing credentials');
    process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
    auth: {
        autoRefreshToken: false,
        persistSession: false
    }
});

async function checkUsers() {
    try {
        console.log('Fetching all auth users...\n');

        const { data: { users }, error } = await supabase.auth.admin.listUsers();

        if (error) {
            console.error('Error:', error.message);
            return;
        }

        console.log(`Found ${users.length} users in auth system:\n`);

        const targetEmails = [
            'admin1@example.com',
            'mkulima1@example.com',
            'buyer1@example.com'
        ];

        for (const email of targetEmails) {
            const user = users.find(u => u.email?.toLowerCase() === email.toLowerCase());
            if (user) {
                console.log(`✓ ${email}`);
                console.log(`  ID: ${user.id}`);
                console.log(`  Email confirmed: ${user.email_confirmed_at ? 'Yes' : 'No'}`);
                console.log(`  Created: ${user.created_at}`);
                console.log('');
            } else {
                console.log(`✗ ${email} - NOT FOUND`);
                console.log('');
            }
        }

        // Try to sign in with one user
        console.log('\n--- Testing Login ---');
        const testEmail = 'admin1@example.com';
        const testPassword = 'TempPassword123!';

        console.log(`Attempting login: ${testEmail}`);

        const { data, error: signInError } = await supabase.auth.signInWithPassword({
            email: testEmail,
            password: testPassword
        });

        if (signInError) {
            console.error(`✗ Login failed: ${signInError.message}`);
            console.error(`  Error code: ${signInError.status}`);
        } else {
            console.log(`✓ Login successful!`);
            console.log(`  User ID: ${data.user?.id}`);
        }

    } catch (err) {
        console.error('Error:', err.message);
    }
}

checkUsers();
