// Validate weight
const weightValidator = (req, res, next) => {
  console.log("Weight validator middleware:");
  console.log("- Weight: " + req.body.weight);

  try {
    const weight = req.body.weight;

    if (weight && Number(weight) < 0) {
      return res.status(400).json({ msg: "Invalid weight" });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default weightValidator;
