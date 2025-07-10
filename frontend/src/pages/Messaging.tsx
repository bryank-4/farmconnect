import React from 'react';
import MessagingUI from '../components/MessagingUI';

const Messaging: React.FC = () => {
    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold text-primary mb-4">Messages</h2>
            <MessagingUI />
        </div>
    );
};

export default Messaging;