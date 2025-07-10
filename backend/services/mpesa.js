import 'dotenv/config';
import axios from 'axios';

async function initiateMpesaPayment({ phoneNumber, amount, orderIds }) {
    const consumerKey = process.env.MPESA_CONSUMER_KEY;
    const consumerSecret = process.env.MPESA_CONSUMER_SECRET;
    const shortCode = process.env.MPESA_SHORT_CODE || '174379'; // Sandbox default
    const passkey = process.env.MPESA_PASSKEY || 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'; // Sandbox default

    // Get OAuth token
    const { data: { access_token } } = await axios.get(
        'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials',
        {
            auth: {
                username: consumerKey,
                password: consumerSecret,
            },
        }
    );

    // Initiate STK Push
    const timestamp = new Date().toISOString().replace(/[^0-9]/g, '').slice(0, 14);
    const password = Buffer.from(`${shortCode}${passkey}${timestamp}`).toString('base64');
    const accountReference = Array.isArray(orderIds) ? orderIds.join('-') : orderIds || 'ORDER-001'; // Handle string or array

    const { data } = await axios.post(
        'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest',
        {
            BusinessShortCode: shortCode,
            Password: password,
            Timestamp: timestamp,
            TransactionType: 'CustomerPayBillOnline',
            Amount: amount,
            PartyA: phoneNumber,
            PartyB: shortCode,
            PhoneNumber: phoneNumber,
            CallBackURL: 'https://nctitrjdmpxpbkntmbcd.supabase.co/functions/v1/mpesa-callback',
            AccountReference: accountReference,
            TransactionDesc: 'Payment for cart items',
        },
        {
            headers: {
                Authorization: `Bearer ${access_token}`,
            },
        }
    );

    return data;
}

export { initiateMpesaPayment };