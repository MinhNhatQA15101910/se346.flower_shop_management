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
import typeIdsValidator from "../../middlewares/type_ids_validator.js";
import occasionIdsValidator from "../../middlewares/occasion_ids_validator.js";
import imageUrlsValidator from "../../middlewares/image_urls_validator.js";

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
  typeIdsValidator,
  occasionIdsValidator,
  imageUrlsValidator,
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
        type_ids,
        occasion_ids,
        image_urls,
      } = req.body;

      if (!sale_percentage) sale_percentage = 0;
      if (!weight) weight = 0;
      if (!color) color = "";
      if (!material) material = "";

      // Validate if there is another product with the same name in db
      const existingProduct = await db.query(
        "SELECT * FROM products WHERE name = $1",
        [name]
      );
      if (existingProduct.rowCount !== 0) {
        await db.end();
        return res.status(400).json({ msg: "Product name already existed." });
      }

      // Calculate sale price
      let salePrice = (Number(price) * (100 - sale_percentage)) / 100;

      // Add product to db
      const product = await db.query(
        "INSERT INTO products (name, price, sale_price, sale_percentage, detail_description, size, weight, color, material, stock, sold, rating_avg, total_rating, is_available) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, 0, 0, 0, TRUE) RETURNING *",
        [
          name,
          price,
          salePrice,
          sale_percentage,
          detail_description,
          size,
          weight,
          color,
          material,
          stock,
        ]
      );

      // Add product types to db
      for (let i = 0; i < type_ids.length; i++) {
        await db.query("INSERT INTO product_type VALUES ($1, $2)", [
          product.rows[0].id,
          type_ids[i],
        ]);
      }

      // Add product occasions to db
      for (let i = 0; i < occasion_ids.length; i++) {
        await db.query("INSERT INTO product_occasion VALUES ($1, $2)", [
          product.rows[0].id,
          occasion_ids[i],
        ]);
      }

      // Add product images to db
      for (let i = 0; i < image_urls.length; i++) {
        await db.query("INSERT INTO product_images VALUES ($1, $2)", [
          product.rows[0].id,
          image_urls[i],
        ]);
      }

      // Add import product record
      await db.query(
        "INSERT INTO import_product_records (product_id, quantity, import_date) VALUES ($1, $2, $3)",
        [product.rows[0].id, stock, new Date()]
      );

      // Add images to product
      product.rows[0].image_urls = image_urls;

      await db.end();

      res.json(product.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default adminProductRouter;
