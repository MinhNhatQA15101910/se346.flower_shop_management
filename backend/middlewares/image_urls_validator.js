// Validate image urls
const imageUrlsValidator = async (req, res, next) => {
  console.log("Image urls validator middleware:");
  console.log("- Image urls: " + req.body.image_urls);
  try {
    const imageUrls = req.body.image_urls;

    if (!imageUrls) {
      return res.status(400).json({ msg: "Image urls is required." });
    }

    if (imageUrls.length === 0) {
      return res
        .status(400)
        .json({ msg: "Image urls must not be an empty list." });
    }

    for (let i = 0; i < imageUrls.length; i++) {
      if (!imageUrls[i]) {
        return res.status(400).json({ msg: "Invalid image urls." });
      }
    }

    if (new Set(imageUrls).size !== imageUrls.length) {
      return res.status(400).json({ msg: "Image urls cannot be duplicated." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default imageUrlsValidator;
