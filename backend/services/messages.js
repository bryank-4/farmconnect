import supabase from '../config/supabaseSetup.js';
import { Server } from 'http'; // For SSE (optional, install if using SSE)

// Create an admin Supabase client to bypass RLS
const adminSupabase = supabase;

const verifyToken = async (req) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        throw new Error('Unauthorized: No token provided');
    }
    const token = authHeader.split(' ')[1];
    const { data: { user }, error } = await adminSupabase.auth.getUser(token);
    if (error) {
        console.error('Token verification error:', error);
        throw new Error('Unauthorized: Invalid token');
    }
    console.log('Verified auth user:', user);

    // Use admin client to bypass RLS and fetch the role
    const { data: userData, error: userError } = await adminSupabase
        .from('users')
        .select('role')
        .eq('id', user.id)
        .single();
    if (userError || !userData) {
        console.error('User query error:', userError);
        console.error('Supabase client config:', {
            url: process.env.SUPABASE_URL,
            hasServiceKey: !!process.env.SUPABASE_SERVICE_ROLE_KEY,
        });
        throw new Error('User not found in database or RLS blocked access');
    }
    console.log('Database user role:', userData.role);

    return { ...user, role: userData.role };
};

// Send a message
async function sendMessage(req, res) {
    try {
        const user = await verifyToken(req);
        const { receiver_id, content, status = 'sent', product_id } = req.body;

        if (user.role !== 'Buyer' && user.role !== 'Farmer') {
            throw new Error('Unauthorized: Only buyers and farmers can send messages');
        }

        if (!receiver_id || !content || typeof content !== 'string' || content.trim().length === 0 || !product_id) {
            throw new Error('Invalid input: receiver_id, content, and product_id are required');
        }

        const { data: receiver, error: receiverError } = await adminSupabase
            .from('users')
            .select('id')
            .eq('id', receiver_id)
            .single();
        if (receiverError || !receiver) {
            console.error('Receiver query error:', receiverError);
            throw new Error('Receiver not found');
        }

        const { data: product, error: productError } = await adminSupabase
            .from('products')
            .select('id')
            .eq('id', product_id)
            .single();
        if (productError || !product) {
            console.error('Product query error:', productError);
            throw new Error('Product not found');
        }

        const { data, error } = await adminSupabase
            .from('messages')
            .insert({
                sender_id: user.id,
                receiver_id,
                content: content.trim(),
                status,
                product_id,
            })
            .select('*, sender:users!sender_id(name), receiver:users!receiver_id(name)')
            .single();
        if (error) {
            console.error('Message insert error:', error);
            throw error;
        }

        res.status(201).json(data);
    } catch (error) {
        console.error('Send message error:', error);
        res.status(400).json({ error: error.message });
    }
}

// Fetch messages between two users for a specific product and update status to "Delivered"
async function getMessages(req, res) {
    try {
        const user = await verifyToken(req);
        const { receiver_id, product_id } = req.query;

        if (!receiver_id || !product_id) {
            throw new Error('Receiver ID and Product ID are required');
        }

        // Fetch messages where:
        // (user sent to receiver OR receiver sent to user) AND product_id matches
        const { data, error } = await adminSupabase
            .from('messages')
            .select('*, sender:users!sender_id(name), receiver:users!receiver_id(name)')
            .or(
                `and(sender_id.eq.${user.id},receiver_id.eq.${receiver_id}),and(sender_id.eq.${receiver_id},receiver_id.eq.${user.id})`
            )
            .eq('product_id', product_id)
            .order('created_at', { ascending: true });
        if (error) {
            console.error('Fetch messages error:', error);
            throw error;
        }

        // Update status to "Delivered" for messages sent to the user (i.e., user is the receiver)
        const messagesToUpdate = data
            .filter((message) => message.receiver_id === user.id && message.status === 'sent' && message.product_id === product_id)
            .map((message) => message.id);

        if (messagesToUpdate.length > 0) {
            const { error: updateError } = await adminSupabase
                .from('messages')
                .update({ status: 'delivered' })
                .in('id', messagesToUpdate)
                .eq('product_id', product_id);
            if (updateError) {
                console.error('Update message status error:', updateError);
            }
        }

        const normalizedData = data.map((message) => ({
            id: message.id || '',
            sender_id: message.sender_id || '',
            receiver_id: message.receiver_id || '',
            content: message.content || '',
            sender_name: message.sender?.name || 'Unknown',
            receiver_name: message.receiver?.name || 'Unknown',
            created_at: message.created_at || '',
            status: message.status || 'sent',
            product_id: message.product_id || '',
        }));

        res.json(normalizedData);
    } catch (error) {
        console.error('Fetch messages error:', error);
        res.status(400).json({ error: error.message });
    }
}

