const mongo = require("./../mongo");
var schedule = require("node-schedule");
const { ObjectId } = require("mongodb");

var activarTurnos = schedule.scheduleJob("00 11 * * *", async () => {
 let { db, conection } = await mongo();
  try {
    await db.collection("turnos")
            .updateOne({ _id: ObjectId("5e5143398052830aa396b6e6") },
                       { $set: { activo: true } }
      );
    console.log("listo");
  } catch (err) {
    console.log(err);
  }
  conection.close();
});

var desactivarTurnos = schedule.scheduleJob("00 12 * * *", async () => {
 let { db, conection } = await mongo();
  try {
    await db
      .collection("turnos")
      .updateOne(
        { _id: ObjectId("5e5143398052830aa396b6e6") },
        { $set: { activo: false } }
      );
    console.log("listo");
  } catch (err) {
    console.log(err);
  }
  conection.close();
});

module.exports.activarTurnos    = activarTurnos;
module.exports.desactivarTurnos = desactivarTurnos;
