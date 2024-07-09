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

// Validate occasion ids
const occasionIdsValidator = async (req, res, next) => {
  console.log("Occasion ids validator middleware:");
  console.log("- Occasion ids: " + req.body.occasion_ids);

  const db = getDatabaseInstance();

  try {
    const occasionIds = req.body.occasion_ids;

    if (!occasionIds) {
      await db.end();
      return res.status(400).json({ msg: "Occasion ids is required." });
    }

    if (occasionIds.length === 0) {
      await db.end();
      return res
        .status(400)
        .json({ msg: "Occasion ids must not be an empty list." });
    }

    if (new Set(occasionIds).size !== occasionIds.length) {
      return res
        .status(400)
        .json({ msg: "Occasion ids cannot be duplicated." });
    }

    for (let i = 0; i < occasionIds.length; i++) {
      const result = await db.query("SELECT * FROM occasions WHERE id = $1", [
        occasionIds[i],
      ]);
      if (result.rowCount === 0) {
        await db.end();
        return res.status(400).json({ msg: "Invalid occasion ids." });
      }
    }

    await db.end();

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default occasionIdsValidator;
