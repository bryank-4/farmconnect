// frontend/src/components/Checkout.tsx
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCart } from '../context/CartContext';
import { useAuth } from '../context/AuthContext';
import { supabase } from '../utils/supabase';
import { toast } from 'react-toastify';

interface BillingDetails {
    fullName: string;
    location: string;
    townCity: string;
    phoneNumber: string;
    email: string;
}

interface Product {
    id: string;
    name: string;
}

const Checkout: React.FC = () => {
    const { cart, clearCart } = useCart();
    const { user } = useAuth();
    const navigate = useNavigate();
    const [billingDetails, setBillingDetails] = useState<BillingDetails>({
        fullName: '',
        location: '',
        townCity: '',
        phoneNumber: '',
        email: '',
    });
    const [products, setProducts] = useState<{ [key: string]: Product }>({});
    const subtotal = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);

    // Fetch user details to pre-fill billing form
    useEffect(() => {
        const fetchUserDetails = async () => {
            if (!user) return;

            const { data, error } = await supabase
                .from('users')
                .select('name, email, location, phone_number')
                .eq('id', user.id)
                .single();

            if (error) {
                console.error('Error fetching user details:', error);
                toast.error('Failed to load user details');
                return;
            }

            if (data) {
                setBillingDetails({
                    fullName: data.name || '',
                    location: data.location || '',
                    townCity: '',
                    phoneNumber: data.phone_number || '',
                    email: data.email || '',
                });
            }
        };

        fetchUserDetails();
    }, [user]);

    // Fetch product details for display
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
                toast.error('Failed to load product details');
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

    // Validate and format phone number
    const formatPhoneNumber = (phone: string): string => {
        let cleaned = phone.replace(/\D/g, ''); // Remove non-digits
        if (cleaned.startsWith('0') && cleaned.length > 1) {
            cleaned = '254' + cleaned.slice(1); // Convert 07XXXXXXX to 2547XXXXXXX
        }
        if (cleaned.startsWith('254') && cleaned.length === 12) {
            return cleaned;
        }
        return ''; // Invalid format
    };

    const handleCheckout = async () => {
        if (!user) {
            toast.error('Please log in to complete your purchase');
            navigate('/login');
            return;
        }

        if (!billingDetails.fullName || !billingDetails.phoneNumber || !billingDetails.email) {
            toast.error('Please fill in all required billing details');
            return;
        }

        // Validate and format phone number
        const formattedPhoneNumber = formatPhoneNumber(billingDetails.phoneNumber);
        if (!formattedPhoneNumber) {
            toast.error('Please enter a valid phone number (e.g., 07XXXXXXXX or 2547XXXXXXXX)');
            return;
        }

        try {
            // Create orders for each cart item with order_amount
            const ordersToInsert = cart.map(item => ({
                buyer_id: user.id,
                farmer_id: item.farmer_id,
                product_id: item.product_id,
                quantity: item.quantity,
                status: 'Pending',
                billing_details: {
                    ...billingDetails,
                    order_amount: item.price * item.quantity
                },
            }));

            const { data: orderData, error: orderError } = await supabase
                .from('orders')
                .insert(ordersToInsert)
                .select('id');

            if (orderError) {
                console.error('Order creation error:', orderError);
                throw new Error(orderError.message || 'Failed to create orders');
            }

            if (!orderData || orderData.length === 0) {
                throw new Error('No orders were created');
            }

            // Extract order IDs and log for debugging
            const orderIds = orderData.map(order => order.id);
            console.log('Order IDs sent to M-Pesa:', orderIds);

            // Initiate M-Pesa payment with a single order_id if only one order
            const mpesaResponse = await fetch('http://localhost:3001/api/initiate-mpesa-payment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${await supabase.auth.getSession().then(({ data }) => data.session?.access_token)}`,
                },
                body: JSON.stringify({
                    phoneNumber: formattedPhoneNumber,
                    amount: subtotal,
                    orderIds: orderIds.length === 1 ? orderIds[0] : orderIds,
                }),
            });

            if (!mpesaResponse.ok) {
                const errorData = await mpesaResponse.json();
                throw new Error(errorData.message || 'Payment initiation failed');
            }

            const result = await mpesaResponse.json();
            console.log('M-Pesa response:', result);
            if (result.ResponseCode === '0') {
                clearCart();
                toast.success('Payment initiated successfully! Please check your phone to complete the payment.');
                navigate('/orders');
            } else {
                throw new Error(result.CustomerMessage || 'Payment initiation failed');
            }
        } catch (error) {
            console.error('Checkout error:', error);
            toast.error(`Checkout failed: ${(error as Error).message}`);
        }
    };

    return (
        <div className="mt-6 p-4 border rounded shadow">
            <h2 className="text-2xl font-bold text-primary mb-4">Checkout</h2>
            {cart.length === 0 ? (
                <p>
                    Your cart is empty.{' '}
                    <button onClick={() => navigate('/products')} className="text-primary underline">
                        Continue shopping
                    </button>
                </p>
            ) : (
                <>
                    {cart.map((item, index) => {
                        const product = products[item.product_id] || { name: 'Loading...' };
                        return (
                            <div key={index} className="flex justify-between items-center mb-2">
                                <span>{product.name} (x{item.quantity})</span>
                                <span>KSH {(item.price * item.quantity).toLocaleString()}</span>
                            </div>
                        );
                    })}
                    <p className="mt-4 font-bold">Subtotal: KSH {subtotal.toLocaleString()}</p>
                    <div className="mt-4 space-y-2">
                        <input
                            placeholder="Full Name *"
                            value={billingDetails.fullName}
                            onChange={(e) => setBillingDetails({ ...billingDetails, fullName: e.target.value })}
                            className="w-full p-2 border rounded"
                        />
                        <input
                            placeholder="Location"
                            value={billingDetails.location}
                            onChange={(e) => setBillingDetails({ ...billingDetails, location: e.target.value })}
                            className="w-full p-2 border rounded"
                        />
                        <input
                            placeholder="Town/City"
                            value={billingDetails.townCity}
                            onChange={(e) => setBillingDetails({ ...billingDetails, townCity: e.target.value })}
                            className="w-full p-2 border rounded"
                        />
                        <input
                            placeholder="Phone Number *"
                            value={billingDetails.phoneNumber}
                            onChange={(e) => setBillingDetails({ ...billingDetails, phoneNumber: e.target.value })}
                            className="w-full p-2 border rounded"
                        />
                        <input
                            placeholder="Email *"
                            value={billingDetails.email}
                            onChange={(e) => setBillingDetails({ ...billingDetails, email: e.target.value })}
                            className="w-full p-2 border rounded"
                        />
                    </div>
                    <button
                        onClick={handleCheckout}
                        className="mt-4 bg-primary text-white px-4 py-2 rounded hover:bg-secondary"
                    >
                        Pay with M-Pesa
                    </button>
                </>
            )}
        </div>
    );
};

export default Checkout;