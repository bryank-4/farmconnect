import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
    auth: {
        autoRefreshToken: false,
        persistSession: false
    }
});

async function resetPassword() {
    try {
        const testEmail = 'admin1@example.com';
        const newPassword = 'TempPassword123!';

        console.log(`Resetting password for: ${testEmail}\n`);

        // Get user by email
        const { data: { users }, error: listError } = await supabase.auth.admin.listUsers();

        if (listError) {
            console.error('Error listing users:', listError.message);
            return;
        }

        const user = users.find(u => u.email === testEmail);

        if (!user) {
            console.error(`User not found: ${testEmail}`);
            return;
        }

        console.log(`Found user: ${user.email}`);
        console.log(`User ID: ${user.id}`);
        console.log(`Email confirmed: ${user.email_confirmed_at ? 'Yes' : 'No'}\n`);

        // Reset password
        const { data, error } = await supabase.auth.admin.updateUserById(
            user.id,
            { password: newPassword }
        );

        if (error) {
            console.error(`Error resetting password: ${error.message}`);
        } else {
            console.log(`✓ Password reset successful!`);
            console.log(`\nLogin credentials:`);
            console.log(`Email: ${testEmail}`);
            console.log(`Password: ${newPassword}`);

            // Test login
            console.log(`\n--- Testing Login ---`);
            const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
                email: testEmail,
                password: newPassword
            });

            if (signInError) {
                console.error(`✗ Login test failed: ${signInError.message}`);
            } else {
                console.log(`✓ Login test successful!`);
            }
        }

    } catch (err) {
        console.error('Error:', err.message);
    }
}

resetPassword();
