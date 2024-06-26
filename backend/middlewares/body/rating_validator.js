// Validate rating
const ratingValidator = (req, res, next) => {
  console.log("Rating validator middleware:");
  console.log("- Rating: " + req.body.rating);

  try {
    const rating = req.body.rating;

    if (!rating) {
      return res.status(400).json({ msg: "Rating is required." });
    }

    if (isNaN(Number(rating)) || rating <= 0 || rating > 5) {
      return res.status(400).json({ msg: "Invalid rating." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default ratingValidator;
