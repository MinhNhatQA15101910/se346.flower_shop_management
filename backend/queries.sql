CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(200) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(2000) NOT NULL,
    image_url VARCHAR(200),
    role VARCHAR(20)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE,
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
    name VARCHAR(20) NOT NULL,
    image_url VARCHAR(200) NOT NULL,
    
    CONSTRAINT fk_types_categories_category_id
    FOREIGN KEY (category_id)
    REFERENCES categories(id),
    CONSTRAINT uq_category_id_name
    UNIQUE (category_id, name)
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

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL UNIQUE,
    price DECIMAL NOT NULL,
    sale_price DECIMAL NOT NULL,
    sale_percentage DECIMAL NOT NULL,
    detail_description VARCHAR(2000) NOT NULL,
    size VARCHAR(20),
    weight DECIMAL,
    color VARCHAR(20),
    material VARCHAR(200),
    stock INT NOT NULL,
    sold INT NOT NULL,
    rating_avg DECIMAL NOT NULL,
    total_rating INT NOT NULL,
    is_available BOOLEAN NOT NULL
);

CREATE TABLE product_images (
    product_id INT NOT NULL,
    image_url VARCHAR(200) NOT NULL,
    CONSTRAINT pk_product_image PRIMARY KEY (product_id, image_url)
);

