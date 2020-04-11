var express = require("express");
var app = express();
const server = require('http').createServer(app);
var cors = require("cors");
var expressJwt = require("express-jwt");
var jwtClave = "admin.120";
var http = require("http")
var httpServ = http.createServer(app)
var mqtt=require("./mqtt_server");
var FMC = require("./notificaciones/notificacones")
// tareas Programadas
var activarTurnos    = require("./tareas/turnos").activarTurnos
var desactivarTurnos = require("./tareas/turnos").desactivarTurnos




app.use(cors());
app.use(express.static(__dirname + "/dist"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
/* app.use(expressJwt({ secret: jwtClave, requestProperty: "token"}).unless({
    path: ["/usuario/login","/chat"]
  })
); */


app.use('/turnos',require('./api/turnos'))
app.use('/usuarios',require('./api/usuarios'))
app.use('/mensajes',require('./api/mensajes'))



server.listen(4001, async () => {
  console.log("Server ready");
 
});
