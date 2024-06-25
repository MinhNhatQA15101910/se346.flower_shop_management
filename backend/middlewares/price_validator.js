// Validate price
const priceValidator = (req, res, next) => {
  console.log("Price validator middleware:");
  console.log("- Price: " + req.body.price);

  try {
    const price = req.body.price;

    if (!price) {
      return res.status(400).json({ msg: "Price is required." });
    }

    if (Number(price) <= 0) {
      return res.status(400).json({ msg: "Invalid price" });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default priceValidator;
