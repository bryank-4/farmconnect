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

const OLD_PROJECT = 'nctitrjdmpxpbkntmbcd';
const NEW_PROJECT = 'bwoplpubgeglssfwswbl';

async function updateImageUrls() {
    try {
        console.log('Connecting to database...');
        await client.connect();

        console.log('Fetching products with images...');
        const result = await client.query(`
            SELECT id, images 
            FROM public.products 
            WHERE images IS NOT NULL 
            AND images::text LIKE '%${OLD_PROJECT}%'
        `);

        console.log(`Found ${result.rows.length} products with old image URLs`);

        let updated = 0;
        for (const row of result.rows) {
            // images is already a JSON array from PostgreSQL
            const oldImages = row.images;

            // Convert to string, replace URLs
            let imagesStr = JSON.stringify(oldImages);
            imagesStr = imagesStr.replace(
                new RegExp(OLD_PROJECT, 'g'),
                NEW_PROJECT
            );

            // Update the row - pass as string and cast to jsonb
            await client.query(
                'UPDATE public.products SET images = $1::jsonb WHERE id = $2',
                [imagesStr, row.id]
            );

            updated++;
            console.log(`Updated product ${row.id} (${updated}/${result.rows.length})`);
        }

        console.log(`\nSuccessfully updated ${updated} products!`);
        console.log(`Old URL: https://${OLD_PROJECT}.supabase.co`);
        console.log(`New URL: https://${NEW_PROJECT}.supabase.co`);

    } catch (err) {
        console.error('Error updating image URLs:', err);
    } finally {
        await client.end();
    }
}

updateImageUrls();
