
var express    = require('express');
var app        = express();
var expressWs  = require('express-ws')(app);
var cors       = require('cors');
var expressJwt = require('express-jwt');
var jwtClave   = "admin.120";


app.use(cors());
app.use(express.static(__dirname + "/dist"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
/* app.use(expressJwt({ secret: jwtClave, requestProperty: "token"}).unless({
    path: ["/usuario/login","/chat"]
  })
); */

app.ws('/chat/:user', function(ws, req) {
  ws.on('message', function(msg) {
    console.log(msg);
    ws.send(msg);
  });

  console.log(req.params);
});

app.listen(3000,()=> {
 
console.log("Server ready");


});