import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitalapp/bloc_delegate.dart';
import 'package:hospitalapp/rutas.dart';
import 'package:hospitalapp/src/componetes/chat/bloc/chat_bloc.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/componetes/login/vistas/login_page.dart';
import 'package:web_socket_channel/io.dart';





void main() async {
 WidgetsFlutterBinding.ensureInitialized();

 var channel = IOWebSocketChannel.connect("ws://localhost:3000/chat/alan",headers: {
   HttpHeaders.authorizationHeader: 'Bearer tyteytyetd'
 });
 channel.sink.add("received!");
channel.stream.listen((message) {
   
    print(message);
   // channel.sink.close(status.goingAway);
  });
 BlocSupervisor.delegate = SimpleBlocDelegate();
 
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider (
          providers: [
                      BlocProvider<LoginBloc>(
                      create: (context) => LoginBloc(),
                      ),
                      BlocProvider<ChatBloc>(
                      create: (context) => ChatBloc()..add(GetMensajesEvent()),
                      ),

                     ],
          child: MaterialApp(
        
          debugShowCheckedModeBanner: false,
          title: 'Hospital Citas',
          theme: ThemeData(
                 
                 appBarTheme   : AppBarTheme(
                                 elevation  : 0.0, 
                                 color      : Colors.white,
                                 brightness : Brightness.light,
                                 //iconTheme  : IconThemeData(color:Colors.teal), 
                                 textTheme  : TextTheme(title : TextStyle(
                                                                color: Colors.teal,
                                                                fontSize: 25.0,
                                                                //fontFamily: 'Alata'
                                                                ))
                                 ),
               
          ),
          home   : LoginPage(),
          routes : route(),
          initialRoute: 'login',
          ),
    );
  }
}
