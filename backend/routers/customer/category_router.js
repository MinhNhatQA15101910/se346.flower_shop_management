import express from "express";
import pg from "pg";

import authValidator from "../../middlewares/auth_validator.js";

const categoryRouter = express.Router();

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

// Fetch all categories
categoryRouter.get("/customer/categories", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const categories = await db.query("SELECT * FROM categories");

    await db.end();

    res.json(categories.rows);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Fetch all types
categoryRouter.get("/customer/types", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const { category_id } = req.query;

    if (category_id) {
      const categories = await db.query(
        "SELECT * FROM types WHERE category_id = $1",
        [category_id]
      );

      await db.end();

      return res.json(categories.rows);
    }

    const categories = await db.query("SELECT * FROM types");

    await db.end();

    res.json(categories.rows);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Fetch all occasions
categoryRouter.get("/customer/occasions", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const { category_id } = req.query;

    if (category_id) {
      const categories = await db.query(
        "SELECT * FROM occasions WHERE category_id = $1",
        [category_id]
      );

      await db.end();

      return res.json(categories.rows);
    }

    const categories = await db.query("SELECT * FROM occasions");

    await db.end();

    res.json(categories.rows);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

export default categoryRouter;
