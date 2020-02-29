//import 'dart:async';
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class MqttService {

  mqtt.MqttClient client;
  mqtt.MqttConnectionState connectionState;
  mqtt.MqttClientPayloadBuilder builder;
  StreamSubscription _reconect;
  final _streamcotroller = StreamController<String>.broadcast();
  final _streamMqttt     = StreamController<List<mqtt.MqttReceivedMessage>>.broadcast();

  void disposeStreams(){
    _streamcotroller?.close();
    _streamMqttt?.close();
    }

  Function(String)      get conectionMqttSink   => _streamcotroller.sink.add;
  Stream                get conectionMqttStream => _streamcotroller.stream;

  Function(List<mqtt.MqttReceivedMessage>)  get messajeMqttSink   => _streamMqttt.sink.add;
  Stream                get mesaajeMqttStream => _streamMqttt.stream;

  String topic;
  static final MqttService _instancia = new MqttService._internal();

  factory MqttService() {
    return _instancia;
  }
  MqttService._internal();

  void subscribeToTopic(String topic) {
    if (client.connectionStatus.state == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Subscribing to $topic');
      client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
    }
  }

  void sendMessaje(String topic, String messaje) {
    builder = mqtt.MqttClientPayloadBuilder();
    builder.addString(messaje);
    client.publishMessage(topic, mqtt.MqttQos.atMostOnce, builder.payload);
  }

  void connect() async {
    /// First create a client, the client is constructed with a broker name, client identifier
    /// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
    /// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
    /// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
    /// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
    /// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
    /// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
    /// of 1883 is used.
    /// If you want to use websockets rather than TCP see below.
    ///
    Box<Usuario> usuarioBox = await Hive.openBox<Usuario>('usuario');
    if(usuarioBox.length >0){
      final Usuario usuario = usuarioBox.get(0);
      topic = usuario.cedula;
    }
    else  topic = 'initial';
    client = mqtt.MqttClient('ws://localhost', '');
    client.port = 9001;
    client.useWebSocket = true;
   
    /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
    /// for details.
    /// To use websockets add the following lines -:
    /// client.useWebSocket = true;
    /// client.port = 80;  ( or whatever your WS port is)
    /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.

    /// Set logging on if needed, defaults to off
    client.logging(on: false);

    /// If you intend to use a keep alive value in your connect message that is not the default(60s)
    /// you must set it here
    client.keepAlivePeriod = 10;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = _onDisconnected;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(topic)
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(mqtt.MqttQos.atMostOnce);

    print('[MQTT client] MQTT client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.

    try {
     
      await client.connect('alice', 'secret');
    
    } catch (e) {
      print(e);
      _disconnect();
    }

    /// Check if we are connected
    if (client.connectionStatus.state == mqtt.MqttConnectionState.connected) {

       _reconect?.cancel();
       _reconect = null;
       conectionMqttSink("Conectado a Mqtt");
    } else {
      
      _disconnect();
    }

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
     subscribeToTopic(topic);
     client.updates.listen((data){
        messajeMqttSink(data);
   
    });
  }

  void _disconnect() {
    client.disconnect();
   
    _onDisconnected();
  }

  void _onDisconnected() {
   _reconectMqtt();
   conectionMqttSink("Desonectado a Mqtt");
  }

  String onMessage(List<mqtt.MqttReceivedMessage> event) {
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    /*   print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
        'payload is <-- $message -->');
    print(client.connectionStatus.state);
    print("[MQTT client] message with topic: ${event[0].topic}");
    print("[MQTT client] message with message: $message"); */
    return message;
  }

  void _reconectMqtt() {
     print("Reconectando...");
    if (_reconect == null) {
      _reconect = Stream.periodic(Duration(seconds: 10)).listen((_) {
        this.connect(); 
      });
    }
  }
}
