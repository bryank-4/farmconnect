// frontend/src/components/FilterPanel.tsx
import React, { useState } from 'react';

const FilterPanel: React.FC<{ setFilters: (filters: any) => void }> = ({ setFilters }) => {
    const [category, setCategory] = useState('');
    const [minPrice, setMinPrice] = useState(0);
    const [maxPrice, setMaxPrice] = useState(10000);

    const applyFilters = () => {
        setFilters({
            category,
            minPrice: Number(minPrice) || 0,
            maxPrice: Number(maxPrice) || Infinity,
        });
    };

    return (
        <div className="p-4 border rounded shadow">
            <h3 className="text-lg font-semibold mb-4">Filters</h3>
            <div className="mb-4">
                <label className="block text-gray-700">Category</label>
                <select
                    value={category}
                    onChange={(e) => setCategory(e.target.value)}
                    className="w-full p-2 border rounded"
                >
                    <option value="">All Categories</option>
                    <option value="Cereals & Grains">Cereals & Grains</option>
                    <option value="Vegetables">Vegetables</option>
                    <option value="Fruits">Fruits</option>
                    <option value="Dairy">Dairy</option>
                    <option value="Poultry Eggs">Poultry Eggs</option>
                    <option value="Meat & Livestock">Meat & Livestock</option>
                    <option value="Seedlings">Seedlings</option>
                </select>
            </div>
            <div className="mb-4">
                <label className="block text-gray-700">Min Price (KSH)</label>
                <input
                    type="number"
                    value={minPrice}
                    onChange={(e) => setMinPrice(Number(e.target.value))}
                    className="w-full p-2 border rounded"
                />
            </div>
            <div className="mb-4">
                <label className="block text-gray-700">Max Price (KSH)</label>
                <input
                    type="number"
                    value={maxPrice}
                    onChange={(e) => setMaxPrice(Number(e.target.value))}
                    className="w-full p-2 border rounded"
                />
            </div>
            <button
                onClick={applyFilters}
                className="w-full bg-primary text-white p-2 rounded hover:bg-secondary"
            >
                Apply Filters
            </button>
        </div>
    );
};

export default FilterPanel;