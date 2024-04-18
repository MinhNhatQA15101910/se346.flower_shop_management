import env from "dotenv";
import express from "express";

import authRouter from "./routers/auth_router.js";

const app = express();
env.config();

app.use(express.json());

app.use(authRouter);

app.get("/document", (req, res) => {
  res.render("index.ejs");
});

app.listen(process.env.PORT, () => {
  console.log(`Server running on: http://localhost:${process.env.PORT}.`);
});
