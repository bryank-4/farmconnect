import React, { useState, useEffect, useRef } from 'react';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';
import { toast } from 'react-toastify';
import { formatDistanceToNow, isToday, isYesterday, format } from 'date-fns';
import { useLocation } from 'react-router-dom';

interface Message {
    id: string;
    sender_id: string;
    receiver_id: string;
    content: string;
    created_at: string;
    status: 'sent' | 'delivered' | 'read';
    product_id: string;
    sender_name: string;
    receiver_name: string;
}

interface BuyerConversation {
    buyer_id: string;
    buyer_name: string;
    product_id: string;
    product_name: string;
    last_message: string;
    last_message_time: string;
    unread_count: number;
}

const MessagingUI: React.FC = () => {
    const { user } = useAuth();
    const location = useLocation();
    const [conversations, setConversations] = useState<BuyerConversation[]>([]);
    const [selectedConversation, setSelectedConversation] = useState<BuyerConversation | null>(null);
    const [messages, setMessages] = useState<Message[]>([]);
    const [newMessage, setNewMessage] = useState('');
    const [loading, setLoading] = useState(true);
    const [isBuyerTyping, setIsBuyerTyping] = useState(false);
    const [sendError, setSendError] = useState<string | null>(null);
    const chatEndRef = useRef<HTMLDivElement>(null);

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

    const fetchConversations = async () => {
        if (!user?.id) return;

        try {
            const { data: messagesData, error: messagesError } = await supabase
                .from('messages')
                .select(`
                    *,
                    sender:users!sender_id(id, name),
                    products!product_id(name)
                `)
                .eq('receiver_id', user.id)
                .order('created_at', { ascending: false });

            if (messagesError) throw messagesError;

            const groupedConversations = messagesData.reduce((acc: { [key: string]: BuyerConversation }, message: any) => {
                const key = `${message.sender_id}_${message.product_id}`;
                if (!acc[key]) {
                    acc[key] = {
                        buyer_id: message.sender_id,
                        buyer_name: message.sender?.name || 'Unknown',
                        product_id: message.product_id,
                        product_name: message.products?.name || 'Unknown Product',
                        last_message: message.content,
                        last_message_time: message.created_at,
                        unread_count: message.receiver_id === user.id && ['sent', 'delivered'].includes(message.status) ? 1 : 0,
                    };
                } else {
                    acc[key].last_message = message.content;
                    acc[key].last_message_time = message.created_at;
                    if (message.receiver_id === user.id && ['sent', 'delivered'].includes(message.status)) {
                        acc[key].unread_count += 1;
                    }
                }
                return acc;
            }, {});

            const conversationsArray = Object.values(groupedConversations).sort(
                (a, b) => new Date(b.last_message_time).getTime() - new Date(a.last_message_time).getTime()
            );
            setConversations(conversationsArray);

            // Check if navigated from notification
            const { buyerId, productId } = (location.state as { buyerId?: string; productId?: string }) || {};
            if (buyerId && productId) {
                const conversation = conversationsArray.find(
                    (conv) => conv.buyer_id === buyerId && conv.product_id === productId
                );
                if (conversation) {
                    setSelectedConversation(conversation);
                    fetchMessages(conversation.buyer_id, conversation.product_id);
                }
            }
        } catch (error) {
            console.error('Fetch conversations error:', error);
            toast.error('Failed to load conversations');
        } finally {
            setLoading(false);
        }
    };

    const fetchMessages = async (buyerId: string, productId: string) => {
        if (!user) return;

        const token = await supabase.auth.getSession().then(({ data }) => data.session?.access_token);
        if (!token) {
            toast.error('No valid authentication token found. Please log in again.');
            return;
        }

        try {
            const response = await fetch(
                `http://localhost:3001/api/messages?receiver_id=${buyerId}&product_id=${productId}`,
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                }
            );
            const data = await response.json();
            if (!response.ok) throw new Error(data.error || 'Failed to fetch messages');
            setMessages(data || []);
            await markMessagesAsRead(buyerId, productId);
            setConversations((prev) =>
                prev.map((conv) =>
                    conv.buyer_id === buyerId && conv.product_id === productId
                        ? { ...conv, unread_count: 0 }
                        : conv
                )
            );
        } catch (error) {
            console.error('Fetch messages error:', error);
            toast.error(`Failed to load messages: ${(error as Error).message}`);
        }
    };

    const markMessagesAsRead = async (senderId: string, productId: string) => {
        const token = await supabase.auth.getSession().then(({ data }) => data.session?.access_token);
        if (!token) return;

        try {
            const response = await fetch('http://localhost:3001/api/messages/mark-read', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`,
                },
                body: JSON.stringify({ sender_id: senderId, product_id: productId }),
            });
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || 'Failed to mark messages as read');
            }
        } catch (error) {
            console.error('Mark as read error:', error);
        }
    };

    const handleSend = async () => {
        if (!user?.id || !newMessage.trim() || !selectedConversation) {
            toast.error('Please select a conversation and type a message.');
            return;
        }

        const token = await supabase.auth.getSession().then(({ data }) => data.session?.access_token);
        if (!token) {
            toast.error('No valid authentication token found. Please log in again.');
            return;
        }

        try {
            const typingChannel = supabase.channel(`typing:${selectedConversation.buyer_id}:${user.id}:${selectedConversation.product_id}`);
            await typingChannel.send({
                type: 'broadcast',
                event: 'typing',
                payload: { sender_id: user.id, product_id: selectedConversation.product_id },
            }).catch((error) => console.error('Broadcast typing error:', error));

            const response = await fetch('http://localhost:3001/api/messages', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`,
                },
                body: JSON.stringify({
                    receiver_id: selectedConversation.buyer_id,
                    content: newMessage,
                    status: 'sent',
                    product_id: selectedConversation.product_id,
                }),
            });
            const data = await response.json();
            if (!response.ok) throw new Error(data.error || 'Failed to send message');
            setMessages((prev) => [...prev, {
                ...data,
                sender_name: user.name || 'Unknown',
                receiver_name: selectedConversation.buyer_name || 'Unknown',
                product_id: selectedConversation.product_id,
            }]);
            setNewMessage('');
            setSendError(null);
            toast.success('Message sent!');
            setConversations((prev) =>
                prev.map((conv) =>
                    conv.buyer_id === selectedConversation.buyer_id && conv.product_id === selectedConversation.product_id
                        ? { ...conv, last_message: newMessage, last_message_time: new Date().toISOString() }
                        : conv
                ).sort(
                    (a, b) => new Date(b.last_message_time).getTime() - new Date(a.last_message_time).getTime()
                )
            );
        } catch (error) {
            console.error('Send message error:', error);
            setSendError((error as Error).message);
            toast.error(`Failed to send message: ${(error as Error).message}`);
        }
    };

    const handleRetrySend = () => {
        setSendError(null);
        handleSend();
    };

    useEffect(() => {
        fetchConversations();
    }, [user]);

    useEffect(() => {
        if (!user?.id) return;

        // Real-time subscription for new messages
        const messageChannel = supabase
            .channel('messages_all_conversations')
            .on('postgres_changes', {
                event: 'INSERT',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user.id}`,
            }, (payload) => {
                const newMessage: Message = {
                    id: payload.new.id || '',
                    sender_id: payload.new.sender_id || '',
                    receiver_id: payload.new.receiver_id || '',
                    content: payload.new.content || '',
                    sender_name: '', // Will be populated by fetchConversations
                    receiver_name: user.name || 'Unknown',
                    created_at: payload.new.created_at || '',
                    status: payload.new.status || 'sent',
                    product_id: payload.new.product_id || '',
                };
                setConversations((prev) => {
                    const key = `${newMessage.sender_id}_${newMessage.product_id}`;
                    const existingConv = prev.find(
                        (conv) => conv.buyer_id === newMessage.sender_id && conv.product_id === newMessage.product_id
                    );
                    if (existingConv) {
                        return prev
                            .map((conv) =>
                                conv.buyer_id === newMessage.sender_id && conv.product_id === newMessage.product_id
                                    ? {
                                        ...conv,
                                        last_message: newMessage.content,
                                        last_message_time: newMessage.created_at,
                                        unread_count: conv.unread_count + (newMessage.status === 'sent' || newMessage.status === 'delivered' ? 1 : 0),
                                    }
                                    : conv
                            )
                            .sort(
                                (a, b) => new Date(b.last_message_time).getTime() - new Date(a.last_message_time).getTime()
                            );
                    }
                    // Fetch conversations to get sender and product names for new conversations
                    fetchConversations();
                    return prev;
                });

                // If the message is for the current conversation, add it to messages
                if (
                    selectedConversation &&
                    selectedConversation.buyer_id === newMessage.sender_id &&
                    selectedConversation.product_id === newMessage.product_id
                ) {
                    setMessages((prev) => [
                        ...prev,
                        { ...newMessage, sender_name: selectedConversation.buyer_name },
                    ]);
                }
            })
            .on('postgres_changes', {
                event: 'UPDATE',
                schema: 'public',
                table: 'messages',
                filter: `receiver_id=eq.${user.id}`,
            }, () => {
                fetchConversations(); // Refresh conversations to update unread counts
            })
            .subscribe();

        return () => {
            messageChannel.unsubscribe();
        };
    }, [user, selectedConversation]);

    useEffect(() => {
        if (!user?.id || !selectedConversation) return;

        const typingChannel = supabase.channel(`typing:${user.id}:${selectedConversation.buyer_id}:${selectedConversation.product_id}`);
        typingChannel
            .on('broadcast', { event: 'typing' }, (payload) => {
                if (payload.sender_id === selectedConversation.buyer_id && payload.product_id === selectedConversation.product_id) {
                    setIsBuyerTyping(true);
                    setTimeout(() => setIsBuyerTyping(false), 3000);
                }
            })
            .subscribe((status) => {
                console.log('Typing channel subscription status:', status);
            });

        return () => {
            typingChannel.unsubscribe();
        };
    }, [user, selectedConversation]);

    useEffect(() => {
        chatEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    }, [messages]);

    const handleSelectConversation = (conversation: BuyerConversation) => {
        setSelectedConversation(conversation);
        fetchMessages(conversation.buyer_id, conversation.product_id);
    };

    if (loading) return <div className="text-center text-gray-600">Loading conversations...</div>;
    if (!user) return <div className="text-center text-gray-600">Please log in to view messages.</div>;

    return (
        <div className="border rounded-lg p-4 shadow-lg bg-white h-[600px] flex">
            <div className="w-1/3 border-r overflow-y-auto">
                <h3 className="text-xl font-semibold text-[#795548] mb-4">Conversations</h3>
                {conversations.length === 0 ? (
                    <p className="text-gray-500">No conversations yet.</p>
                ) : (
                    <ul>
                        {conversations.map((conversation) => (
                            <li
                                key={`${conversation.buyer_id}_${conversation.product_id}`}
                                onClick={() => handleSelectConversation(conversation)}
                                className={`relative p-3 mb-2 rounded-lg cursor-pointer hover:bg-gray-100 flex justify-between items-center ${
                                    selectedConversation?.buyer_id === conversation.buyer_id &&
                                    selectedConversation?.product_id === conversation.product_id
                                        ? 'bg-gray-200'
                                        : ''
                                }`}
                            >
                                <div>
                                    <p className="font-semibold">{conversation.buyer_name}</p>
                                    <p className="text-sm text-gray-600">{conversation.product_name}</p>
                                    <p className="text-sm text-gray-500 truncate">{conversation.last_message}</p>
                                </div>
                                {conversation.unread_count > 0 && (
                                    <span className="bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                                        {conversation.unread_count}
                                    </span>
                                )}
                            </li>
                        ))}
                    </ul>
                )}
            </div>
            <div className="w-2/3 flex flex-col">
                {selectedConversation ? (
                    <>
                        <h3 className="text-xl font-semibold text-[#795548] mb-4 px-4">
                            Chat with {selectedConversation.buyer_name} - {selectedConversation.product_name}
                        </h3>
                        <div className="flex-1 overflow-y-auto mb-4 p-4 bg-gray-100 rounded">
                            {messages.length === 0 ? (
                                <p className="text-gray-500 text-center">No messages yet.</p>
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
                                                    <div className={`inline-block p-3 rounded-lg max-w-xs ${message.sender_id === user.id ? 'bg-[#2E7D32] text-white rounded-br-none' : 'bg-[#FF9800] text-white rounded-bl-none'}`}>
                                                        {message.content}
                                                    </div>
                                                </div>
                                                {message.sender_id === user.id && (
                                                    <div className="w-8 h-8 bg-[#2E7D32] text-white rounded-full flex items-center justify-center ml-2">
                                                        {getInitials(user.name || 'Unknown')}
                                                    </div>
                                                )}
                                            </div>
                                        </React.Fragment>
                                    );
                                })
                            )}
                            {isBuyerTyping && (
                                <div className="text-left text-gray-500 text-sm mt-2">
                                    {selectedConversation.buyer_name} is typing...
                                </div>
                            )}
                            <div ref={chatEndRef} />
                        </div>
                        <div className="flex gap-2 px-4">
                            <input
                                type="text"
                                value={newMessage}
                                onChange={(e) => setNewMessage(e.target.value)}
                                placeholder="Type a message..."
                                className="w-full p-2 border rounded focus:outline-none focus:ring-2 focus:ring-[#2E7D32]"
                            />
                            <button
                                onClick={handleSend}
                                className="bg-[#FF9800] text-white px-4 py-2 rounded hover:bg-[#e68a00] transition disabled:bg-gray-300"
                                disabled={!newMessage.trim()}
                            >
                                Send
                            </button>
                        </div>
                        {sendError && (
                            <div className="mt-2 text-red-600 flex items-center px-4">
                                <span>Failed to send: {sendError}</span>
                                <button onClick={handleRetrySend} className="ml-2 text-[#2E7D32] underline">Retry</button>
                            </div>
                        )}
                    </>
                ) : (
                    <div className="flex-1 flex items-center justify-center">
                        <p className="text-gray-500">Select a conversation to start chatting.</p>
                    </div>
                )}
            </div>
        </div>
    );
};

const isSameDay = (date1: Date, date2: Date) => {
    return date1.getFullYear() === date2.getFullYear() &&
        date1.getMonth() === date2.getMonth() &&
        date1.getDate() === date2.getDate();
};

export default MessagingUI;