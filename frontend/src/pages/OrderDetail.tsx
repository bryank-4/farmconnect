import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';
import { toast } from 'react-toastify';
import OrderTracker from '../components/OrderTracker';

interface Order {
    id: string;
    product_id: string;
    quantity: number;
    status: string;
    product: { name: string; price: number; category: string };
    buyer_name: string;
    buyer_phone: string;
    farmer_name: string;
    farmer_phone: string;
    farmer_location: string;
}

const OrderDetail: React.FC = () => {
    const { id } = useParams();
    const { user } = useAuth();
    const navigate = useNavigate();
    const [order, setOrder] = useState<Order | null>(null);
    const [loading, setLoading] = useState(true);

    const fetchOrder = async () => {
        if (!user || !id) return;
        setLoading(true);

        try {
            const { data, error } = await supabase
                .from('orders')
                .select('*, products(name, price, category, farmer_id), buyer:users!buyer_id(name, phone_number), farmer:users!farmer_id(name, phone_number, location)')
                .eq('id', id)
                .single();
            if (error) throw error;

            if (data.buyer_id !== user.id && data.farmer_id !== user.id) {
                throw new Error('Unauthorized: You can only view your own orders');
            }

            setOrder({
                id: data.id,
                product_id: data.product_id,
                quantity: data.quantity,
                status: data.status,
                product: {
                    name: data.products?.name || '',
                    price: data.products?.price || 0,
                    category: data.products?.category || '',
                },
                buyer_name: data.buyer?.name || 'Unknown',
                buyer_phone: data.buyer?.phone_number || 'Not provided',
                farmer_name: data.farmer?.name || 'Unknown',
                farmer_phone: data.farmer?.phone_number || 'Not provided',
                farmer_location: data.farmer?.location || 'Not provided',
            });
        } catch (error) {
            console.error('Fetch order error:', error);
            toast.error(`Failed to load order: ${(error as Error).message}`);
            navigate('/orders');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchOrder();
    }, [id, user]);

    const handleCancelOrder = async () => {
        if (!user || !order) return;

        try {
            const response = await fetch(`http://localhost:3001/api/orders/${order.id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${await supabase.auth.getSession().then(({ data }) => data.session?.access_token)}`,
                },
                body: JSON.stringify({ status: 'Cancelled' }),
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || 'Failed to cancel order');
            }

            toast.success('Order cancelled successfully');
            fetchOrder();
        } catch (error) {
            toast.error(`Failed to cancel order: ${(error as Error).message}`);
        }
    };

    const handleUpdateStatus = async (newStatus: string) => {
        if (!user || !order) return;

        try {
            const response = await fetch(`http://localhost:3001/api/orders/${order.id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${await supabase.auth.getSession().then(({ data }) => data.session?.access_token)}`,
                },
                body: JSON.stringify({ status: newStatus }),
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || `Failed to update order status to ${newStatus}`);
            }

            toast.success(`Order status updated to ${newStatus} successfully`);
            fetchOrder();
        } catch (error) {
            toast.error(`Failed to update order status: ${(error as Error).message}`);
        }
    };

    if (loading) return <div>Loading...</div>;
    if (!order) return <div>Order not found</div>;

    return (
        <div className="mt-6 p-4 border rounded shadow">
            <h2 className="text-2xl font-bold text-primary mb-4">Order Details</h2>
            <div className="space-y-4">
                <p><strong>Order ID:</strong> ORD{order.id.toString().padStart(3, '0')}</p>
                <p><strong>Product:</strong> {order.product.name}</p>
                <p><strong>Quantity:</strong> {order.quantity} {order.product.category === 'Dairy' ? 'liters' : order.product.category === 'Seedlings' || order.product.category === 'Poultry Eggs' ? 'pieces' : 'kg'}</p>
                <p><strong>Total Price:</strong> KES {(order.quantity * order.product.price).toLocaleString()}</p>
                <p><strong>Buyer:</strong> {order.buyer_name}</p>
                <p><strong>Buyer Phone:</strong> {order.buyer_phone}</p>
                <p><strong>Farmer:</strong> {order.farmer_name}</p>
                <p><strong>Farmer Phone:</strong> {order.farmer_phone}</p>
                <p><strong>Farmer Location:</strong> {order.farmer_location}</p>
                <p><strong>Status:</strong> {order.status}</p>
                <OrderTracker status={order.status} />
                {user && user.role === 'Buyer' && order.status === 'Pending' && (
                    <button
                        onClick={handleCancelOrder}
                        className="mt-4 bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700"
                    >
                        Cancel Order
                    </button>
                )}
                {user && user.role === 'Farmer' && order.status === 'Confirmed' && (
                    <button
                        onClick={() => handleUpdateStatus('Shipped')}
                        className="mt-4 bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 ml-2"
                    >
                        Mark as Shipped
                    </button>
                )}
                {user && user.role === 'Buyer' && order.status === 'Shipped' && (
                    <button
                        onClick={() => handleUpdateStatus('Delivered')}
                        className="mt-4 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 ml-2"
                    >
                        Mark as Delivered
                    </button>
                )}
            </div>

            {/* Safety Tips Section */}
            <div className="mt-6">
                <h3 className="text-lg font-semibold text-primary mb-2">Safety Tips for Deal</h3>
                <ul className="list-disc pl-5 space-y-2 text-gray-600">
                    <li>Meet in a public place for the exchange, such as a local market or a well-lit area.</li>
                    <li>Verify the product quality before finalizing the deal.</li>
                    <li>Communicate through the platform’s messaging system to keep a record of your conversation.</li>
                    <li>Avoid sharing personal information like your home address until you trust the farmer.</li>
                    <li>If something feels off, report the issue to support immediately.</li>
                </ul>
            </div>
        </div>
    );
};

export default OrderDetail;