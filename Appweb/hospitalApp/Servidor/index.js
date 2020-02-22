var express = require("express");
var app = express();
const server = require('http').createServer(app);
var cors = require("cors");
var expressJwt = require("express-jwt");
var jwtClave = "admin.120";
var http = require("http")
var httpServ = http.createServer(app)
var mqtt=require("./mqtt_server");





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



server.listen(3000, () => {
  console.log("Server ready");
});
