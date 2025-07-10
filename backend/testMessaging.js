// backend/testMessaging.js
import 'dotenv/config';
import { signup, login, getCurrentUser } from './services/auth.js';
import { sendMessage, subscribeToMessages } from './services/backend.js';

async function runMessagingTests() {
    try {
        // Use unique emails for each test run
        const timestamp = Date.now();
        const user1Email = `user1_${timestamp}@example.com`;
        const user2Email = `user2_${timestamp}@example.com`;

        // Signup or login user1
        console.log('Setting up user1...');
        try {
            await signup(user1Email, 'password123', 'Buyer', 'User One', 'Nairobi');
        } catch (error) {
            if (error.code === 'user_already_exists') {
                console.log('User1 already exists, logging in...');
            } else {
                throw error;
            }
        }
        await login(user1Email, 'password123');
        const user1 = await getCurrentUser();
        console.log('User1 authenticated:', user1);

        // Signup or login user2
        console.log('Setting up user2...');
        let user2;
        try {
            await signup(user2Email, 'password123', 'Farmer', 'User Two', 'Nairobi');
            await login(user2Email, 'password123');
            user2 = await getCurrentUser();
        } catch (error) {
            if (error.code === 'user_already_exists') {
                console.log('User2 already exists, logging in...');
                await login(user2Email, 'password123');
                user2 = await getCurrentUser();
            } else {
                throw error;
            }
        }
        console.log('User2 authenticated:', user2);

        // Test Send Message
        console.log('Testing sendMessage...');
        if (!user1.id || !user2.id) throw new Error('User IDs not available');
        const message = await sendMessage({
            sender_id: user1.id,
            receiver_id: user2.id,
            content: 'Hello, interested in your products!',
        });
        console.log('Sent message:', message);

        // Test Subscribe to Messages
        console.log('Testing subscribeToMessages...');
        const subscription = subscribeToMessages(user2.id, (newMessage) => {
            console.log('New message received:', newMessage);
        });
        console.log('Subscribed to messages');

        // Keep the script running to receive messages
        setTimeout(() => {}, 60000); // Wait 1 minute to receive messages
    } catch (error) {
        console.error('Test failed:', error);
    }
}

runMessagingTests();