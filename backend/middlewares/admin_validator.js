import jwt from "jsonwebtoken";
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

const adminValidator = async (req, res, next) => {
  const db = getDatabaseInstance();

  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(401).json({ msg: "No auth token, access denied." });
    }

    const verified = jwt.verify(token, process.env.PASSWORD_KEY);
    if (!verified) {
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });
    }

    const user = await db.query("SELECT * FROM users WHERE id = $1", [
      verified.id,
    ]);
    if (user.role !== "admin") {
      return res.status(401).json({ msg: "You are not an admin!" });
    }

    req.user = verified.id;
    req.token = token;

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default adminValidator;
