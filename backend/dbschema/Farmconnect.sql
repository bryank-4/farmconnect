-- backend/db/databaseSchema.sql
-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
                       id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                       email TEXT UNIQUE NOT NULL,
                       role TEXT NOT NULL CHECK (role IN ('Farmer', 'Buyer', 'Admin')),
                       name TEXT NOT NULL,
                       location TEXT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE products (
                          id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                          farmer_id UUID REFERENCES users(id),
                          name TEXT NOT NULL,
                          description TEXT,
                          price DECIMAL NOT NULL,
                          category TEXT,
                          images TEXT[],
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders table
CREATE TABLE orders (
                        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                        buyer_id UUID REFERENCES users(id),
                        farmer_id UUID REFERENCES users(id),
                        product_id UUID REFERENCES products(id),
                        quantity INTEGER NOT NULL,
                        status TEXT NOT NULL CHECK (status IN ('Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled')),
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages table
CREATE TABLE messages (
                          id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                          sender_id UUID REFERENCES users(id),
                          receiver_id UUID REFERENCES users(id),
                          content TEXT NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reviews table
CREATE TABLE reviews (
                         id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                         product_id UUID REFERENCES products(id),
                         buyer_id UUID REFERENCES users(id),
                         rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
                         comment TEXT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Favorites table (for buyer analytics)
CREATE TABLE favorites (
                           id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                           buyer_id UUID REFERENCES users(id),
                           product_id UUID REFERENCES products(id) NULL,
                           farmer_id UUID REFERENCES users(id) NULL,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

-- RLS Policies
-- Users: Only admins can view all users; users can view/update their own profile; allow signup
CREATE POLICY admin_view_users ON users FOR SELECT USING (role = 'Admin');
CREATE POLICY user_view_own ON users FOR SELECT USING (id = auth.uid());
CREATE POLICY user_update_own ON users FOR UPDATE USING (id = auth.uid());
CREATE POLICY user_signup ON users FOR INSERT WITH CHECK (id = auth.uid());
CREATE POLICY public_view_farmer_for_products ON users
FOR SELECT
                      TO authenticated
                      USING (
                      id IN (
                      SELECT farmer_id
                      FROM products
                      WHERE true -- Since products are publicly viewable
                      )
                      );

-- Products: Public read, farmers create/update/delete their own, admins manage all
CREATE POLICY public_view_products ON products FOR SELECT USING (true);
CREATE POLICY "Farmers manage own products" ON products
FOR ALL
TO authenticated
USING (farmer_id = auth.uid())
WITH CHECK (farmer_id = auth.uid());
CREATE POLICY admin_manage_products ON products FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'Admin')
);

-- Orders: Buyers/farmers view their own, admins view all
CREATE POLICY buyer_view_own_orders ON orders FOR SELECT USING (buyer_id = auth.uid());
CREATE POLICY "Farmers view own orders" ON orders
FOR SELECT
               TO authenticated
               USING (farmer_id = auth.uid());
CREATE POLICY admin_view_orders ON orders FOR SELECT USING (
                                                  EXISTS (SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'Admin')
                                                  );
CREATE POLICY buyer_create_orders ON orders FOR INSERT WITH CHECK (buyer_id = auth.uid());
CREATE POLICY farmer_update_orders ON orders FOR UPDATE USING (farmer_id = auth.uid());

-- Messages: Users view their own conversations, send messages, admins manage all
CREATE POLICY user_view_own_messages ON messages FOR SELECT USING (sender_id = auth.uid() OR receiver_id = auth.uid());
CREATE POLICY user_send_messages ON messages FOR INSERT WITH CHECK (sender_id = auth.uid());
CREATE POLICY admin_manage_messages ON messages FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'Admin')
);

-- Reviews: Public read, buyers create/update their own, admins manage all
CREATE POLICY public_view_reviews ON reviews FOR SELECT USING (true);
CREATE POLICY buyer_manage_own_reviews ON reviews FOR ALL USING (buyer_id = auth.uid()) WITH CHECK (buyer_id = auth.uid());
CREATE POLICY admin_manage_reviews ON reviews FOR ALL USING (
    EXISTS (SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'Admin')
);

-- Favorites: Buyers manage their own
CREATE POLICY buyer_manage_favorites ON favorites FOR ALL USING (buyer_id = auth.uid()) WITH CHECK (buyer_id = auth.uid());


ALTER TABLE products
DROP COLUMN IF EXISTS images;

ALTER TABLE products
    ADD COLUMN images jsonb DEFAULT '[]';


-- backend/db/analyticsView.sql
CREATE VIEW farmer_analytics AS
SELECT
    p.farmer_id,
    COUNT(DISTINCT o.id) as total_orders,
    SUM(o.quantity * p.price) as total_sales,
    COUNT(DISTINCT p.id) as products_listed,
    AVG(r.rating) as average_rating,
    COUNT(DISTINCT f.id) as favorite_count
FROM products p
         LEFT JOIN orders o ON p.id = o.product_id
         LEFT JOIN reviews r ON p.id = r.product_id
         LEFT JOIN favorites f ON p.id = f.product_id OR p.farmer_id = f.farmer_id
GROUP BY p.farmer_id;


-- backend/db/migrations/add_stock_status_to_products.sql
ALTER TABLE products
ADD COLUMN stock INTEGER NOT NULL DEFAULT 0,
ADD COLUMN status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive'));


ALTER TABLE users
ADD COLUMN phone_number TEXT;

ALTER TABLE orders
    ADD COLUMN billing_details JSONB DEFAULT '{}';


-- backend/db/migrations/add_admin_rls_policies.sql
-- Enable UUID extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users Table: Add DELETE policy for admins
CREATE POLICY "Admins can delete users" ON public.users
FOR DELETE
TO authenticated
USING (EXISTS (SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'Admin'));

-- Orders Table: Add UPDATE policy for admins and service role
CREATE POLICY "Admins and service role can update orders" ON public.orders
FOR UPDATE
               TO authenticated, service_role
               USING (
               EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role = 'Admin')
               )
    WITH CHECK (true);

