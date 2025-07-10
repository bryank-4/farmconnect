import React, { createContext, useContext, useState, useEffect } from 'react';
import { supabase } from '../utils/supabase';
import { useAuth } from './AuthContext';

interface CartItem {
    product_id: string;
    farmer_id: string;
    quantity: number;
    price: number;
}

interface CartContextType {
    cart: CartItem[];
    addToCart: (item: CartItem) => void;
    removeFromCart: (product_id: string) => void;
    clearCart: () => void;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

export const CartProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const { user } = useAuth();
    const [cart, setCart] = useState<CartItem[]>([]);

    // Load cart from Supabase when user changes
    useEffect(() => {
        const loadCart = async () => {
            if (!user) {
                setCart([]); // Clear cart for unlogged users
                return;
            }

            const { data, error } = await supabase
                .from('carts')
                .select('product_id, farmer_id, quantity, price')
                .eq('buyer_id', user.id);

            if (error) {
                console.error('Error loading cart:', error);
            } else if (data) {
                setCart(data as CartItem[]);
            }
        };

        loadCart();
    }, [user]);

    // Save cart to Supabase whenever it changes
    useEffect(() => {
        const saveCart = async () => {
            if (!user) return;

            // Remove existing cart items for the buyer
            await supabase.from('carts').delete().eq('buyer_id', user.id);

            // Insert new cart items
            if (cart.length > 0) {
                const items = cart.map(item => ({ ...item, buyer_id: user.id }));
                const { error } = await supabase.from('carts').insert(items);
                if (error) {
                    console.error('Error saving cart:', error);
                }
            }
        };

        saveCart();
    }, [cart, user]);

    const addToCart = (item: CartItem) => {
        setCart(prevCart => {
            const existingItem = prevCart.find(i => i.product_id === item.product_id);
            if (existingItem) {
                return prevCart.map(i =>
                    i.product_id === item.product_id ? { ...i, quantity: i.quantity + item.quantity } : i
                );
            }
            return [...prevCart, item];
        });
    };

    const removeFromCart = (product_id: string) => {
        setCart(prevCart => prevCart.filter(item => item.product_id !== product_id));
    };

    const clearCart = () => {
        setCart([]);
    };

    return (
        <CartContext.Provider value={{ cart, addToCart, removeFromCart, clearCart }}>
            {children}
        </CartContext.Provider>
    );
};

export const useCart = () => {
    const context = useContext(CartContext);
    if (!context) {
        throw new Error('useCart must be used within a CartProvider');
    }
    return context;
};

export default CartContext;