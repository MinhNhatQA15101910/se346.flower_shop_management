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

const typeIdValidator = async (req, res, next) => {
  console.log("Type id validator middleware:");
  console.log("- Type id: " + req.params.type_id);

  const db = getDatabaseInstance();

  try {
    const typeId = req.params.type_id;

    if (!typeId) {
      return res.status(400).json({ msg: "Type id is required." });
    }

    let result = await db.query("SELECT * FROM types WHERE id = $1", [typeId]);

    if (result.rowCount === 0) {
      db.end();
      return res.status(400).json({ msg: "Type id not exists." });
    }

    db.end();

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default typeIdValidator;