-- Products Table: Clarify DELETE policy for admins (optional, as FOR ALL already implies it)
-- This is redundant but added for explicitness
CREATE POLICY "Admins can delete products" ON public.products
FOR DELETE
TO authenticated
USING (EXISTS (SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'Admin'));

-- Note: No changes to existing policies are needed, as they are compatible with the new additions.
-- However, ensure the following existing policies are not overridden:
-- - user_view_own, user_update_own, user_signup (users)
-- - public_view_products, "Farmers manage own products", admin_manage_products (products)
-- - buyer_view_own_orders, "Farmers view own orders", admin_view_orders, buyer_create_orders, farmer_update_orders (orders)
-- - user_view_own_messages, user_send_messages, admin_manage_messages (messages)
-- - public_view_reviews, buyer_manage_own_reviews, admin_manage_reviews (reviews)
-- - buyer_manage_favorites (favorites)

-- Apply the changes
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Update existing RLS policies
ALTER POLICY admin_view_users ON users USING (true); -- Allow admins to see all
ALTER POLICY admin_manage_products ON products USING (true); -- Allow admins full access


ALTER TABLE messages
    ADD COLUMN status TEXT DEFAULT 'sent',
ADD CONSTRAINT messages_status_check CHECK (status IN ('sent', 'delivered', 'read'));


ALTER TABLE messages ADD COLUMN product_id UUID REFERENCES products(id);
CREATE INDEX idx_messages_product_id ON messages(product_id);

CREATE TABLE carts (
                       id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                       buyer_id UUID REFERENCES users(id),
                       product_id UUID REFERENCES products(id),
                       farmer_id UUID REFERENCES users(id),
                       quantity INTEGER NOT NULL,
                       price DECIMAL NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       UNIQUE(buyer_id, product_id)
);

ALTER TABLE carts ENABLE ROW LEVEL SECURITY;

-- RLS Policies for carts
CREATE POLICY buyer_manage_cart ON carts FOR ALL
    USING (buyer_id = auth.uid())
    WITH CHECK (buyer_id = auth.uid());

CREATE POLICY admin_manage_cart ON carts FOR ALL
    USING (EXISTS (SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'Admin'));


ALTER TABLE orders
    ALTER COLUMN billing_details SET DEFAULT '{"fullName": "", "location": "", "townCity": "", "phoneNumber": "", "email": "", "order_amount": 0.00}'::jsonb;


