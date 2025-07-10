import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { useCart } from '../context/CartContext';
import { FaCartShopping, FaHeart } from 'react-icons/fa6';
import { supabase } from '../utils/supabase';

interface IconProps {
    size?: number;
    className?: string;
}

const Navbar: React.FC = () => {
    const { user, logout } = useAuth();
    const { cart } = useCart();
    const [unreadCount, setUnreadCount] = useState<number>(0);

    const totalItemsInCart = cart.reduce((sum: number, item: { quantity: number }) => sum + item.quantity, 0);

    const CartIcon = FaCartShopping as React.FC<IconProps>;
    const HeartIcon = FaHeart as React.FC<IconProps>;

    const fetchUnreadCount = async () => {
        if (!user) return;

        const token = await supabase.auth.getSession().then(({ data }) => data.session?.access_token);
        if (!token) return;

        try {
            const response = await fetch('http://localhost:3001/api/messages/unread', {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            });
            const data = await response.json();
            if (response.ok) {
                setUnreadCount(data.total_unread || 0);
            }
        } catch (error) {
            console.error('Fetch unread messages count error:', error);
        }
    };

    useEffect(() => {
        fetchUnreadCount();

        if (!user) return;

        const channel = supabase
            .channel('messages_notifications')
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user.id}`,
            }, () => {
                fetchUnreadCount();
            })
            .on('postgres_changes', {
                event: 'UPDATE',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user.id}`,
            }, () => {
                fetchUnreadCount();
            })
            .subscribe();

        return () => {
            channel.unsubscribe();
        };
    }, [user]);

    return (
        <nav className="bg-primary text-white p-4">
            <div className="container mx-auto flex justify-between items-center">
                <Link to="/" className="text-2xl font-bold">FarmConnect</Link>
                <div className="space-x-4 flex items-center">
                    <Link to="/products" className="hover:text-accent">Products</Link>
                    {user && <Link to="/orders" className="hover:text-accent">Orders</Link>}
                    {user ? (
                        <>
                            <Link to={`/dashboard/${user.role.toLowerCase()}`} className="hover:text-accent relative">
                                Dashboard
                                {unreadCount > 0 && user.role === 'Buyer' && (
                                    <span className="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                                        {unreadCount}
                                    </span>
                                )}
                            </Link>
                            {user.role === 'Buyer' && (
                                <Link to="/favorites" className="hover:text-accent flex items-center">
                                    <HeartIcon size={16} className="mr-1" />
                                    Favorites
                                </Link>
                            )}
                            {user.role === 'Farmer' && (
                                <Link to="/messages" className="hover:text-accent relative">
                                    Messages
                                    {unreadCount > 0 && (
                                        <span className="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                                            {unreadCount}
                                        </span>
                                    )}
                                </Link>
                            )}
                            <button onClick={logout} className="hover:text-accent">Logout</button>
                            <Link to="/cart" className="relative hover:text-accent">
                                <CartIcon size={20} />
                                {totalItemsInCart > 0 && (
                                    <span className="absolute -top-2 -right-2 bg-accent text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                                        {totalItemsInCart}
                                    </span>
                                )}
                            </Link>
                        </>
                    ) : (
                        <>
                            <Link to="/login" className="hover:text-accent">Login</Link>
                            <Link to="/signup" className="hover:text-accent">Signup</Link>
                            <span className="text-gray-400 cursor-not-allowed">Cart (Login Required)</span>
                        </>
                    )}
                </div>
            </div>
        </nav>
    );
};

export default Navbar;