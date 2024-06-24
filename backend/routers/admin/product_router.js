import express from "express";
import pg from "pg";
import adminValidator from "../../middlewares/admin_validator.js";
import nameValidator from "../../middlewares/name_validator.js";
import priceValidator from "../../middlewares/price_validator.js";
import salePercentageValidator from "../../middlewares/sale_percentage_validator.js";
import detailDescriptionValidator from "../../middlewares/detail_description_validator.js";
import sizeValidator from "../../middlewares/size_validator.js";
import weightValidator from "../../middlewares/weight_validator.js";
import stockValidator from "../../middlewares/stock_validator.js";

const adminProductRouter = express.Router();

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

// Add new product
adminProductRouter.post(
  "/admin/add-product",
  adminValidator,
  nameValidator,
  priceValidator,
  salePercentageValidator,
  detailDescriptionValidator,
  sizeValidator,
  weightValidator,
  stockValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      let {
        name,
        price,
        sale_percentage,
        detail_description,
        size,
        weight,
        color,
        material,
        stock,
      } = req.body;

      if (!sale_percentage) sale_percentage = 0;
      if (!weight) weight = 0;
      if (!color) color = "";
      if (!material) material = "";

      res.json("Hello");
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default adminProductRouter;
