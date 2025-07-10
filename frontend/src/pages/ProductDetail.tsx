import React, { useEffect, useState, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';
import { toast } from 'react-toastify';
import { useCart } from '../context/CartContext';
import { formatDistanceToNow, isToday, isYesterday, format } from 'date-fns';
import { FaHeart, FaRegHeart } from 'react-icons/fa6';

interface IconProps {
    size?: number;
    className?: string;
}

interface Review {
    id: string;
    rating: number;
    comment: string;
    buyer_name: string;
    created_at: string;
}

interface Message {
    id: string;
    sender_id: string;
    receiver_id: string;
    content: string;
    sender_name: string;
    receiver_name: string;
    created_at: string;
    status: 'sent' | 'delivered' | 'read';
    product_id: string;
}

const ProductDetail: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const { user } = useAuth();
    const { addToCart } = useCart();
    const navigate = useNavigate();
    const [product, setProduct] = useState<any>(null);
    const [quantity, setQuantity] = useState(1);
    const [loading, setLoading] = useState(true);
    const [reviews, setReviews] = useState<Review[]>([]);
    const [newReview, setNewReview] = useState({ rating: 0, comment: '' });
    const [reviewError, setReviewError] = useState<string | null>(null);
    const [canReview, setCanReview] = useState(false);
    const [messages, setMessages] = useState<Message[]>([]);
    const [newMessage, setNewMessage] = useState('');
    const [activeTab, setActiveTab] = useState<'reviews' | 'messages'>('reviews');
    const [isFarmerTyping, setIsFarmerTyping] = useState(false);
    const [sendError, setSendError] = useState<string | null>(null);
    const [isFavorite, setIsFavorite] = useState(false);
    const [unreadCount, setUnreadCount] = useState(0);
    const chatContainerRef = useRef<HTMLDivElement>(null);

    const getInitials = (name: string) => {
        if (!name || name === 'Unknown') return '?';
        const nameParts = name.trim().split(' ');
        return nameParts.length > 1
            ? `${nameParts[0][0]}${nameParts[nameParts.length - 1][0]}`
            : nameParts[0][0];
    };

    const formatMessageGroupDate = (date: Date) => {
        if (isToday(date)) return 'Today';
        if (isYesterday(date)) return 'Yesterday';
        return format(date, 'MMMM d, yyyy');
    };

    const fetchMessagesAndUnreadCount = async () => {
        if (!user || !product?.farmer_id || !id) return;
        const token = await supabase.auth.getSession().then(({ data }) => data.session?.access_token);
        if (!token) return;

        const response = await fetch(`http://localhost:3001/api/messages?receiver_id=${product.farmer_id}&product_id=${id}`, {
            headers: { 'Authorization': `Bearer ${token}` },
        });
        const messageData = await response.json();
        if (response.ok) {
            setMessages((messageData as Message[]) || []);

            const unreadResponse = await fetch('http://localhost:3001/api/messages/unread', {
                headers: { 'Authorization': `Bearer ${token}` },
            });
            const unreadData = await unreadResponse.json();
            if (unreadResponse.ok) {
                const totalUnread = unreadData.total_unread || 0;
                setUnreadCount(totalUnread);
            }
        } else {
            console.error('Fetch messages error:', messageData.error);
            setSendError(messageData.error || 'Failed to fetch messages');
        }
    };

    const markMessagesAsRead = async () => {
        if (!user || !product?.farmer_id || !id) return;
        const response = await fetch('http://localhost:3001/api/messages/mark-read', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${await supabase.auth.getSession().then(({ data }) => data.session?.access_token)}`,
            },
            body: JSON.stringify({ sender_id: product.farmer_id, product_id: id }),
        });
        if (!response.ok) {
            console.error('Mark messages as read error:', (await response.json()).error);
        }
    };

    useEffect(() => {
        const fetchProductAndReviews = async () => {
            try {
                const { data: productData, error: productError } = await supabase
                    .from('products')
                    .select('*, farmer:users!farmer_id(name, phone_number, location)')
                    .eq('id', id)
                    .single();
                if (productError) {
                    console.error('Fetch product error:', productError);
                    throw new Error('Failed to fetch product');
                }
                setProduct({
                    ...productData,
                    farmer_name: productData.farmer?.name || 'Unknown Farmer',
                    farmer_phone: productData.farmer?.phone_number || 'Not provided',
                    farmer_location: productData.farmer?.location || 'Not provided',
                    farmer_id: productData.farmer_id || '',
                });

                const response = await fetch(`http://localhost:3001/api/reviews?product_id=${id}`);
                const reviewData = await response.json();
                if (response.ok) {
                    setReviews((reviewData as Review[]) || []);
                } else {
                    console.error('Fetch reviews error:', reviewData.error);
                    throw new Error(reviewData.error || 'Failed to fetch reviews');
                }

                if (user && user.role === 'Buyer') {
                    const { data: orderData, error: orderError } = await supabase
                        .from('orders')
                        .select('id')
                        .eq('buyer_id', user.id)
                        .eq('product_id', id)
                        .eq('status', 'Delivered')
                        .single();
                    setCanReview(!!orderData && !orderError);

                    const { data: favoriteData } = await supabase
                        .from('favorites')
                        .select('id')
                        .eq('buyer_id', user.id)
                        .eq('product_id', id)
                        .single();
                    setIsFavorite(!!favoriteData);
                }
            } catch (error) {
                console.error('Fetch error:', error);
                toast.error(`Failed to load product: ${(error as Error).message}`);
            } finally {
                setLoading(false);
            }
        };

        fetchProductAndReviews();
        if (user && product?.farmer_id) {
            fetchMessagesAndUnreadCount();
            if (user.role === 'Buyer') markMessagesAsRead();
        }
    }, [id, user, product?.farmer_id]);

    useEffect(() => {
        if (!user || !product?.farmer_id || !id) return;

        const messageChannel = supabase.channel(`messages:${user.id}:${product.farmer_id}:${id}`);
        messageChannel
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: 'messages',
                filter: `sender_id=eq.${product.farmer_id},receiver_id=eq.${user.id},product_id=eq.${id}`,
            }, (payload) => {
                const newMessage: Message = {
                    id: payload.new.id || '',
                    sender_id: payload.new.sender_id || '',
                    receiver_id: payload.new.receiver_id || '',
                    content: payload.new.content || '',
                    sender_name: product.farmer_name || 'Unknown',
                    receiver_name: user.name || 'Unknown',
                    created_at: payload.new.created_at || '',
                    status: payload.new.status || 'sent',
                    product_id: id || '',
                };
                setMessages((prev) => [...prev, newMessage]);
                fetchMessagesAndUnreadCount();
            })
            .on('postgres_changes', {
                event: 'UPDATE',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user.id},product_id=eq.${id}`,
            }, () => {
                fetchMessagesAndUnreadCount();
            })
            .subscribe((status) => console.log('Message channel subscription status:', status));

        const typingChannel = supabase.channel(`typing:${user.id}:${product.farmer_id}:${id}`);
        typingChannel
            .on('broadcast', { event: 'typing' }, (payload) => {
                if (payload.sender_id === product.farmer_id && payload.product_id === id) {
                    setIsFarmerTyping(true);
                    setTimeout(() => setIsFarmerTyping(false), 3000);
                }
            })
            .subscribe((status) => console.log('Typing channel subscription status:', status));

        return () => {
            messageChannel.unsubscribe();
            typingChannel.unsubscribe();
        };
    }, [user, product?.farmer_id, id, product?.farmer_name]);

    useEffect(() => {
        if (chatContainerRef.current) {
            chatContainerRef.current.scrollTop = chatContainerRef.current.scrollHeight;
        }
    }, [messages]);

    const handleSendMessage = async () => {
        if (!user || !product?.farmer_id || !newMessage.trim() || user.role !== 'Buyer' || !id) return;
        try {
            const typingChannel = supabase.channel(`typing:${product.farmer_id}:${user.id}:${id}`);
            await typingChannel.send({
                type: 'broadcast',
                event: 'typing',
                payload: { sender_id: user.id, product_id: id },
            }).catch((error) => console.error('Broadcast typing error:', error));

            const response = await fetch('http://localhost:3001/api/messages', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${await supabase.auth.getSession().then(({ data }) => data.session?.access_token)}`,
                },
                body: JSON.stringify({ receiver_id: product.farmer_id, content: newMessage, status: 'sent', product_id: id }),
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || 'Failed to send message');
            }

            const newMessageData = await response.json();
            setMessages((prev) => [...prev, {
                ...newMessageData,
                sender_name: user.name || 'Unknown',
                receiver_name: product.farmer_name || 'Unknown',
                product_id: id || '',
            }]);
            setNewMessage('');
            setSendError(null);
            toast.success('Message sent successfully');
            fetchMessagesAndUnreadCount();
        } catch (error) {
            setSendError((error as Error).message);
            toast.error(`Failed to send message: ${(error as Error).message}`);
        }
    };

    const handleRetrySend = () => {
        setSendError(null);
        handleSendMessage();
    };

    const handleOrder = () => {
        if (!user) {
            navigate('/login');
            return;
        }
        if (!product) {
            toast.error('Product details are not available');
            return;
        }
        addToCart({
            product_id: product.id,
            farmer_id: product.farmer_id,
            quantity,
            price: product.price,
        });
        navigate('/checkout');
    };

    const handleAddToCart = () => {
        if (!product || !user) {
            toast.error('Please log in to add items to your cart');
            return;
        }
        addToCart({
            product_id: product.id,
            farmer_id: product.farmer_id,
            quantity,
            price: product.price,
        });
        toast.success('Added to cart!');
    };

    const handleReviewSubmit = async () => {
        if (!user || user.role !== 'Buyer' || !canReview || !newReview.rating || !newReview.comment || newReview.rating < 1 || newReview.rating > 5) {
            setReviewError('Unauthorized: Only buyers who have received a product can create reviews with a valid rating (1-5) and comment.');
            return;
        }

        try {
            setReviewError(null);
            const session = await supabase.auth.getSession();
            if (!session.data.session?.access_token) {
                throw new Error('No valid session token');
            }

            const response = await fetch('http://localhost:3001/api/reviews', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${session.data.session.access_token}`,
                },
                body: JSON.stringify({
                    product_id: id,
                    rating: newReview.rating,
                    comment: newReview.comment,
                    buyer_id: user.id,
                }),
            });

            if (!response.ok) {
                const errorData = await response.json();
                console.error('Review submit error:', errorData);
                throw new Error(errorData.error || 'Failed to submit review');
            }

            const newReviewData = await response.json();
            setReviews([{ ...newReviewData, buyer_name: user.name || 'Unknown', created_at: new Date().toISOString() }, ...reviews]);
            setNewReview({ rating: 0, comment: '' });
            toast.success('Review submitted successfully');
        } catch (error) {
            setReviewError((error as Error).message);
            toast.error(`Failed to submit review: ${(error as Error).message}`);
        }
    };

    const handleToggleFavorite = async () => {
        if (!user || user.role !== 'Buyer' || !id) return;

        if (isFavorite) {
            const { error } = await supabase
                .from('favorites')
                .delete()
                .eq('buyer_id', user.id)
                .eq('product_id', id);
            if (error) {
                toast.error(`Failed to remove from favorites: ${error.message}`);
            } else {
                setIsFavorite(false);
                toast.success('Removed from favorites');
            }
        } else {
            const { error } = await supabase
                .from('favorites')
                .insert({ buyer_id: user.id, product_id: id });
            if (error) {
                toast.error(`Failed to add to favorites: ${error.message}`);
            } else {
                setIsFavorite(true);
                toast.success('Added to favorites');
            }
        }
    };

    if (loading) return <div>Loading...</div>;
    if (!product) return <div>Product not found</div>;

    return (
        <div className="mt-6 p-4 border rounded shadow">
            <div className="flex flex-col md:flex-row gap-4">
                <img src={product.images[0] || '/placeholder.jpg'} alt={product.name} className="w-full md:w-1/2 h-64 object-cover rounded" />
                <div>
                    <h2 className="text-2xl font-bold text-primary">{product.name}</h2>
                    <p className="text-gray-600 mt-2">{product.description}</p>
                    <p className="text-primary font-bold mt-2">KSH {product.price}</p>
                    <p className="text-gray-600 mt-1">Sold by: {product.farmer_name}</p>
                    <div className="mt-4">
                        <label className="block text-gray-700">Quantity ({product.category === 'Dairy' ? 'liters' : product.category === 'Seedlings' || product.category === 'Poultry Eggs' ? 'pieces' : 'kg'})</label>
                        <input
                            type="number"
                            value={quantity}
                            onChange={(e) => {
                                const newQuantity = Number(e.target.value);
                                if (newQuantity <= (product.stock || 0)) {
                                    setQuantity(newQuantity > 0 ? newQuantity : 1);
                                } else {
                                    toast.error(`Maximum available stock is ${product.stock} ${product.category === 'Dairy' ? 'liters' : product.category === 'Seedlings' || product.category === 'Poultry Eggs' ? 'pieces' : 'kg'}`);
                                    setQuantity(product.stock || 1);
                                }
                            }}
                            min="1"
                            max={product.stock || 1}
                            className="w-20 p-2 border rounded"
                        />
                        <p className="text-sm text-gray-500 mt-1">Available: {product.stock} {product.category === 'Dairy' ? 'liters' : product.category === 'Seedlings' || product.category === 'Poultry Eggs' ? 'pieces' : 'kg'}</p>
                    </div>
                    <button
                        onClick={handleOrder}
                        className="mt-4 bg-accent text-white px-4 py-2 rounded hover:bg-secondary"
                    >
                        Place Order with M-Pesa
                    </button>
                    <button
                        onClick={handleAddToCart}
                        className="mt-4 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 ml-2"
                        disabled={!user}
                    >
                        Add to Cart
                    </button>
                    {user && user.role === 'Buyer' && (
                        <button
                            onClick={handleToggleFavorite}
                            className="mt-4 ml-2 text-red-600 hover:text-red-800"
                        >
                            {isFavorite ? <FaHeart size={20} /> : <FaRegHeart size={20} />}
                        </button>
                    )}
                </div>
            </div>

            <div className="mt-8">
                <div className="border-b">
                    <button
                        onClick={() => setActiveTab('reviews')}
                        className={`px-4 py-2 font-semibold ${activeTab === 'reviews' ? 'border-b-2 border-primary text-primary' : 'text-gray-600'}`}
                    >
                        Reviews
                    </button>
                    <button
                        onClick={() => setActiveTab('messages')}
                        className={`px-4 py-2 font-semibold ${activeTab === 'messages' ? 'border-b-2 border-primary text-primary' : 'text-gray-600'} relative`}
                    >
                        Message Farmer
                        {unreadCount > 0 && (
                            <span className="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                                {unreadCount}
                            </span>
                        )}
                    </button>
                </div>
                {activeTab === 'reviews' && (
                    <div className="mt-4">
                        {reviews.length === 0 ? (
                            <p>No reviews yet.</p>
                        ) : (
                            reviews.map(review => (
                                <div key={review.id} className="border p-4 rounded">
                                    <p><strong>{review.buyer_name}</strong> - {new Date(review.created_at).toLocaleDateString()}</p>
                                    <p>Rating: {review.rating}/5</p>
                                    <p>{review.comment}</p>
                                </div>
                            ))
                        )}
                        {user && user.role === 'Buyer' && (
                            <div className="mt-6">
                                <h4 className="text-lg font-semibold mb-2">Add Your Review</h4>
                                <div className="space-y-4">
                                    <div>
                                        <label className="block text-gray-700">Rating (1-5)</label>
                                        <input
                                            type="number"
                                            min="1"
                                            max="5"
                                            value={newReview.rating}
                                            onChange={(e) => setNewReview({ ...newReview, rating: Number(e.target.value) })}
                                            className="w-20 p-2 border rounded"
                                        />
                                    </div>
                                    <div>
                                        <label className="block text-gray-700">Comment</label>
                                        <textarea
                                            value={newReview.comment}
                                            onChange={(e) => setNewReview({ ...newReview, comment: e.target.value })}
                                            className="w-full p-2 border rounded"
                                            rows={3}
                                        />
                                    </div>
                                    {reviewError && (
                                        <p className="text-red-600">{reviewError}</p>
                                    )}
                                    <button
                                        onClick={handleReviewSubmit}
                                        className="bg-primary text-white px-4 py-2 rounded hover:bg-secondary"
                                    >
                                        Submit Review
                                    </button>
                                </div>
                            </div>
                        )}
                    </div>
                )}
                {activeTab === 'messages' && user && user.role === 'Buyer' ? (
                    <div className="mt-4">
                        <h4 className="text-lg font-semibold mb-2">Chat with {product.farmer_name}</h4>
                        <div ref={chatContainerRef} className="border rounded p-4 h-64 overflow-y-auto mb-4 bg-gray-50">
                            {messages.length === 0 ? (
                                <p className="text-gray-500">No messages yet. Start the conversation!</p>
                            ) : (
                                messages.map((message, index) => {
                                    const messageDate = new Date(message.created_at);
                                    const prevMessageDate = index > 0 ? new Date(messages[index - 1].created_at) : null;
                                    const showDateHeader =
                                        index === 0 ||
                                        (prevMessageDate &&
                                            !isSameDay(messageDate, prevMessageDate));

                                    return (
                                        <React.Fragment key={message.id}>
                                            {showDateHeader && (
                                                <div className="text-center my-4">
                                                    <span className="bg-gray-200 text-gray-700 text-xs px-3 py-1 rounded-full">
                                                        {formatMessageGroupDate(messageDate)}
                                                    </span>
                                                </div>
                                            )}
                                            <div className={`mb-3 flex ${message.sender_id === user.id ? 'justify-end' : 'justify-start'}`}>
                                                {message.sender_id !== user.id && (
                                                    <div className="w-8 h-8 bg-gray-300 text-gray-700 rounded-full flex items-center justify-center mr-2">
                                                        {getInitials(message.sender_name)}
                                                    </div>
                                                )}
                                                <div className="flex flex-col">
                                                    <p className="text-xs text-gray-500 mb-1">
                                                        {message.sender_id === user.id ? 'You' : message.sender_name} • {formatDistanceToNow(messageDate, { addSuffix: true })}
                                                        {message.sender_id === user.id && (
                                                            <span className="ml-2 text-xs">
                                                                {message.status === 'sent' && '✓ Sent'}
                                                                {message.status === 'delivered' && '✓✓ Delivered'}
                                                                {message.status === 'read' && '✓✓ Read'}
                                                            </span>
                                                        )}
                                                    </p>
                                                    <div className={`inline-block p-3 rounded-lg max-w-xs ${message.sender_id === user.id ? 'bg-primary text-white rounded-br-none' : 'bg-gray-200 text-gray-800 rounded-bl-none'}`}>
                                                        {message.content}
                                                    </div>
                                                </div>
                                                {message.sender_id === user.id && (
                                                    <div className="w-8 h-8 bg-primary text-white rounded-full flex items-center justify-center ml-2">
                                                        {getInitials(user.name || 'Unknown')}
                                                    </div>
                                                )}
                                            </div>
                                        </React.Fragment>
                                    );
                                })
                            )}
                            {isFarmerTyping && (
                                <div className="text-left text-gray-500 text-sm mt-2">
                                    {product.farmer_name} is typing...
                                </div>
                            )}
                        </div>
                        <div className="flex gap-2">
                            <input
                                type="text"
                                value={newMessage}
                                onChange={(e) => setNewMessage(e.target.value)}
                                placeholder="Type your message..."
                                className="flex-1 p-2 border rounded focus:outline-none focus:ring-2 focus:ring-primary"
                            />
                            <button
                                onClick={handleSendMessage}
                                className="bg-primary text-white px-4 py-2 rounded hover:bg-secondary"
                                disabled={!newMessage.trim()}
                            >
                                Send
                            </button>
                        </div>
                        {sendError && (
                            <div className="mt-2 text-red-600 flex items-center">
                                <span>Failed to send: {sendError}</span>
                                <button onClick={handleRetrySend} className="ml-2 text-primary underline">Retry</button>
                            </div>
                        )}
                    </div>
                ) : activeTab === 'messages' && <p>Please log in as a buyer to message the farmer.</p>}
            </div>

            <div className="mt-6">
                <h3 className="text-lg font-semibold text-primary mb-2">Additional Information</h3>
                <p><strong>Sold by:</strong> {product.farmer_name || 'Unknown Farmer'}</p>
                <p><strong>Location:</strong> {product.farmer_location || 'Not provided'}</p>
                <p><strong>Phone:</strong> {user ? (product.farmer_phone || 'Not provided') : 'Hidden for unregistered users'}</p>
                <div>
                    <h4 className="text-md font-semibold text-primary mt-2">Safety Tips for Deal</h4>
                    <ul className="list-disc pl-5 space-y-2 text-gray-600">
                        <li>Meet in a public place for the exchange, such as a local market or a well-lit area.</li>
                        <li>Verify the product quality before finalizing the deal.</li>
                        <li>Communicate through the platform’s messaging system to keep a record of your conversation.</li>
                        <li>Avoid sharing personal information like your home address until you trust the farmer.</li>
                        <li>If something feels off, report the issue to support immediately.</li>
                    </ul>
                </div>
            </div>
        </div>
    );
};

const isSameDay = (date1: Date, date2: Date) => {
    return date1.getFullYear() === date2.getFullYear() &&
        date1.getMonth() === date2.getMonth() &&
        date1.getDate() === date2.getDate();
};

export default ProductDetail;