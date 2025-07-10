import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import rateLimit from 'express-rate-limit';
import {
    createProduct,
    getProducts,
    updateProduct,
    deleteProduct,
} from './backend/services/backend.js';
import { signup, login, getCurrentUser, logout, resetPassword } from './backend/services/auth.js';
import { getOrders, updateOrder, createOrder } from './backend/services/orders.js';
import { createReview, getReviews } from './backend/services/reviews.js';
import { sendMessage, getMessages, markMessagesAsRead, getUnreadMessages, subscribeToMessages } from './backend/services/messages.js';
import { initiateMpesaPayment } from './backend/services/mpesa.js';
import adminRouter from './backend/routes/admin.js';

dotenv.config();
const app = express();

// Rate limiting
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    limit: 1000, // Requests per windowMs
    message: 'Too many requests from this IP, please try again later.',
    standardHeaders: true,
    legacyHeaders: false,
});
app.use(limiter);

// Enable CORS with specific options
app.use(cors({
    origin: 'http://localhost:3000', // Explicitly allow the frontend origin
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'], // Allow necessary methods
    allowedHeaders: ['Content-Type', 'Authorization'], // Allow necessary headers
}));

app.use(express.json());

// Routes
app.post('/api/auth/signup', async (req, res) => {
    const { email, password, role, name, location } = req.body;
    try {
        const data = await signup(email, password, role, name, location);
        res.status(201).json(data);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

app.post('/api/auth/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        const data = await login(email, password);
        res.json(data);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

app.get('/api/auth/user', async (req, res) => {
    try {
        const user = await getCurrentUser();
        res.json(user);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

app.post('/api/auth/logout', async (req, res) => {
    try {
        await logout();
        res.status(204).send();
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

app.post('/api/auth/reset-password', async (req, res) => {
    const { email, redirectTo } = req.body;
    try {
        await resetPassword(email, redirectTo);
        res.status(200).json({ message: 'Password reset email sent successfully.' });
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

app.post('/api/products', createProduct);
app.get('/api/products', getProducts);
app.put('/api/products/:id', updateProduct);
app.delete('/api/products/:id', deleteProduct);

app.post('/api/orders', createOrder);
app.get('/api/orders', getOrders);
app.put('/api/orders/:id', updateOrder);

app.post('/api/reviews', createReview);
app.get('/api/reviews', getReviews);

app.post('/api/messages', sendMessage);
app.get('/api/messages', getMessages);
app.post('/api/messages/mark-read', markMessagesAsRead);
app.get('/api/messages/unread', getUnreadMessages);
app.get('/api/messages/subscribe', subscribeToMessages);

app.post('/api/initiate-mpesa-payment', async (req, res) => {
    try {
        const { phoneNumber, amount, orderIds } = req.body;
        const result = await initiateMpesaPayment({ phoneNumber, amount, orderIds });
        res.json(result);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.use('/api/admin', adminRouter);

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));