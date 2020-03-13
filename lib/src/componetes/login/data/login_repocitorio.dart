import 'package:hive/hive.dart';

import 'package:hospitalapp/src/componetes/login/models/status_model.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';
import 'package:hospitalapp/src/plugins/push_notification.dart';
import 'package:http/http.dart' as http;

class LoginRepocitorio {
  final headers = {"Content-Type": "application/json"};
  final url = "https://hospital.apptransportes.com/usuarios/";
  final push = PushNotificatios();
  Future<Usuario> getUsuario() async {
    final usuarioBox = await Hive.openBox<Usuario>('usuario');
    //usuarioBox.clear();
    if (usuarioBox.isEmpty)
      return Usuario(email: '', password: '', token: '');
    else
      return usuarioBox.getAt(0);
  }

  Future<StatusLogin> setUsuario(Usuario usuario) async {
    try {
      usuario.idPush = await push.getoken();
      final resp =
          await http.post('$url/new', body: usuario.toJson(), headers: headers);
      if (resp.statusCode == 200) return StatusLogin.registrado;
      if (resp.statusCode == 400) return StatusLogin.duplicado;
    } catch (e) {
      return StatusLogin.error;
    }
    return StatusLogin.error;
  }

  Future<Usuario> auth(Usuario usuario) async {
    try {
     final resp =
           await http.post('$url/login', body: usuario.toJson(), headers: headers);
     Usuario usuarioResp = Usuario.fromJson(resp.body);
     final box = await Hive.openBox<Usuario>('usuario');
           box.add(usuarioResp);
     return usuarioResp;
    } catch (e) {   
      print(e);
    }
    return Usuario();
  }
}
