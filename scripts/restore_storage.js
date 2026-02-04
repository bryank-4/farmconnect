
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Configuration
const SUPABASE_URL = 'https://bwoplpubgeglssfwswbl.supabase.co';
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ3b3BscHViZ2VnbHNzZndzd2JsIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2OTYwMTIyMywiZXhwIjoyMDg1MTc3MjIzfQ.1sn8TZe8yvF0w71RPx83wR2Is-tikjYYWa9IYBoPOdY';
const BACKUP_DIR_NAME = 'nctitrjdmpxpbkntmbcd';

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

const backupPath = path.join(__dirname, '..', BACKUP_DIR_NAME);

async function restoreStorage() {
    console.log(`Scanning backup directory: ${backupPath}`);

    if (!fs.existsSync(backupPath)) {
        console.error('Backup directory not found!');
        return;
    }

    const items = fs.readdirSync(backupPath, { withFileTypes: true });

    for (const item of items) {
        if (item.isDirectory()) {
            const bucketName = item.name;
            console.log(`Processing bucket: ${bucketName}`);

            // Create bucket if not exists
            const { data: buckets, error: listError } = await supabase.storage.listBuckets();
            if (listError) console.error('Error listing buckets:', listError);

            const bucketExists = buckets?.find(b => b.name === bucketName);
            if (!bucketExists) {
                console.log(`Creating bucket ${bucketName}...`);
                const { error: createError } = await supabase.storage.createBucket(bucketName, { public: true });
                if (createError) console.error(`Error creating bucket ${bucketName}:`, createError);
            }

            await uploadDirectory(bucketName, path.join(backupPath, bucketName));
        }
    }
}

async function uploadDirectory(bucketName, dirPath, prefix = '') {
    const items = fs.readdirSync(dirPath, { withFileTypes: true });

    for (const item of items) {
        const fullPath = path.join(dirPath, item.name);
        const relativePath = prefix ? `${prefix}/${item.name}` : item.name;

        if (item.isDirectory()) {
            await uploadDirectory(bucketName, fullPath, relativePath);
        } else {
            console.log(`Uploading ${relativePath}...`);
            const fileContent = fs.readFileSync(fullPath);
            const { error } = await supabase.storage.from(bucketName).upload(relativePath, fileContent, {
                upsert: true,
                contentType: 'image/jpeg' // Defaulting to jpeg, Supabase might auto-detect
            });

            if (error) console.error(`Failed to upload ${relativePath}:`, error);
        }
    }
}

restoreStorage().catch(console.error);
