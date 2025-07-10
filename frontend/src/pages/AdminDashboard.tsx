import React, { useEffect, useState } from 'react';
import { useAuth } from '../context/AuthContext';
import { supabase } from '../utils/supabase';
import { toast } from 'react-toastify';
import { Line } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, LineElement, PointElement, Title, Tooltip, Legend, Filler } from 'chart.js';

// Register Chart.js components including Filler for fill option
ChartJS.register(CategoryScale, LinearScale, LineElement, PointElement, Title, Tooltip, Legend, Filler);

interface User {
    id: string;
    email: string | null;
    role: string | null;
    name: string | null;
    location: string | null;
    created_at: string | null;
}

interface Order {
    id: string;
    buyer: { name: string | null } | null;
    farmer: { name: string | null } | null;
    products: { name: string | null; price: number } | null;
    product_id: string | null;
    quantity: number;
    status: string | null;
    created_at: string | null;
    billing_details: { order_amount: number } | null;
}

interface Product {
    id: string;
    farmer_id: string | null;
    name: string | null;
    description: string | null;
    price: number;
    category: string | null;
    status: string | null;
    stock: number;
    created_at: string | null;
    farmer: { name: string | null } | null;
}

interface Stats {
    totalFarmers: number;
    totalBuyers: number;
    totalOrders: number;
    totalRevenue: number;
    activeOrders: number; // Added for the new stat
}

interface ChartData {
    labels: string[];
    datasets: {
        label: string;
        data: number[];
        borderColor: string;
        backgroundColor: string;
        fill: boolean;
    }[];
}

// Type for sales data (includes created_at for trends)
interface DeliveredOrder {
    quantity: number;
    products: { price: number }[];
    created_at: string | null;
    product_id: string;
    billing_details: { order_amount: number } | null;
    status: string | null;
}

// Type for revenue calculation
interface DeliveredOrderForRevenue {
    quantity: number;
    products: { price: number }[];
    product_id: string;
    billing_details: { order_amount: number } | null;
    status: string | null;
}

