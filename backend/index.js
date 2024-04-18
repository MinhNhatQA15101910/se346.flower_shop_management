import env from "dotenv";
import express from "express";

const app = express();
env.config();

app.use(express.json());

app.get("/document", (req, res) => {
  res.render("index.ejs");
});

app.listen(process.env.PORT, () => {
  console.log(`Server running on: http://localhost:${process.env.PORT}.`);
});
