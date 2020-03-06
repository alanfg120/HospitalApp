import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hospitalapp/src/componetes/citas/models/status_model.dart';
import 'package:hospitalapp/src/plugins/websocket.dart';
import 'package:hospitalapp/src/componetes/citas/models/turno_model.dart';
import 'package:http/http.dart' as http;

class CitasRepocitorio {
  final mqtt = MqttService();

  Turno turno;
  String url = "http://192.168.0.17:3000/turnos/";
  final header = {"Content-Type": "application/json"};

  Future<StatusCitas> sendTurno(Turno turno) async {
    StatusCitas respuesta;
    try {
      final resp =
          await http.post("$url/new", headers: header, body: turno.toJson());
      if (resp.statusCode == 200) {
        final activo = json.decode(resp.body);
        if (activo) {
          final turnosBox = await Hive.openBox<Turno>('turnos');
          turnosBox.add(turno);
          respuesta = StatusCitas.aceptada;
        } else
          respuesta = StatusCitas.no_aceptada;
      }
      if (resp.statusCode == 400) respuesta = StatusCitas.duplicado;
    } catch (e) {
      respuesta = StatusCitas.error;
    }
    return respuesta;
  }
}