const AdminDashboard: React.FC = () => {
    const { user } = useAuth();
    const [stats, setStats] = useState<Stats>({ totalFarmers: 0, totalBuyers: 0, totalOrders: 0, totalRevenue: 0, activeOrders: 0 });
    const [users, setUsers] = useState<User[]>([]);
    const [filteredUsers, setFilteredUsers] = useState<User[]>([]);
    const [orders, setOrders] = useState<Order[]>([]);
    const [products, setProducts] = useState<Product[]>([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState('');

    useEffect(() => {
        if (!user || user.role !== 'Admin') return;

        const fetchData = async () => {
            setLoading(true);
            try {
                const { count: farmersCount, error: farmersError } = await supabase
                    .from('users')
                    .select('*', { count: 'exact', head: true })
                    .eq('role', 'Farmer');
                if (farmersError) throw farmersError;

                const { count: buyersCount, error: buyersError } = await supabase
                    .from('users')
                    .select('*', { count: 'exact', head: true })
                    .eq('role', 'Buyer');
                if (buyersError) throw buyersError;

                const { count: ordersCount, error: ordersError } = await supabase
                    .from('orders')
                    .select('*', { count: 'exact', head: true });
                if (ordersError) throw ordersError;

                // Calculate total revenue for Confirmed, Shipped, or Delivered orders
                const { data: completedOrdersData, error: completedOrdersError } = await supabase
                    .from('orders')
                    .select('quantity, products:products!product_id(price), product_id, billing_details, status')
                    .in('status', ['Confirmed', 'Shipped', 'Delivered'])
                    .not('product_id', 'is', null);
                if (completedOrdersError) throw completedOrdersError;

                // Calculate active orders (Pending, Confirmed, Shipped)
                const { count: activeOrdersCount, error: activeOrdersError } = await supabase
                    .from('orders')
                    .select('*', { count: 'exact', head: true })
                    .in('status', ['Pending', 'Confirmed', 'Shipped']);
                if (activeOrdersError) throw activeOrdersError;

                // Log the data for debugging
                console.log('Completed Orders Data:', completedOrdersData);

                const totalRevenue = completedOrdersData.reduce(
                    (sum: number, order: DeliveredOrderForRevenue) => {
                        console.log('Order Details:', order);
                        const price = order.products.length > 0 ? order.products[0].price || 0 : 0;
                        const orderAmount = order.billing_details?.order_amount || (order.quantity * price);
                        console.log(`Order: Quantity=${order.quantity}, Product ID=${order.product_id}, Price=${price}, Order Amount=${orderAmount}, Status=${order.status}`);
                        return sum + orderAmount;
                    },
                    0
                );

                console.log('Total Revenue:', totalRevenue);

                setStats({
                    totalFarmers: farmersCount || 0,
                    totalBuyers: buyersCount || 0,
                    totalOrders: ordersCount || 0,
                    totalRevenue,
                    activeOrders: activeOrdersCount || 0,
                });

                const { data: allUsers, error: usersError } = await supabase
                    .from('users')
                    .select('*');
                if (usersError) throw usersError;
                setUsers(allUsers || []);
                setFilteredUsers(allUsers || []); // Initialize filtered users

                const { data: recentOrders, error: recentOrdersError } = await supabase
                    .from('orders')
                    .select('*, buyer:users!buyer_id(name), farmer:users!farmer_id(name), products:products!product_id(name, price)')
                    .order('created_at', { ascending: false })
                    .limit(5);
                if (recentOrdersError) throw recentOrdersError;
                setOrders(recentOrders || []);

                const { data: productsData, error: productsError } = await supabase
                    .from('products')
                    .select('*, farmer:users!farmer_id(name)')
                    .order('created_at', { ascending: false })
                    .limit(5);
                if (productsError) throw productsError;
                setProducts(productsData || []);
            } catch (error) {
                console.error('Admin fetch error:', error);
                toast.error('Failed to load dashboard data: ' + (error as Error).message);
            } finally {
                setLoading(false);
            }
        };

        fetchData();

        const usersSubscription = supabase
            .channel('users')
            .on('postgres_changes', { event: '*', schema: 'public', table: 'users' }, () => fetchData())
            .subscribe();
        const ordersSubscription = supabase
            .channel('orders')
            .on('postgres_changes', { event: '*', schema: 'public', table: 'orders' }, () => fetchData())
            .subscribe();
        const productsSubscription = supabase
            .channel('products')
            .on('postgres_changes', { event: '*', schema: 'public', table: 'products' }, () => fetchData())
            .subscribe();

        return () => {
            usersSubscription.unsubscribe();
            ordersSubscription.unsubscribe();
            productsSubscription.unsubscribe();
        };
    }, [user]);

    useEffect(() => {
        const filtered = users.filter(user =>
            (user.name?.toLowerCase().includes(searchTerm.toLowerCase()) || '') ||
            (user.email?.toLowerCase().includes(searchTerm.toLowerCase()) || '') ||
            (user.role?.toLowerCase().includes(searchTerm.toLowerCase()) || '') ||
            (user.location?.toLowerCase().includes(searchTerm.toLowerCase()) || '')
        );
        setFilteredUsers(filtered);
    }, [searchTerm, users]);

    const handleBanUser = async (userId: string) => {
        try {
            const token = await supabase.auth.getSession().then(({ data }) => data.session?.access_token);
            if (!token) throw new Error('No authentication token found');

            const response = await fetch('http://localhost:3001/api/admin/ban-user', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`,
                },
                body: JSON.stringify({ userId }),
            });

            if (!response.ok) throw new Error((await response.json()).error || 'Failed to ban user');

            setUsers(users.filter((u) => u.id !== userId));
            setFilteredUsers(filteredUsers.filter((u) => u.id !== userId));
            toast.success('User banned successfully');
        } catch (error) {
            console.error('Ban user error:', error);
            toast.error('Failed to ban user: ' + (error as Error).message);
        }
    };

    const handleUpdateOrderStatus = async (orderId: string, status: string) => {
        try {
            const { data, error } = await supabase
                .from('orders')
                .update({ status })
                .eq('id', orderId)
                .select('*');
            if (error) throw error;

            if (data && data.length > 0) {
                setOrders(orders.map((order) => (order.id === orderId ? { ...order, status: data[0].status } : order)));
                toast.success('Order status updated');
            } else {
                throw new Error('No data returned after update');
            }
        } catch (error) {
            console.error('Update order status error:', error);
            toast.error('Failed to update order status: ' + (error as Error).message);
        }
    };

    const handleProductStatus = async (productId: string, status: string) => {
        try {
            const { error } = await supabase
                .from('products')
                .update({ status })
                .eq('id', productId);
            if (error) throw error;

            setProducts(products.map((product) => (product.id === productId ? { ...product, status } : product)));
            toast.success(`Product ${status.toLowerCase()}d`);
        } catch (error) {
            console.error('Update product status error:', error);
            toast.error(`Failed to update product status: ` + (error as Error).message);
        }
    };

    const fetchSalesData = async (): Promise<ChartData> => {
        try {
            const { data, error } = await supabase
                .from('orders')
                .select('created_at, quantity, products:products!product_id(price), product_id, billing_details')
                .in('status', ['Confirmed', 'Shipped', 'Delivered'])
                .not('product_id', 'is', null)
                .not('created_at', 'is', null);
            if (error) throw error;

            console.log('Sales Data:', data);

            const monthlySales: { [key: string]: number } = {};
            (data as DeliveredOrder[]).forEach((order) => {
                const date = new Date(order.created_at!);
                const monthYear = date.toLocaleString('default', { month: 'short', year: 'numeric' });
                const price = order.products.length > 0 ? order.products[0].price || 0 : 0;
                const amount = order.billing_details?.order_amount || (order.quantity * price);
                console.log(`Sales Order: Date=${monthYear}, Quantity=${order.quantity}, Product ID=${order.product_id}, Price=${price}, Amount=${amount}`);
                monthlySales[monthYear] = (monthlySales[monthYear] || 0) + amount;
            });

            console.log('Monthly Sales:', monthlySales);

            const labels = Object.keys(monthlySales).sort((a, b) => new Date(a).getTime() - new Date(b).getTime());
            const salesValues = labels.map((label) => monthlySales[label]);

            if (salesValues.every(value => value === 0)) {
                console.log('All sales values are 0, using fallback.');
                return {
                    labels: ['Jan 2025', 'Feb 2025', 'Mar 2025', 'Apr 2025', 'May 2025'],
                    datasets: [
                        {
                            label: 'Sales (KES)',
                            data: [12000, 19000, 3000, 5000, 20000],
                            borderColor: '#2E7D32',
                            backgroundColor: 'rgba(46, 125, 50, 0.2)',
                            fill: true,
                        },
                    ],
                };
            }

            return {
                labels,
                datasets: [
                    {
                        label: 'Sales (KES)',
                        data: salesValues,
                        borderColor: '#2E7D32',
                        backgroundColor: 'rgba(46, 125, 50, 0.2)',
                        fill: true,
                    },
                ],
            };
        } catch (error) {
            console.error('Sales data fetch error:', error);
            return {
                labels: ['Jan 2025', 'Feb 2025', 'Mar 2025', 'Apr 2025', 'May 2025'],
                datasets: [
                    {
                        label: 'Sales (KES)',
                        data: [12000, 19000, 3000, 5000, 20000],
                        borderColor: '#2E7D32',
                        backgroundColor: 'rgba(46, 125, 50, 0.2)',
                        fill: true,
                    },
                ],
            };
        }
    };

    const [salesData, setSalesData] = useState<ChartData>({
        labels: ['Jan 2025', 'Feb 2025', 'Mar 2025', 'Apr 2025', 'May 2025'],
        datasets: [
            {
                label: 'Sales (KES)',
                data: [12000, 19000, 3000, 5000, 20000],
                borderColor: '#2E7D32',
                backgroundColor: 'rgba(46, 125, 50, 0.2)',
                fill: true,
            },
        ],
    });

    useEffect(() => {
        fetchSalesData().then(setSalesData);
    }, []);

    if (loading) return <div className="text-center text-gray-600">Loading...</div>;
    if (!user || user.role !== 'Admin') return <div className="text-center text-gray-600">Access denied: Admins only.</div>;

    return (
        <div className="p-6 bg-gray-100 min-h-screen">
            <h2 className="text-3xl font-bold text-[#2E7D32] mb-6">Admin Dashboard</h2>
            <p className="text-gray-600 mb-6">Welcome back, {user.name || 'Admin'}</p>

            {/* Stats Section */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                <div className="bg-white p-4 rounded-lg shadow flex items-center transform transition hover:scale-105">
                    <span className="text-[#2E7D32] text-2xl mr-3">👩‍🌾</span>
                    <div>
                        <p className="text-gray-600 text-sm">Total Farmers</p>
                        <p className="text-lg font-semibold text-[#795548]">{stats.totalFarmers}</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center transform transition hover:scale-105">
                    <span className="text-[#FF9800] text-2xl mr-3">🛒</span>
                    <div>
                        <p className="text-gray-600 text-sm">Total Buyers</p>
                        <p className="text-lg font-semibold text-[#795548]">{stats.totalBuyers}</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center transform transition hover:scale-105">
                    <span className="text-[#2E7D32] text-2xl mr-3">📦</span>
                    <div>
                        <p className="text-gray-600 text-sm">Active Orders</p>
                        <p className="text-lg font-semibold text-[#795548]">{stats.activeOrders}</p>
                    </div>
                </div>
                <div className="bg-white p-4 rounded-lg shadow flex items-center transform transition hover:scale-105">
                    <span className="text-[#FF9800] text-2xl mr-3">💰</span>
                    <div>
                        <p className="text-gray-600 text-sm">Total Revenue (Confirmed, Shipped, Delivered)</p>
                        <p className="text-lg font-semibold text-[#795548]">KES {stats.totalRevenue.toLocaleString()}</p>
                    </div>
                </div>
            </div>

            {/* Analytics Section */}
            <div className="bg-white p-6 rounded-lg shadow mb-6">
                <h3 className="text-lg font-semibold text-[#795548] mb-4">Sales Trends (Confirmed, Shipped, Delivered)</h3>
                <div className="h-64">
                    <Line data={salesData} options={{ responsive: true, maintainAspectRatio: false }} />
                </div>
            </div>

            {/* User Management Section */}
            <div className="bg-white p-6 rounded-lg shadow mb-6">
                <h3 className="text-lg font-semibold text-[#795548] mb-4">User Management</h3>
                <div className="mb-4">
                    <input
                        type="text"
                        placeholder="Search users..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className="w-full p-2 border rounded focus:outline-none focus:ring-2 focus:ring-[#2E7D32]"
                    />
                </div>
                {filteredUsers.length === 0 ? (
                    <p className="text-gray-600">No users found.</p>
                ) : (
                    <div className="overflow-x-auto">
                        <table className="w-full text-left">
                            <thead>
                            <tr className="border-b">
                                <th className="p-2 text-[#2E7D32]">Name</th>
                                <th className="p-2 text-[#2E7D32]">Email</th>
                                <th className="p-2 text-[#2E7D32]">Role</th>
                                <th className="p-2 text-[#2E7D32]">Location</th>
                                <th className="p-2 text-[#2E7D32]">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            {filteredUsers.map((u) => (
                                <tr key={u.id} className="border-b hover:bg-gray-50">
                                    <td className="p-2">{u.name || 'N/A'}</td>
                                    <td className="p-2">{u.email || 'N/A'}</td>
                                    <td className="p-2">{u.role || 'N/A'}</td>
                                    <td className="p-2">{u.location || 'N/A'}</td>
                                    <td className="p-2">
                                        <button
                                            onClick={() => handleBanUser(u.id)}
                                            className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition"
                                        >
                                            Ban
                                        </button>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                )}
            </div>

            {/* Order Oversight Section */}
            <div className="bg-white p-6 rounded-lg shadow mb-6">
                <h3 className="text-lg font-semibold text-[#795548] mb-4">Recent Orders</h3>
                {orders.length === 0 ? (
                    <p className="text-gray-600">No orders found.</p>
                ) : (
                    <div className="overflow-x-auto">
                        <table className="w-full text-left">
                            <thead>
                            <tr className="border-b">
                                <th className="p-2 text-[#2E7D32]">Order ID</th>
                                <th className="p-2 text-[#2E7D32]">Product</th>
                                <th className="p-2 text-[#2E7D32]">Buyer</th>
                                <th className="p-2 text-[#2E7D32]">Farmer</th>
                                <th className="p-2 text-[#2E7D32]">Quantity</th>
                                <th className="p-2 text-[#2E7D32]">Status</th>
                                <th className="p-2 text-[#2E7D32]">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            {orders.map((order) => (
                                <tr key={order.id} className="border-b hover:bg-gray-50">
                                    <td className="p-2">{order.id}</td>
                                    <td className="p-2">{order.products?.name || 'N/A'}</td>
                                    <td className="p-2">{order.buyer?.name || 'N/A'}</td>
                                    <td className="p-2">{order.farmer?.name || 'N/A'}</td>
                                    <td className="p-2">{order.quantity || 0}</td>
                                    <td className="p-2">{order.status || 'N/A'}</td>
                                    <td className="p-2">
                                        <select
                                            value={order.status || 'Pending'}
                                            onChange={(e) => handleUpdateOrderStatus(order.id, e.target.value)}
                                            className="border p-1 rounded"
                                        >
                                            <option value="Pending">Pending</option>
                                            <option value="Confirmed">Confirmed</option>
                                            <option value="Shipped">Shipped</option>
                                            <option value="Delivered">Delivered</option>
                                            <option value="Cancelled">Cancelled</option>
                                        </select>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                )}
            </div>

            {/* Product Moderation Section */}
            <div className="bg-white p-6 rounded-lg shadow">
                <h3 className="text-lg font-semibold text-[#795548] mb-4">Product Moderation</h3>
                {products.length === 0 ? (
                    <p className="text-gray-600">No products found.</p>
                ) : (
                    <div className="overflow-x-auto">
                        <table className="w-full text-left">
                            <thead>
                            <tr className="border-b">
                                <th className="p-2 text-[#2E7D32]">Product Name</th>
                                <th className="p-2 text-[#2E7D32]">Farmer</th>
                                <th className="p-2 text-[#2E7D32]">Price</th>
                                <th className="p-2 text-[#2E7D32]">Stock</th>
                                <th className="p-2 text-[#2E7D32]">Status</th>
                                <th className="p-2 text-[#2E7D32]">Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            {products.map((product) => (
                                <tr key={product.id} className="border-b hover:bg-gray-50">
                                    <td className="p-2">{product.name || 'N/A'}</td>
                                    <td className="p-2">{product.farmer?.name || 'N/A'}</td>
                                    <td className="p-2">KES {product.price ? product.price.toLocaleString() : '0'}</td>
                                    <td className="p-2">{product.stock || 0}</td>
                                    <td className="p-2">{product.status || 'N/A'}</td>
                                    <td className="p-2 flex space-x-2">
                                        <button
                                            onClick={() => handleProductStatus(product.id, 'active')}
                                            className="bg-[#2E7D32] text-white px-3 py-1 rounded hover:bg-[#256528] transition"
                                        >
                                            Approve
                                        </button>
                                        <button
                                            onClick={() => handleProductStatus(product.id, 'inactive')}
                                            className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition"
                                        >
                                            Reject
                                        </button>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                )}
            </div>
        </div>
    );
};

export default AdminDashboard;