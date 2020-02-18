var router = require("express").Router();
const { ObjectId } = require("mongodb");
const mongo = require('./../mongo');


router.get('/', async (req, res) => {
    let { db, conection } = await mongo();
    let data = await db.colletion("turnos").find().toArray()
    conection.close();
    res.statusCode(200).send(data)
})
router.post('/new', async (req, res) => {
    let { db, conection } = await mongo();
    try {
        await db.collection().insertOne(req.body)
    } catch (err) {

    }

})



module.exports = router;