import 'package:hospitalapp/src/componetes/notificaciones/models/notificacion_model.dart';
import 'package:http/http.dart' as http;

class NotificacionesRepocitorio {
  
  final headers = {"Content-Type": "application/json"};
  final url = "http://192.168.0.17:4001/notificacones/";

  Future<List<Notificacion>> getNotificaciones(String cedula) async {
    try {
      final httpresponse = await http.get('$url');
      if (httpresponse.statusCode == 200)
        return Notificacion.fromJsonList(httpresponse.body).notificaciones;
      else
        return [];
    } catch (e) {
      return [];
    }
  }
  
  

}
