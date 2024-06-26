// Validate page
const pageValidator = async (req, res, next) => {
  console.log("Page validator middleware:");
  console.log("- Page: " + req.query.page);

  try {
    const page = req.query.page;

    if (page) {
      if (!Number(page) || Number(page) < 1) {
        return res.status(400).json(`Invalid page.`);
      }
    } else {
      req.query.page = 1;
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default pageValidator;
