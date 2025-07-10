import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';
import L from 'leaflet';
import { formatDistanceToNow } from 'date-fns';

// Fix Leaflet marker icon issue
delete (L.Icon.Default.prototype as any)._getIconUrl;
L.Icon.Default.mergeOptions({
    iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
    iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
    shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
});

interface Notification {
    sender_id: string;
    sender_name: string;
    product_id: string;
    product_name: string;
    message_snippet: string;
    created_at: string;
    unread_count: number;
}

const FarmerDashboard: React.FC = () => {
    const { user } = useAuth();
    const navigate = useNavigate();
    const [orders, setOrders] = useState<any[]>([]);
    const [products, setProducts] = useState<any[]>([]);
    const [notifications, setNotifications] = useState<Notification[]>([]);
    const [loading, setLoading] = useState(true);

    const fetchNotifications = async () => {
        if (!user || user.role !== 'Farmer') return;

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

    useEffect(() => {
        const fetchData = async () => {
            if (!user) return;

            // Fetch orders
            const { data: orderData, error: orderError } = await supabase
                .from('orders')
                .select('id, buyer_id, product_id, quantity, status, products(name, price), users!buyer_id(name)')
                .eq('farmer_id', user.id)
                .order('created_at', { ascending: false })
                .limit(3);
            if (orderError) console.error(orderError);

            // Fetch products for stats
            const { data: productData, error: productError } = await supabase
                .from('products')
                .select('*')
                .eq('farmer_id', user.id);
            if (productError) console.error(productError);

            setOrders(orderData || []);
            setProducts(productData || []);
            setLoading(false);
        };

        fetchData();
        fetchNotifications();

        if (!user || user.role !== 'Farmer') return;

        const channel = supabase
            .channel('messages_notifications_dashboard')
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user.id}`,
            }, () => {
                fetchNotifications();
            })
            .on('postgres_changes', {
                event: 'UPDATE',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user.id}`,
            }, () => {
                fetchNotifications();
            })
            .subscribe();

        return () => {
            channel.unsubscribe();
        };
    }, [user]);

    const handleNotificationClick = (notification: Notification) => {
        navigate('/messages', {
            state: { buyerId: notification.sender_id, productId: notification.product_id },
        });
    };

    if (loading) return <div>Loading...</div>;
    if (!user) return <div>Please log in to view your dashboard.</div>;

    const totalProducts = products.length;
    const activeOrders = orders.filter((o) => o.status === 'Pending' || o.status === 'Shipped').length;
    const totalRevenue = orders.reduce((sum, order) => ['Confirmed', 'Shipped', 'Delivered'].includes(order.status) ? sum + order.products.price * order.quantity : sum, 0);
    const avgOrderValue = orders.length > 0 ? totalRevenue / orders.length : 0;

    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">Welcome back, {user.name || 'Farmer'}</h2>
            <p className="text-gray-600 mb-6">Manage your products and track your sales.</p>
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-green-600 mr-2">🌾</span>
                    <div>
                        <p className="text-gray-600 text-sm">Total Products</p>
                        <p className="text-lg font-semibold">{totalProducts}</p>
                        <p className="text-xs text-green-600">+2 from last month</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-green-600 mr-2">📦</span>
                    <div>
                        <p className="text-gray-600 text-sm">Active Orders</p>
                        <p className="text-lg font-semibold">{activeOrders}</p>
                        <p className="text-xs text-green-600">+1 from last week</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-green-600 mr-2">💰</span>
                    <div>
                        <p className="text-gray-600 text-sm">Total Revenue</p>
                        <p className="text-lg font-semibold">KES {totalRevenue.toLocaleString()}</p>
                        <p className="text-xs text-green-600">+10% from last month</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center">
                    <span className="text-green-600 mr-2">💸</span>
                    <div>
                        <p className="text-gray-600 text-sm">Avg. Order Value</p>
                        <p className="text-lg font-semibold">KES {avgOrderValue.toLocaleString()}</p>
                        <p className="text-xs text-green-600">+5% from last month</p>
                    </div>
                </div>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                <div className="bg-white p-4 rounded-lg shadow">
                    <h3 className="text-lg font-semibold mb-4">Recent Orders</h3>
                    {orders.length === 0 ? (
                        <p>No recent orders.</p>
                    ) : (
                        <ul className="space-y-2">
                            {orders.map((order) => (
                                <li key={order.id} className="flex justify-between items-center">
                                    <span>ORD{order.id.toString().padStart(3, '0')} - {order.users.name || 'Buyer'}</span>
                                    <span>KES {(order.products.price * order.quantity).toLocaleString()}</span>
                                    <span className={order.status === 'Pending' ? 'text-yellow-500' : 'text-green-600'}>
                                        {order.status}
                                    </span>
                                    <button
                                        onClick={() => navigate(`/order-details/${order.id}`)}
                                        className="ml-2 bg-blue-600 text-white px-2 py-1 rounded hover:bg-blue-700"
                                    >
                                        View Details
                                    </button>
                                </li>
                            ))}
                        </ul>
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
                                        <p className="text-xs text-gray-400">
                                            {formatDistanceToNow(new Date(notification.created_at), { addSuffix: true })}
                                        </p>
                                    </div>
                                    <span className="bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                                        {notification.unread_count}
                                    </span>
                                </li>
                            ))}
                        </ul>
                    )}
                </div>
                <div className="bg-white p-4 rounded-lg shadow">
                    <h3 className="text-lg font-semibold mb-4">Your Location</h3>
                    <MapContainer
                        center={[1.2921, 36.8219]}
                        zoom={13}
                        style={{ height: '300px', width: '100%' }}
                    >
                        <TileLayer
                            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                            attribution='© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                        />
                        <Marker position={[1.2921, 36.8219]}>
                            <Popup>{user.location || 'Nairobi'}</Popup>
                        </Marker>
                    </MapContainer>
                </div>
            </div>
            <div className="bg-white p-4 rounded-lg shadow">
                <h3 className="text-lg font-semibold mb-4">Manage Your Products</h3>
                <Link to="/product-management" className="bg-green-600 text-white p-2 rounded hover:bg-green-700">
                    Go to Product Management
                </Link>
            </div>
        </div>
    );
};

export default FarmerDashboard;