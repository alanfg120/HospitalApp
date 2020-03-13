const mongo = require("./../mongo");
var schedule = require("node-schedule");
const { ObjectId } = require("mongodb");

var activarTurnos = schedule.scheduleJob("00 16 * * *", async () => {
 let { db, conection } = await mongo();
  try {
    await db.collection("estado")
            .updateOne({ _id: ObjectId("5e630c2f2ae725ec369037ea") },
                       { $set: { turnos: true } }
      );
    console.log("listo");
  } catch (err) {
    console.log(err);
  }
  conection.close();
});

var desactivarTurnos = schedule.scheduleJob("00 18 * * *", async () => {
 let { db, conection } = await mongo();
  try {
    await db
      .collection("estado")
      .updateOne(
        { _id: ObjectId("5e630c2f2ae725ec369037ea") },
        { $set: { turnos: false } }
      );
    console.log("listo");
  } catch (err) {
    console.log(err);
  }
  conection.close();
});

module.exports.activarTurnos    = activarTurnos;
module.exports.desactivarTurnos = desactivarTurnos;
