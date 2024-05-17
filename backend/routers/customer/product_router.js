import express from "express";
import pg from "pg";
import authValidator from "../../middlewares/auth_validator.js";

const productRouter = express.Router();

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

productRouter.get("/customer/deals-of-day", authValidator, async (req, res) => {
  try {
    const db = getDatabaseInstance();

    const { page } = req.query;

    const products = await db.query(
      "SELECT * FROM products ORDER BY (rating_avg * total_rating) DESC"
    );

    const totalPages = Math.floor(products.rowCount / 10);
    const totalResults = products.rowCount;

    if (page) {
      if (page !== 1) {
        if (page <= 0 || page > totalPages) {
          return res.status(400).json({
            msg: `Invalid page: Pages start at 1 and max at ${totalPages}. They are expected to be an integer.`,
          });
        } else {
          if (page === totalPages) {
            const results = products.rows.splice((page - 1) * 10);

            return res.json({
              page,
              results,
              total_pages: totalPages,
              total_results: totalResults,
            });
          }
        }
      }
    }

    const results = products.rows.splice(0, 10);

    await db.end();

    res.json({
      page: 1,
      results,
      total_pages: totalPages,
      total_results: totalResults,
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

export default productRouter;
