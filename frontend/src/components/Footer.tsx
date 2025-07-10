import React from 'react';
import { Link } from 'react-router-dom';
import { Facebook, Twitter, Instagram, Linkedin, MapPin, Phone, Mail } from 'lucide-react';

const Footer: React.FC = () => {
    const currentYear = new Date().getFullYear();

    return (
        <footer className="bg-primary text-white p-4 mt-8">
            <div className="container mx-auto flex flex-col md:flex-row justify-between items-start gap-8 py-6">
                {/* Company Information */}
                <div className="mb-6 md:mb-0">
                    <h3 className="text-xl font-semibold mb-4">FarmConnect</h3>
                    <p className="mb-4">
                        Connecting Kenyan farmers directly with buyers for fairer prices and sustainable agriculture.
                    </p>
                    <div className="flex space-x-4">
                        <a href="#" className="hover:text-accent transition-colors duration-300">
                            <Facebook size={20} />
                        </a>
                        <a href="#" className="hover:text-accent transition-colors duration-300">
                            <Twitter size={20} />
                        </a>
                        <a href="#" className="hover:text-accent transition-colors duration-300">
                            <Instagram size={20} />
                        </a>
                        <a href="#" className="hover:text-accent transition-colors duration-300">
                            <Linkedin size={20} />
                        </a>
                    </div>
                </div>

                {/* Quick Links */}
                <div className="mb-6 md:mb-0">
                    <h3 className="text-lg font-semibold mb-4">Quick Links</h3>
                    <ul className="space-y-2">
                        <li>
                            <Link to="/products" className="hover:text-accent transition-colors duration-300">
                                Marketplace
                            </Link>
                        </li>
                        <li>
                            <Link to="/signup?role=farmer" className="hover:text-accent transition-colors duration-300">
                                Join as Farmer
                            </Link>
                        </li>
                        <li>
                            <Link to="/signup?role=buyer" className="hover:text-accent transition-colors duration-300">
                                Join as Buyer
                            </Link>
                        </li>
                        <li>
                            <Link to="/about" className="hover:text-accent transition-colors duration-300">
                                About Us
                            </Link>
                        </li>
                        <li>
                            <Link to="/contact" className="hover:text-accent transition-colors duration-300">
                                Contact Us
                            </Link>
                        </li>
                    </ul>
                </div>

                {/* Categories */}
                <div className="mb-6 md:mb-0">
                    <h3 className="text-lg font-semibold mb-4">Product Categories</h3>
                    <ul className="space-y-2">
                        <li>
                            <Link to="/products?category=Cereals & Grains" className="hover:text-accent transition-colors duration-300">
                                Cereals & Grains
                            </Link>
                        </li>
                        <li>
                            <Link to="/products?category=Fruits" className="hover:text-accent transition-colors duration-300">
                                Fruits
                            </Link>
                        </li>
                        <li>
                            <Link to="/products?category=Vegetables" className="hover:text-accent transition-colors duration-300">
                                Vegetables
                            </Link>
                        </li>
                        <li>
                            <Link to="/products?category=Dairy" className="hover:text-accent transition-colors duration-300">
                                Dairy Products
                            </Link>
                        </li>
                        <li>
                            <Link to="/products?category=Meat & Livestock" className="hover:text-accent transition-colors duration-300">
                                Livestock
                            </Link>
                        </li>
                        <li>
                            <Link to="/products?category=Organic" className="hover:text-accent transition-colors duration-300">
                                Organic Produce
                            </Link>
                        </li>
                    </ul>
                </div>

                {/* Contact Information */}
                <div>
                    <h3 className="text-lg font-semibold mb-4">Contact Us</h3>
                    <ul className="space-y-3">
                        <li className="flex items-start">
                            <MapPin className="mr-2 h-5 w-5 text-accent flex-shrink-0 mt-0.5" />
                            <span>Kenyatta Avenue, Nairobi, Kenya</span>
                        </li>
                        <li className="flex items-center">
                            <Phone className="mr-2 h-5 w-5 text-accent flex-shrink-0" />
                            <span>+254 700 000 000</span>
                        </li>
                        <li className="flex items-center">
                            <Mail className="mr-2 h-5 w-5 text-accent flex-shrink-0" />
                            <span>info@farmconnect.co.ke</span>
                        </li>
                    </ul>
                    <div className="mt-4">
                        <h4 className="text-white font-medium mb-2">Subscribe to Newsletter</h4>
                        <form className="flex">
                            <input
                                type="email"
                                placeholder="Your email"
                                className="px-3 py-2 text-gray-900 rounded-l-md focus:outline-none focus:ring-2 focus:ring-accent flex-1 min-w-0"
                            />
                            <button
                                type="submit"
                                className="bg-accent px-4 py-2 text-white rounded-r-md hover:bg-primary-dark focus:outline-none"
                            >
                                Subscribe
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <div className="border-t border-accent mt-6 pt-4">
                <div className="container mx-auto flex flex-col md:flex-row justify-between items-center">
                    <p>© {currentYear} FarmConnect. All rights reserved.</p>
                    <div className="mt-2 md:mt-0">
                        <ul className="flex space-x-6">
                            <li>
                                <Link to="/privacy" className="hover:text-accent transition-colors duration-300">
                                    Privacy Policy
                                </Link>
                            </li>
                            <li>
                                <Link to="/terms" className="hover:text-accent transition-colors duration-300">
                                    Terms of Service
                                </Link>
                            </li>
                            <li>
                                <Link to="/faq" className="hover:text-accent transition-colors duration-300">
                                    FAQ
                                </Link>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
    );
};

export default Footer;