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

// Validate type ids
const typeIdsValidator = async (req, res, next) => {
  console.log("Type ids validator middleware:");
  console.log("- Type ids: " + req.body.type_ids);

  const db = getDatabaseInstance();

  try {
    const typeIds = req.body.type_ids;

    if (!typeIds) {
      await db.end();
      return res.status(400).json({ msg: "Type ids is required." });
    }

    if (typeIds.length === 0) {
      await db.end();
      return res
        .status(400)
        .json({ msg: "Type ids must not be an empty list." });
    }

    if (new Set(typeIds).size !== typeIds.length) {
      return res.status(400).json({ msg: "Type ids cannot be duplicated." });
    }

    for (let i = 0; i < typeIds.length; i++) {
      const result = await db.query("SELECT * FROM types WHERE id = $1", [
        typeIds[i],
      ]);
      if (result.rowCount === 0) {
        await db.end();
        return res.status(400).json({ msg: "Invalid type ids." });
      }
    }

    await db.end();

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default typeIdsValidator;