// Mark messages as "Read"
async function markMessagesAsRead(req, res) {
    try {
        const user = await verifyToken(req);
        const { sender_id, product_id } = req.body;

        if (!sender_id || !product_id) {
            throw new Error('Sender ID and Product ID are required');
        }

        // Update status to "Read" for messages sent by sender_id to the user for the specific product
        const { data, error } = await adminSupabase
            .from('messages')
            .update({ status: 'read' })
            .eq('sender_id', sender_id)
            .eq('receiver_id', user.id)
            .eq('product_id', product_id)
            .in('status', ['sent', 'delivered']);
        if (error) {
            console.error('Mark messages as read error:', error);
            throw error;
        }

        res.status(200).json({ message: 'Messages marked as read' });
    } catch (error) {
        console.error('Mark messages as read error:', error);
        res.status(400).json({ error: error.message });
    }
}

// Fetch unread messages count and snippets for notifications
async function getUnreadMessages(req, res) {
    try {
        const user = await verifyToken(req);

        // Fetch messages where the user is the receiver and status is 'sent' or 'delivered'
        const { data, error } = await adminSupabase
            .from('messages')
            .select(`
                id,
                sender_id,
                content,
                created_at,
                status,
                product_id,
                sender:users!sender_id(name),
                products!product_id(name)
            `)
            .eq('receiver_id', user.id)
            .in('status', ['sent', 'delivered'])
            .order('created_at', { ascending: false });

        if (error) {
            console.error('Fetch unread messages error:', error);
            throw error;
        }

        // Group messages by sender and product for the notification snippets
        const groupedMessages = data.reduce((acc, message) => {
            const key = `${message.sender_id}_${message.product_id}`;
            if (!acc[key]) {
                acc[key] = {
                    sender_id: message.sender_id,
                    sender_name: message.sender?.name || 'Unknown',
                    product_id: message.product_id,
                    product_name: message.products?.name || 'Unknown Product',
                    latest_message: message.content,
                    created_at: message.created_at,
                    unread_count: 1,
                };
            } else {
                acc[key].unread_count += 1;
                // Update to the latest message
                if (new Date(message.created_at) > new Date(acc[key].created_at)) {
                    acc[key].latest_message = message.content;
                    acc[key].created_at = message.created_at;
                }
            }
            return acc;
        }, {});

        const notifications = Object.values(groupedMessages).map((notification) => ({
            sender_id: notification.sender_id,
            sender_name: notification.sender_name,
            product_id: notification.product_id,
            product_name: notification.product_name,
            message_snippet: notification.latest_message.length > 50
                ? `${notification.latest_message.substring(0, 47)}...`
                : notification.latest_message,
            created_at: notification.created_at,
            unread_count: notification.unread_count,
        }));

        const totalUnread = notifications.reduce((sum, notif) => sum + notif.unread_count, 0);

        res.json({
            total_unread: totalUnread,
            notifications: notifications,
        });
    } catch (error) {
        console.error('Fetch unread messages error:', error);
        res.status(400).json({ error: error.message });
    }
}

// Real-time message subscription using Server-Sent Events (optional)
async function subscribeToMessages(req, res) {
    res.setHeader('Content-Type', 'text/event-stream');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');

    const user = await verifyToken(req);
    const { receiver_id, product_id } = req.query;

    if (!receiver_id || !product_id) {
        res.status(400).send('Event: error\ndata: Receiver ID and Product ID are required\n\n');
        return res.end();
    }

    const channel = adminSupabase
        .channel(`messages_${user.id}_${receiver_id}_${product_id}`)
        .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'messages' }, (payload) => {
            if (
                ((payload.new.sender_id === user.id && payload.new.receiver_id === receiver_id) ||
                    (payload.new.receiver_id === user.id && payload.new.sender_id === receiver_id)) &&
                payload.new.product_id === product_id
            ) {
                const normalizedMessage = {
                    id: payload.new.id || '',
                    sender_id: payload.new.sender_id || '',
                    receiver_id: payload.new.receiver_id || '',
                    content: payload.new.content || '',
                    sender_name: payload.new.sender?.name || 'Unknown',
                    receiver_name: payload.new.receiver?.name || 'Unknown',
                    created_at: payload.new.created_at || '',
                    status: payload.new.status || 'sent',
                    product_id: payload.new.product_id || '',
                };
                res.write(`event: message\ndata: ${JSON.stringify(normalizedMessage)}\n\n`);
            }
        })
        .subscribe();

    req.on('close', () => {
        channel.unsubscribe();
        res.end();
    });
}

export { sendMessage, getMessages, markMessagesAsRead, getUnreadMessages, subscribeToMessages };