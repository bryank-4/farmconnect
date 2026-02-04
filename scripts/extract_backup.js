
import fs from 'fs';
import zlib from 'zlib';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const inputFile = path.join(__dirname, '..', 'db_cluster-25-08-2025@00-59-41.backup.gz');
const outputFile = path.join(__dirname, '..', 'backup.sql');

console.log(`Extracting ${inputFile} to ${outputFile}...`);

const fileContents = fs.createReadStream(inputFile);
const writeStream = fs.createWriteStream(outputFile);
const unzip = zlib.createGunzip();

fileContents.pipe(unzip).pipe(writeStream).on('finish', () => {
    console.log('Extraction complete.');
});
