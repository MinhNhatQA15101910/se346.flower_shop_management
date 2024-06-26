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

// Validate occasion id
const occasionIdValidator = async (req, res, next) => {
  console.log("Occasion id validator middleware:");
  console.log("- Occasion id: " + req.params.occasion_id);

  const db = getDatabaseInstance();

  try {
    const occasionId = req.params.occasion_id;

    if (!occasionId) {
      return res.status(400).json({ msg: "Occasion id is required." });
    }

    let result = await db.query("SELECT * FROM occasions WHERE id = $1", [
      occasionId,
    ]);

    if (result.rowCount === 0) {
      await db.end();
      return res.status(400).json({ msg: "Occasion id not exists." });
    }

    await db.end();

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default occasionIdValidator;
