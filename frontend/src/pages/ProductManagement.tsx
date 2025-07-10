// frontend/src/pages/ProductManagement.tsx
import React, { useEffect, useState } from 'react';
import { useAuth } from '../context/AuthContext';
import { supabase } from '../utils/supabase';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

interface Product {
    id: string;
    name: string;
    description: string;
    price: number;
    stock: number;
    status: 'active' | 'inactive';
    images: string[];
    farmer_id: string;
    category: string;
}

interface EditableProduct extends Product {
    imageFile: File | null;
}

const ProductManagement: React.FC = () => {
    const { user } = useAuth();
    const [products, setProducts] = useState<Product[]>([]);
    const [loading, setLoading] = useState(true);
    const [newProduct, setNewProduct] = useState<EditableProduct>({
        id: '',
        name: '',
        description: '',
        price: 0,
        stock: 0,
        status: 'active',
        images: [],
        farmer_id: '',
        category: '',
        imageFile: null,
    });
    const [editingProduct, setEditingProduct] = useState<EditableProduct | null>(null);

    const BACKEND_URL = 'http://localhost:3001';

    const fetchProducts = async () => {
        if (!user) return;

        try {
            const { data: session } = await supabase.auth.getSession();
            const token = session?.session?.access_token;
            if (!token) throw new Error('No authentication token found');

            const response = await fetch(`${BACKEND_URL}/api/products?farmer_id=${user.id}`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            });
            const data = await response.json();
            if (!response.ok) throw new Error(data.error || 'Failed to fetch products');
            const normalizedProducts = data.map((p: any) => ({
                id: p.id || '',
                name: p.name || '',
                description: p.description || '',
                price: p.price || 0,
                stock: p.stock || 0,
                status: p.status || 'active',
                images: p.images || [],
                farmer_id: p.farmer_id || '',
                category: p.category || '',
            }));
            setProducts(normalizedProducts);
            console.log('Fetched products:', normalizedProducts);
        } catch (error) {
            console.error('Fetch products error:', error);
            toast.error(`Failed to fetch products: ${(error as Error).message}`);
        }
        setLoading(false);
    };

    const validateForm = (product: EditableProduct): boolean => {
        if (product.price <= 0) throw new Error('Price must be a positive number');
        if (product.stock < 0) throw new Error('Stock must be a non-negative number');
        if (!product.category) throw new Error('Category is required');
        return true;
    };

    const handleCreate = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!user) return;

        try {
            validateForm(newProduct);
            const formData = new FormData();
            formData.append('name', newProduct.name);
            formData.append('description', newProduct.description);
            formData.append('price', newProduct.price.toString());
            formData.append('stock', newProduct.stock.toString());
            formData.append('status', newProduct.status);
            formData.append('farmer_id', user.id!);
            formData.append('category', newProduct.category);
            if (newProduct.imageFile) formData.append('image', newProduct.imageFile);

            console.log('Creating product with data:', {
                name: newProduct.name,
                description: newProduct.description,
                price: newProduct.price,
                stock: newProduct.stock,
                status: newProduct.status,
                farmer_id: user.id,
                category: newProduct.category,
            });

            const { data: session } = await supabase.auth.getSession();
            const token = session?.session?.access_token;
            if (!token) throw new Error('No authentication token found');

            const response = await fetch(`${BACKEND_URL}/api/products`, {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                },
                body: formData,
            });
            const data = await response.json();
            if (!response.ok) throw new Error(data.error || 'Failed to create product');
            setProducts([...products, data]);
            setNewProduct({
                id: '',
                name: '',
                description: '',
                price: 0,
                stock: 0,
                status: 'active',
                images: [],
                farmer_id: '',
                category: '',
                imageFile: null,
            });
            toast.success('Product created successfully');
            await fetchProducts();
        } catch (error) {
            console.error('Create product error:', error);
            toast.error(`Failed to create product: ${(error as Error).message}`);
        }
    };

    const handleUpdate = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!editingProduct || !user) return;

        try {
            validateForm(editingProduct);
            const formData = new FormData();
            formData.append('name', editingProduct.name);
            formData.append('description', editingProduct.description);
            formData.append('price', editingProduct.price.toString());
            formData.append('stock', editingProduct.stock.toString());
            formData.append('status', editingProduct.status);
            formData.append('farmer_id', user.id!);
            formData.append('category', editingProduct.category);
            if (editingProduct.imageFile) formData.append('image', editingProduct.imageFile);

            console.log('Updating product with data:', {
                id: editingProduct.id,
                name: editingProduct.name,
                description: editingProduct.description,
                price: editingProduct.price,
                stock: editingProduct.stock,
                status: editingProduct.status,
                farmer_id: user.id,
                category: editingProduct.category,
            });

            const { data: session } = await supabase.auth.getSession();
            const token = session?.session?.access_token;
            if (!token) throw new Error('No authentication token found');

            const response = await fetch(`${BACKEND_URL}/api/products/${editingProduct.id}`, {
                method: 'PUT',
                headers: {
                    Authorization: `Bearer ${token}`,
                },
                body: formData,
            });
            const data = await response.json();
            if (!response.ok) throw new Error(data.error || 'Failed to update product');
            setProducts(products.map((p) => (p.id === editingProduct.id ? data : p)));
            setEditingProduct(null);
            toast.success('Product updated successfully');
            await fetchProducts();
        } catch (error) {
            console.error('Update product error:', error);
            toast.error(`Failed to update product: ${(error as Error).message}`);
        }
    };

    const handleDelete = async (id: string) => {
        if (!user) return;

        try {
            const { data: session } = await supabase.auth.getSession();
            const token = session?.session?.access_token;
            if (!token) throw new Error('No authentication token found');

            const response = await fetch(`${BACKEND_URL}/api/products/${id}`, {
                method: 'DELETE',
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            });
            if (!response.ok) throw new Error('Failed to delete product');
            setProducts(products.filter((p) => p.id !== id));
            toast.success('Product deleted successfully');
            await fetchProducts();
        } catch (error) {
            console.error('Delete product error:', error);
            toast.error(`Failed to delete product: ${(error as Error).message}`);
        }
    };

    useEffect(() => {
        fetchProducts();
    }, [user]); // Removed fetchProducts from dependencies

    if (loading) return <div>Loading...</div>;
    if (!user) return <div>Please log in to manage your products.</div>;

    return (
        <div className="p-6">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">Product Management</h2>
            <div className="bg-white p-4 rounded-lg shadow mb-6">
                <h3 className="text-lg font-semibold mb-4">
                    {editingProduct ? 'Edit Product' : 'Add New Product'}
                </h3>
                <form onSubmit={editingProduct ? handleUpdate : handleCreate}>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label className="block text-gray-700">Product Name</label>
                            <input
                                type="text"
                                value={editingProduct ? editingProduct.name : newProduct.name}
                                onChange={(e) =>
                                    editingProduct
                                        ? setEditingProduct({ ...editingProduct, name: e.target.value })
                                        : setNewProduct({ ...newProduct, name: e.target.value })
                                }
                                className="w-full p-2 border rounded"
                                required
                            />
                        </div>
                        <div>
                            <label className="block text-gray-700">Category</label>
                            <select
                                value={editingProduct ? editingProduct.category : newProduct.category}
                                onChange={(e) => {
                                    const category = e.target.value;
                                    if (editingProduct) {
                                        setEditingProduct({ ...editingProduct, category });
                                    } else {
                                        setNewProduct({ ...newProduct, category });
                                    }
                                }}
                                className="w-full p-2 border rounded"
                                required
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
                        <div>
                            <label className="block text-gray-700">Price (KES)</label>
                            <input
                                type="number"
                                value={editingProduct ? editingProduct.price : newProduct.price}
                                onChange={(e) =>
                                    editingProduct
                                        ? setEditingProduct({ ...editingProduct, price: Number(e.target.value) || 0 })
                                        : setNewProduct({ ...newProduct, price: Number(e.target.value) || 0 })
                                }
                                className="w-full p-2 border rounded"
                                required
                            />
                        </div>
                        <div>
                            <label className="block text-gray-700">
                                Stock ({(editingProduct ? editingProduct.category : newProduct.category) === 'Dairy' ? 'liters' :
                                (editingProduct ? editingProduct.category : newProduct.category) === 'Seedlings' || (editingProduct ? editingProduct.category : newProduct.category) === 'Poultry Eggs' ? 'pieces' : 'kg'})
                            </label>
                            <input
                                type="number"
                                value={editingProduct ? editingProduct.stock : newProduct.stock}
                                onChange={(e) =>
                                    editingProduct
                                        ? setEditingProduct({ ...editingProduct, stock: Number(e.target.value) || 0 })
                                        : setNewProduct({ ...newProduct, stock: Number(e.target.value) || 0 })
                                }
                                className="w-full p-2 border rounded"
                                required
                            />
                        </div>
                        <div>
                            <label className="block text-gray-700">Status</label>
                            <select
                                value={editingProduct ? editingProduct.status : newProduct.status}
                                onChange={(e) =>
                                    editingProduct
                                        ? setEditingProduct({
                                            ...editingProduct,
                                            status: e.target.value as 'active' | 'inactive',
                                        })
                                        : setNewProduct({
                                            ...newProduct,
                                            status: e.target.value as 'active' | 'inactive',
                                        })
                                }
                                className="w-full p-2 border rounded"
                            >
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>
                        <div>
                            <label className="block text-gray-700">Product Image</label>
                            <input
                                type="file"
                                accept="image/*"
                                onChange={(e) => {
                                    const file = e.target.files?.[0] || null;
                                    if (file) {
                                        if (editingProduct) {
                                            setEditingProduct({ ...editingProduct, imageFile: file });
                                        } else {
                                            setNewProduct({ ...newProduct, imageFile: file });
                                        }
                                    }
                                }}
                                className="w-full p-2 border rounded"
                            />
                        </div>
                        <div className="col-span-2">
                            <label className="block text-gray-700">Description</label>
                            <textarea
                                value={editingProduct ? editingProduct.description : newProduct.description}
                                onChange={(e) =>
                                    editingProduct
                                        ? setEditingProduct({ ...editingProduct, description: e.target.value })
                                        : setNewProduct({ ...newProduct, description: e.target.value })
                                }
                                className="w-full p-2 border rounded"
                                rows={3}
                            />
                        </div>
                    </div>
                    <button
                        type="submit"
                        className="mt-4 bg-green-600 text-white p-2 rounded hover:bg-green-700"
                    >
                        {editingProduct ? 'Update Product' : 'Add Product'}
                    </button>
                    {editingProduct && (
                        <button
                            type="button"
                            onClick={() => setEditingProduct(null)}
                            className="mt-4 ml-2 bg-gray-600 text-white p-2 rounded hover:bg-gray-700"
                        >
                            Cancel
                        </button>
                    )}
                </form>
            </div>
            <div className="bg-white p-4 rounded-lg shadow overflow-x-auto">
                <h3 className="text-lg font-semibold mb-4">Your Products</h3>
                <table className="w-full text-left">
                    <thead>
                    <tr className="bg-gray-100">
                        <th className="p-2">Product</th>
                        <th className="p-2">Category</th>
                        <th className="p-2">Image</th>
                        <th className="p-2">Price</th>
                        <th className="p-2">Stock</th>
                        <th className="p-2">Status</th>
                        <th className="p-2">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    {products.map((product) => (
                        <tr key={product.id} className="border-t">
                            <td className="p-2">{product.name}</td>
                            <td className="p-2">{product.category || 'N/A'}</td>
                            <td className="p-2">
                                {product.images?.[0] ? (
                                    <img
                                        src={product.images[0]}
                                        alt={product.name}
                                        className="h-10 w-10 object-cover rounded"
                                    />
                                ) : (
                                    'No Image'
                                )}
                            </td>
                            <td className="p-2">KES {product.price.toLocaleString()}</td>
                            <td className="p-2">
                                {product.stock !== undefined && product.stock !== null
                                    ? `${product.stock} ${product.category === 'Dairy' ? 'liters' : product.category === 'Seedlings' || product.category === 'Poultry Eggs' ? 'pieces' : 'kg'}`
                                    : 'N/A'}
                            </td>
                            <td className="p-2">
                  <span
                      className={product.status === 'active' ? 'text-green-600' : 'text-red-600'}
                  >
                    {product.status || 'N/A'}
                  </span>
                            </td>
                            <td className="p-2">
                                <button
                                    onClick={() =>
                                        setEditingProduct({ ...product, imageFile: null })
                                    }
                                    className="text-blue-600 mr-2"
                                >
                                    ✏️
                                </button>
                                <button
                                    onClick={() => handleDelete(product.id)}
                                    className="text-red-600"
                                >
                                    🗑️
                                </button>
                            </td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default ProductManagement;