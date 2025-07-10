// backend/services/orders.js
import supabase from '../config/supabaseSetup.js';

// Verify JWT token and get user
const verifyToken = async (req) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        throw new Error('Unauthorized: No token provided');
    }
    const token = authHeader.split(' ')[1];
    const { data: { user }, error } = await supabase.auth.getUser(token);
    if (error) throw new Error('Unauthorized: Invalid token');
    return user;
};

// Input validation for billing details
const validateBillingDetails = (billingDetails) => {
    const requiredFields = ['fullName', 'location', 'townCity', 'phoneNumber', 'email'];
    for (const field of requiredFields) {
        if (!billingDetails[field]) {
            throw new Error(`Missing billing detail: ${field}`);
        }
    }
    if (!/^\+254\d{9}$/.test(billingDetails.phoneNumber)) {
        throw new Error('Invalid phone number format. Use +254 followed by 9 digits.');
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(billingDetails.email)) {
        throw new Error('Invalid email format.');
    }
};

// Create order from cart
async function createOrder(req, res) {
    try {
        const user = await verifyToken(req);
        const { items, billingDetails } = req.body;

        if (!items || !Array.isArray(items) || items.length === 0) {
            throw new Error('Invalid cart items');
        }

        validateBillingDetails(billingDetails);

        // Verify product availability and stock
        const productIds = items.map(item => item.product_id);
        const { data: products, error: productError } = await supabase
            .from('products')
            .select('id, stock, farmer_id, price')
            .in('id', productIds);
        if (productError) throw productError;

        for (const item of items) {
            const product = products.find(p => p.id === item.product_id);
            if (!product) throw new Error(`Product not found: ${item.product_id}`);
            if (product.stock < item.quantity) throw new Error(`Insufficient stock for product: ${item.product_id}`);
            item.farmer_id = product.farmer_id; // Ensure farmer_id is set
            // Calculate order amount for each item
            item.order_amount = product.price * item.quantity;
        }

        const orderPromises = items.map(item =>
            supabase.from('orders').insert({
                buyer_id: user.id,
                farmer_id: item.farmer_id,
                product_id: item.product_id,
                quantity: item.quantity,
                status: 'Pending',
                billing_details: {
                    ...billingDetails,
                    order_amount: item.order_amount
                }
            }).select()
        );

        const results = await Promise.all(orderPromises);
        const errors = results.filter(result => result.error).map(result => result.error);
        if (errors.length > 0) throw errors[0];

        const orderIds = results.map(result => result.data[0].id);

        // Update stock
        const stockUpdates = items.map(item => {
            const product = products.find(p => p.id === item.product_id);
            return supabase
                .from('products')
                .update({ stock: product.stock - item.quantity })
                .eq('id', item.product_id);
        });
        await Promise.all(stockUpdates);

        res.status(201).json({ orderIds, message: 'Orders created successfully' });
    } catch (error) {
        console.error('Create order error:', error);
        res.status(400).json({ error: error.message });
    }
}

// Get all orders for a buyer or farmer
async function getOrders(req, res) {
    try {
        const user = await verifyToken(req);
        const { buyer_id, farmer_id } = req.query;

        let query = supabase.from('orders').select('*, products(name, price, category, farmer_id), buyer:users!buyer_id(name), farmer:users!farmer_id(name)');

        if (buyer_id && user.id === buyer_id) {
            query = query.eq('buyer_id', buyer_id);
        } else if (farmer_id && user.id === farmer_id) {
            query = query.eq('farmer_id', farmer_id);
        } else {
            throw new Error('Unauthorized: Can only fetch your own orders');
        }

        const { data, error } = await query;
        if (error) throw error;

        const normalizedData = data.map((order) => ({
            id: order.id || '',
            buyer_id: order.buyer_id || '',
            farmer_id: order.farmer_id || '',
            product_id: order.product_id || '',
            quantity: order.quantity || 0,
            status: order.status || 'Pending',
            product: {
                name: order.products?.name || '',
                price: order.products?.price || 0,
                category: order.products?.category || '',
                farmer_id: order.products?.farmer_id || '',
            },
            buyer_name: order.buyer?.name || 'Unknown',
            farmer_name: order.farmer?.name || 'Unknown',
            billing_details: order.billing_details || {},
        }));

        res.json(normalizedData);
    } catch (error) {
        console.error('Get orders error:', error);
        res.status(400).json({ error: error.message });
    }
}

// Update an order (e.g., change status or cancel)
async function updateOrder(req, res) {
    try {
        const user = await verifyToken(req);
        const { id } = req.params;
        const { status } = req.body;

        if (!['Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled'].includes(status)) {
            throw new Error('Invalid status value');
        }

        const { data: order, error: fetchError } = await supabase
            .from('orders')
            .select('buyer_id, farmer_id, status')
            .eq('id', id)
            .single();
        if (fetchError) throw fetchError;

        if (user.id !== order.buyer_id && user.id !== order.farmer_id) {
            throw new Error('Unauthorized: Can only update your own orders');
        }

        if (order.status === 'Delivered' || order.status === 'Cancelled') {
            throw new Error('Cannot update an order that is already Delivered or Cancelled');
        }

        if (user.id === order.buyer_id) {
            if (status === 'Cancelled' && order.status !== 'Pending') {
                throw new Error('Unauthorized: Buyers can only cancel orders when status is Pending');
            }
            if (status === 'Delivered' && order.status !== 'Shipped') {
                throw new Error('Unauthorized: Buyers can only mark orders as Delivered when status is Shipped');
            }
        } else if (user.id === order.farmer_id) {
            if (status !== 'Shipped' || order.status !== 'Confirmed') {
                throw new Error('Unauthorized: Farmers can only mark orders as Shipped when status is Confirmed');
            }
        }

        const { data, error } = await supabase
            .from('orders')
            .update({ status })
            .eq('id', id)
            .select()
            .single();
        if (error) throw error;

        res.status(200).json(data);
    } catch (error) {
        console.error('Update order error:', error);
        res.status(400).json({ error: error.message });
    }
}

export { createOrder, getOrders, updateOrder };