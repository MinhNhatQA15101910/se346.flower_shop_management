import env from "dotenv";
import express from "express";

import authRouter from "./routers/auth_router.js";
import productRouter from "./routers/customer/product_router.js";
import categoryRouter from "./routers/customer/category_router.js";
import cartRouter from "./routers/customer/cart_router.js";
import orderRouter from "./routers/customer/order_router.js";

import adminProductRouter from "./routers/admin/product_router.js";
import adminCategoryRouter from "./routers/admin/category_router.js";
import adminOrderRouter from "./routers/admin/order_router.js";

import cors from "cors";

const app = express();
env.config();

app.use(express.json());
app.use(cors());

// Customer
app.use(authRouter);
app.use(productRouter);
app.use(categoryRouter);
app.use(cartRouter);
app.use(orderRouter);

// Admin
app.use(adminProductRouter);
app.use(adminCategoryRouter);
app.use(adminOrderRouter);

app.get("/", (req, res) => {
  res.render("index.ejs");
});

app.listen(process.env.PORT, () => {
  console.log(`Server running on: http://localhost:${process.env.PORT}.`);
});
