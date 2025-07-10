import 'dotenv/config';
import { initiateMpesaPayment } from './services/mpesa.js';

async function runMpesaTest() {
    try {
        console.log('Testing M-Pesa payment...');
        const result = await initiateMpesaPayment({
            phoneNumber: '254704186096', // Safaricom sandbox test number
            amount: 1, // Minimum amount in KES
            orderIds: 'ORDER-001', // Pass as string or array
        });
        console.log('M-Pesa response:', result);
    } catch (error) {
        console.error('M-Pesa test failed:', error);
    }
}

runMpesaTest();