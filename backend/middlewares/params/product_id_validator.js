import pg from "pg";

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

// Validate product id
const productIdValidator = async (req, res, next) => {
  console.log("Product id validator middleware:");
  console.log("- Product id: " + req.params.product_id);

  const db = getDatabaseInstance();

  try {
    const productId = req.params.product_id;

    if (!productId) {
      return res.status(400).json({ msg: "Product id is required." });
    }

    let result = await db.query("SELECT * FROM products WHERE id = $1", [
      productId,
    ]);

    if (result.rowCount === 0) {
      await db.end();
      return res.status(400).json({ msg: "Product id not exists." });
    }

    await db.end();

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default productIdValidator;
