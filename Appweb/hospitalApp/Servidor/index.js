var express = require('express');
var app = express();

app.use(cors());
app.use(express.static(__dirname + "/dist"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(expressJwt({ secret: jwtClave, requestProperty: "token" }).unless({
    path: ["/usuario/login"]
  })
);;



app.listen(3000,()=> {
 


});