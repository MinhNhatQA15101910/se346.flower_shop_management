// Validate detail description
const detailDescriptionValidator = (req, res, next) => {
  console.log("Detail description validator middleware:");
  console.log("- Detail description: " + req.body.detail_description);

  try {
    const detailDescription = req.body.detail_description;

    if (!detailDescription) {
      return res.status(400).json({ msg: "Description is required." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default detailDescriptionValidator;
