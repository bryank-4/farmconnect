// frontend/src/components/BuyerDashboard.tsx
import React, { useEffect, useState, useCallback } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import ProductCard from '../components/ProductCard';

interface Order {
    id: string;
    product_id: string;
    quantity: number;
    status: string;
    products: { name: string; price: number; category: string }[];
    billing_details: { order_amount: number };
}

interface SavedItem {
    id: string;
    product_id: string;
    product: {
        id: string;
        name: string;
        price: number;
        category: string;
        images: string[];
        farmer_id: string;
        farmer: { name: string } | { name: string }[];
        farmer_name: string;
    };
}

interface Product {
    id: string;
    name: string;
    description: string;
    price: number;
    category: string;
    images: string[];
    farmer_name: string;
}

interface Notification {
    sender_id: string;
    sender_name: string;
    product_id: string;
    product_name: string;
    message_snippet: string;
    created_at: string;
    unread_count: number;
}

const BuyerDashboard: React.FC = () => {
    const { user } = useAuth();
    const navigate = useNavigate();
    const [orders, setOrders] = useState<Order[]>([]);
    const [savedItems, setSavedItems] = useState<SavedItem[]>([]);
    const [stats, setStats] = useState({
        totalOrders: 0,
        pendingOrders: 0,
        savedCount: 0,
        totalSpent: 0,
    });
    const [loading, setLoading] = useState(true);
    const [products, setProducts] = useState<Product[]>([]);
    const [searchQuery, setSearchQuery] = useState('');
    const [filters, setFilters] = useState({ category: '', minPrice: 0, maxPrice: Infinity });
    const [notifications, setNotifications] = useState<Notification[]>([]);

    const fetchData = useCallback(async () => {
        if (!user) return;
        setLoading(true);

        try {
            const { data: orderData, error: orderError } = await supabase
                .from('orders')
                .select('id, product_id, quantity, status, products(name, price, category), billing_details')
                .eq('buyer_id', user.id)
                .order('created_at', { ascending: false })
                .limit(3);
            if (orderError) throw orderError;
            setOrders(orderData || []);

            const { data: savedData, error: savedError } = await supabase
                .from('favorites')
                .select('id, product_id')
                .eq('buyer_id', user.id)
                .limit(3);
            if (savedError) throw savedError;

            if (savedData && savedData.length > 0) {
                const productIds = savedData.map((item) => item.product_id);
                const { data: productsData, error: productsError } = await supabase
                    .from('products')
                    .select('id, name, price, category, images, farmer_id, farmer:users!farmer_id(name)')
                    .in('id', productIds);
                if (productsError) throw productsError;

                const enrichedSavedItems = savedData.map((item) => {
                    const product = productsData.find((p) => p.id === item.product_id) || {
                        id: '',
                        name: 'Unknown Product',
                        price: 0,
                        category: '',
                        images: ['/placeholder.jpg'],
                        farmer_id: '',
                        farmer: { name: 'Unknown' },
                        farmer_name: 'Unknown',
                    };
                    let farmerName = 'Unknown';
                    if (product.farmer && typeof product.farmer === 'object') {
                        if (Array.isArray(product.farmer)) {
                            farmerName = product.farmer[0]?.name || 'Unknown';
                        } else {
                            farmerName = product.farmer.name || 'Unknown';
                        }
                    }
                    const enrichedProduct = {
                        ...product,
                        farmer_name: farmerName,
                    };
                    return {
                        ...item,
                        product: enrichedProduct,
                    };
                });
                setSavedItems(enrichedSavedItems);
            } else {
                setSavedItems([]);
            }

            const { data: orderCount, error: orderCountError, count } = await supabase
                .from('orders')
                .select('status', { count: 'exact' })
                .eq('buyer_id', user.id)
                .in('status', ['Pending', 'Confirmed', 'Shipped', 'Delivered']);
            if (orderCountError) throw orderCountError;

            const { data: favoriteData, error: favoriteCountError, count: favCount } = await supabase
                .from('favorites')
                .select('*', { count: 'exact' })
                .eq('buyer_id', user.id);
            if (favoriteCountError) throw favoriteCountError;

            const { data: spentData, error: spentError } = await supabase
                .from('orders')
                .select('billing_details')
                .eq('buyer_id', user.id)
                .in('status', ['Confirmed', 'Shipped', 'Delivered']);
            if (spentError) throw spentError;
            const totalSpent = spentData?.reduce((sum, order) => sum + (order.billing_details?.order_amount || 0), 0) || 0;

            setStats({
                totalOrders: count || 0,
                pendingOrders: orderCount?.filter((o) => o.status === 'Pending').length || 0,
                savedCount: favCount || 0,
                totalSpent: totalSpent,
            });

            const response = await fetch(`http://localhost:3001/api/products?search=${searchQuery}&category=${filters.category}&minPrice=${filters.minPrice}&maxPrice=${filters.maxPrice}`);
            const productData = await response.json();
            if (response.ok) {
                setProducts(productData || []);
            } else {
                console.error('Fetch products error:', productData.error);
            }
        } catch (error) {
            console.error('Dashboard fetch error:', error);
            toast.error(`Failed to load dashboard: ${(error as Error).message}`);
        } finally {
            setLoading(false);
        }
    }, [user, searchQuery, filters]);

    const fetchNotifications = async () => {
        if (!user || user.role !== 'Buyer') return;

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
                setNotifications(data.notifications || []);
            }
        } catch (error) {
            console.error('Fetch notifications error:', error);
        }
    };

    const handleNotificationClick = (notification: Notification) => {
        navigate(`/product/${notification.product_id}`, {
            state: { farmerId: notification.sender_id, productId: notification.product_id },
        });
    };

    const handleRemoveSavedItem = async (itemId: string) => {
        if (!user) return;
        try {
            const { error } = await supabase
                .from('favorites')
                .delete()
                .eq('id', itemId)
                .eq('buyer_id', user.id);
            if (error) throw error;
            toast.success('Item removed from saved items');
            await fetchData();
        } catch (error) {
            toast.error(`Failed to remove item: ${(error as Error).message}`);
        }
    };

    useEffect(() => {
        fetchData();
        fetchNotifications();

        const ordersSubscription = supabase
            .channel('orders')
            .on('postgres_changes', { event: '*', schema: 'public', table: 'orders', filter: `buyer_id=eq.${user?.id}` }, () => fetchData())
            .subscribe();
        const favoritesSubscription = supabase
            .channel('favorites')
            .on('postgres_changes', { event: '*', schema: 'public', table: 'favorites', filter: `buyer_id=eq.${user?.id}` }, () => fetchData())
            .subscribe();
        const messagesSubscription = supabase
            .channel('messages_notifications_dashboard')
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user?.id}`,
            }, () => fetchNotifications())
            .on('postgres_changes', {
                event: 'UPDATE',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user?.id}`,
            }, () => fetchNotifications())
            .subscribe();

        return () => {
            ordersSubscription.unsubscribe();
            favoritesSubscription.unsubscribe();
            messagesSubscription.unsubscribe();
        };
    }, [user, searchQuery, filters, fetchData]);

    if (loading) return <div>Loading...</div>;
    if (!user) return <div>Please log in to view your dashboard.</div>;

    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">Welcome back, {user.name || 'Buyer One'}</h2>
            <p className="text-gray-600 mb-6">Track your orders and discover new products.</p>
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-green-600 mr-2">📦</span>
                    <div>
                        <p className="text-gray-600 text-sm">Total Orders</p>
                        <p className="text-lg font-semibold">{stats.totalOrders}</p>
                        <p className="text-xs text-green-600">+5 from last month</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-yellow-600 mr-2">⏳</span>
                    <div>
                        <p className="text-gray-600 text-sm">Pending Orders</p>
                        <p className="text-lg font-semibold">{stats.pendingOrders}</p>
                        <p className="text-xs text-yellow-600">+1 from last week</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-red-600 mr-2">❤️</span>
                    <div>
                        <p className="text-gray-600 text-sm">Saved Items</p>
                        <p className="text-lg font-semibold">{stats.savedCount}</p>
                        <p className="text-xs text-red-600">+2 from last week</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-green-600 mr-2">💰</span>
                    <div>
                        <p className="text-gray-600 text-sm">Total Spent</p>
                        <p className="text-lg font-semibold">KES {stats.totalSpent.toLocaleString()}</p>
                        <p className="text-xs text-green-600">+15% from last month</p>
                    </div>
                </div>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div className="bg-white p-4 rounded-lg shadow">
                    <h3 className="text-lg font-semibold mb-4">Recent Orders</h3>
                    {orders.length === 0 ? (
                        <p>No recent orders.</p>
                    ) : (
                        <ul className="space-y-2">
                            {orders.map((order) => (
                                <li key={order.id} className="flex justify-between items-center">
                                    <span>
                                        ORD{order.id.toString().padStart(3, '0')} - {order.products[0]?.name || 'Unknown'} ({order.quantity}
                                        {order.products[0]?.category === 'Dairy' ? ' liters' : ' kg'})
                                    </span>
                                    <span>KES {(order.billing_details?.order_amount || (order.quantity * (order.products[0]?.price || 0))).toLocaleString()}</span>
                                    <Link to={`/order-details/${order.id}`} className="text-green-600 hover:underline">View Details</Link>
                                </li>
                            ))}
                        </ul>
                    )}
                </div>
                <div className="bg-white p-4 rounded-lg shadow">
                    <h3 className="text-lg font-semibold mb-4">Saved Products</h3>
                    {savedItems.length === 0 ? (
                        <p>No saved items.</p>
                    ) : (
                        <table className="w-full">
                            <thead>
                            <tr>
                                <th className="text-left p-2">Product</th>
                                <th className="text-left p-2">Farmer</th>
                                <th className="text-left p-2">Price</th>
                                <th className="text-left p-2">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            {savedItems.map((item) => (
                                <tr key={item.id} className="border-t">
                                    <td className="p-2 flex items-center">
                                        <img
                                            src={item.product.images[0] || '/placeholder.jpg'}
                                            alt={item.product.name}
                                            className="w-16 h-16 object-cover mr-2"
                                        />
                                        {item.product.name}
                                    </td>
                                    <td className="p-2">{item.product.farmer_name}</td>
                                    <td className="p-2">
                                        KSH {item.product.price.toLocaleString()}/
                                        {item.product.category === 'Dairy' ? 'liter' : 'kg'}
                                    </td>
                                    <td className="p-2">
                                        <Link
                                            to={`/product/${item.product_id}`}
                                            className="text-green-600 hover:underline mr-2"
                                        >
                                            View Details
                                        </Link>
                                        <button
                                            onClick={() => handleRemoveSavedItem(item.id)}
                                            className="text-red-600 hover:underline"
                                        >
                                            Remove
                                        </button>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    )}
                </div>
                <div className="bg-white p-4 rounded-lg shadow">
                    <h3 className="text-lg font-semibold mb-4">Notifications</h3>
                    {notifications.length === 0 ? (
                        <p>No new messages.</p>
                    ) : (
                        <ul className="space-y-2">
                            {notifications.map((notification) => (
                                <li
                                    key={`${notification.sender_id}_${notification.product_id}`}
                                    onClick={() => handleNotificationClick(notification)}
                                    className="p-2 rounded-lg cursor-pointer hover:bg-gray-100 flex justify-between items-center"
                                >
                                    <div>
                                        <p className="font-semibold">{notification.sender_name}</p>
                                        <p className="text-sm text-gray-600">{notification.product_name}</p>
                                        <p className="text-sm text-gray-500">{notification.message_snippet}</p>
                                    </div>
                                    <span className="bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                                        {notification.unread_count}
                                    </span>
                                </li>
                            ))}
                        </ul>
                    )}
                </div>
            </div>

            <div className="mt-6">
                <h3 className="text-lg font-semibold mb-4">Discover Products</h3>
                <div className="flex flex-col md:flex-row gap-4 mb-4">
                    <input
                        type="text"
                        placeholder="Search products..."
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                        className="w-full md:w-1/2 p-2 border rounded focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                    <div className="w-full md:w-1/4">
                        <label className="block text-gray-700 mb-1">Category</label>
                        <select
                            value={filters.category}
                            onChange={(e) => setFilters({ ...filters, category: e.target.value })}
                            className="w-full p-2 border rounded"
                        >
                            <option value="">All Categories</option>
                            <option value="Cereals & Grains">Cereals & Grains</option>
                            <option value="Vegetables">Vegetables</option>
                            <option value="Fruits">Fruits</option>
                            <option value="Dairy">Dairy</option>
                            <option value="Poultry Eggs">Poultry Eggs</option>
                            <option value="Meat & Livestock">Meat & Livestock</option>
                            <option value="Seedlings">Seedlings</option>
                        </select>
                    </div>
                    <div className="w-full md:w-1/4">
                        <label className="block text-gray-700 mb-1">Max Price (KSH)</label>
                        <input
                            type="number"
                            value={filters.maxPrice === Infinity ? '' : filters.maxPrice}
                            onChange={(e) => setFilters({ ...filters, maxPrice: e.target.value ? Number(e.target.value) : Infinity })}
                            className="w-full p-2 border rounded"
                            placeholder="No limit"
                        />
                    </div>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                    {products.length === 0 ? (
                        <p>No products found.</p>
                    ) : (
                        products.map((product) => (
                            <ProductCard key={product.id} product={product} />
                        ))
                    )}
                </div>
            </div>
        </div>
    );
};

export default BuyerDashboard;