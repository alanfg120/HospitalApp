var MongoClient = require("mongodb").MongoClient;
const url = "mongodb://localhost:27017"
const dbName = "hospital";
const option = { useUnifiedTopology: true, useNewUrlParser: true }

async function mongo() {
  let conection = await new MongoClient(url, option).connect()
  let db = conection.db(dbName)
  return { db, conection }
}



module.exports = mongo
