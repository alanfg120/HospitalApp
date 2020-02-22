import 'dart:convert';



class Turno {

String nombre;  
String email;
String cedula;

Turno({this.nombre,this.email,this.cedula});


String toJson()=>json.encode({
  "nombre": this.nombre,
  "email" : this.cedula,
  "cedula": this.cedula
});

}
