// frontend/src/components/OrderTracker.tsx
import React from 'react';

const OrderTracker: React.FC<{ status: string }> = ({ status }) => {
    const stages = ['Pending', 'Confirmed', 'Shipped', 'Delivered'];
    const currentIndex = stages.indexOf(status);

    return (
        <div className="mt-4">
            <div className="flex justify-between items-center">
                {stages.map((stage, index) => (
                    <div key={stage} className="text-center">
                        <div
                            className={`w-8 h-8 mx-auto rounded-full ${
                                index <= currentIndex ? 'bg-primary text-white' : 'bg-gray-300'
                            }`}
                        >
                            {index + 1}
                        </div>
                        <p className="text-sm mt-1">{stage}</p>
                    </div>
                ))}
            </div>
            <div className="relative mt-2">
                <div className="h-1 bg-gray-300 absolute top-1/2 w-full"></div>
                <div
                    className="h-1 bg-primary absolute top-1/2"
                    style={{ width: `${(currentIndex / (stages.length - 1)) * 100}%` }}
                ></div>
            </div>
        </div>
    );
};

export default OrderTracker;