var router = require("express").Router();
const { ObjectId } = require("mongodb");
const mongo = require("./../mongo");

router.post("/new", async (req, res) => {
  let { db, conection } = await mongo();
  let data = await db.collection("estado").findOne();
  if (data.turnos) {
    req.body.mensajes=[]
    try {
      await db.collection("turnos").insertOne(req.body);
      res.status(200).send(true);
    } catch (err) {
      res.status(400).send();
    }
  } else res.status(200).send(false);

  conection.close();
});
router.get("/", async (req, res) => {
  let { db, conection } = await mongo();
  try {
    let data = await db.collection("turnos").find().toArray();
    res.status(200).send(data);
  } catch (err) {
    res.status(400).send()
  }
  conection.close();
});

router.put("/update/mensaje", async (req, res) => {
   console.log(req.body);
   
  let { db, conection } = await mongo();
  try {
    await db.collection("turnos").updateOne({ cedula: req.body.cedula }, { $push: { mensajes: req.body.mensaje } })
    res.status(200).send("hola")
  } catch (err) {
    res.status(400).send(err)
  }
  conection.close()
})

module.exports = router;
