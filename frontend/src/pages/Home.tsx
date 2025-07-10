import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import ProductCard from '../components/ProductCard';

interface Product {
    id: string;
    name: string;
    description: string;
    price: number;
    category: string;
    images: string[];
    farmer_name: string;
}

const Home: React.FC = () => {
    const [featuredProducts, setFeaturedProducts] = useState<Product[]>([]);
    const [loading, setLoading] = useState(true);
    const [searchQuery, setSearchQuery] = useState('');
    const [category, setCategory] = useState('');

    useEffect(() => {
        const fetchFeaturedProducts = async () => {
            try {
                const response = await fetch(`http://localhost:3001/api/products?limit=4`);
                const productData = await response.json();
                if (response.ok) {
                    setFeaturedProducts(productData || []);
                } else {
                    console.error('Fetch featured products error:', productData.error);
                }
            } catch (error) {
                console.error('Error fetching featured products:', error);
            } finally {
                setLoading(false);
            }
        };

        fetchFeaturedProducts();
    }, []);

    const handleSearch = (e: React.FormEvent) => {
        e.preventDefault();
        const searchParams = new URLSearchParams({ search: searchQuery, category });
        window.location.href = `/products?${searchParams.toString()}`;
    };

    return (
        <div>
            {/* Hero Section */}
            <section className="relative bg-gradient-to-r from-green-700 to-green-900 text-white">
                <div className="absolute inset-0 bg-black opacity-40"></div>
                <div
                    className="absolute inset-0 bg-cover bg-center"
                    style={{
                        backgroundImage: "url('https://images.pexels.com/photos/2252584/pexels-photo-2252584.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')",
                        mixBlendMode: 'overlay'
                    }}
                ></div>
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 relative z-10">
                    <div className="max-w-3xl">
                        <h1 className="text-4xl sm:text-5xl font-bold mb-4 leading-tight">
                            Welcome to FarmConnect
                        </h1>
                        <p className="text-xl mb-8 text-gray-100">
                            Connect with farmers and buyers across Kenya to build a thriving agricultural marketplace.
                        </p>
                        <div className="flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4">
                            <Link to="/signup?role=farmer" className="bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-md text-lg font-medium">
                                Join as a Farmer
                            </Link>
                            <Link to="/signup?role=buyer" className="bg-white hover:bg-gray-100 text-green-800 px-6 py-3 rounded-md text-lg font-medium">
                                Join as a Buyer
                            </Link>
                        </div>
                    </div>
                </div>
            </section>

            {/* Search Section */}
            <section className="bg-white py-6 shadow-md relative z-20 -mt-8 mx-4 rounded-lg sm:mx-8 lg:mx-auto lg:max-w-6xl">
                <div className="max-w-5xl mx-auto px-4">
                    <form onSubmit={handleSearch} className="flex flex-col md:flex-row gap-3">
                        <div className="flex-1">
                            <input
                                type="text"
                                className="w-full p-2 border rounded focus:outline-none focus:ring-2 focus:ring-green-500"
                                placeholder="Search products, farmers, locations..."
                                value={searchQuery}
                                onChange={(e) => setSearchQuery(e.target.value)}
                            />
                        </div>
                        <div>
                            <select
                                className="w-full p-2 border rounded"
                                value={category}
                                onChange={(e) => setCategory(e.target.value)}
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
                        <button className="bg-green-600 hover:bg-green-700 text-white py-3 px-6 rounded-md">
                            Search
                        </button>
                    </form>
                </div>
            </section>

            {/* Featured Products Section */}
            <section className="py-16">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="flex justify-between items-center mb-8">
                        <h2 className="text-3xl font-bold text-gray-900">Featured Products</h2>
                        <Link to="/products" className="text-green-600 hover:underline flex items-center font-medium">
                            View all products
                        </Link>
                    </div>

                    {loading ? (
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                            {[...Array(4)].map((_, i) => (
                                <div key={i} className="bg-white p-4 rounded-lg shadow">
                                    <div className="h-48 bg-gray-200"></div>
                                    <div className="p-4">
                                        <div className="h-4 bg-gray-200 rounded w-3/4 mb-2"></div>
                                        <div className="h-4 bg-gray-200 rounded w-1/2 mb-4"></div>
                                        <div className="h-4 bg-gray-200 rounded w-full mb-2"></div>
                                        <div className="h-4 bg-gray-200 rounded w-full mb-4"></div>
                                        <div className="h-8 bg-gray-200 rounded w-1/3"></div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                            {featuredProducts.slice(0, 4).map((product) => (
                                <ProductCard key={product.id} product={product} />
                            ))}
                        </div>
                    )}
                </div>
            </section>

            {/* How It Works Section */}
            <section className="py-16 bg-gray-50">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="text-center mb-12">
                        <h2 className="text-3xl font-bold text-gray-900 mb-4">How FarmConnect Works</h2>
                        <p className="text-lg text-gray-600 max-w-3xl mx-auto">
                            Our platform simplifies the connection between farmers and buyers, ensuring fair prices and direct relationships.
                        </p>
                    </div>

                    <div className="grid md:grid-cols-3 gap-8">
                        <div className="bg-white p-6 rounded-lg shadow-md text-center">
                            <div className="text-4xl mb-4">👥</div>
                            <h3 className="text-xl font-semibold mb-3">Connect Directly</h3>
                            <p className="text-gray-600">
                                Farmers list their products, and buyers connect directly, eliminating middlemen.
                            </p>
                        </div>

                        <div className="bg-white p-6 rounded-lg shadow-md text-center">
                            <div className="text-4xl mb-4">📈</div>
                            <h3 className="text-xl font-semibold mb-3">Fair Pricing</h3>
                            <p className="text-gray-600">
                                Access transparent pricing to ensure fair deals for both farmers and buyers.
                            </p>
                        </div>

                        <div className="bg-white p-6 rounded-lg shadow-md text-center">
                            <div className="text-4xl mb-4">🔒</div>
                            <h3 className="text-xl font-semibold mb-3">Secure Transactions</h3>
                            <p className="text-gray-600">
                                Conduct business with confidence using secure payments and communication.
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            {/* Testimonials Section */}
            <section className="py-16">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="text-center mb-12">
                        <h2 className="text-3xl font-bold text-gray-900 mb-4">What Our Users Say</h2>
                        <p className="text-lg text-gray-600 max-w-3xl mx-auto">
                            Hear from farmers and buyers who have transformed their agricultural business with FarmConnect.
                        </p>
                    </div>

                    <div className="grid md:grid-cols-3 gap-8">
                        <div className="bg-white p-6 rounded-lg shadow-md">
                            <p className="text-gray-600 mb-4">
                                FarmConnect helped me sell my tomatoes directly to buyers, doubling my profits by cutting out middlemen.
                            </p>
                            <div className="flex items-center">
                                <img
                                    className="h-12 w-12 rounded-full object-cover mr-4"
                                    src="https://images.pexels.com/photos/5384445/pexels-photo-5384445.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
                                    alt="Testimonial"
                                />
                                <div>
                                    <h4 className="text-lg font-semibold">John Kiptoo</h4>
                                    <p className="text-gray-500">Tomato Farmer, Eldoret</p>
                                </div>
                            </div>
                        </div>

                        <div className="bg-white p-6 rounded-lg shadow-md">
                            <p className="text-gray-600 mb-4">
                                I source fresh vegetables for my supermarket directly from farmers, ensuring quality and fair prices.
                            </p>
                            <div className="flex items-center">
                                <img
                                    className="h-12 w-12 rounded-full object-cover mr-4"
                                    src="https://images.pexels.com/photos/3769021/pexels-photo-3769021.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
                                    alt="Testimonial"
                                />
                                <div>
                                    <h4 className="text-lg font-semibold">Mary Achieng</h4>
                                    <p className="text-gray-500">Supermarket Owner, Nairobi</p>
                                </div>
                            </div>
                        </div>

                        <div className="bg-white p-6 rounded-lg shadow-md">
                            <p className="text-gray-600 mb-4">
                                The platform connects me to buyers across Kenya, helping me sell my dairy products faster and at better prices.
                            </p>
                            <div className="flex items-center">
                                <img
                                    className="h-12 w-12 rounded-full object-cover mr-4"
                                    src="https://images.pexels.com/photos/8437857/pexels-photo-8437857.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
                                    alt="Testimonial"
                                />
                                <div>
                                    <h4 className="text-lg font-semibold">Peter Mwangi</h4>
                                    <p className="text-gray-500">Dairy Farmer, Nyeri</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Call to Action Section */}
            <section className="py-16 bg-green-700 text-white">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <div className="max-w-2xl mx-auto">
                        <h2 className="text-3xl font-bold mb-4">Join FarmConnect Today</h2>
                        <p className="text-xl mb-8">
                            Start connecting with farmers and buyers across Kenya to grow your agricultural business.
                        </p>
                        <div className="flex flex-col sm:flex-row justify-center space-y-4 sm:space-y-0 sm:space-x-4">
                            <Link to="/signup?role=farmer" className="bg-white text-green-700 hover:bg-gray-100 px-6 py-3 rounded-md text-lg font-medium">
                                Register as Farmer
                            </Link>
                            <Link to="/signup?role=buyer" className="border-2 border-white text-white hover:bg-green-600 px-6 py-3 rounded-md text-lg font-medium">
                                Register as Buyer
                            </Link>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
};

export default Home;