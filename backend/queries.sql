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
VALUES (1, 'All Combos', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624804/types/All%20Combos/types-all-combos_lhsww9.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Cakes & Flower', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624494/types/Cakes%20and%20Flower/types-cakes-and-flower_gk5kqy.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Flower & Chocolate', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624559/types/Flower%20and%20Chocolate/types-flower-and-chocolate_dtj1o9.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Flowers & Teddy', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624611/types/Flowers%20and%20Teddy/types-flowers-and-teddy_zsiaqj.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Jumbo Combo', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624695/types/Jumbo%20Combo/types-jumbo-combo_qjbw6l.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (1, 'Greeting Card Combo', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713624775/types/Greeting%20Card%20Combo/types-greeting-card-combo_smy5yn.jpg');

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
VALUES (3, 'All Cakes', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623093/types/All%20Cakes/types-all-cakes_zo9jdu.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Cartoon Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623235/types/Cartoon%20Cake/types-cartoon-cake_u8n2c9.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Floral Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623316/types/Floral%20Cake/types-floral-cake_ky5mhe.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Heart Shaped', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623368/types/Heart%20Shaped/types-heart-shaped_xy73wx.jpg');

INSERT INTO types (category_id, name, image_url)
VALUES (3, 'Round Shaped', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713623490/types/Round%20Shaped/types-round-shaped_swhrkz.jpg');

CREATE TABLE occasions (
    id SERIAL PRIMARY KEY,
    category_id INT,
    name VARCHAR(20) NOT NULL,
    image_url VARCHAR(200) NOT NULL,
    
    CONSTRAINT fk_types_categories_category_id
    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);

INSERT INTO occasions (category_id, name, image_url)
VALUES (1, 'Valentine''s Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626169/occasions/Valentine%27s%20Day/occasions-valentine-day_gdvolw.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (1, 'Birthday Combo', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626197/occasions/Birthday%20Combo/occasions-birthday-combo_ilifl5.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (1, 'Mother''s Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626281/occasions/Mother%27s%20Day/occasions-mother-day_gxuarc.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (1, 'Father''s Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626310/occasions/Father%27s%20Day/occasions-father-day_n3thih.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (1, 'Women''s Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626361/occasions/Women%27s%20Day/occasions-women-day_a7yakw.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (2, 'Anniversary', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626741/occasions/Anniversary/occasions-anniversary_j4orem.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (2, 'Birthday', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626786/occasions/Birthday/occasions-birthday_sjifo9.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (2, 'Valentine', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626818/occasions/Valentine/occasions-valentine_rzpefx.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (2, 'Get Well', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626856/occasions/Get%20Well/occasions-get-well_qs1g7t.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (2, 'Sorry', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626906/occasions/Sorry/occasions-sorry_m6o2it.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (2, 'Rose Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713626942/occasions/Rose%20Day/occasions-rose-day_um5u5c.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (3, 'Birthday Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713627530/occasions/Birthday%20Cake/occasions-birthday-cake_gy0lpi.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (3, 'Anniversary Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713627559/occasions/Anniversary%20Cake/occasions-anniversary-cake_budzyo.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (3, 'Engagement Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713754256/occasions/Engagement%20Cake/occasions-engagement-cake_ei8fsa.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (3, 'Wedding Cake', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713754295/occasions/Wedding%20Cake/occasions-wedding-cake_n5ie4f.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (3, 'Valentine''s Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713754335/occasions/Valentine%27s%20Day/occasions-valentine-day_satctb.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (3, 'Mother''s Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713754377/occasions/Mother%27s%20Day/occasions-mother-day_k5n09z.jpg');

INSERT INTO occasions (category_id, name, image_url)
VALUES (3, 'Father''s Day', 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713754416/occasions/Father%27s%20Day/occasions-father-day_y2mmyl.jpg');
