import 'dart:convert';

import 'package:hive/hive.dart';
part 'usuario_model.g.dart';


@HiveType(typeId:0)

class Usuario {

  @HiveField(0)
  String nombre;
  @HiveField(1)
  String email;
  @HiveField(2)
  String cedula;
  @HiveField(3)
  String password;
  @HiveField(4)
  String token;
  Usuario({this.nombre, this.email, this.cedula, this.password,this.token});

  String toJson()=>json.encode({
   "nombre"  :this.nombre,
   "email"   :this.email,
   "cedula"  :this.cedula,
   "password":this.password
  });

 Usuario.fromJson(String data) {
    final Map<String,dynamic> dataJson = json.decode(data);
    nombre   = dataJson['nombre'] ?? '';
    email    = dataJson['email']  ?? '';
    cedula   = dataJson['cedula'] ?? '';
    password = dataJson['password'] ?? '';
    token    = dataJson['token'] ?? '';
  }
}
