CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(200) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(1000) NOT NULL,
    image_url VARCHAR(100),
    role VARCHAR(10)
);
