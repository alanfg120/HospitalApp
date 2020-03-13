const router = require("express").Router();
const { ObjectId } = require("mongodb");
const mongo = require("./../mongo");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const jwtClave = "A679hff";

router.post("/new", async (req, res) => {
  
  
  let { db, conection } = await mongo();
  try {
    req.body.password = await bcrypt.hash(req.body.password, 10);
 
    
    await db.collection("usuarios").insertOne(req.body);
    res.status(200).send();
  } catch (err) {
    res.status(400).send();
    console.log(err);
    
  }
  conection.close();
});

router.post("/login", async (req, res) => {
 
  
  let { db, conection } = await mongo();
  try {
    let user = await db
      .collection("usuarios")
      .find({ $or: [{ cedula: req.body.cedula }, { email: req.body.email }] })
      .project({"_id":0})
      .toArray();
      
     if (user.length > 0) {
      let hash = await bcrypt.compare(req.body.password, user[0].password);
      if (hash) {
        let token = jwt.sign(
          { name: req.body.username, rol: user[0].rol },
          jwtClave
        );
        user[0].token = token;
        delete user[0].password
        res.status(200).send(user[0]);
      }
    } else res.status(400).send();
  } catch (err) {
    res.status(400).send();
  }
  conection.close();
});

module.exports = router;
