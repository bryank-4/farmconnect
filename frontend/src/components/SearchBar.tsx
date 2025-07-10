// frontend/src/components/SearchBar.tsx
import React from 'react';

const SearchBar: React.FC<{ setSearchQuery: (query: string) => void }> = ({ setSearchQuery }) => {
    return (
        <input
            type="text"
            placeholder="Search products..."
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full p-2 border rounded focus:outline-none focus:ring-2 focus:ring-primary"
            aria-label="Search products"
        />
    );
};

export default SearchBar;