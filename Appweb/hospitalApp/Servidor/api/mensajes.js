const router = require("express").Router();
const { ObjectId } = require("mongodb");
const mongo = require("./../mongo");

router.get("/get", async (req, res) => {
  let { db, conection } = await mongo();
  try {
    let mensajes = await db
      .collection("mensajesp")
      .find()
      .toArray();
    res.status(200).send(mensajes);
  } catch (err) {
    res.status(400).send();
    console.log(err);
  }
  conection.close();
});

router.post("/new", async (req, res) => {
  let { db, conection } = await mongo();
  try {
    await db.collection("mensajesp").insertOne(req.body);
  } catch (err) {
    console.log(err);
  }
  conection.close();
});

module.exports = router;
