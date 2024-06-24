const imageUrlValidator = (req, res, next) => {
  console.log("Image url validator middleware:");
  console.log("- Image url: " + req.body.image_url);

  try {
    const imageUrl = req.body.image_url;

    if (!imageUrl) {
      return res.status(400).json({ msg: "Image url is required." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default imageUrlValidator;
