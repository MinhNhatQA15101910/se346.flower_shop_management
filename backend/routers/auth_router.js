import bcryptjs from "bcryptjs";
import express from "express";
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";
import pg from "pg";

import emailValidator from "../middlewares/email_validator.js";
import usernameValidator from "../middlewares/username_validator.js";
import passwordValidator from "../middlewares/password_validator.js";
import pincodeValidator from "../middlewares/pincode_validator.js";
import newPasswordValidator from "../middlewares/new_password_validator.js";
import authValidator from "../middlewares/auth_validator.js";

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

function hideEmailCharacters(email) {
  const [username, domain] = email.split("@");

  const usernameLength = username.length;

  const hiddenCharactersCount = Math.max(usernameLength - 2, 0);

  const hiddenUsername =
    username.substring(0, 1) +
    "*".repeat(hiddenCharactersCount) +
    username.substring(usernameLength - 1);

  const hiddenEmail = hiddenUsername + "@" + domain;

  return hiddenEmail;
}

// Sign up route
authRouter.post(
  "/signup",
  usernameValidator,
  emailValidator,
  passwordValidator,
  async (req, res) => {
    console.log("------ Send email route ------");
    console.log(
      `Body: \n- username: ${req.body.username},\n- email: ${req.body.email},\n- password: ${req.body.password}`
    );

    try {
      const db = getDatabaseInstance();

      const { username, email, password } = req.body;

      const existingUser = await db.query(
        "SELECT * FROM users WHERE email = $1",
        [email]
      );
      if (existingUser.rowCount > 0) {
        await db.end();

        return res
          .status(400)
          .json({ msg: "User with the same email already exists!" });
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

// Log in route
authRouter.post(
  "/login",
  emailValidator,
  passwordValidator,
  async (req, res) => {
    console.log("------ Log in route ------");
    console.log(
      `Body: \n- email: ${req.body.email},\n- password: ${req.body.password}`
    );

    try {
      const db = getDatabaseInstance();

      const { email, password } = req.body;

      const user = await db.query("SELECT * FROM users WHERE email = $1", [
        email,
      ]);
      if (user.rowCount === 0) {
        await db.end();

        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }

      const isMatch = await bcryptjs.compare(password, user.rows[0].password);
      if (!isMatch) {
        await db.end();

        return res.status(400).json({ msg: "Incorrect password!" });
      }

      const products = await db.query(
        "SELECT DISTINCT p.* FROM products p, carts c, users u WHERE p.id = c.product_id AND c.user_id = $1 ORDER BY p.id ASC",
        [user.rows[0].id]
      );
      const quantities = await db.query(
        "SELECT quantity FROM carts WHERE user_id = $1 ORDER BY product_id ASC",
        [user.rows[0].id]
      );

      await db.end();

      const token = jwt.sign({ id: user.rows[0].id }, process.env.PASSWORD_KEY);
      res.json({
        token,
        ...user.rows[0],
        products: products.rows,
        quantities: quantities.rows,
      });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

// Log in with Google route
authRouter.post(
  "/login/google",
  emailValidator,
  passwordValidator,
  usernameValidator,
  async (req, res) => {
    console.log("------ Log in with Google route ------");
    console.log(
      `Body: \n- email: ${req.body.email},\n- password: ${req.body.password},\n- username: ${req.body.username},\n- imageUrl: ${req.body.imageUrl}`
    );

    try {
      const db = getDatabaseInstance();

      const { email, password, username, imageUrl } = req.body;

      const existingUser = await db.query(
        "SELECT * FROM users WHERE email = $1",
        [email]
      );
      if (existingUser.rowCount > 0) {
        const token = jwt.sign(
          { id: existingUser.rows[0].id },
          process.env.PASSWORD_KEY
        );

        const products = await db.query(
          "SELECT DISTINCT p.* FROM products p, carts c, users u WHERE p.id = c.product_id AND c.user_id = $1 ORDER BY p.id ASC",
          [existingUser.rows[0].id]
        );
        const quantities = await db.query(
          "SELECT quantity FROM carts WHERE user_id = $1 ORDER BY product_id ASC",
          [existingUser.rows[0].id]
        );

        await db.end();

        return res.json({
          token,
          ...existingUser.rows[0],
          products: products.rows,
          quantities: quantities.rows,
        });
      }

      const hashedPassword = await bcryptjs.hash(
        password,
        Number(process.env.SALT_ROUNDS)
      );

      const result = await db.query(
        "INSERT INTO users (username, email, password, image_url, role) VALUES ($1, $2, $3, $4, $5) RETURNING *",
        [username, email, hashedPassword, imageUrl, "user"]
      );

      await db.end();

      const token = jwt.sign(
        { id: result.rows[0].id },
        process.env.PASSWORD_KEY
      );
      res.json({
        token,
        ...result.rows[0],
        products: [],
        quantities: [],
      });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

// Validate email route
authRouter.post("/email-exists", emailValidator, async (req, res) => {
  console.log("------ Validate email route ------");
  console.log(`Body:\n- email: ${req.body.email}`);

  try {
    const db = getDatabaseInstance();

    const { email } = req.body;

    const existingUser = await db.query(
      "SELECT * FROM users WHERE email = $1",
      [email]
    );
    if (existingUser.rowCount > 0) {
      db.end();

      return res.json(true);
    }

    db.end();

    res.json(false);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Send verify email route
authRouter.post(
  "/send-email",
  emailValidator,
  pincodeValidator,
  async (req, res) => {
    console.log("------ Send email route ------");
    console.log(
      `Body: \n- email: ${req.body.email},\n- pincode: ${req.body.pincode}`
    );

    try {
      const { email, pincode } = req.body;

      var transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 465,
        secure: true,
        auth: {
          user: process.env.FLOWERFLY_EMAIL,
          pass: process.env.FLOWERFLY_PASSWORD,
        },
      });

      var mailOptions = {
        from: process.env.FLOWERFLY_EMAIL,
        to: email,
        subject: "FlowerFly account verify code",
        html: `<h2>FlowerFly account</h2>
      <h1 style="color:#23C16B;">Verify code</h1>
      <p>
        Please use the following verify code for the FlowerFly account:
        ${hideEmailCharacters(email)}
      </p>
      <p>Security code: <b>${pincode}</b></p>
      <p>
        If you didn't request this code, you can safely ignore this email. Someone
        else might have typed your email address by mistake.
      </p>
      <br />
      <p>Thanks,</p>
      <p>The FlowerFly development team.</p>`,
      };

      transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
          res.status(500).json({ error: error.message });
        } else {
          res.json({ msg: "Email sent: " + info.response });
        }
      });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

// Change password route
authRouter.patch(
  "/change-password",
  emailValidator,
  newPasswordValidator,
  async (req, res) => {
    try {
      const db = getDatabaseInstance();

      const { email, newPassword } = req.body;

      let existingUser = await db.query(
        "SELECT * FROM users WHERE email = $1",
        [email]
      );
      if (existingUser.rowCount === 0) {
        db.end();

        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }

      const hashedPassword = await bcryptjs.hash(
        newPassword,
        Number(process.env.SALT_ROUNDS)
      );

      existingUser = await db.query(
        "UPDATE users SET password = $1 WHERE email = $2 RETURNING *",
        [hashedPassword, email]
      );

      db.end();

      res.json(existingUser.rows[0]);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);

// Validate token
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");

    if (!token) {
      return res.json(false);
    }

    const verified = jwt.verify(token, process.env.PASSWORD_KEY);
    if (!verified) {
      return res.json(false);
    }

    const db = getDatabaseInstance();
    const user = await db.query("SELECT * FROM users WHERE id = $1", [
      verified.id,
    ]);
    if (user.rowCount === 0) {
      return res.json(false);
    }

    return res.json(true);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get user data
authRouter.get("/user", authValidator, async (req, res) => {
  const db = getDatabaseInstance();

  const user = await db.query("SELECT * FROM users WHERE id = $1", [req.user]);
  const products = await db.query(
    "SELECT DISTINCT p.* FROM products p, carts c, users u WHERE p.id = c.product_id AND c.user_id = $1 ORDER BY p.id ASC",
    [user.rows[0].id]
  );
  const quantities = await db.query(
    "SELECT quantity FROM carts WHERE user_id = $1 ORDER BY product_id ASC",
    [user.rows[0].id]
  );

  await db.end();
  res.json({
    token: req.token,
    ...user.rows[0],
    products: products.rows,
    quantities: quantities.rows,
  });
});

export default authRouter;
