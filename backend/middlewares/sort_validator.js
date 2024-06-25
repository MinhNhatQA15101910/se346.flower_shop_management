const sortOptions = ["sold", "name", "price"];
const orderOptions = ["asc", "desc"];

// Validate sort
const sortValidator = (req, res, next) => {
  console.log("Sort validator middleware:");
  console.log(`- Sort: ${req.query.sort}`);
  console.log(`- Order: ${req.query.order}`);

  try {
    let { sort, order } = req.query;

    if (sort && order) {
      if (!sortOptions.includes(sort)) {
        return res.status(400).json({ msg: "Invalid sort attribute." });
      }

      if (!orderOptions.includes(order)) {
        return res.status(400).json({ msg: "Invalid order option." });
      }
    } else {
      req.query.sort = "id";
      req.query.order = "asc";
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default sortValidator;
