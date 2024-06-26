// Validate stock
const stockValidator = (req, res, next) => {
  console.log("Stock validator middleware:");
  console.log("- Stock: " + req.body.stock);

  try {
    const stock = req.body.stock;

    if (!stock) {
      return res.status(400).json({ msg: "Stock is required." });
    }

    if (isNaN(Number(stock)) || Number(stock) <= 0) {
      return res.status(400).json({ msg: "Invalid stock." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default stockValidator;
