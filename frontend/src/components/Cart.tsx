import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCart } from '../context/CartContext';
import { supabase } from '../utils/supabase';

interface Product {
    id: string;
    name: string;
}

const Cart: React.FC = () => {
    const { cart, removeFromCart } = useCart();
    const navigate = useNavigate();
    const [products, setProducts] = useState<{ [key: string]: Product }>({});
    const subtotal = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);

    useEffect(() => {
        const fetchProductDetails = async () => {
            const productIds = Array.from(new Set(cart.map(item => item.product_id)));
            if (productIds.length === 0) return;

            const { data, error } = await supabase
                .from('products')
                .select('id, name')
                .in('id', productIds);

            if (error) {
                console.error('Error fetching product details:', error);
                return;
            }

            const productMap = (data || []).reduce((map: { [key: string]: Product }, product: Product) => {
                map[product.id] = product;
                return map;
            }, {});
            setProducts(productMap);
        };

        fetchProductDetails();
    }, [cart]);

    const handleCheckout = () => {
        navigate('/checkout');
    };

    return (
        <div className="mt-6 p-4 border rounded shadow">
            <h2 className="text-2xl font-bold text-primary mb-4">Your Cart</h2>
            {cart.length === 0 ? (
                <p>Your cart is empty.</p>
            ) : (
                <>
                    {cart.map((item, index) => {
                        const product = products[item.product_id] || { name: 'Loading...' };
                        return (
                            <div key={index} className="flex justify-between items-center mb-2">
                                <div>
                                    <span>{product.name} (x{item.quantity})</span>
                                    <p className="text-gray-600">KSH {item.price} each</p>
                                </div>
                                <div className="flex items-center">
                                    <span>KSH {(item.price * item.quantity).toLocaleString()}</span>
                                    <button
                                        onClick={() => removeFromCart(item.product_id)}
                                        className="ml-4 text-red-500 hover:text-red-700"
                                    >
                                        Remove
                                    </button>
                                </div>
                            </div>
                        );
                    })}
                    <p className="mt-4 font-bold">Subtotal: KSH {subtotal.toLocaleString()}</p>
                    <button
                        onClick={handleCheckout}
                        className="mt-4 bg-primary text-white px-4 py-2 rounded hover:bg-secondary"
                    >
                        Checkout
                    </button>
                </>
            )}
        </div>
    );
};

export default Cart;