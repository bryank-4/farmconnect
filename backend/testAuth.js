// backend/testAuth.js
import 'dotenv/config';
import { signup, login, getCurrentUser, logout } from './services/auth.js';

async function runAuthTests() {
    try {
        // Test Signup
        console.log('Testing signup...');
        const signupResult = await signup('test@example.com', 'password123', 'Buyer', 'Test User', 'Nairobi');
        console.log('Signup result:', signupResult);

        // Test Login
        console.log('Testing login...');
        const loginResult = await login('test@example.com', 'password123');
        console.log('Login result:', loginResult);

        // Test Get Current User
        console.log('Testing getCurrentUser...');
        const user = await getCurrentUser();
        console.log('Current user:', user);

        // Test Logout
        console.log('Testing logout...');
        await logout();
        console.log('Logout successful');
    } catch (error) {
        console.error('Test failed:', error);
    }
}

runAuthTests();