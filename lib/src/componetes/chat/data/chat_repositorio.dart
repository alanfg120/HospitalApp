import 'dart:async';

import 'package:hospitalapp/src/componetes/chat/models/chat_model.dart';
import 'package:hospitalapp/src/plugins/websocket.dart';

class ChatRpositorio {

final mqtt = MqttService();


send(Mensaje mensaje){
 mqtt.sendMessaje("test", mensaje.toJson());
}
Future<List<Mensaje>> getConvesation() async {
  mqtt.connect();
  print("obteniendo Conversacion de Hive");
  return [];
}

Stream get requestMensaje=>mqtt.client.updates;

Mensaje messaje(mqttmessaje){

return Mensaje.fromJson(mqtt.onMessage(mqttmessaje));


}
  


} 