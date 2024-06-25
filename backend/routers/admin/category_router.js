import express from "express";
import pg from "pg";

import adminValidator from "../../middlewares/admin_validator.js";
import nameValidator from "../../middlewares/name_validator.js";
import categoryIdValidator from "../../middlewares/category_id_validator.js";
import imageUrlValidator from "../../middlewares/image_url_validator.js";
import typeIdValidator from "../../middlewares/type_id_validator.js";
import occasionIdValidator from "../../middlewares/occasion_id_validator.js";

const adminCategoryRouter = express.Router();

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

// Get type by id
adminCategoryRouter.get(
  "/admin/types/:type_id",
  adminValidator,
  typeIdValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { type_id } = req.params;

      const type = await db.query("SELECT * FROM types WHERE id = $1", [
        type_id,
      ]);

      await db.end();

      res.json(type.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Add new type
adminCategoryRouter.post(
  "/admin/add-type",
  adminValidator,
  categoryIdValidator,
  imageUrlValidator,
  nameValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { category_id, name, image_url } = req.body;

      const existingType = await db.query(
        "SELECT * FROM types WHERE name = $1 AND category_id = $2",
        [name, category_id]
      );
      if (existingType.rowCount !== 0) {
        await db.end();
        return res.status(400).json({ msg: "Type name already existed." });
      }

      const type = await db.query(
        "INSERT INTO types (category_id, name, image_url) VALUES ($1, $2, $3) RETURNING *",
        [category_id, name, image_url]
      );

      await db.end();

      res.json(type.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Update type
adminCategoryRouter.patch(
  "/admin/update-type/:type_id",
  adminValidator,
  typeIdValidator,
  nameValidator,
  imageUrlValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { type_id } = req.params;
      const { name, image_url } = req.body;

      // Get category_id from type_id
      const categoryId = await db.query(
        "SELECT category_id FROM types WHERE id = $1",
        [type_id]
      );

      // Validate if type name already exists in the category
      const result = await db.query(
        "SELECT * FROM types WHERE category_id = $1 AND name = $2 AND id <> $3",
        [categoryId.rows[0].category_id, name, type_id]
      );
      if (result.rowCount !== 0) {
        await db.end();
        return res
          .status(400)
          .json({ msg: "Type name already exists in the category." });
      }

      const type = await db.query(
        "UPDATE types SET name = $1, image_url = $2 WHERE id = $3 RETURNING *",
        [name, image_url, type_id]
      );

      await db.end();

      res.json(type.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Get occasion by id
adminCategoryRouter.get(
  "/admin/occasions/:occasion_id",
  adminValidator,
  occasionIdValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { occasion_id } = req.params;

      const occasion = await db.query("SELECT * FROM occasions WHERE id = $1", [
        occasion_id,
      ]);

      await db.end();

      res.json(occasion.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Add new occasion
adminCategoryRouter.post(
  "/admin/add-occasion",
  adminValidator,
  categoryIdValidator,
  imageUrlValidator,
  nameValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { category_id, name, image_url } = req.body;

      const existingOccasion = await db.query(
        "SELECT * FROM occasions WHERE name = $1 AND category_id = $2",
        [name, category_id]
      );
      if (existingOccasion.rowCount !== 0) {
        await db.end();
        return res.status(400).json({ msg: "Occasion name already existed." });
      }

      const occasion = await db.query(
        "INSERT INTO occasions (category_id, name, image_url) VALUES ($1, $2, $3) RETURNING *",
        [category_id, name, image_url]
      );

      await db.end();

      res.json(occasion.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// Update occasion
adminCategoryRouter.patch(
  "/admin/update-occasion/:occasion_id",
  adminValidator,
  occasionIdValidator,
  nameValidator,
  imageUrlValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { occasion_id } = req.params;
      const { name, 
        
       } = req.body;

      // Get category_id from occasion_id
      const categoryId = await db.query(
        "SELECT category_id FROM occasions WHERE id = $1",
        [occasion_id]
      );

      // Validate if type name already exists in the category
      const result = await db.query(
        "SELECT * FROM occasions WHERE category_id = $1 AND name = $2 AND id <> $3",
        [categoryId.rows[0].category_id, name, occasion_id]
      );
      if (result.rowCount !== 0) {
        await db.end();
        return res
          .status(400)
          .json({ msg: "Occasion name already exists in the category." });
      }

      const occasion = await db.query(
        "UPDATE occasions SET name = $1, image_url = $2 WHERE id = $3 RETURNING *",
        [name, image_url, occasion_id]
      );

      await db.end();

      res.json(occasion.rows[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

export default adminCategoryRouter;
