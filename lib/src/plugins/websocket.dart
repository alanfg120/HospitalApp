//import 'dart:async';
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  MqttServerClient client;
  MqttConnectionState connectionState;
  MqttClientPayloadBuilder builder;
  //StreamSubscription _reconect;
  final _streamcotroller = StreamController<bool>.broadcast();
  final _streamMqttt = StreamController<List<MqttReceivedMessage>>.broadcast();

  void disposeStreams() {
    _streamcotroller?.close();
    _streamMqttt?.close();
  }

  Function(bool) get conectionMqttSink => _streamcotroller.sink.add;
  Stream get conectionMqttStream => _streamcotroller.stream;

  Function(List<MqttReceivedMessage>) get messajeMqttSink =>
      _streamMqttt.sink.add;
  Stream get mesaajeMqttStream => _streamMqttt.stream;

  String topic;
  static final MqttService _instancia = new MqttService._internal();

  factory MqttService() {
    return _instancia;
  }
  MqttService._internal();

  void subscribeToTopic(String topic) {
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('[MQTT client] Subscribing to $topic');
      client.subscribe(topic, MqttQos.atLeastOnce);
    }
  }

  void sendMessaje(String topic, String messaje) {
    builder = MqttClientPayloadBuilder();
    builder.addUTF8String(messaje);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
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
    if (usuarioBox.length > 0) {
      final Usuario usuario = usuarioBox.get(0);
      topic = usuario.cedula;
    } else
      topic = 'initial';
    client = MqttServerClient('192.168.0.17', '');
    client.port = 1883;
    client.autoReconnect = true;
    //client.useWebSocket = true;

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
    client.keepAlivePeriod = 30;

    /// Add the unsolicited disconnection callback
    //client.onDisconnected = _onDisconnected;
    client.onAutoReconnect = onAutoReconnect;
    client.onConnected = onConnected;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(topic)
        //.startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(MqttQos.atLeastOnce);

    print('[MQTT client] MQTT client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect('alice', 'secret');
    } catch (e) {
      print(e);
      client.disconnect();
    }

    /// Check if we are connected
    if (client.connectionStatus.state == MqttConnectionState.disconnected)
      client.disconnect();

    subscribeToTopic(topic);

    client.updates.listen((data) {
      messajeMqttSink(data);
    });
  }

  String onMessage(List<MqttReceivedMessage> event) {
    final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
    final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    return message;
  }

  void onAutoReconnect() {
    print(
        'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start');
    conectionMqttSink(false);
  }

  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
    conectionMqttSink(true);
  }
}