CREATE TABLE product_rating (
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DECIMAL NOT NULL,
    CONSTRAINT pk_product_rating PRIMARY KEY (product_id, user_id),
    CONSTRAINT fk_product_rating_1 FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_product_rating_2 FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE product_type (
    product_id INT NOT NULL,
    type_id INT NOT NULL,
    CONSTRAINT pk_product_type PRIMARY KEY (product_id, type_id),
    CONSTRAINT fk_product_type_1 FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_product_type_2 FOREIGN KEY (type_id) REFERENCES types(id)
);

CREATE TABLE product_occasion (
    product_id INT NOT NULL,
    occasion_id INT NOT NULL,
    CONSTRAINT pk_product_occasion PRIMARY KEY (product_id, occasion_id),
    CONSTRAINT fk_product_occasion_1 FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_product_occasion_2 FOREIGN KEY (occasion_id) REFERENCES occasions(id)
);

INSERT INTO products (name, price, sale_price, sale_percentage, detail_description, size, weight, color, material, stock, sold, rating_avg, total_rating, is_available) VALUES 
('Sweetheart Surprise', 49.99, 39.99, 20, 'A delightful combination of red roses and chocolates, perfect for expressing your love.', 'Medium', 1, 'Red', 'Roses, Chocolate', 25, 0, 0, 0, TRUE),
('Birthday Bliss Bouquet', 59.99, 49.99, 17, 'A vibrant bouquet of assorted flowers paired with a cuddly teddy bear, perfect for birthdays.', 'Large', 2, 'Assorted', 'Flower, Teddy', 30, 0, 0, 0, TRUE),
('Love Symphony', 79.99, 69.99, 13, 'An extravagant arrangement of roses, chocolates, and a greeting card, perfect for expressing heartfelt emotions.', 'Extra Large', 3, 'Pink, White', 'Roses, Chocolate, Paper', 20, 0, 0, 0, TRUE),
('Deluxe Celebration Package', 99.99, 89.99, 10, 'A grand combination of flowers, chocolates, and a jumbo-sized teddy bear, perfect for special occasions.', 'Jumbo', 5, 'Assorted', 'Flowers, Chocolate, Teddy', 15, 0, 0, 0, TRUE),
('Mother''s Day Medley', 69.99, 59.99, 14, 'A charming arrangement of flowers and a heartfelt greeting card, perfect for celebrating mothers.', 'Medium', 2, 'Pink, Purple', 'Flowers, Paper', 25, 0, 0, 0, TRUE),
('Heavenly Roses & Chocolate Delight', 59.99, 49.99, 17, 'A classic combination of red roses and premium chocolates, perfect for expressing love and affection.', 'Medium', 1.5, 'Red, Brown', 'Roses, Chocolate', 30, 0, 0, 0, TRUE),
('Luxury Birthday Extravaganza', 89.99, 79.99, 11, 'An opulent arrangement of flowers, chocolates, and a plush teddy bear, perfect for celebrating birthdays in style.', 'Large', 3, 'Assorted', 'Flowers, Chocolate, Teddy', 20, 0, 0, 0, TRUE),
('Elegant Valentine''s Affair', 69.99, 59.99, 14, 'A sophisticated arrangement of roses, chocolates, and a romantic greeting card, perfect for Valentine''s Day.', 'Medium', 2, 'Red, White', 'Roses, Chocolate, Paper', 25, 0, 0, 0, TRUE),
('Springtime Surprise', 49.99, 39.99, 20, 'A delightful combination of spring flowers and chocolates, perfect for bringing cheer to any occasion.', 'Small', 1, 'Assorted', 'Flowers, Chocolate', 35, 0, 0, 0, TRUE),
('Charming Greetings Bouquet', 59.99, 49.99, 17, 'A beautiful bouquet of assorted flowers paired with a heartfelt greeting card, perfect for expressing warm wishes.', 'Medium', 2, 'Assorted', 'Flowers, Paper', 30, 0, 0, 0, TRUE);

INSERT INTO products (name, price, sale_price, sale_percentage, detail_description, size, weight, color, material, stock, sold, rating_avg, total_rating, is_available) VALUES 
('Red Roses Bouquet', 30, 25, 17, 'A classic bouquet of fresh red roses, symbolizing love and passion.', 'Standard', 0, 'Red', 'Fresh Roses', 50, 0, 0, 0, TRUE),
('White Orchid Arrangement', 40, 35, 12.5, 'Elegant arrangement of white orchids, perfect for sophisticated occasions.', 'Medium', 0, 'White', 'Fresh Orchids', 30, 0, 0, 0, TRUE),
('Rainbow Gerbera Bouquet', 25, 20, 20, 'Vibrant bouquet featuring a mix of colorful gerbera daisies.', 'Standard', 0, 'Multi-color', 'Fresh Gerbera Daisies', 40, 0, 0, 0, TRUE),
('Pink Lily Vase', 35, 30, 14.3, 'Graceful arrangement of pink lilies in a glass vase.', 'Large', 0, 'Pink', 'Fresh Lilies', 20, 0, 0, 0, TRUE),
('Mixed Flower Basket', 50, 45, 10, 'Charming basket filled with an assortment of seasonal flowers.', 'Medium', 0, 'Mixed', 'Fresh Mixed Flowers', 25, 0, 0, 0, TRUE),
('Elegant Carnation Bouquet', 30, 25, 17, 'Classic bouquet of carnations in elegant hues.', 'Standard', 0, 'Various', 'Fresh Carnations', 35, 0, 0, 0, TRUE),
('Chocolate Bouquet', 45, 40, 11.1, 'Bouquet crafted from premium chocolates, a delightful treat for any occasion.', 'Large', 0, 'Brown', 'Assorted Chocolates', 15, 0, 0, 0, TRUE),
('Sunshine Yellow Roses Bouquet', 35, 30, 14.3, 'Bright and cheerful bouquet featuring yellow roses to spread happiness.', 'Standard', 0, 'Yellow', 'Fresh Roses', 45, 0, 0, 0, TRUE),
('Purple Orchid Lei', 25, 20, 20, 'Exotic lei made of purple orchids, perfect for Hawaiian-themed parties.', 'Standard', 0, 'Purple', 'Fresh Orchids', 20, 0, 0, 0, TRUE),
('Pink Gerbera Daisy Bunch', 20, 18, 10, 'Delicate bunch of pink gerbera daisies, perfect for expressing affection.', 'Small', 0, 'Pink', 'Fresh Gerbera Daisies', 30, 0, 0, 0, TRUE);

INSERT INTO products (name, price, sale_price, sale_percentage, detail_description, size, weight, color, material, stock, sold, rating_avg, total_rating, is_available) VALUES 
('Happy Birthday Bash Cake', 39.99, 34.99, 12.5, 'A colorful and fun birthday cake decorated with balloons and confetti.', 'Medium', 2, 'Assorted', 'Fondant', 30, 0, 0, 0, TRUE),
('Elegant Anniversary Elegance Cake', 49.99, 39.99, 10, 'A sophisticated floral-themed cake perfect for celebrating anniversaries.', 'Large', 3, 'White, Gold', 'Fondant', 25, 0, 0, 0, TRUE),
('Love Struck Heart Cake', 59.99, 54.99, 8.3, 'A romantic heart-shaped cake adorned with delicate roses, perfect for expressing love.', 'Large', 3.5, 'Red, White', 'Fondant', 20, 0, 0, 0, TRUE),
('Classic Round Celebration Cake', 44.99, 39.99, 11.1, 'A timeless round-shaped cake suitable for any celebration, adorned with colorful sprinkles.', 'Medium', 2.5, 'Assorted', 'Fondant', 35, 0, 0, 0, TRUE),
('Magical Unicorn Dreams Cake', 54.99, 49.99, 9.1, 'A whimsical cake featuring a majestic unicorn, perfect for a magical birthday celebration.', 'Large', 3, 'Pastel', 'Fondant', 25, 0, 0, 0, TRUE),
('Golden Anniversary Bliss Cake', 69.99, 64.99, 7.1, 'A luxurious gold-themed cake adorned with intricate floral designs, perfect for milestone anniversaries.', 'Extra Large', 4, 'Gold, White', 'Fondant', 15, 0, 0, 0, TRUE),
('Enchanted Garden Cake', 59.99, 54.99, 8.3, 'A whimsical floral cake resembling a lush garden, perfect for outdoor-themed celebrations.', 'Large', 3.5, 'Green, Pink', 'Fondant', 20, 0, 0, 0, TRUE),
('Sweetheart Engagement Cake', 49.99, 44.99, 10, 'A romantic cake featuring intertwined hearts, perfect for celebrating engagements.', 'Medium', 2.5, 'Red, White', 'Fondant', 25, 0, 0, 0, TRUE),
('Springtime Floral Fantasy Cake', 54.99, 49.99, 9.1, 'A vibrant floral cake inspired by the colors of spring, perfect for seasonal celebrations.', 'Large', 3, 'Assorted', 'Fondant', 30, 0, 0, 0, TRUE),
('Adorable Teddy Bear Cake', 44.99, 39.99, 11.1, 'A cute cake featuring a fondant teddy bear, perfect for children''s birthdays.', 'Medium', 2, 'Brown, White', 'Fondant', 35, 0, 0, 0, TRUE);

INSERT INTO product_images (product_id, image_url) VALUES 
(1, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765245/products/Sweetheart%20Surprise/sweetheart-surprise-1_ozqt2p.jpg'),
(1, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765255/products/Sweetheart%20Surprise/sweetheart-surprise-2_uqqifb.jpg'),
(1, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765267/products/Sweetheart%20Surprise/sweetheart-surprise-3_gsiwr7.jpg'),
(1, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765276/products/Sweetheart%20Surprise/sweetheart-surprise-4_hcdpur.jpg'),

(2, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765337/products/Birthday%20Bliss%20Bouquet/birthday-bliss-bouquet-1_fpbm3b.jpg'),
(2, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765347/products/Birthday%20Bliss%20Bouquet/birthday-bliss-bouquet-2_me7pml.jpg'),
(2, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765356/products/Birthday%20Bliss%20Bouquet/birthday-bliss-bouquet-3_zfsejf.jpg'),
(2, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765368/products/Birthday%20Bliss%20Bouquet/birthday-bliss-bouquet-4_wycjeu.png'),

(3, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765503/products/Love%20Symphony/love-symphony-1_dz89gn.jpg'),
(3, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765514/products/Love%20Symphony/love-symphony-2_lw5k9s.jpg'),
(3, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765524/products/Love%20Symphony/love-symphony-3_etcfpn.jpg'),
(3, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765536/products/Love%20Symphony/love-symphony-4_r0sse5.jpg'),

(4, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765641/products/Deluxe%20Celebration%20Package/deluxe-celebration-package-1_guycko.jpg'),
(4, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765652/products/Deluxe%20Celebration%20Package/deluxe-celebration-package-2_ese9c3.jpg'),
(4, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765675/products/Deluxe%20Celebration%20Package/deluxe-celebration-package-3_noo4fl.png'),
(4, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765663/products/Deluxe%20Celebration%20Package/deluxe-celebration-package-4_e4dbsz.jpg'),

(5, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765776/products/Mother%27s%20Day%20Medley/mother-day-medley-1_vqqeu1.jpg'),
(5, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765787/products/Mother%27s%20Day%20Medley/mother-day-medley-2_yueeju.jpg'),
(5, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765799/products/Mother%27s%20Day%20Medley/mother-day-medley-3_wb9urk.jpg'),
(5, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765811/products/Mother%27s%20Day%20Medley/mother-day-medley-4_yvzqbm.jpg'),

(6, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765924/products/Heavenly%20Roses%20and%20Chocolate%20Delight/heavenly-roses-and-chocolate-delight-1_vl1fpy.jpg'),
(6, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765935/products/Heavenly%20Roses%20and%20Chocolate%20Delight/heavenly-roses-and-chocolate-delight-2_zpqz1h.jpg'),
(6, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765948/products/Heavenly%20Roses%20and%20Chocolate%20Delight/heavenly-roses-and-chocolate-delight-3_yuxv9u.jpg'),
(6, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713765959/products/Heavenly%20Roses%20and%20Chocolate%20Delight/heavenly-roses-and-chocolate-delight-4_c2frkm.jpg'),

(7, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766063/products/Luxury%20Birthday%20Extravaganza/luxury-birthday-extravaganza-1_u7zafg.jpg'),
(7, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766075/products/Luxury%20Birthday%20Extravaganza/luxury-birthday-extravaganza-2_qxtuct.jpg'),
(7, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766087/products/Luxury%20Birthday%20Extravaganza/luxury-birthday-extravaganza-3_t0pe4k.jpg'),
(7, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766100/products/Luxury%20Birthday%20Extravaganza/luxury-birthday-extravaganza-4_z1cbg3.jpg'),

(8, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766197/products/Elegant%20Valentine%27s%20Affair/elegant-valentine-affair-1_fzgkns.jpg'),
(8, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766185/products/Elegant%20Valentine%27s%20Affair/elegant-valentine-affair-2_qgdf7p.jpg'),
(8, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766210/products/Elegant%20Valentine%27s%20Affair/elegant-valentine-affair-3_yxvbm0.jpg'),
(8, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766223/products/Elegant%20Valentine%27s%20Affair/elegant-valentine-affair-4_ewg2ie.jpg'),

(9, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766333/products/Springtime%20Surprise/springtime-surprise-1_xidt1q.jpg'),
(9, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766345/products/Springtime%20Surprise/springtime-surprise-2_xbuk7j.jpg'),
(9, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766358/products/Springtime%20Surprise/springtime-surprise-3_qzt50m.jpg'),
(9, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766371/products/Springtime%20Surprise/springtime-surprise-4_whbnze.jpg'),

(10, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713766462/products/Charming%20Greetings%20Bouquet/charming-greetings-bouquet-1_bropqz.jpg'),
(10, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713775426/products/Charming%20Greetings%20Bouquet/charming-greetings-bouquet-2_ipebbb.jpg'),
(10, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713775424/products/Charming%20Greetings%20Bouquet/charming-greetings-bouquet-3_wsl71z.png'),
(10, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713775432/products/Charming%20Greetings%20Bouquet/charming-greetings-bouquet-4_ddaisj.jpg'),

(11, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713757379/products/Red%20Roses%20Bouquet/red-roses-bouquet-1_xqci3j.png'),
(11, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713757384/products/Red%20Roses%20Bouquet/red-roses-bouquet-2_icbim4.jpg'),
(11, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713757374/products/Red%20Roses%20Bouquet/red-roses-bouquet-3_bmpuyo.jpg'),
(11, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713757371/products/Red%20Roses%20Bouquet/red-roses-bouquet-4_hlaw3v.jpg'),

(12, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713758882/products/White%20Orchid%20Arrangement/white-orchid-arrangement-1_h1aws8.jpg'),
(12, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713758901/products/White%20Orchid%20Arrangement/white-orchid-arrangement-2_qze6xz.jpg'),
(12, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713758890/products/White%20Orchid%20Arrangement/white-orchid-arrangement-3_o8ld0o.jpg'),
(12, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713758896/products/White%20Orchid%20Arrangement/white-orchid-arrangement-4_ru0fbv.jpg'),

(13, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759042/products/Rainbow%20Gerbera%20Bouquet/rainbow-gerbera-bouquet-1_fhngpp.jpg'),
(13, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759047/products/Rainbow%20Gerbera%20Bouquet/rainbow-gerbera-bouquet-2_xhbznl.jpg'),
(13, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759053/products/Rainbow%20Gerbera%20Bouquet/rainbow-gerbera-bouquet-3_rcjd78.jpg'),
(13, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759059/products/Rainbow%20Gerbera%20Bouquet/rainbow-gerbera-bouquet-4_ql3oht.jpg'),

(14, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759147/products/Pink%20Lily%20Vase/pink-lily-vase-1_gp98xx.jpg'),
(14, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759142/products/Pink%20Lily%20Vase/pink-lily-vase-2_dux35f.jpg'),
(14, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759179/products/Pink%20Lily%20Vase/pink-lily-vase-3_yiclfw.jpg'),
(14, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759185/products/Pink%20Lily%20Vase/pink-lily-vase-4_hipor0.jpg'),

(15, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759270/products/Mixed%20Flower%20Basket/mixed-flower-basket-1_ch4ot4.jpg'),
(15, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759281/products/Mixed%20Flower%20Basket/mixed-flower-basket-2_yihnsh.jpg'),
(15, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759288/products/Mixed%20Flower%20Basket/mixed-flower-basket-3_hqvsi2.jpg'),
(15, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759293/products/Mixed%20Flower%20Basket/mixed-flower-basket-4_vnstrc.jpg'),

(16, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759359/products/Elegant%20Carnation%20Bouquet/elegant-carnation-bouquet-1_a0kh8t.jpg'),
(16, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759365/products/Elegant%20Carnation%20Bouquet/elegant-carnation-bouquet-2_tc1lw5.jpg'),
(16, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759375/products/Elegant%20Carnation%20Bouquet/elegant-carnation-bouquet-3_tiz2bd.jpg'),
(16, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759384/products/Elegant%20Carnation%20Bouquet/elegant-carnation-bouquet-4_sk93lb.jpg'),

(17, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759783/products/Chocolate%20Bouquet/chocolate-bouquet-1_nkjqlr.jpg'),
(17, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759799/products/Chocolate%20Bouquet/chocolate-bouquet-2_gxvbvh.jpg'),
(17, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759806/products/Chocolate%20Bouquet/chocolate-bouquet-3_lowcga.jpg'),
(17, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759813/products/Chocolate%20Bouquet/chocolate-bouquet-4_tos25n.jpg'),

(18, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759888/products/Sunshine%20Yellow%20Roses%20Bouquet/sunshine-yellow-roses-bouquet-1_qpbybu.jpg'),
(18, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759895/products/Sunshine%20Yellow%20Roses%20Bouquet/sunshine-yellow-roses-bouquet-2_rvosdl.jpg'),
(18, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759901/products/Sunshine%20Yellow%20Roses%20Bouquet/sunshine-yellow-roses-bouquet-3_t78tuy.jpg'),
(18, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713759907/products/Sunshine%20Yellow%20Roses%20Bouquet/sunshine-yellow-roses-bouquet-4_fg9usw.jpg'),

(19, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760013/products/Purple%20Orchid%20Lei/purple-orchid-lei-1_xnrlky.jpg'),
(19, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760019/products/Purple%20Orchid%20Lei/purple-orchid-lei-2_nug1nw.jpg'),
(19, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760000/products/Purple%20Orchid%20Lei/purple-orchid-lei-3_jsyxak.jpg'),
(19, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760007/products/Purple%20Orchid%20Lei/purple-orchid-lei-4_axzy7x.jpg'),

(20, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760098/products/Pink%20Gerbera%20Daisy%20Bunch/pink-gerbera-daisy-bunch-1_f6gbqd.jpg'),
(20, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760091/products/Pink%20Gerbera%20Daisy%20Bunch/pink-gerbera-daisy-bunch-2_dilvz8.jpg'),
(20, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760157/products/Pink%20Gerbera%20Daisy%20Bunch/pink-gerbera-daisy-bunch-3_fz32r4.jpg'),
(20, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713760162/products/Pink%20Gerbera%20Daisy%20Bunch/pink-gerbera-daisy-bunch-4_kodbxs.jpg'),

(21, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777686/products/Happy%20Birthday%20Bash%20Cake/happy-birthday-bash-cake-1_chh8ij.jpg'),
(21, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777686/products/Happy%20Birthday%20Bash%20Cake/happy-birthday-bash-cake-2_lbergt.jpg'),
(21, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777685/products/Happy%20Birthday%20Bash%20Cake/happy-birthday-bash-cake-3_x99a2g.jpg'),
(21, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777686/products/Happy%20Birthday%20Bash%20Cake/happy-birthday-bash-cake-4_imjchd.jpg'),

(22, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777783/products/Elegant%20Anniversary%20Elegance%20Cake/elegant-anniversary-elegance-cake-1_zhctfw.jpg'),
(22, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777780/products/Elegant%20Anniversary%20Elegance%20Cake/elegant-anniversary-elegance-cake-2_mfzydr.jpg'),
(22, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777783/products/Elegant%20Anniversary%20Elegance%20Cake/elegant-anniversary-elegance-cake-3_rxnpve.jpg'),
(22, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777790/products/Elegant%20Anniversary%20Elegance%20Cake/elegant-anniversary-elegance-cake-4_lhyjlt.jpg'),

(23, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777879/products/Love%20Struck%20Heart%20Cake/love-struck-heart-cake-1_hbwin4.jpg'),
(23, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777880/products/Love%20Struck%20Heart%20Cake/love-struck-heart-cake-2_y6t6ji.jpg'),
(23, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777890/products/Love%20Struck%20Heart%20Cake/love-struck-heart-cake-3_xmeh17.jpg'),
(23, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777891/products/Love%20Struck%20Heart%20Cake/love-struck-heart-cake-4_pdteoc.jpg'),

(24, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778004/products/Classic%20Round%20Celebration%20Cake/classic-round-celebration-cake-1_qrxnso.jpg'),
(24, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713777991/products/Classic%20Round%20Celebration%20Cake/classic-round-celebration-cake-2_mqbqro.jpg'),
(24, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778001/products/Classic%20Round%20Celebration%20Cake/classic-round-celebration-cake-3_wrp4wg.jpg'),
(24, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778002/products/Classic%20Round%20Celebration%20Cake/classic-round-celebration-cake-4_ixt1ya.jpg'),

(25, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778426/products/Magical%20Unicorn%20Dreams%20Cake/magical-unicorn-dreams-cake-1_k28gbk.jpg'),
(25, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778421/products/Magical%20Unicorn%20Dreams%20Cake/magical-unicorn-dreams-cake-2_edk46a.jpg'),
(25, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778421/products/Magical%20Unicorn%20Dreams%20Cake/magical-unicorn-dreams-cake-3_sfx2wf.jpg'),
(25, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778423/products/Magical%20Unicorn%20Dreams%20Cake/magical-unicorn-dreams-cake-4_sihbzt.jpg'),

(26, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778524/products/Golden%20Anniversary%20Bliss%20Cake/golden-anniversary-bliss-cake-1_nlyhwl.jpg'),
(26, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778526/products/Golden%20Anniversary%20Bliss%20Cake/golden-anniversary-bliss-cake-2_vtcmgx.jpg'),
(26, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778529/products/Golden%20Anniversary%20Bliss%20Cake/golden-anniversary-bliss-cake-3_cittut.jpg'),
(26, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778531/products/Golden%20Anniversary%20Bliss%20Cake/golden-anniversary-bliss-cake-4_mxnp7m.jpg'),

(27, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778619/products/Enchanted%20Garden%20Cake/enchanted-garden-cake-1_d34v9y.jpg'),
(27, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778622/products/Enchanted%20Garden%20Cake/enchanted-garden-cake-2_rowcqb.jpg'),
(27, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778624/products/Enchanted%20Garden%20Cake/enchanted-garden-cake-3_mtyhga.jpg'),
(27, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778627/products/Enchanted%20Garden%20Cake/enchanted-garden-cake-4_dyg4vf.jpg'),

(28, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778693/products/Sweetheart%20Engagement%20Cake/sweetheart-engagement-cake-1_aaieyd.jpg'),
(28, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778708/products/Sweetheart%20Engagement%20Cake/sweetheart-engagement-cake-2_sf2c27.jpg'),
(28, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778715/products/Sweetheart%20Engagement%20Cake/sweetheart-engagement-cake-3_lz0igs.jpg'),
(28, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778711/products/Sweetheart%20Engagement%20Cake/sweetheart-engagement-cake-4_nyc9so.jpg'),

(29, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778803/products/Springtime%20Floral%20Fantasy%20Cake/springtime-floral-fantasy-cake-1_fn8zfh.jpg'),
(29, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778813/products/Springtime%20Floral%20Fantasy%20Cake/springtime-floral-fantasy-cake-2_hghcsi.jpg'),
(29, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778817/products/Springtime%20Floral%20Fantasy%20Cake/springtime-floral-fantasy-cake-3_ug8njz.jpg'),
(29, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778821/products/Springtime%20Floral%20Fantasy%20Cake/springtime-floral-fantasy-cake-4_lba0er.jpg'),

(30, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778890/products/Adorable%20Teddy%20Bear%20Cake/adorable-teddy-bear-cake-1_aywv6q.jpg'),
(30, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778907/products/Adorable%20Teddy%20Bear%20Cake/adorable-teddy-bear-cake-2_hsc1pc.jpg'),
(30, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778912/products/Adorable%20Teddy%20Bear%20Cake/adorable-teddy-bear-cake-3_mobqhw.jpg'),
(30, 'https://res.cloudinary.com/dauyd6npv/image/upload/v1713778927/products/Adorable%20Teddy%20Bear%20Cake/adorable-teddy-bear-cake-4_ulpcrz.jpg');

INSERT INTO product_type (product_id, type_id) VALUES
(1, 1),
(1, 2),
(1, 3),

(2, 1),
(2, 4),

(3, 1),
(3, 2),
(3, 6),

(4, 1),
(4, 5),

(5, 1),
(5, 6),

(6, 1),
(6, 3),

(7, 1),
(7, 5),

(8, 1),
(8, 2),
(8, 6),

(9, 1),
(9, 3),

(10, 1),
(10, 6),

(11, 7),
(11, 8),

(12, 7),
(12, 9),

(13, 7),
(13, 10),

(14, 7),
(14, 11),

(15, 7),
(15, 12),

(16, 7),
(16, 13),

(17, 7),
(17, 14),

(18, 7),
(18, 8),

(19, 7),
(19, 9),

(20, 7),
(20, 10),

(21, 15),
(21, 16),

(22, 15),
(22, 17),

(23, 15),
(23, 18),

(24, 15),
(24, 19),

(25, 15),
(25, 16),

(26, 15),
(26, 17),

(27, 15),
(27, 17),

(28, 15),
(28, 18),

(29, 15),
(29, 17),

(30, 15),
(30, 16);

INSERT INTO product_occasion (product_id, occasion_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(5, 3),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(7, 2),
(8, 1),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 5),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 5),
(11, 6),
(11, 8),
(12, 6),
(12, 9),
(13, 7),
(13, 9),
(14, 6),
(14, 7),
(15, 7),
(15, 9),
(15, 10),
(16, 7),
(16, 10),
(17, 6),
(17, 7),
(17, 8),
(18, 7),
(18, 9),
(19, 6),
(19, 7),
(20, 7),
(20, 9),
(20, 10),
(21, 11),
(21, 12),
(22, 13),
(23, 16),
(24, 11),
(24, 12),
(24, 13),
(24, 14),
(24, 15),
(24, 16),
(24, 17),
(24, 18),
(25, 12),
(26, 11),
(26, 13),
(27, 12),
(27, 13),
(27, 14),
(27, 15),
(27, 16),
(27, 17),
(27, 18),
(28, 14),
(29, 12),
(29, 13),
(29, 14),
(29, 15),
(29, 16),
(29, 17),
(29, 18),
(30, 12);

CREATE TABLE carts (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT pk_carts PRIMARY KEY (user_id, product_id),
    CONSTRAINT fk_carts_1 FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_carts_2 FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL NOT NULL,
    product_price DECIMAL NOT NULL,
    shipping_price DECIMAL NOT NULL,
    status VARCHAR(20) NOT NULL,
    estimated_receive_date TIMESTAMP,
    order_date TIMESTAMP,
    in_delivery_date TIMESTAMP,
    receive_date TIMESTAMP,
    province VARCHAR(50) NOT NULL,
    district VARCHAR(50) NOT NULL,
    ward VARCHAR(50) NOT NULL,
    detail_address VARCHAR(100) NOT NULL,
    receiver_name VARCHAR(100) NOT NULL,
    receiver_phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE order_details (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT pk_order_details PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order_details_1 FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT fk_order_details_2 FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE import_product_records (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    import_date TIMESTAMP,
    CONSTRAINT fk_import_product_records FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE export_product_records (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    export_date TIMESTAMP,
    CONSTRAINT fk_export_product_records FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE params (
    name VARCHAR(50) NOT NULL,
    value BIGINT NOT NULL
);

INSERT INTO params VALUES ('SHIPPING_PRICE', 2);
