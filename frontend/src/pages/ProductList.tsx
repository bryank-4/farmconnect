// frontend/src/pages/ProductList.tsx
import React, { useEffect, useState } from 'react';
import { supabase } from '../utils/supabase';
import ProductCard from '../components/ProductCard';
import SearchBar from '../components/SearchBar';
import FilterPanel from '../components/FilterPanel';

const ProductList: React.FC = () => {
    const [products, setProducts] = useState<any[]>([]);
    const [filteredProducts, setFilteredProducts] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [searchQuery, setSearchQuery] = useState('');
    const [filters, setFilters] = useState({ category: '', minPrice: 0, maxPrice: Infinity });

    useEffect(() => {
        const fetchProducts = async () => {
            const { data, error } = await supabase.from('products').select('*');
            if (error) console.error(error);
            else {
                setProducts(data || []);
                setFilteredProducts(data || []);
            }
            setLoading(false);
        };
        fetchProducts();
    }, []);

    useEffect(() => {
        let filtered = products;
        if (searchQuery) {
            filtered = filtered.filter((p) =>
                p.name.toLowerCase().includes(searchQuery.toLowerCase())
            );
        }
        if (filters.category) {
            filtered = filtered.filter((p) => p.category === filters.category);
        }
        filtered = filtered.filter(
            (p) => p.price >= filters.minPrice && p.price <= filters.maxPrice
        );
        setFilteredProducts(filtered);
    }, [searchQuery, filters, products]);

    if (loading) return <div>Loading...</div>;

    return (
        <div className="mt-6">
            <div className="flex flex-col md:flex-row gap-4">
                <div className="md:w-1/4">
                    <FilterPanel setFilters={setFilters} />
                </div>
                <div className="md:w-3/4">
                    <SearchBar setSearchQuery={setSearchQuery} />
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-4">
                        {filteredProducts.map((product) => (
                            <ProductCard key={product.id} product={product} />
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ProductList;