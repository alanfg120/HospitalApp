var mosca = require("mosca")

SECURE_KEY= "/etc/letsencrypt/live/hospital.apptransportes.com/privkey.pem"
SECURE_CERT="/etc/letsencrypt/live/hospital.apptransportes.com/fullchain.pem"

  moscaSetting = {
    interfaces: [
      { type: "mqtt", port: 1883 },
      //{ type: "mqtts", port: 8883, credentials: { keyPath: SECURE_KEY, certPath: SECURE_CERT } },
      { type: "http", port: 9001, bundle: true },
      //{ type: "https", port: 5001, bundle: true, credentials: { keyPath: SECURE_KEY, certPath: SECURE_CERT } }
    ],
    publishNewClient: false,
    
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
  console.log("client connected", client.id);
});

servermqtt.on("clientDisconnecting", function(client) {
  console.log("client disconect", client.id);
});
servermqtt.on("clientDisconnected", function(client) {
  console.log("client disconect", client.id);
});

servermqtt.on("published",  (packet, client) => {
  let messaje = packet.payload.toString();
  console.log(packet.topic,messaje);

})
module.exports = servermqtt;
