import React, { useEffect, useState } from 'react';
import { supabase } from '../utils/supabase';
import { useAuth } from '../context/AuthContext';
import ProductCard from '../components/ProductCard';
import { toast } from 'react-toastify';

const Favorites: React.FC = () => {
    const { user } = useAuth();
    const [favorites, setFavorites] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchFavorites = async () => {
            if (!user) return;
            const { data, error } = await supabase
                .from('favorites')
                .select('id, product_id, products(*)')
                .eq('buyer_id', user.id);
            if (error) {
                console.error('Fetch favorites error:', error);
                toast.error('Failed to load favorites');
            } else {
                setFavorites(data || []);
            }
            setLoading(false);
        };
        fetchFavorites();
    }, [user]);

    const handleRemoveFavorite = async (favoriteId: string) => {
        if (!window.confirm('Are you sure you want to remove this favorite?')) return;
        if (!user) return;
        const { error } = await supabase
            .from('favorites')
            .delete()
            .eq('id', favoriteId)
            .eq('buyer_id', user.id);
        if (error) {
            toast.error(`Failed to remove favorite: ${error.message}`);
        } else {
            setFavorites(favorites.filter(fav => fav.id !== favoriteId));
            toast.success('Favorite removed');
        }
    };

    const handleAddFavorite = async (productId: string) => {
        if (!user || favorites.some(fav => fav.product_id === productId)) return;
        const { error } = await supabase
            .from('favorites')
            .insert({ buyer_id: user.id, product_id: productId });
        if (error) {
            toast.error(`Failed to add favorite: ${error.message}`);
        } else {
            const { data } = await supabase
                .from('favorites')
                .select('id, product_id, products(*)')
                .eq('buyer_id', user.id)
                .eq('product_id', productId)
                .single();
            setFavorites([...favorites, data]);
            toast.success('Added to favorites');
        }
    };

    if (loading) return <div className="text-center py-10">Loading...</div>;
    if (!user) return <div className="text-center py-10 text-red-600">Please log in to view your favorites.</div>;

    return (
        <div className="mt-6 p-4">
            <h2 className="text-2xl font-bold text-primary mb-6">My Favorites</h2>
            {favorites.length === 0 ? (
                <div className="text-center text-gray-500 py-10">
                    <p>No favorites yet.</p>
                    <p className="mt-2">Save products from the product details page to see them here!</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                    {favorites.map((fav) => (
                        <div key={fav.id} className="relative border rounded-lg shadow-md p-4 hover:shadow-lg transition-shadow">
                            <ProductCard product={fav.products} />
                            <button
                                onClick={() => handleRemoveFavorite(fav.id)}
                                className="absolute top-2 right-2 text-red-600 hover:text-red-800"
                            >
                                <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm5 13.59L15.59 17 12 13.41 8.41 17 7 15.59 10.59 12 7 8.41 8.41 7 12 10.59 15.59 7 17 8.41 13.41 12 17 15.59z"/>
                                </svg>
                            </button>
                            <button
                                onClick={() => handleAddFavorite(fav.product_id)}
                                className="mt-4 w-full bg-primary text-white py-2 rounded hover:bg-secondary disabled:opacity-50"
                                disabled={true} // Disable add since it's already a favorite
                            >
                                Already in Favorites
                            </button>
                        </div>
                    ))}
                </div>
            )}
            <div className="mt-6 text-center">
                <p className="text-gray-600">Tip: Click the heart icon on product pages to save or remove favorites instantly!</p>
            </div>
        </div>
    );
};

export default Favorites;