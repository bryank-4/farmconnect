// frontend/src/components/ProductCard.tsx
import React from 'react';
import { Link } from 'react-router-dom';

interface Product {
    id: string;
    name: string;
    description: string;
    price: number;
    images: string[];
}

const ProductCard: React.FC<{ product: Product }> = ({ product }) => {
    return (
        <div className="border rounded-lg p-4 shadow hover:shadow-lg transition">
            <img src={product.images[0] || '/placeholder.jpg'} alt={product.name} className="w-full h-48 object-cover rounded" />
            <h3 className="text-xl font-semibold mt-2">{product.name}</h3>
            <p className="text-gray-600">{product.description}</p>
            <p className="text-primary font-bold mt-2">KSH {product.price}</p>
            <Link to={`/product/${product.id}`} className="mt-2 inline-block bg-accent text-white px-4 py-2 rounded hover:bg-secondary">
                View Details
            </Link>
        </div>
    );
};

export default ProductCard;