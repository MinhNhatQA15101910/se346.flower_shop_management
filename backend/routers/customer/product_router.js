import express from "express";
import pg from "pg";

import authValidator from "../../middlewares/auth_validator.js";

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

productRouter.get("/customer/products", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    let { page, type_id, occasion_id, keyword } = req.query;

    let products;

    if (type_id) {
      if (keyword) {
        products = await db.query(
          "SELECT p.* FROM products p, product_type pt, types t WHERE p.id = pt.product_id AND pt.type_id = t.id AND t.id = $1 AND p.name LIKE $2",
          [type_id, "%" + keyword + "%"]
        );
      } else {
        products = await db.query(
          "SELECT p.* FROM products p, product_type pt, types t WHERE p.id = pt.product_id AND pt.type_id = t.id AND t.id = $1",
          [type_id]
        );
      }
    } else if (occasion_id) {
      if (keyword) {
        products = await db.query(
          "SELECT p.* FROM products p, product_occasion po, occasions o WHERE p.id = po.product_id AND po.occasion_id = o.id AND o.id = $1 AND p.name LIKE $2",
          [occasion_id, "%" + keyword + "%"]
        );
      } else {
        products = await db.query(
          "SELECT p.* FROM products p, product_occasion po, occasions o WHERE p.id = po.product_id AND po.occasion_id = o.id AND o.id = $1",
          [occasion_id]
        );
      }
    } else {
      if (keyword) {
        products = await db.query("SELECT * FROM products WHERE name LIKE $1", [
          "%" + keyword + "%",
        ]);
      } else {
        products = await db.query("SELECT * FROM products");
      }
    }

    const totalPages = Math.ceil(products.rowCount / 10);
    const totalResults = products.rowCount;

    if (page) {
      if (!Number(page) || page <= 0) {
        await db.end();
        return res.status(400).json({
          msg: `Invalid page: Pages start at 1 and max at ${totalPages}. They are expected to be an integer.`,
        });
      }
    } else {
      page = 1;
    }

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

productRouter.get("/customer/deals-of-day", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    let { page } = req.query;

    const products = await db.query(
      "SELECT * FROM products ORDER BY (rating_avg * total_rating) DESC"
    );

    const totalPages = Math.ceil(products.rowCount / 10);
    const totalResults = products.rowCount;

    if (page) {
      if (!Number(page) || page <= 0) {
        await db.end();
        return res.status(400).json({
          msg: `Invalid page: Pages start at 1 and max at ${totalPages}. They are expected to be an integer.`,
        });
      }
    } else {
      page = 1;
    }

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
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      var { page } = req.query;

      const products = await db.query(
        "SELECT * FROM products ORDER BY rating_avg DESC"
      );

      const totalPages = Math.ceil(products.rowCount / 10);
      const totalResults = products.rowCount;

      if (page) {
        if (!Number(page) || page <= 0) {
          await db.end();
          return res.status(400).json({
            msg: `Invalid page: Pages start at 1 and max at ${totalPages}. They are expected to be an integer.`,
          });
        }
      } else {
        page = 1;
      }

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

export default productRouter;
