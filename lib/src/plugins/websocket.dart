import 'dart:async';

import 'package:mqtt_client/mqtt_client.dart' as mqtt;


class MqttService{


 mqtt.MqttClient client;
 mqtt.MqttConnectionState connectionState;
 mqtt.MqttClientPayloadBuilder builder;
 StreamSubscription subscription;

 void subscribeToTopic(String topic) {
    if (client.connectionStatus.state == mqtt.MqttConnectionState.connected) {
        print('[MQTT client] Subscribing to $topic');
        client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
    }
  }

 void sendMessaje(String topic,String messaje){
      builder = mqtt.MqttClientPayloadBuilder();
      builder.addString(messaje);
      print("hola");
      client.publishMessage(topic, mqtt.MqttQos.atMostOnce,builder.payload); 
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
    client = mqtt.MqttClient('ws://localhost','');
    client.port = 9001;
    client.useWebSocket=true;
    
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
        .withClientIdentifier("alan")
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(mqtt.MqttQos.atMostOnce);
        
    print('[MQTT client] MQTT client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.

    try {
      await client.connect('alice','secret');
    } catch (e) {
      print(e);
      _disconnect();
    }

    /// Check if we are connected
    if (client.connectionStatus.state == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] connected');
    
    } else {
      print('[MQTT client] ERROR: MQTT client connection failed - '
          'disconnecting, state is ${client.connectionStatus.state}');
      _disconnect();
    }

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    
    subscribeToTopic("temp");
     
  }

  void _disconnect() {
    print('[MQTT client] _disconnect()');
    client.disconnect();
    _onDisconnected();
  }

  void _onDisconnected() {
   print('[MQTT client] MQTT client disconnected');
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

}