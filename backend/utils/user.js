import getDatabaseInstance from "./db.js";

export const getUserRoleById = async (userId) => {
  try {
    const db = getDatabaseInstance();

    const result = await db.query("SELECT role FROM users WHERE id = $1", [
      userId,
    ]);
    if (result.rows.length === 0) {
      return null;
    }
    return result.rows[0].role;
  } catch (err) {
    throw new Error("Database query failed.");
  }
};
