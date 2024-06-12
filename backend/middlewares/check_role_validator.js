import jwt from "jsonwebtoken";

import { getUserRoleById } from "../utils/user.js";

const checkRoleValidator = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(401).json({ msg: "No auth token, access denied." });
    }

    const verified = jwt.verify(token, process.env.PASSWORD_KEY);
    if (!verified) {
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });
    }

    const userRole = getUserRoleById(verified.id);

    if (userRole !== "admin") {
      return res.status(403).json({ msg: "Access denied. Admins only." });
    }

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export default checkRoleValidator;
