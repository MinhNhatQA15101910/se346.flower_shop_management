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

        categoryMap.push({
          name: categories.rows[i].name,
          value: value.toString(),
        });
      }

      await db.end();

      res.json(categoryMap);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

statisticsRouter.get(
  "/admin/revenue-analytics",
  adminValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const months = [
        "JAN",
        "FEB",
        "MAR",
        "APR",
        "MAY",
        "JUN",
        "JUL",
        "AUG",
        "SEP",
        "OCT",
        "NOV",
        "DEC",
      ];

      let map = [];
      for (let i = 0; i < 12; i++) {
        const sum = await db.query(
          "SELECT SUM(total_price) FROM orders WHERE EXTRACT(MONTH FROM receive_date) = $1",
          [i + 1]
        );
        if (sum.rows[0].sum) {
          map.push({ name: months[i], value: sum.rows[0].sum });
        } else {
          map.push({ name: months[i], value: "0" });
        }
      }

      await db.end();

      res.json(map);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

statisticsRouter.get("/admin/total-sales", adminValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const totalSale = await db.query("SELECT SUM (total_price) FROM orders");

    await db.end();

    res.json(totalSale.rows[0].sum);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

statisticsRouter.get(
  "/admin/total-products",
  adminValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const products = await db.query(
        "SELECT * FROM products WHERE is_available = TRUE"
      );

      await db.end();

      res.json(products.rowCount.toString());
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

statisticsRouter.get(
  "/admin/total-orders",
  adminValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const orders = await db.query("SELECT * FROM orders");

      await db.end();

      res.json(orders.rowCount.toString());
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

statisticsRouter.get(
  "/admin/total-customers",
  adminValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const customers = await db.query(
        "SELECT * FROM users WHERE role = 'user'"
      );

      await db.end();

      res.json(customers.rowCount.toString());
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default statisticsRouter;
