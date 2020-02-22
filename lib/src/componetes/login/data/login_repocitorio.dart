import 'package:hive/hive.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class LoginRepocitorio {
  final headers = {"Content-Type": "application/json"};
  final url = "http://localhost:3000/usuarios/";

  Future<Usuario> getUsuario() async {
    final usuarioBox = await Hive.openBox<Usuario>('usuario');
    //usuarioBox.clear();
    if (usuarioBox.isEmpty)
      return Usuario(email: '', password: '', token: '');
    else
      return usuarioBox.getAt(0);
  }

  Future<String> setUsuario(Usuario usuario) async {
    try {
      final resp =
          await http.post('$url/new', body: usuario.toJson(), headers: headers);
      if (resp.statusCode == 200) return "REGISTRADO";
      if (resp.statusCode == 400) return "DUPLICADO";
    } catch (e) {
      return "ERROR";
    }
    return 'ERROR';
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
