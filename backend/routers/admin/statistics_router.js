import express from "express";
import pg from "pg";

import adminValidator from "../../middlewares/admin_validator.js";

const statisticsRouter = express.Router();

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

statisticsRouter.get(
  "/admin/product-analytics/categories",
  adminValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const categories = await db.query("SELECT * FROM categories");

      let categoryMap = [];
      for (let i = 0; i < categories.rowCount; i++) {
        const products = await db.query(
          "SELECT DISTINCT p.*, c.* FROM products p, product_type pt, types t, categories c WHERE p.id = pt.product_id AND pt.type_id = t.id AND t.category_id = c.id AND c.id = $1 UNION SELECT DISTINCT p.*, c.* FROM products p, product_occasion po, occasions o, categories c WHERE p.id = po.product_id AND po.occasion_id = o.id AND o.category_id = c.id AND c.id = $1",
          [categories.rows[i].id]
        );

        let value = 0;
        for (let j = 0; j < products.rowCount; j++) {
          value += Number(products.rows[j].stock);
        }

        categoryMap.push({ name: categories.rows[i].name, value });
      }

      await db.end();

      res.json(categoryMap);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default statisticsRouter;
