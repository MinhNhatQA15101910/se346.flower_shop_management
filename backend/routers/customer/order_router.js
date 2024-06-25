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

    for (let i = 0; i < orders.rowCount; i++) {
      // Load all products from order
      const productsResult = await db.query(
        "SELECT DISTINCT p.* FROM products p, order_details od WHERE p.id = od.product_id AND od.order_id = $1 ORDER BY p.id ASC",
        [orders.rows[i].id]
      );
      const products = productsResult.rows;
      for (let j = 0; j < products.length; j++) {
        let imageUrlList = await db.query(
          "SELECT image_url FROM product_images WHERE product_id = $1",
          [products[j].id]
        );

        let imageUrls = [];
        for (let k = 0; k < imageUrlList.rowCount; k++) {
          imageUrls.push(imageUrlList.rows[k].image_url);
        }

        products[j].image_urls = imageUrls;
      }

      // Load all quantities from order
      const quantitiesResult = await db.query(
        "SELECT quantity FROM order_details WHERE order_id = $1 ORDER BY product_id ASC",
        [orders.rows[i].id]
      );
      let quantities = [];
      for (let j = 0; j < quantitiesResult.rowCount; j++) {
        quantities.push(quantitiesResult.rows[j].quantity);
      }

      orders.rows[i].products = products;
      orders.rows[i].quantities = quantities;
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

      const {
        estimated_receive_date,
        province,
        district,
        ward,
        detail_address,
        receiver_name,
        receiver_phone_number,
      } = req.body;

      const cart = await db.query("SELECT * FROM carts WHERE user_id = $1", [
        req.user,
      ]);

      // Check if exist product with stock is smaller than quantity in cart.
      for (let i = 0; i < cart.rowCount; i++) {
        let product = await db.query("SELECT * FROM products WHERE id = $1", [
          cart.rows[i].product_id,
        ]);
        let stock = product.rows[0].stock;
        let quantity = cart.rows[i].quantity;
        if (stock >= quantity) {
          db.query("UPDATE products SET stock = $1, sold = $2 WHERE id = $3", [
            stock - quantity,
            quantity,
            cart.rows[i].product_id,
          ]);
        } else {
          return res
            .status(400)
            .json({ msg: `${product.rows[0].name} is out of stock!` });
        }
      }

      // Get shipping price
      const shippingPriceValue = await db.query(
        "SELECT value FROM params WHERE name = $1",
        [shippingPriceKey]
      );

      // Get product price
      const productPrice = await db.query(
        "SELECT SUM(p.sale_price * c.quantity) FROM products p, carts c, users u WHERE p.id = c.product_id AND c.user_id = u.id AND u.id = $1",
        [req.user]
      );

      // Get total price
      const totalPrice =
        Number(shippingPriceValue.rows[0].value) +
        Number(productPrice.rows[0].sum);

      // Create order
      const newOrderResult = await db.query(
        "INSERT INTO orders(user_id, total_price, product_price, shipping_price, status, estimated_receive_date, order_date, province, district, ward, detail_address, receiver_name, receiver_phone_number) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13) RETURNING *",
        [
          req.user,
          Number(totalPrice),
          Number(productPrice.rows[0].sum),
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

      // Create order details
      for (let i = 0; i < cart.rowCount; i++) {
        db.query("INSERT INTO order_details VALUES ($1, $2, $3)", [
          newOrderResult.rows[0].id,
          cart.rows[i].product_id,
          cart.rows[i].quantity,
        ]);
      }

      // Empty cart
      db.query("DELETE FROM carts WHERE user_id = $1", [req.user]);

      // Get all order details
      const productsResult = await db.query(
        "SELECT DISTINCT p.* FROM products p, order_details od WHERE p.id = od.product_id AND od.order_id = $1 ORDER BY p.id ASC",
        [newOrderResult.rows[0].id]
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
        "SELECT quantity FROM order_details WHERE order_id = $1 ORDER BY product_id ASC",
        [newOrderResult.rows[0].id]
      );
      let quantities = [];
      for (let i = 0; i < quantitiesResult.rowCount; i++) {
        quantities.push(quantitiesResult.rows[i].quantity);
      }

      await db.end();

      res.json({ ...newOrderResult.rows[0], products, quantities });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Create order from product
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
      db.query("UPDATE products SET stock = $1, sold = 1 WHERE id = $2", [
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

// Get shipping price
orderRouter.get("/customer/shipping_price", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const shippingPrice = await db.query(
      "SELECT * FROM params WHERE name = $1",
      [shippingPriceKey]
    );

    await db.end();

    res.json(shippingPrice.rows[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

export default orderRouter;
