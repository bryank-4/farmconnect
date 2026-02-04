
import fs from 'fs';
import path from 'path';
import pg from 'pg';
import { fileURLToPath } from 'url';

const { Client } = pg;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const backupFile = path.join(__dirname, '..', 'backup.sql');
const authFile = path.join(__dirname, '..', 'temp_auth.txt');
let password;
try {
    password = fs.readFileSync(authFile, 'utf8').trim();
} catch (e) {
    console.error('Could not read temp_auth.txt');
    process.exit(1);
}

const encodedPassword = encodeURIComponent(password);
const connectionString = `postgres://postgres.bwoplpubgeglssfwswbl:${encodedPassword}@aws-0-eu-west-1.pooler.supabase.com:6543/postgres`;

const client = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false },
});

async function restore() {
    try {
        console.log('Connecting to database...');
        await client.connect();

        console.log('Reading backup file...');
        const sql = fs.readFileSync(backupFile, 'utf8');

        console.log('Executing backup SQL...');
        await client.query(sql);

        console.log('Restoration completed successfully.');
    } catch (err) {
        console.error('Error during restoration:', err);
    } finally {
        await client.end();
    }
}

restore();
