import express from 'express';
import supabase from '../config/supabaseSetup.js';

const router = express.Router();

// Ban a user (delete from auth and users table)
router.post('/ban-user', async (req, res) => {
    const { userId } = req.body;

    if (!userId) {
        return res.status(400).json({ error: 'User ID is required' });
    }

    try {
        // Extract the token from the Authorization header
        const authHeader = req.headers.authorization;
        const token = authHeader && authHeader.split(' ')[1];
        if (!token) {
            return res.status(401).json({ error: 'Authorization token required' });
        }

        // Get the current user using the token
        const { data: { user }, error: userError } = await supabase.auth.getUser(token);
        if (userError || !user) {
            return res.status(401).json({ error: 'Invalid token or user not found' });
        }

        // Fetch the user's role from the custom users table
        const { data: userData, error: roleError } = await supabase
            .from('users')
            .select('role')
            .eq('id', user.id)
            .single();
        if (roleError || !userData) {
            return res.status(403).json({ error: 'Unable to verify user role' });
        }

        // Check if the user is an Admin
        if (userData.role !== 'Admin') {
            return res.status(403).json({ error: 'Admin access required' });
        }

        // Step 1: Delete user from auth
        const { error: authError } = await supabase.auth.admin.deleteUser(userId);
        if (authError) throw authError;

        // Step 2: Delete user from users table
        const { error: dbError } = await supabase
            .from('users')
            .delete()
            .eq('id', userId);
        if (dbError) throw dbError;

        res.status(200).json({ message: 'User banned successfully' });
    } catch (error) {
        console.error('Ban user error:', error);
        res.status(500).json({ error: error.message || 'Internal server error' });
    }
});

export default router;