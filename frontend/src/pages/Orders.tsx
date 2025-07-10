// frontend/src/pages/Orders.tsx
import React, { useEffect, useState } from 'react';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';
import { useNavigate } from 'react-router-dom';
import OrderTracker from '../components/OrderTracker';

const Orders: React.FC = () => {
    const { user } = useAuth();
    const navigate = useNavigate();
    const [orders, setOrders] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchOrders = async () => {
            if (!user) return;
            const { data, error } = await supabase
                .from('orders')
                .select('*, products(name)')
                .or(`buyer_id.eq.${user.id},farmer_id.eq.${user.id}`);
            if (error) console.error(error);
            else {
                // Filter out cancelled orders for both buyers and farmers
                const filteredOrders = data.filter(order =>
                    order.status !== 'Cancelled'
                );
                setOrders(filteredOrders || []);
            }
            setLoading(false);
        };
        fetchOrders();
    }, [user]);

    if (loading) return <div>Loading...</div>;
    if (!user) return <div>Please log in to view orders.</div>;

    return (
        <div className="mt-6">
            <h2 className="text-2xl font-bold text-primary mb-4">Your Orders</h2>
            {orders.length === 0 ? (
                <p>No orders found.</p>
            ) : (
                <div className="space-y-4">
                    {orders.map((order) => (
                        <div
                            key={order.id}
                            className="border rounded p-4 shadow cursor-pointer"
                            onClick={() => navigate(`/order-details/${order.id}`)}
                        >
                            <p>Product: {order.products.name}</p>
                            <p>Quantity: {order.quantity}</p>
                            <OrderTracker status={order.status} />
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default Orders;