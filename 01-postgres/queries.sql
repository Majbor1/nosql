CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    room_name VARCHAR(50) UNIQUE NOT NULL,
    capacity INT CHECK (capacity > 0),
    has_projector BOOLEAN DEFAULT true
);
INSERT INTO rooms (room_name, capacity, has_projector) VALUES
('Boardroom A', 12, true),
('Focus Room B', 4, false),
('Auditorium C', 50, true);

SELECT * FROM rooms;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO users (full_name, email) VALUES
('Alice Johnson', 'alice.johnson@example.com'),
('Bob Smith', 'bob.smith@example.com'),
('Charlie Brown', 'charlie.brown@example.com');

SELECT * FROM users;

DROP TABLE bookings;
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    room_id INT REFERENCES rooms(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    booking_date DATE NOT NULL,
    duration_hours INT CHECK (1 <= duration_hours and duration_hours <= 8)
);

INSERT INTO bookings (room_id, user_id, booking_date, duration_hours) VALUES
(1, 1, '2026-09-20', 2), -- Alice booked Boardroom A
(1, 2, '2026-09-21', 4), -- Bob booked Boardroom A
(2, 1, '2026-09-22', 1), -- Alice booked Focus Room B
(3, 3, '2026-09-20', 3); -- Charlie booked Auditorium C

SELECT * FROM bookings;


SELECT u.full_name, r.room_name, b.booking_date, b.duration_hours FROM rooms r JOIN bookings b ON r.id = b.room_id JOIN users u ON b.user_id = u.id;

INSERT INTO users (full_name, email) 
VALUES ('Duplicate User', 'alice.johnson@example.com');

INSERT INTO rooms (room_name, capacity, has_projector) 
VALUES ('Tiny Closet', 0, false);

INSERT INTO bookings (room_id, user_id, booking_date, duration_hours) 
VALUES (1, 1, '2026-09-25', 10);

DELETE FROM users WHERE email = 'alice.johnson@example.com';

#----------------------------------------2
-- 1. Cleanup
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- 2. Schema Creation
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    order_date DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('PENDING', 'COMPLETED', 'CANCELLED'))
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_name VARCHAR(100) NOT NULL,
    quantity INT CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) CHECK (unit_price > 0)
);

-- 3. Data Insertion
INSERT INTO customers (full_name, country) VALUES
('Alice Smith', 'USA'),
('Bob Jones', 'Poland'),
('Charlie Brown', 'Germany'),
('Diana Prince', 'USA');

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2026-09-01', 'COMPLETED'),
(1, '2026-09-10', 'COMPLETED'),
(2, '2026-09-05', 'COMPLETED'),
(2, '2026-09-12', 'PENDING'),
(3, '2026-09-08', 'CANCELLED'),
(4, '2026-09-11', 'COMPLETED');

INSERT INTO order_items (order_id, product_name, quantity, unit_price) VALUES
(1, 'Laptop', 1, 1200.00),
(1, 'Mouse', 2, 25.00),
(2, 'Monitor', 1, 300.00),
(3, 'Keyboard', 1, 80.00),
(3, 'Mouse', 1, 25.00),
(4, 'Webcam', 1, 60.00),
(5, 'Desk Lamp', 1, 45.00),
(6, 'Headphones', 2, 150.00);

SELECT c.full_name, c.country, o.id, o.order_date FROM customers c JOIN orders o ON c.id=o.customer_id WHERE status = 'COMPLETED';

SELECT c.full_name, c.country, SUM(oi.quantity * oi.unit_price) FROM customers c JOIN orders o ON c.id=o.customer_id JOIN order_items oi ON o.id = oi.order_id WHERE o.status = 'COMPLETED' GROUP BY full_name, country; 

SELECT c.full_name, c.country, SUM(oi.quantity * oi.unit_price) FROM customers c JOIN orders o ON c.id=o.customer_id JOIN order_items oi ON o.id = oi.order_id WHERE o.status = 'COMPLETED' GROUP BY full_name, country HAVING SUM(oi.quantity * oi.unit_price)>=300;

CREATE VIEW v_customer_revenue AS
SELECT c.full_name, c.country, SUM(oi.quantity * oi.unit_price) FROM customers c JOIN orders o ON c.id=o.customer_id JOIN order_items oi ON o.id = oi.order_id WHERE o.status = 'COMPLETED' GROUP BY full_name, country; 
SELECT * FROM v_customer_revenue WHERE country = 'USA';