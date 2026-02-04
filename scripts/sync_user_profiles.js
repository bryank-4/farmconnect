import fs from 'fs';
import path from 'path';
import pg from 'pg';
import { fileURLToPath } from 'url';

const { Client } = pg;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

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

const client = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false },
});

// User profile data from backup (matching the auth users we created)
const userProfiles = [
    {
        id: '20f2d46e-4a8e-4c11-b0b7-c4386cd7e92d',
        email: 'admin1@example.com',
        role: 'Admin',
        name: 'Admin User',
        location: 'Nairobi',
        phone_number: '+254700000000'
    },
    {
        id: 'c7e0ebfb-e2d7-4759-9a9f-7bd1e808ced2',
        email: 'mkulima3@example.com',
        role: 'Farmer',
        name: 'Mkulima Three',
        location: 'Kiambu',
        phone_number: '+254712000003'
    },
    {
        id: '75b9f51d-d709-40df-9be0-276c60692342',
        email: 'buyer1@example.com',
        role: 'Buyer',
        name: 'Buyer One',
        location: 'Nairobi',
        phone_number: '+254722000001'
    },
    {
        id: '3414523a-4dba-4314-a3ee-c7c3674dc963',
        email: 'kariukialfred68@gmail.com',
        role: 'Buyer',
        name: 'Alfred Kariuki',
        location: 'Nairobi',
        phone_number: '+254733000001'
    },
    {
        id: '59eff280-f6c7-4d91-9e61-c1283f1c432b',
        email: 'mshiru24@gmail.com',
        role: 'Buyer',
        name: 'Mshiru',
        location: 'Mombasa',
        phone_number: '+254744000001'
    },
    {
        id: 'e77050cf-481b-4adc-bc68-bd81d2775a8b',
        email: 'mkulima1@example.com',
        role: 'Farmer',
        name: 'Mkulima One',
        location: 'Nakuru',
        phone_number: '+254712000001'
    },
    {
        id: 'efb46ecb-4c08-4f0b-aad9-4a88b4a38d7c',
        email: 'buyer2@example.com',
        role: 'Buyer',
        name: 'Buyer Two',
        location: 'Kisumu',
        phone_number: '+254722000002'
    },
    {
        id: 'e839b936-ba33-4b9d-90b1-b08a74a5ea4d',
        email: 'mkulima2@example.com',
        role: 'Farmer',
        name: 'Mkulima Two',
        location: 'Eldoret',
        phone_number: '+254712000002'
    },
    {
        id: 'ad2c26db-54a7-4613-9bc0-0f349cecb7f9',
        email: 'bryankinyua4@gmail.com',
        role: 'Farmer',
        name: 'Bryan Kinyua',
        location: 'Nairobi',
        phone_number: '+254755000001'
    }
];

async function syncUserProfiles() {
    try {
        console.log('Connecting to database...');
        await client.connect();

        console.log('Syncing user profiles to public.users table...\n');

        let inserted = 0;
        let updated = 0;
        let skipped = 0;

        for (const user of userProfiles) {
            try {
                // Check if user already exists
                const checkResult = await client.query(
                    'SELECT id FROM public.users WHERE id = $1',
                    [user.id]
                );

                if (checkResult.rows.length > 0) {
                    // Update existing user
                    await client.query(
                        `UPDATE public.users 
                         SET email = $2, role = $3, name = $4, location = $5, phone_number = $6
                         WHERE id = $1`,
                        [user.id, user.email, user.role, user.name, user.location, user.phone_number]
                    );
                    console.log(`✓ Updated profile: ${user.email} (${user.role})`);
                    updated++;
                } else {
                    // Insert new user profile
                    await client.query(
                        `INSERT INTO public.users (id, email, role, name, location, phone_number, created_at)
                         VALUES ($1, $2, $3, $4, $5, $6, NOW())`,
                        [user.id, user.email, user.role, user.name, user.location, user.phone_number]
                    );
                    console.log(`✓ Inserted profile: ${user.email} (${user.role})`);
                    inserted++;
                }

            } catch (err) {
                console.error(`✗ Error processing ${user.email}:`, err.message);
                skipped++;
            }
        }

        console.log(`\n=== Summary ===`);
        console.log(`Inserted: ${inserted}`);
        console.log(`Updated: ${updated}`);
        console.log(`Skipped: ${skipped}`);
        console.log(`Total: ${userProfiles.length}`);

        if (inserted > 0 || updated > 0) {
            console.log(`\n✅ SUCCESS! User profiles synced.`);
            console.log('\nUsers can now login and access the app:');
            console.log('  Email: admin1@example.com');
            console.log('  Email: mkulima1@example.com');
            console.log('  Email: buyer1@example.com');
            console.log('  Password: TempPassword123!');
        }

    } catch (err) {
        console.error('Error syncing user profiles:', err);
    } finally {
        await client.end();
    }
}

syncUserProfiles();
