import 'package:hospitalapp/src/componetes/citas/models/turno_model.dart';
import 'package:http/http.dart' as http;

class CitasRepocitorio {
  Turno turno;

  Future<bool> sendTurno(Turno turno) async {
    try {
      final respuesta = await http.post("http://localhost:3000/turnos/new",
          body: turno.toJson());
      if (respuesta.statusCode == 200) {
        print("se guardo el turno");
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
