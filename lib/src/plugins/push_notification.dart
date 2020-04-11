import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print('object');
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class PushNotificatios {
  String token;

  final _streamcotrollerOnresume = StreamController<Map>.broadcast();
  Function(Map) get onresumeSink => _streamcotrollerOnresume.sink.add;
  Stream get onresumeStream => _streamcotrollerOnresume.stream;

  final _streamcotrollerOnlaunch = StreamController<Map>.broadcast();
  Function(Map) get onlaunchSink => _streamcotrollerOnlaunch.sink.add;
  Stream get onlaunchStream => _streamcotrollerOnlaunch.stream;

  final _streamcotrollerOnmessage = StreamController<Map>.broadcast();
  Function(Map) get onmessageSink => _streamcotrollerOnmessage.sink.add;
  Stream get onmessageStream => _streamcotrollerOnmessage.stream;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static final PushNotificatios _instancia = PushNotificatios._internal();

  void disposeStreams() {
    _streamcotrollerOnresume?.close();
    _streamcotrollerOnlaunch?.close();
    _streamcotrollerOnmessage?.close();
  }

  factory PushNotificatios() {
    return _instancia;
  }
  PushNotificatios._internal();

  init() async {
    _firebaseMessaging.requestNotificationPermissions();
 
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
         if (Platform.isAndroid) onmessageSink(message['data']);
         else print('es Ios');
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        if (Platform.isAndroid) onlaunchSink(message['data']);
         else print('es Ios');
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
         if (Platform.isAndroid) onresumeSink(message['data']);
         else print('es Ios');
      },
    );
  }

  Future<String> getoken() async {
    return _firebaseMessaging.getToken();
  }
}
