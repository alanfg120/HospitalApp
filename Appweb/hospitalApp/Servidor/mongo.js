var MongoClient = require("mongodb").MongoClient;
const url="mongodb://localhost:27017" 
const dbName = "Hospital";
const option={useUnifiedTopology:true,useNewUrlParser:true}

async function mongo(){
  const conection   =  await new MongoClient(url,option).connect()
  const db      = conection.db(dbName)
  return   {db,conection}
}



module.exports.mongo      = mongo
module.exports.url        = url