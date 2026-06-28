/* ============================================================
   PROYEK: Olist E-Commerce SQL Analysis
   Dataset: Brazilian E-Commerce Public Dataset by Olist (Kaggle)
   Tools: PostgreSQL via DBeaver
   ============================================================ */


/* ============================================================
   FASE 1 — SETUP DATABASE & STRUKTUR TABEL
   ============================================================ */

CREATE DATABASE olist_ecommerce;

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(5)
);

CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(5)
);

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght NUMERIC,
    product_description_lenght NUMERIC,
    product_photos_qty NUMERIC,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2)
);

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(20),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2)
);

CREATE TABLE order_reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(5)
);

-- Catatan: review_id dan order_id di order_reviews menggunakan TEXT
-- (bukan VARCHAR(50)) karena ditemukan masalah parsing CSV yang
-- menyebabkan teks komentar panjang "bocor" ke kolom lain saat
-- delimiter koma di dalam teks tidak terbaca dengan benar.
-- Lihat bagian "Tantangan & Solusi" di README untuk detail lengkap.


/* ============================================================
   FASE 2 — EKSPLORASI & VALIDASI DATA
   ============================================================ */

-- 2.1 Cek jumlah baris di setiap tabel
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation;

-- 2.2 Cek NULL di kolom kunci tabel orders
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(customer_id) AS null_customer_id,
    COUNT(*) - COUNT(order_status) AS null_order_status,
    COUNT(*) - COUNT(order_purchase_timestamp) AS null_purchase_timestamp,
    COUNT(*) - COUNT(order_delivered_customer_date) AS null_delivered_date
FROM orders;

-- 2.3 Validasi relasi antar tabel (foreign key check)
-- Mencari orphan record: baris yang order_id/product_id-nya
-- tidak punya pasangan di tabel induk

SELECT COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS orphan_payments
FROM order_payments op
LEFT JOIN orders o ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS orphan_products
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS orphan_customers
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 2.4 Validasi nilai bisnis (price tidak boleh negatif/nol)
SELECT 
    COUNT(*) AS total_items,
    COUNT(*) FILTER (WHERE price <= 0) AS price_zero_or_negative,
    COUNT(*) FILTER (WHERE freight_value < 0) AS negative_freight,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM order_items;

-- 2.5 Investigasi nilai price tertinggi (cek apakah outlier wajar)
SELECT 
    oi.order_id,
    oi.product_id,
    oi.price,
    p.product_category_name
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.price DESC
LIMIT 5;


/* ============================================================
   FASE 3 — QUERY DASAR (SINGLE TABLE)
   ============================================================ */

-- 3.1 Distribusi status order
SELECT 
    order_status, 
    COUNT(*) AS jumlah_order
FROM orders
GROUP BY order_status
ORDER BY jumlah_order DESC;

-- 3.2 Rentang waktu data
SELECT 
    MIN(order_purchase_timestamp) AS order_pertama,
    MAX(order_purchase_timestamp) AS order_terakhir
FROM orders;

-- 3.3 Top kategori produk berdasarkan jumlah terjual
SELECT 
    product_category_name,
    COUNT(*) AS jumlah_terjual
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY product_category_name
ORDER BY jumlah_terjual DESC
LIMIT 10;


/* ============================================================
   FASE 4 — QUERY MENENGAH (JOIN MULTI-TABEL)
   ============================================================ */

-- 4.1 Revenue per customer state
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS jumlah_order,
    SUM(oi.price) AS total_revenue
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- 4.2 Revenue & rata-rata harga per kategori (JOIN 3 tabel + translasi)
SELECT 
    pt.product_category_name_english,
    COUNT(oi.order_id) AS jumlah_item_terjual,
    SUM(oi.price) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS rata_rata_harga
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation pt 
    ON p.product_category_name = pt.product_category_name
GROUP BY pt.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- 4.3 Revenue per kategori, khusus order yang berhasil "delivered"
SELECT 
    pt.product_category_name_english,
    SUM(oi.price) AS total_revenue
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation pt 
    ON p.product_category_name = pt.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY pt.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- 4.4 Analisis metode pembayaran
SELECT 
    op.payment_type,
    COUNT(DISTINCT op.order_id) AS jumlah_order,
    ROUND(AVG(op.payment_value), 2) AS rata_rata_nilai_bayar,
    ROUND(AVG(op.payment_installments), 1) AS rata_rata_cicilan
FROM order_payments op
GROUP BY op.payment_type
ORDER BY jumlah_order DESC;

-- 4.5 Review score per kategori (HAVING untuk filter sample size)
SELECT 
    pt.product_category_name_english,
    COUNT(orv.review_score) AS jumlah_review,
    ROUND(AVG(orv.review_score), 2) AS rata_rata_rating
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation pt 
    ON p.product_category_name = pt.product_category_name
INNER JOIN order_reviews orv ON oi.order_id = orv.order_id
GROUP BY pt.product_category_name_english
HAVING COUNT(orv.review_score) >= 50
ORDER BY rata_rata_rating ASC
LIMIT 10;