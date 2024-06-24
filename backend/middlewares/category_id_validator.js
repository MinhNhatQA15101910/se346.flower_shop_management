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

// Validate category id
const categoryIdValidator = async (req, res, next) => {
  console.log("Category id validator middleware:");
  console.log("- Category id: " + req.body.category_id);

  const db = getDatabaseInstance();

  try {
    const categoryId = req.body.category_id;

    if (!categoryId) {
      return res.status(400).json({ msg: "Category id is required." });
    }

    let result = await db.query("SELECT * FROM categories WHERE id = $1", [
      categoryId,
    ]);

    if (result.rowCount === 0) {
      return res.status(400).json({ msg: "Category id not exists." });
    }

    db.end();

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default categoryIdValidator;
