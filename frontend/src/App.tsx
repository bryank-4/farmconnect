import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import Navbar from './components/Navbar';
import Home from './pages/Home';
import Login from './pages/Login';
import Signup from './pages/Signup';
import ForgotPassword from './pages/ForgotPassword';
import ResetPassword from './pages/ResetPassword';
import ProductList from './pages/ProductList';
import ProductDetail from './pages/ProductDetail';
import FarmerDashboard from './pages/FarmerDashboard';
import BuyerDashboard from './pages/BuyerDashboard';
import AdminDashboard from './pages/AdminDashboard';
import Messaging from './pages/Messaging';
import TransactionHistory from './pages/TransactionHistory';
import ProductManagement from './pages/ProductManagement';
import Orders from './pages/Orders';
import OrderDetail from './pages/OrderDetail';
import Profile from './pages/Profile';
import Favorites from './pages/Favorites';
import Cart from './components/Cart';
import Checkout from './components/Checkout';
import { CartProvider } from './context/CartContext';
import { ToastContainer } from 'react-toastify'; // Import ToastContainer
import 'react-toastify/dist/ReactToastify.css'; // Import CSS for styling
import Footer from './components/Footer'; // Import Footer

const App: React.FC = () => {
  return (
      <AuthProvider>
        <CartProvider>
          <Router>
            <Navbar />
            <div className="container mx-auto p-4">
              <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/login" element={<Login />} />
                <Route path="/signup" element={<Signup />} />
                <Route path="/forgot-password" element={<ForgotPassword />} />
                <Route path="/reset-password" element={<ResetPassword />} />
                <Route path="/products" element={<ProductList />} />
                <Route path="/product/:id" element={<ProductDetail />} />
                <Route path="/cart" element={<Cart />} />
                <Route path="/checkout" element={<Checkout />} />
                <Route path="/dashboard/farmer" element={<FarmerDashboard />} />
                <Route path="/dashboard/buyer" element={<BuyerDashboard />} />
                <Route path="/dashboard/admin" element={<AdminDashboard />} />
                <Route path="/messages" element={<Messaging />} />
                <Route path="/transaction-history" element={<TransactionHistory />} />
                <Route path="/product-management" element={<ProductManagement />} />
                <Route path="/orders" element={<Orders />} />
                <Route path="/order-details/:id" element={<OrderDetail />} />
                <Route path="/profile" element={<Profile />} />
                <Route path="/favorites" element={<Favorites />} />
              </Routes>
            </div>
            <Footer /> {/* Add Footer here */}
            <ToastContainer /> {/* Add ToastContainer here */}
          </Router>
        </CartProvider>
      </AuthProvider>
  );
};

export default App;