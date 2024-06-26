// Validate sale percentage
const salePercentageValidator = (req, res, next) => {
  console.log("Sale percentage validator middleware:");
  console.log("- Sale percentage: " + req.body.sale_percentage);

  try {
    const salePercentage = req.body.sale_percentage;

    if (
      salePercentage &&
      (Number(salePercentage) < 0 || Number(salePercentage) > 100)
    ) {
      return res.status(400).json({ msg: "Invalid percentage" });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default salePercentageValidator;
