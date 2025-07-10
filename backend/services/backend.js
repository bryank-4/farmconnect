// backend/services/backend.js
import supabase from '../config/supabaseSetup.js';
import multer from 'multer';
import { v4 as uuidv4 } from 'uuid';

// Configure multer for memory storage
const storage = multer.memoryStorage(); // Use memoryStorage instead of diskStorage
const upload = multer({ storage });

// Middleware to handle single image upload
const uploadMiddleware = upload.single('image');

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

async function handleImageUpload(file, farmer_id) {
    if (!file) return null;
    const fileName = `${farmer_id}/${uuidv4()}_${file.originalname}`;
    const { error } = await supabase.storage
        .from('product-images')
        .upload(fileName, file.buffer, {
            contentType: file.mimetype,
        });
    if (error) throw error;
    const { data } = supabase.storage.from('product-images').getPublicUrl(fileName);
    return data.publicUrl;
}

// Products CRUD
async function createProduct(req, res) {
    uploadMiddleware(req, res, async (err) => {
        if (err) return res.status(400).json({ error: err.message });

        try {
            const user = await verifyToken(req);
            const { name, description, price, stock, status, farmer_id, category } = req.body;
            console.log('Received create product data:', req.body); // Debug log

            if (user.id !== farmer_id) throw new Error('Unauthorized: Farmer ID mismatch');

            const imageFile = req.file;
            let images = [];
            if (imageFile) {
                const imageUrl = await handleImageUpload(imageFile, farmer_id);
                if (imageUrl) images = [imageUrl];
            }

            const { data, error } = await supabase
                .from('products')
                .insert({
                    name,
                    description,
                    price: Number(price),
                    stock: stock ? Number(stock) : 0,
                    status: status || 'active',
                    category,
                    images,
                    farmer_id,
                })
                .select()
                .single();
            if (error) throw error;
            console.log('Created product:', data); // Debug log
            res.status(201).json(data);
        } catch (error) {
            console.error('Create product error:', error);
            res.status(400).json({ error: error.message });
        }
    });
}

// Get all products with search and filter support
async function getProducts(req, res) {
    try {
        const { search, category, minPrice, maxPrice, farmer_id } = req.query;

        let query = supabase
            .from('products')
            .select('*, farmer:users!farmer_id(name)')
            .order('created_at', { ascending: false });

        // Apply farmer_id filter if provided
        if (farmer_id) {
            query = query.eq('farmer_id', farmer_id);
        }

        // Apply search filter (by name)
        if (search) {
            query = query.ilike('name', `%${search}%`);
        }

        // Apply category filter
        if (category && category !== 'All Categories - Default') {
            query = query.eq('category', category);
        }

        // Apply price range filter
        if (minPrice || maxPrice) {
            query = query
                .gte('price', minPrice || 0)
                .lte('price', maxPrice || Infinity);
        }

        const { data, error } = await query;
        if (error) throw error;

        const normalizedData = data.map((product) => ({
            id: product.id || '',
            farmer_id: product.farmer_id || '',
            name: product.name || '',
            description: product.description || '',
            price: product.price || 0,
            category: product.category || '',
            images: product.images || [],
            farmer_name: product.farmer?.[0]?.name || 'Unknown',
            created_at: product.created_at || '',
            stock: product.stock || 0,
            status: product.status || 'active',
        }));

        res.json(normalizedData);
    } catch (error) {
        console.error('Get products error:', error);
        res.status(400).json({ error: error.message });
    }
}

async function updateProduct(req, res) {
    uploadMiddleware(req, res, async (err) => {
        if (err) return res.status(400).json({ error: err.message });

        try {
            const user = await verifyToken(req);
            const { id } = req.params;
            const { name, description, price, stock, status, farmer_id, category } = req.body;
            console.log('Received update product data:', req.body); // Debug log

            if (user.id !== farmer_id) throw new Error('Unauthorized: Farmer ID mismatch');

            let images = [];
            const { data: existingProduct } = await supabase
                .from('products')
                .select('images')
                .eq('id', id)
                .single();
            images = existingProduct?.images || [];

            const imageFile = req.file;
            if (imageFile) {
                const imageUrl = await handleImageUpload(imageFile, farmer_id);
                if (imageUrl) images = [imageUrl];
            }

            const { data, error } = await supabase
                .from('products')
                .update({
                    name,
                    description,
                    price: Number(price),
                    stock: stock ? Number(stock) : 0,
                    status: status || 'active',
                    category,
                    images,
                })
                .eq('id', id)
                .select()
                .single();
            if (error) throw error;
            console.log('Updated product:', data); // Debug log
            res.status(200).json(data);
        } catch (error) {
            console.error('Update product error:', error);
            res.status(400).json({ error: error.message });
        }
    });
}

async function deleteProduct(req, res) {
    try {
        const user = await verifyToken(req);
        const { id } = req.params;
        const { data: product } = await supabase
            .from('products')
            .select('farmer_id')
            .eq('id', id)
            .single();
        if (user.id !== product.farmer_id) throw new Error('Unauthorized: Can only delete your own products');

        const { error } = await supabase.from('products').delete().eq('id', id);
        if (error) throw error;
        res.status(204).send();
    } catch (error) {
        console.error('Delete product error:', error);
        res.status(400).json({ error: error.message });
    }
}

export {
    createProduct,
    getProducts,
    updateProduct,
    deleteProduct,
};