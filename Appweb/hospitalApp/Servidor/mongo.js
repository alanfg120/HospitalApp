var MongoClient = require("mongodb").MongoClient;
const url = "mongodb://localhost:27017"
const dbName = "hospital";
const option = { useUnifiedTopology: true, useNewUrlParser: true };
/* var user = encodeURIComponent("admin"),
  password = encodeURIComponent("admin.120"),
  authMechanism = "DEFAULT",
  url = `mongodb://${user}:${password}@localhost:27017/?authMechanism=${authMechanism}`; */
async function mongo() {
  let conection = await new MongoClient(url, option).connect();
  let db = conection.db(dbName);
  return { db, conection };
}


module.exports = mongo;
