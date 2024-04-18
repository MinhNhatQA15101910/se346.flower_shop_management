import bcryptjs from "bcryptjs";
import express from "express";
import pg from "pg";

import emailValidator from "../middlewares/email_validator.js";
import usernameValidator from "../middlewares/username_validator.js";
import passwordValidator from "../middlewares/password_validator.js";

const authRouter = express.Router();

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

// Sign up route
authRouter.post(
  "/signup",
  usernameValidator,
  emailValidator,
  passwordValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { username, email, password } = req.body;

      const existingUser = await db.query(
        "SELECT * FROM users WHERE email = $1",
        [email]
      );
      if (existingUser.rowCount > 0) {
        return res
          .status(400)
          .json({ msg: "User with the same email already exists!" });
      }

      if (password.length < 8) {
        return res.status(400).json({ msg: "Password too short!" });
      }

      const hashedPassword = await bcryptjs.hash(
        password,
        Number(process.env.SALT_ROUNDS)
      );

      const result = await db.query(
        "INSERT INTO users (username, email, password, role) VALUES ($1, $2, $3, $4) RETURNING *",
        [username, email, hashedPassword, "user"]
      );

      await db.end();

      res.json(result.rows[0]);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

export default authRouter;
