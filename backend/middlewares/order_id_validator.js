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

// Validate order id
const orderIdValidator = async (req, res, next) => {
  console.log("Order id validator middleware:");
  console.log("- Order id: " + req.params.order_id);

  const db = getDatabaseInstance();

  try {
    const orderId = req.params.order_id;

    if (!orderId) {
      return res.status(400).json({ msg: "Order id is required." });
    }

    let result = await db.query("SELECT * FROM orders WHERE id = $1", [
      orderId,
    ]);

    if (result.rowCount === 0) {
      db.end();
      return res.status(400).json({ msg: "Order id not exists." });
    }

    db.end();

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default orderIdValidator;
