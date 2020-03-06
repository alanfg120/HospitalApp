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

  
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token;
  
   init() async{
    _firebaseMessaging.requestNotificationPermissions();
     token = await _firebaseMessaging.getToken();
     print(token);
    _firebaseMessaging.configure(
      
       onMessage: (Map<String, dynamic> message) async {
         print("onMessage: $message");
         print('______');
       },
       onBackgroundMessage: myBackgroundMessageHandler,
       onLaunch: (Map<String, dynamic> message) async {
         print("onLaunch: $message");
       
       },
       onResume: (Map<String, dynamic> message) async {
         print("onResume: $message");
       
       },
     );

   
  }
  
  
}