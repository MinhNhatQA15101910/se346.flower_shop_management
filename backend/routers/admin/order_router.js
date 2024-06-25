import express from "express";
import pg from "pg";

import adminValidator from "../../middlewares/admin_validator.js";
import orderIdValidator from "../../middlewares/order_id_validator.js";

const adminOrderRouter = express.Router();

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

// Change order status
adminOrderRouter.patch(
  "/admin/change-order-status/:order_id",
  adminValidator,
  orderIdValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { order_id } = req.params;

      let order;

      const orderStatus = await db.query(
        "SELECT status FROM orders WHERE id = $1",
        [order_id]
      );
      if (orderStatus.rows[0].status === "Pending") {
        order = await db.query(
          "UPDATE orders SET status = 'In Delivery', in_delivery_date = $1 WHERE id = $2 RETURNING *",
          [new Date(), order_id]
        );
      } else if (orderStatus.rows[0].status == "In Delivery") {
        order = await db.query(
          "UPDATE orders SET status = 'Received', receive_date = $1 WHERE id = $2 RETURNING *",
          [new Date(), order_id]
        );
      } else {
        return res.status(400).json({ msg: "Cannot change status." });
      }

      await db.end();

      res.json(order.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default adminOrderRouter;
