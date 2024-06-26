const sizes = ["Small", "Medium", "Standard", "Large", "Extra Large", "Jumbo"];

// Validate size
const sizeValidator = (req, res, next) => {
  console.log("Size validator middleware:");
  console.log("- Size: " + req.body.size);

  try {
    const size = req.body.size;

    if (!size) {
      return res.status(400).json({ msg: "Size is required." });
    }

    if (!sizes.includes(size)) {
      return res.status(400).json({ msg: "Invalid size." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default sizeValidator;
