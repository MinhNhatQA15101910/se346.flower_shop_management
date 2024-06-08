import express from "express";
import pg from "pg";

import authValidator from "../../middlewares/auth_validator.js";

const orderRouter = express.Router();

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

// Fetch all orders (with param)
orderRouter.get("/customer/orders", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const { user_id, status } = req.query;

    let orders;
    if (user_id && status) {
      orders = await db.query(
        "SELECT * FROM orders WHERE user_id = $1 AND status = $2",
        [user_id, status]
      );
    } else if (user_id) {
      orders = await db.query("SELECT * FROM orders WHERE user_id = $1", [
        user_id,
      ]);
    } else if (status) {
      orders = await db.query("SELECT * FROM orders WHERE status = $1", [
        status,
      ]);
    } else {
      orders = await db.query("SELECT * FROM orders");
    }

    await db.end();

    res.json(orders.rows);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get order by id
orderRouter.get(
  "/customer/orders/:order_id",
  authValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { order_id } = req.params;

      let orders = await db.query("SELECT * FROM orders WHERE id = $1", [
        order_id,
      ]);

      await db.end();

      res.json(orders.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default orderRouter;
