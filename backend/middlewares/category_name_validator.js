const categoryNameValidator = (req, res, next) => {
  console.log("Category name validator middleware:");
  console.log("- Category name: " + req.body.name);

  try {
    const name = req.body.name;

    if (!name) {
      return res.status(400).json({ msg: "Category name is required." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default categoryNameValidator;
