import supabase from '../config/supabaseSetup.js';

// Verify JWT token and get user with custom role
const verifyToken = async (req) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        throw new Error('Unauthorized: No token provided');
    }
    const token = authHeader.split(' ')[1];
    const { data: { user }, error } = await supabase.auth.getUser(token);
    if (error) throw new Error('Unauthorized: Invalid token');

    // Query the users table to get the custom role
    const { data: userData, error: userError } = await supabase
        .from('users')
        .select('role')
        .eq('id', user.id)
        .single();
    if (userError || !userData) throw new Error('Unauthorized: User not found in database');

    return { ...user, role: userData.role };
};

// Create a review
async function createReview(req, res) {
    try {
        const user = await verifyToken(req);
        const { product_id, rating, comment } = req.body;

        if (user.role !== 'Buyer') {
            throw new Error('Unauthorized: Only buyers can create reviews');
        }

        if (!product_id || !rating || rating < 1 || rating > 5) {
            throw new Error('Invalid input: product_id and rating (1-5) are required');
        }

        const { data: orderExists } = await supabase
            .from('orders')
            .select('id')
            .eq('buyer_id', user.id)
            .eq('product_id', product_id)
            .eq('status', 'Delivered')
            .single();

        if (!orderExists) {
            throw new Error('Unauthorized: You can only review products you have purchased and received');
        }

        const { data: existingReview } = await supabase
            .from('reviews')
            .select('id')
            .eq('buyer_id', user.id)
            .eq('product_id', product_id)
            .single();

        if (existingReview) {
            throw new Error('You have already reviewed this product');
        }

        const { data, error } = await supabase
            .from('reviews')
            .insert({
                product_id,
                buyer_id: user.id,
                rating: Number(rating),
                comment: comment || '',
            })
            .select('*, buyer:users!buyer_id(name)')
            .single();
        if (error) throw error;

        const normalizedData = {
            id: data.id || '',
            product_id: data.product_id || '',
            buyer_id: data.buyer_id || '',
            rating: data.rating || 0,
            comment: data.comment || '',
            buyer_name: data.buyer?.name || 'Unknown',
            created_at: data.created_at || '',
        };

        res.status(201).json(normalizedData);
    } catch (error) {
        console.error('Create review error:', error);
        res.status(400).json({ error: error.message });
    }
}

// Get reviews for a product
async function getReviews(req, res) {
    try {
        const { product_id } = req.query;

        if (!product_id) {
            throw new Error('Product ID is required');
        }

        const { data, error } = await supabase
            .from('reviews')
            .select('*, buyer:users!buyer_id(name)')
            .eq('product_id', product_id)
            .order('created_at', { ascending: false });
        if (error) throw error;

        const normalizedData = data.map((review) => ({
            id: review.id || '',
            product_id: review.product_id || '',
            buyer_id: review.buyer_id || '',
            rating: review.rating || 0,
            comment: review.comment || '',
            buyer_name: review.buyer?.name || 'Unknown',
            created_at: review.created_at || '',
        }));

        res.json(normalizedData);
    } catch (error) {
        console.error('Get reviews error:', error);
        res.status(400).json({ error: error.message });
    }
}

export { createReview, getReviews };