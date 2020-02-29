var router = require("express").Router();
const { ObjectId } = require("mongodb");
const mongo = require("./../mongo");

router.post("/new", async (req, res) => {
  let { db, conection } = await mongo();
  let data = await db.collection("estado").findOne();
  if (data.turnos) {
    try {
      await db.collection("turnos").insertOne(req.body);
      res.status(200).send(true);
    } catch (err) {
      res.status(400).send();
    }
  } else res.status(200).send(false);

  conection.close();
});
router.post("/", async (req, res) => {
  let { db, conection } = await mongo();
  try {
  } catch (err) {}
});

module.exports = router;
