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
    image_url VARCHAR(200) NOT NULL
);

INSERT INTO categories (name, image_url) 
VALUES ('combos', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713593318/categories/combos/category-combos_swxlvz.png');

INSERT INTO categories (name, image_url) 
VALUES ('flowers', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713589080/categories/flowers/category-flowers_rzjeyy.png');

INSERT INTO categories (name, image_url) 
VALUES ('cakes', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713588992/categories/cakes/category-cakes_jxxme1.png');

CREATE TABLE types (
    id SERIAL PRIMARY KEY,
    category_id INT,
    name VARCHAR(20) NOT NULL UNIQUE,
    image_url VARCHAR(200) NOT NULL,
    
    CONSTRAINT fk_types_categories_category_id
    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'All Cakes', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623093/types/All%20Cakes/types-all-cakes_zo9jdu.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Cartoon Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623235/types/Cartoon%20Cake/types-cartoon-cake_u8n2c9.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Floral Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623316/types/Floral%20Cake/types-floral-cake_ky5mhe.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Heart Shaped', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623368/types/Heart%20Shaped/types-heart-shaped_xy73wx.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Round Shaped', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623490/types/Round%20Shaped/types-round-shaped_swhrkz.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'All Flowers', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713592337/types/All%20Flowers/types-all-flowers_g8qn1f.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'Roses', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713592454/types/Roses/types-roses_s1qqrg.png');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'Orchids', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713592592/types/Orchids/types-orchids_kmchlc.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'Gerberas', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713592780/types/Gerberas/types-gerberas_n9hkoo.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'Lilies', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713592886/types/Lilies/types-lilies_l5nqgc.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'Mixed Flowers', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713592945/types/Mixed%20Flowers/types-mixed-flowers_vzi4vd.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'Carnation', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713593047/types/Carnation/types-carnation_l8uefw.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (2, 'Chocolate Bouquet', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713593125/types/Chocolate%20Bouquet/types-chocolate-bouquet_awbeuh.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'All Combos', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624804/types/All%20Combos/types-all-combos_lhsww9.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Cakes & Flower', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624494/types/Cakes%20and%20Flower/types-cakes-and-flower_gk5kqy.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Flower & Chocolate', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624559/types/Flower%20and%20Chocolate/types-flower-and-chocolate_dtj1o9.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Flowers & Teddy', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624611/types/Flowers%20and%20Teddy/types-flowers-and-teddy_zsiaqj.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Jumbo Combo', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624695/types/Jumbo%20Combo/types-jumbo-combo_qjbw6l.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Greeting Card Combo', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624775/types/Greeting%20Card%20Combo/types-greeting-card-combo_smy5yn.jpg');
