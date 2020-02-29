import 'dart:convert';
import 'package:hive/hive.dart';
part 'turno_model.g.dart';

@HiveType(typeId:1)
class Turno {
  @HiveField(0)
  String nombre;
  @HiveField(1)
  String email;
  @HiveField(2)
  String cedula;
  @HiveField(3)
  String numero;
  @HiveField(4)
  String tipocita;
  @HiveField(5)
  String observaciones;
  @HiveField(6)
  bool automatica;

  Turno(
      {this.nombre,
      this.email,
      this.cedula,
      this.numero,
      this.tipocita,
      this.observaciones,
      this.automatica});

  String toJson() => json.encode({
        "nombre"       : this.nombre,
        "email"        : this.email,
        "cedula"       : this.cedula,
        "numero"       : this.numero,
        "observaciones": this.observaciones,
        "tipocita"     :this.tipocita,
        "automatica"   :this.automatica
      });
}
