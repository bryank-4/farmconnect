// frontend/src/pages/TransactionHistory.tsx
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';

const TransactionHistory: React.FC = () => {
    const { user } = useAuth();
    const [transactions, setTransactions] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchTransactions = async () => {
            if (!user || user.role !== 'Admin') return;
            const { data, error } = await supabase
                .from('transactions')
                .select('id, order_id, amount, status, payment_method, created_at')
                .order('created_at', { ascending: false })
                .limit(3);
            if (error) console.error(error);
            else setTransactions(data || []);
            setLoading(false);
        };
        fetchTransactions();
    }, [user]);

    if (loading) return <div>Loading...</div>;
    if (!user || user.role !== 'Admin') return <div>Access denied.</div>;

    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">Transaction History</h2>
            <div className="mb-4 flex space-x-4">
                <select className="p-2 border rounded">
                    <option>All Time</option>
                    <option>Custom Range</option>
                </select>
                <button className="bg-green-600 text-white p-2 rounded">Export</button>
            </div>
            <div className="bg-white p-4 rounded-lg shadow overflow-x-auto">
                <table className="w-full text-left">
                    <thead>
                    <tr className="bg-gray-100">
                        <th className="p-2">#</th>
                        <th className="p-2">Order ID</th>
                        <th className="p-2">Amount</th>
                        <th className="p-2">Status</th>
                        <th className="p-2">Payment Method</th>
                        <th className="p-2">Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    {transactions.map((t, index) => (
                        <tr key={t.id} className="border-t">
                            <td className="p-2">{index + 1}</td>
                            <td className="p-2">ORD{t.order_id.toString().padStart(3, '0')}</td>
                            <td className="p-2">KES {t.amount.toLocaleString()}</td>
                            <td className="p-2">
                  <span className={t.status === 'pending' ? 'text-yellow-500' : 'text-green-600'}>
                    {t.status}
                  </span>
                            </td>
                            <td className="p-2">{t.payment_method}</td>
                            <td className="p-2">{new Date(t.created_at).toLocaleDateString()}</td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            </div>
            <div className="mt-6 bg-white p-4 rounded-lg shadow">
                <h3 className="text-lg font-semibold mb-4">Reports</h3>
                <div className="flex space-x-4 mb-4">
                    <select className="p-2 border rounded">
                        <option>Sales Report</option>
                    </select>
                    <select className="p-2 border rounded">
                        <option>Weekly</option>
                    </select>
                    <button className="bg-green-600 text-white p-2 rounded">Generate Report</button>
                </div>
                <div>
                    <h4 className="text-md font-semibold mb-2">Recent Reports</h4>
                    <ul className="space-y-2">
                        <li>Sales Report - March 2024 <span className="text-green-600">⬇</span></li>
                        <li>User Activity Report - March 2024 <span className="text-green-600">⬇</span></li>
                    </ul>
                </div>
            </div>
        </div>
    );
};

export default TransactionHistory;