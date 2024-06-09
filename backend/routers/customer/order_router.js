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
const shippingPriceKey = "SHIPPING_PRICE";

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

      // Get order from database
      const order = await db.query("SELECT * FROM orders WHERE id = $1", [
        order_id,
      ]);

      // Load all products from order
      const productsResult = await db.query(
        "SELECT DISTINCT p.* FROM products p, order_details od WHERE p.id = od.product_id AND od.order_id = $1 ORDER BY p.id ASC",
        [order_id]
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

      // Load all quantities from order
      const quantitiesResult = await db.query(
        "SELECT quantity FROM order_details WHERE order_id = $1 ORDER BY product_id ASC",
        [order_id]
      );
      let quantities = [];
      for (let i = 0; i < quantitiesResult.rowCount; i++) {
        quantities.push(quantitiesResult.rows[i].quantity);
      }

      await db.end();

      res.json({ ...order.rows[0], products, quantities });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Create order from cart
orderRouter.post(
  "/customer/create-order-from-cart",
  authValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      await db.end();
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Create order form product
orderRouter.post(
  "/customer/create-order-from-product",
  authValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const {
        product_id,
        estimated_receive_date,
        province,
        district,
        ward,
        detail_address,
        receiver_name,
        receiver_phone_number,
      } = req.body;

      // Validate if the product stock is greater or equal than 1
      const product = await db.query("SELECT * FROM products WHERE id = $1", [
        product_id,
      ]);
      if (product.rows[0].stock < 1) {
        return res
          .status(400)
          .json({ msg: `${product.rows[0].name} is out of stock.` });
      }

      // Decrease the product stock
      db.query("UPDATE products SET stock = $1 WHERE id = $2", [
        product.rows[0].stock - 1,
        product_id,
      ]);

      // Get shipping price
      const shippingPriceValue = await db.query(
        "SELECT value FROM params WHERE name = $1",
        [shippingPriceKey]
      );

      // Get total price
      const totalPrice =
        Number(shippingPriceValue.rows[0].value) +
        Number(product.rows[0].sale_price);

      // Create order
      const newOrderResult = await db.query(
        "INSERT INTO orders(user_id, total_price, product_price, shipping_price, status, estimated_receive_date, order_date, province, district, ward, detail_address, receiver_name, receiver_phone_number) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING *",
        [
          req.user,
          Number(totalPrice),
          Number(product.rows[0].sale_price),
          Number(shippingPriceValue.rows[0].value),
          "Pending",
          estimated_receive_date,
          new Date(),
          province,
          district,
          ward,
          detail_address,
          receiver_name,
          receiver_phone_number,
        ]
      );

      // Add order details
      const newOrderDetail = await db.query(
        "INSERT INTO order_details VALUES ($1, $2, 1) RETURNING *",
        [newOrderResult.rows[0].id, product_id]
      );

      // Load products to list
      let products = [];
      const orderProduct = await db.query(
        "SELECT * FROM products WHERE id = $1",
        [newOrderDetail.rows[0].product_id]
      );

      let imageUrlList = await db.query(
        "SELECT image_url FROM product_images WHERE product_id = $1",
        [newOrderDetail.rows[0].product_id]
      );

      let imageUrls = [];
      for (let j = 0; j < imageUrlList.rowCount; j++) {
        imageUrls.push(imageUrlList.rows[j].image_url);
      }

      orderProduct.rows[0].image_urls = imageUrls;

      products.push(orderProduct.rows[0]);

      // Load quantities to list
      let quantities = [1];

      await db.end();

      res.json({ ...newOrderResult.rows[0], products, quantities });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default orderRouter;
