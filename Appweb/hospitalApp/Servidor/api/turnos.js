var router = require("express").Router();
const mongo = require("./../mongo")
const { ObjectId } = require("mongodb");

router.get('/', async (req,res)=>{
let {db,conect} = await mongo();
let data= await db.colletion("turnos").find().toArray()
conect.close();
})


module.exports=router;