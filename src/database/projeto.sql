-- Active: 1682106889483@@127.0.0.1@3306
CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT(DATETIME()) NOT NULL
);

INSERT INTO users (id, name, email, password)
VALUES ("u001", "Priscila", "priscila@astrodev","123456"),
        ("u002", "Daenerys", "daenerys@astrodev","654321"),
        ("u003", "Arya", "arya@astrodev","987654");

SELECT * FROM users;

CREATE TABLE products (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    description TEXT NOT NULL,
    category TEXT NOT NULL,
    image_url TEXT NOT NULL
);  

INSERT INTO products (id, name, price, description, category, image_url)
VALUES (
        "p001", 
        "Roupa Espacial", 
        189,
        "Roupa Espacial multiplas cores", 
        "Acessórios espaciais",
        "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRbq4gQpn5ln9UNrzACo4KU5OPL5BN9x2c8GBZNDyeHVeo84Z-2tcK6ckayiZ5aegIbQvD5AbCYcDS1Ei_-nHqjgE_zr1seFZYC1s5nHfgs9t2xk-8xP9Ut"
    ), (
        "p002", 
        "Telescópio", 
        499, 
        "Telescópio profissional",
        "Acessórios espaciais",
        "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTeisvdC_dY86CoNR_r6jOodOScrCY-q7fwxzjabDFY5SbAmYkJQiinNGTlVf2G5-v0JrWt3cRRV_JFVRGz5xh1LmLGzGWJC9yQqv1Ipduz4fqQqy_2pP1C&usqp=CAE"
    ), (
        "p003", 
        "Moleto NASA", 
        89, 
        "Moletom estampa NASA",
        "Roupas e acessórios",
        "https://cf.shopee.com.br/file/d8e4e23169bdd0edfb7f455154848865"
    ), (
        "p004", 
        "Foguete NASA - Brinquedo", 
        300,
        "Brinquedo NASA",
        "Brinquedos",
        "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSdfEOQSEsbr2o6IXTmIP0AKmnn9NmpiD6QbN2yo6rT8GPMyXQxLO25UrZGXr2d3UhyPmZ1qYwsfh7-UnswGfTdsn5AsW9MSv1IrdsuIYU&usqp=CAE"
    ), (
        "p005", 
        "Foguete LEGO", 
        169, 
        "Brinquedo LEGO",
        "Brinquedos",
        "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSurFnUoGwRGztuYrNCbzkShpQAHqjAGJjamOvX7NAFZdqHXh84BI8ayzqGwrL_PSYqSwuwSNgpHe3PjE-xTRKX24yVpeHmVnp1nnAH9g0-IymIWq8PWjhP"
        );

-- Get All Users
SELECT * FROM users;

-- Get All Products
SELECT * FROM products;

--Search product by name
SELECT * FROM  products WHERE name LIKE "%Roupa Espacial%";

-- Create User
INSERT INTO users(id, name, email, password)
VALUES ("u004", "João das Neves", "joao@astrodev", "12131415");

-- Create Product
INSERT INTO products(id, name, price, description, category, image_url)
VALUES ("p006", "Camiseta Foguete", 59, "Camiseta tema foguete", "Roupas e acessórios", "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRdVOUf5l5v0zVIs68kKrg16q4bxm3vuLtKtg2O3fiP_Ft3fMqQSrS7nI7YFZd4Cnd_fWRvnSfVVeNqVQJr5h3lyX4yWPQhyzPgggmQH_WOrO0CyryPj9hfmQ&usqp=CAE");    

-- Get Products by IDENTIFIED
SELECT * FROM products
WHERE id = "p001";

-- Delete User by id
DELETE FROM users
WHERE id = "u001";

-- Delete Product by id
DELETE FROM products
WHERE id = "p006";

-- Edit User by id
UPDATE users
SET password = "0102030405"
WHERE id = "u001";

-- Edit Product by id
UPDATE products
SET price = 50
WHERE id = "p001";

-- Get All Users
SELECT * FROM users ORDER BY email ASC;

-- Get All Products
SELECT * FROM products
ORDER BY price ASC
LIMIT 20 OFFSET 0;

-- Get All Products
SELECT * FROM products 
WHERE price >= 100 AND price <= 300
ORDER BY price ASC;

CREATE TABLE purchases (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    buyer TEXT NOT NULL,
    total_price REAL NOT NULL,
    created_at TEXT DEFAULT(DATETIME()) NOT NULL,
    paid INTEGER NOT NULL,
    FOREIGN KEY (buyer) REFERENCES users(id)
);

SELECT * FROM purchases;

INSERT INTO purchases(id, buyer, total_price, paid)
VALUES ("c001", "u001", 100, 0),
        ("c002", "u001", 50, 0),
        ("c003", "u002", 30, 0),
        ("c004", "u002", 80, 0),
        ("c005", "u003", 20, 0),
        ("c006", "u003", 60, 0);


UPDATE purchases
SET paid = 1, created_at = DATETIME('now')
WHERE id = "c003";

SELECT 
users.id AS idUsers,
purchases.id,
purchases.total_price,
purchases.created_at,
purchases.paid
FROM purchases
JOIN users ON purchases.buyer = users.id
WHERE users.id = "u003";    

CREATE TABLE purchases_products (
    purchase_id TEXT NOT NULL,
    product_id TEXT NOT NULL, 
    quantity INTEGER NOT NULL,
    FOREIGN KEY (purchase_id) REFERENCES purchases(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
    );

SELECT * FROM purchases_products;

INSERT INTO purchases_products (purchase_id, product_id, quantity)
VALUES ("c001","p001", 2),
        ("c002","p001", 4),
        ("c003", "p002", 3);


SELECT
purchases.id,
purchases.buyer,
purchases.total_price,
purchases.created_at,
purchases.paid,
purchases_products.product_id AS productId,
purchases_products.quantity,
products.name,
products.price,
products.description,
products.category
FROM purchases
LEFT JOIN purchases_products 
ON purchases_products.purchase_id = purchases.id
INNER JOIN products 
ON purchases_products.product_id = products.id;