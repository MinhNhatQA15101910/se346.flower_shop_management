CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(200) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(1000) NOT NULL,
    image_url VARCHAR(100),
    role VARCHAR(10)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE,
    image_url VARCHAR(50) NOT NULL
);

INSERT INTO categories (name, image_url) 
VALUES ('cakes', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713588992/categories/category-cakes_jxxme1.png');

INSERT INTO categories (name, image_url) 
VALUES ('flowers', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713589080/categories/category-flowers_rzjeyy.png');

INSERT INTO categories (name, image_url) 
VALUES ('combos', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713589079/categories/category-combos_tnw5ny.png');

