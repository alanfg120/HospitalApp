import 'dart:convert';

class Notificacion {
  List<Notificacion> notificaciones = new List();
  String titulo;
  String body;
  bool leida;
  bool vista;

  Notificacion({this.body, this.titulo, this.leida, this.vista});

  Notificacion.fromJsonList(String jsonList) {
    List items;
    if (jsonList == null)
      return;
    else
      notificaciones = items
          .map((item) => Notificacion.fromJson(json.encode(jsonList)))
          .toList();
  }

  Notificacion.fromJson(String data) {
    final Map<String, dynamic> dataJson = json.decode(data);
    titulo = dataJson['titulo'] ?? '';
    body   = dataJson['body']   ?? '';
    leida  = dataJson['leida']  ?? '';
    vista  = dataJson['vista']  ?? '';
  }
}
