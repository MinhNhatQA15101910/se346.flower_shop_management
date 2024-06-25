import express from "express";
import pg from "pg";

import authValidator from "../../middlewares/auth_validator.js";
import pageValidator from "../../middlewares/page_validator.js";
import productIdValidator from "../../middlewares/product_id_validator.js";

const productRouter = express.Router();

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

// Get all products
productRouter.get(
  "/customer/products",
  authValidator,
  pageValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      let { page, type_id, occasion_id, keyword } = req.query;

      let products;

      if (type_id) {
        if (keyword) {
          products = await db.query(
            "SELECT p.* FROM products p, product_type pt, types t WHERE p.id = pt.product_id AND pt.type_id = t.id AND p.is_available = TRUE AND t.id = $1 AND p.name LIKE $2",
            [type_id, "%" + keyword + "%"]
          );
        } else {
          products = await db.query(
            "SELECT p.* FROM products p, product_type pt, types t WHERE p.id = pt.product_id AND pt.type_id = t.id AND p.is_available = TRUE AND t.id = $1",
            [type_id]
          );
        }
      } else if (occasion_id) {
        if (keyword) {
          products = await db.query(
            "SELECT p.* FROM products p, product_occasion po, occasions o WHERE p.id = po.product_id AND po.occasion_id = o.id AND p.is_available = TRUE AND o.id = $1 AND p.name LIKE $2",
            [occasion_id, "%" + keyword + "%"]
          );
        } else {
          products = await db.query(
            "SELECT p.* FROM products p, product_occasion po, occasions o WHERE p.id = po.product_id AND po.occasion_id = o.id AND p.is_available = TRUE AND o.id = $1",
            [occasion_id]
          );
        }
      } else {
        if (keyword) {
          products = await db.query(
            "SELECT * FROM products WHERE name LIKE $1 AND is_available = TRUE",
            ["%" + keyword + "%"]
          );
        } else {
          products = await db.query(
            "SELECT * FROM products WHERE is_available = TRUE"
          );
        }
      }

      const totalPages = Math.ceil(products.rowCount / 10);
      const totalResults = products.rowCount;

      const results = products.rows.splice((page - 1) * 10, 10);

      for (let i = 0; i < results.length; i++) {
        let imageUrlList = await db.query(
          "SELECT image_url FROM product_images WHERE product_id = $1",
          [results[i].id]
        );

        let imageUrls = [];
        for (let j = 0; j < imageUrlList.rowCount; j++) {
          imageUrls.push(imageUrlList.rows[j].image_url);
        }

        results[i].image_urls = imageUrls;
      }

      await db.end();

      res.json({
        page: page,
        results,
        total_pages: totalPages,
        total_results: totalResults,
      });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

productRouter.get("/customer/deals-of-day", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    let { page } = req.query;

    const products = await db.query(
      "SELECT * FROM products WHERE is_available = TRUE ORDER BY (rating_avg * total_rating) DESC"
    );

    const totalPages = Math.ceil(products.rowCount / 10);
    const totalResults = products.rowCount;

    const results = products.rows.splice((page - 1) * 10, 10);

    for (let i = 0; i < results.length; i++) {
      let imageUrlList = await db.query(
        "SELECT image_url FROM product_images WHERE product_id = $1",
        [results[i].id]
      );

      let imageUrls = [];
      for (let j = 0; j < imageUrlList.rowCount; j++) {
        imageUrls.push(imageUrlList.rows[j].image_url);
      }

      results[i].image_urls = imageUrls;
    }

    await db.end();

    res.json({
      page: 1,
      results,
      total_pages: totalPages,
      total_results: totalResults,
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get(
  "/customer/recommended-products",
  authValidator,
  pageValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      var { page } = req.query;

      const products = await db.query(
        "SELECT * FROM products WHERE is_available = TRUE ORDER BY rating_avg DESC"
      );

      const totalPages = Math.ceil(products.rowCount / 10);
      const totalResults = products.rowCount;

      const results = products.rows.splice((page - 1) * 10, 10);

      for (let i = 0; i < results.length; i++) {
        let imageUrlList = await db.query(
          "SELECT image_url FROM product_images WHERE product_id = $1",
          [results[i].id]
        );

        let imageUrls = [];
        for (let j = 0; j < imageUrlList.rowCount; j++) {
          imageUrls.push(imageUrlList.rows[j].image_url);
        }

        results[i].image_urls = imageUrls;
      }

      await db.end();

      res.json({
        page: 1,
        results,
        total_pages: totalPages,
        total_results: totalResults,
      });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

productRouter.get(
  "/customer/products/:product_id",
  authValidator,
  productIdValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { product_id } = req.params;

      const product = await db.query("SELECT * FROM products WHERE id = $1", [
        product_id,
      ]);

      let imageUrlList = await db.query(
        "SELECT image_url FROM product_images WHERE product_id = $1",
        [product_id]
      );

      let imageUrls = [];
      for (let i = 0; i < imageUrlList.rowCount; i++) {
        imageUrls.push(imageUrlList.rows[i].image_url);
      }

      product.rows[0].image_urls = imageUrls;

      await db.end();

      res.json(product.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default productRouter;
