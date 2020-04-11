var router = require("express").Router();
const { ObjectId } = require("mongodb");
const mongo = require("./../mongo");

router.get("/", async (req, res) => {
  let { db, conection } = await mongo();
  try {
    let data = await db.collection("notificaciones").find().toArray();
    res.status(200).send(data);
  } catch (err) {
    res.status(400).send();
  }
  conection.close();
});

router.post("/new", async (req, res) => {
  let { db, conection } = await mongo();
  try {
  } catch (err) {}
});

module.exports = router;
