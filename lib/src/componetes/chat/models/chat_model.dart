import 'dart:convert';

class Mensaje {
  String mensaje;
  String id;
  bool recibido;
  DateTime fecha;

  Mensaje({this.mensaje, this.id, this.recibido, this.fecha});

  Mensaje.fromJson(String data) {
    final Map<String,dynamic> dataJson = json.decode(data);
    mensaje  = dataJson['mensaje'];
    id       = dataJson['id'];
    recibido = dataJson['recibido'];
    fecha    = DateTime.now();
  }

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mensaje']  = this.mensaje;
    data['id']       = this.id;
    data['recibido'] = this.recibido;
    data['fecha']    = this.fecha.toString();
    return json.encode(data);
  }
}
