
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
// Using Session Pooler (port 6543)
const connectionString = `postgres://postgres.bwoplpubgeglssfwswbl:${encodedPassword}@aws-1-eu-west-1.pooler.supabase.com:6543/postgres`;

const client = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false },
});

async function restore() {
    try {
        console.log('Connecting to database...');
        await client.connect();

        console.log('Reading backup file...');
        const fileContent = fs.readFileSync(backupFile, 'utf8');
        const lines = fileContent.split(/\r?\n/);

        let currentStatement = '';
        let inCopyBlock = false;
        let copyTable = '';
        let copyColumns = '';

        console.log(`Total lines to process: ${lines.length}`);

        for (let i = 0; i < lines.length; i++) {
            const line = lines[i].trim(); // Be careful with trim inside COPY, but for logic check it's ok

            // 1. Handle COPY Block
            if (inCopyBlock) {
                if (line === '\\.') {
                    inCopyBlock = false;
                    console.log(`Finished COPY for ${copyTable}`);
                    continue;
                }

                if (copyTable.startsWith('auth.') || copyTable.startsWith('storage.') || copyTable.startsWith('vault.') || copyTable.startsWith('realtime.')) {
                    continue;
                }

                // Parse data line (original line, not trimmed)
                const dataLine = lines[i];
                if (!dataLine) continue;

                const values = dataLine.split('\t').map(val => {
                    if (val === '\\N') return 'NULL';
                    // Escape single quotes for SQL
                    return "'" + val.replace(/'/g, "''") + "'";
                });

                const insertSQL = `INSERT INTO ${copyTable} ${copyColumns} VALUES (${values.join(', ')});`;

                try {
                    await client.query(insertSQL);
                } catch (err) {
                    console.error(`Error inserting row into ${copyTable}:`, err.message); // Clean error log
                }
                continue;
            }

            // 2. Skip psql meta-commands and sensitive/invalid commands
            if (line.startsWith('\\')) continue;
            if (line.startsWith('--')) continue; // Comments
            if (!line) continue;

            // Skip Roles/Grants that might cause issues
            if (line.startsWith('CREATE ROLE')) continue;
            if (line.startsWith('ALTER ROLE')) continue;
            if (line.startsWith('GRANT ')) continue;
            if (line.startsWith('ALTER DEFAULT PRIVILEGES')) continue;

            // 3. Detect COPY start
            // Format: COPY public.carts (id, created_at, user_id, product_id, quantity) FROM stdin;
            if (line.startsWith('COPY ')) {
                const match = line.match(/COPY\s+(.+?)\s+(\(.+?\))\s+FROM stdin;/i);
                if (match) {
                    copyTable = match[1];
                    copyColumns = match[2];
                    inCopyBlock = true;
                    if (copyTable.startsWith('auth.') || copyTable.startsWith('storage.') || copyTable.startsWith('vault.') || copyTable.startsWith('realtime.')) {
                        console.log(`Skipping COPY for system table ${copyTable}`);
                        // We still need to consume the lines until \.
                        // But we can set a flag to ignore data
                        // However, my logic below just reads lines. 
                        // I need to handle "skipping" in the loop.
                        // Let's interpret inCopyBlock as "IN_COPY_BUT_SKIPPING" if needed?
                        // Or just continue?
                        // Actually, I need to look for \.
                    } else {
                        console.log(`Starting COPY for ${copyTable}...`);
                    }
                    continue;
                }
            }

            // 4. Accumulate standard SQL
            currentStatement += lines[i] + '\n';

            if (line.endsWith(';')) {
                // Execute statement
                // Some statements like functional definitions span multiple lines but end with ;
                // However, simplistic logic: $$ usually guards blocks.
                // If we are inside $$, we shouldn't execute on ;

                // Better Check:
                // Count $$ occurrences?
                const dollarCount = (currentStatement.match(/\$\$/g) || []).length;
                if (dollarCount % 2 !== 0) {
                    // Odd number of $$, means we are inside a block (or just started one)
                    continue;
                }

                try {
                    // Filter out SET commands if needed, or specific ones?
                    // For now, let's try executing everything else.
                    if (!currentStatement.trim().startsWith('SET ')) {
                        await client.query(currentStatement);
                    }
                } catch (err) {
                    // Log but continue?
                    if (err.code !== '42P07') { // Ignore "relation already exists"
                        console.warn('SQL Warning:', err.message.substring(0, 100));
                    }
                }
                currentStatement = '';
            }
        }

        console.log('Restoration completed.');
    } catch (err) {
        console.error('Fatal Error:', err);
    } finally {
        await client.end();
    }
}

restore();
