// backend/testCrud.js
import 'dotenv/config';
import { createProduct, getProducts, updateProduct, deleteProduct } from './services/backend.js';
import { signup, login, getCurrentUser } from './services/auth.js';

async function runCrudTests() {
    try {
        // Signup to get a user
        await signup('farmer@example.com', 'password123', 'Farmer', 'Farmer Joe', 'Nairobi');
        await login('farmer@example.com', 'password123');

        // Test Create Product
        console.log('Testing createProduct...');
        const newProduct = await createProduct({
            name: 'Maize',
            description: 'Fresh maize from Kenya',
            price: 50.00,
            category: 'Grains',
            images: ['image1.jpg'],
            farmer_id: (await getCurrentUser()).id,
        });
        console.log('Created product:', newProduct);

        // Test Read Products
        console.log('Testing getProducts...');
        const products = await getProducts({ category: 'Grains' });
        console.log('Products:', products);

        // Test Update Product
        console.log('Testing updateProduct...');
        const updatedProduct = await updateProduct(newProduct.id, { price: 55.00 });
        console.log('Updated product:', updatedProduct);

        // Test Delete Product
        console.log('Testing deleteProduct...');
        await deleteProduct(newProduct.id);
        console.log('Product deleted');
    } catch (error) {
        console.error('Test failed:', error);
    }
}

runCrudTests();