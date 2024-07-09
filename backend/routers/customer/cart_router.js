import express from "express";
import pg from "pg";

import authValidator from "../../middlewares/headers/auth_validator.js";

const cartRouter = express.Router();

function getDatabaseInstance() {
  const db = new pg.Client({
    user: process.env.PG_USER,
    host: process.env.PG_HOST,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT,
  });
  db.connect();
  return db;
}

// Add product to cart
cartRouter.post("/customer/add-to-cart", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const { product_id } = req.body;

    let cart = await db.query("SELECT * FROM carts WHERE user_id = $1", [
      req.user,
    ]);
    if (cart.rowCount === 0) {
      db.query("INSERT INTO carts VALUES ($1, $2, 1)", [req.user, product_id]);
    } else {
      let isProductFound = false;
      let products = await db.query(
        "SELECT * FROM carts WHERE user_id = $1 AND product_id = $2",
        [req.user, product_id]
      );
      if (products.rowCount !== 0) {
        isProductFound = true;
      }

      if (isProductFound) {
        let currQuantity = await db.query(
          "SELECT quantity FROM carts WHERE user_id = $1 AND product_id = $2",
          [req.user, product_id]
        );
        let newQuantity = currQuantity.rows[0].quantity + 1;
        db.query(
          "UPDATE carts SET quantity = $1 WHERE user_id = $2 AND product_id = $3",
          [newQuantity, req.user, product_id]
        );
      } else {
        db.query("INSERT INTO carts VALUES ($1, $2, 1)", [
          req.user,
          product_id,
        ]);
      }
    }

    let user = await db.query("SELECT * FROM users WHERE id = $1", [req.user]);
    const productsResult = await db.query(
      "SELECT DISTINCT p.* FROM products p, carts c, users u WHERE p.id = c.product_id AND c.user_id = $1 ORDER BY p.id ASC",
      [user.rows[0].id]
    );
    const products = productsResult.rows;
    for (let i = 0; i < products.length; i++) {
      let imageUrlList = await db.query(
        "SELECT image_url FROM product_images WHERE product_id = $1",
        [products[i].id]
      );

      let imageUrls = [];
      for (let j = 0; j < imageUrlList.rowCount; j++) {
        imageUrls.push(imageUrlList.rows[j].image_url);
      }

      products[i].image_urls = imageUrls;
    }

    const quantitiesResult = await db.query(
      "SELECT quantity FROM carts WHERE user_id = $1 ORDER BY product_id ASC",
      [user.rows[0].id]
    );
    let quantities = [];
    for (let i = 0; i < quantitiesResult.rowCount; i++) {
      quantities.push(quantitiesResult.rows[i].quantity);
    }

    await db.end();
    res.json({
      token: req.token,
      ...user.rows[0],
      products,
      quantities,
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Remove product from cart
cartRouter.delete(
  "/customer/remove-from-cart/:product_id",
  authValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { product_id } = req.params;

      const cart = await db.query(
        "SELECT * FROM carts WHERE user_id = $1 AND product_id = $2",
        [req.user, product_id]
      );
      if (cart.rows[0].quantity === 1) {
        db.query("DELETE FROM carts WHERE user_id = $1 AND product_id = $2", [
          req.user,
          product_id,
        ]);
      } else {
        db.query(
          "UPDATE carts SET quantity = $1 WHERE user_id = $2 AND product_id = $3",
          [cart.rows[0].quantity - 1, req.user, product_id]
        );
      }

      let user = await db.query("SELECT * FROM users WHERE id = $1", [
        req.user,
      ]);
      const productsResult = await db.query(
        "SELECT DISTINCT p.* FROM products p, carts c, users u WHERE p.id = c.product_id AND c.user_id = $1 ORDER BY p.id ASC",
        [user.rows[0].id]
      );
      const products = productsResult.rows;
      for (let i = 0; i < products.length; i++) {
        let imageUrlList = await db.query(
          "SELECT image_url FROM product_images WHERE product_id = $1",
          [products[i].id]
        );

        let imageUrls = [];
        for (let j = 0; j < imageUrlList.rowCount; j++) {
          imageUrls.push(imageUrlList.rows[j].image_url);
        }

        products[i].image_urls = imageUrls;
      }
      const quantitiesResult = await db.query(
        "SELECT quantity FROM carts WHERE user_id = $1 ORDER BY product_id ASC",
        [user.rows[0].id]
      );
      let quantities = [];
      for (let i = 0; i < quantitiesResult.rowCount; i++) {
        quantities.push(quantitiesResult.rows[i].quantity);
      }

      await db.end();
      res.json({
        token: req.token,
        ...user.rows[0],
        products,
        quantities,
      });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Delete product from cart
cartRouter.delete(
  "/customer/delete-from-cart/:product_id",
  authValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { product_id } = req.params;

      db.query("DELETE FROM carts WHERE user_id = $1 AND product_id = $2", [
        req.user,
        product_id,
      ]);

      let user = await db.query("SELECT * FROM users WHERE id = $1", [
        req.user,
      ]);
      const productsResult = await db.query(
        "SELECT DISTINCT p.* FROM products p, carts c, users u WHERE p.id = c.product_id AND c.user_id = $1 ORDER BY p.id ASC",
        [user.rows[0].id]
      );
      const products = productsResult.rows;
      for (let i = 0; i < products.length; i++) {
        let imageUrlList = await db.query(
          "SELECT image_url FROM product_images WHERE product_id = $1",
          [products[i].id]
        );

        let imageUrls = [];
        for (let j = 0; j < imageUrlList.rowCount; j++) {
          imageUrls.push(imageUrlList.rows[j].image_url);
        }

        products[i].image_urls = imageUrls;
      }
      const quantitiesResult = await db.query(
        "SELECT quantity FROM carts WHERE user_id = $1 ORDER BY product_id ASC",
        [user.rows[0].id]
      );
      let quantities = [];
      for (let i = 0; i < quantitiesResult.rowCount; i++) {
        quantities.push(quantitiesResult.rows[i].quantity);
      }

      await db.end();
      res.json({
        token: req.token,
        ...user.rows[0],
        products,
        quantities,
      });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default cartRouter;
