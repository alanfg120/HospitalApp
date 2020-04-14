const router = require("express").Router();
const { ObjectId } = require("mongodb");
const mongo = require("./../mongo");

router.get("/get", async (req, res) => {
  let { db, conection } = await mongo();
  try {
    let mensajes = await db.collection("mensajes").find().toArray();
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
    await db.collection("mensajes").insertOne(req.body);
    res.status(200).send();
  } catch (err) {
    res.status(400).send();
  }
  conection.close();
});

router.delete("/delete/:id", async (req, res) => {
  let { db, conection } = await mongo();
  try {
    await db.collection("mensajes").deleteOne({id:req.params.id})
    res.status(200).send()
  } catch (err) {
    res.status(400).send()
  }
  conection.close();
});
router.put("/update", async (req, res) => {
  console.log(req.body);
  
  let { db, conection } = await mongo();
  try {
    await db.collection("mensajes").updateOne({id:req.body.id},{$set:{mensaje:req.body.mensaje}})
    res.status(200).send()
  } catch (err) {
    res.status(400).send()
  }
  conection.close();
});
module.exports = router;
