const passwordValidator = (req, res, next) => {
  try {
    const password = req.body.password;

    if (!password) {
      return res.status(400).json({ msg: "Password is required." });
    }

    let isValid = password.length >= 8;

    if (!isValid) {
      return res
        .status(400)
        .json({ msg: "Password must be at least 8 characters long." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default passwordValidator;
