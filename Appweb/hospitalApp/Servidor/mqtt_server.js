var mosca = require("mosca");
const mongo = require("./mongo");

SECURE_KEY = "/etc/letsencrypt/live/hospital.apptransportes.com/privkey.pem";
SECURE_CERT = "/etc/letsencrypt/live/hospital.apptransportes.com/fullchain.pem";
var ascoltatore = {
  type: 'mongodb',        
  url: 'mongodb://localhost:27017/mqtt',
 };
moscaSetting = {

  interfaces: [
    { type: "mqtt", port: 1883 },
    //{ type: "mqtts", port: 8883, credentials: { keyPath: SECURE_KEY, certPath: SECURE_CERT } },
    { type: "http", port: 9001, bundle: true }
    //{ type: "https", port: 5001, bundle: true, credentials: { keyPath: SECURE_KEY, certPath: SECURE_CERT } }
  ],
  publishNewClient: false,
  publishSubscriptions:false,
    backend: ascoltatore,
  persistence: {
    factory: mosca.persistence.Mongo,
    url: "mongodb://localhost:27017/mqtt"
  }
};

var servermqtt = new mosca.Server(moscaSetting);

var authenticate = (client, username, password, callback) => {
  var authorized = username === "alice" && password.toString() === "secret";
  if (authorized) client.user = username;
  callback(null, authorized);
};
servermqtt.on("ready", setup);

function setup() {
  servermqtt.authenticate = authenticate;
  console.log("servidor MQTT Listo");
}

servermqtt.on("clientConnected", function(client) {
 // console.log("client connected", client.id);
});
servermqtt.on("delivered", function(packet,client) {
 console.log("mensaje recibido");
});

servermqtt.on("clientDisconnecting", function(client) {
  console.log("client disconect", client.id);
});
servermqtt.on("clientDisconnected", function(client) {
  console.log("client disconect", client.id);
});

servermqtt.on("published", async (packet, client) => {
  let cedula;
  let messaje = isJson(packet.payload.toString());
  if(packet.topic=='hospital'){
     cedula = messaje.id;
     messaje.recibido= true;
  
  }
  else cedula = packet.topic;
  let { db, conection } = await mongo();
  try {
    await db
      .collection("turnos")
      .updateOne({ cedula: cedula }, { $push: { mensajes: messaje } });
  } catch (err) {
    console.log(err);
  }
  conection.close();
});

function isJson(data) {
  try {
    let json = JSON.parse(data);
    return json;
  } catch (error) {
    return data;
  }
}
module.exports = servermqtt;
