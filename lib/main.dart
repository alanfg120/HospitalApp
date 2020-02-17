

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitalapp/bloc_delegate.dart';
import 'package:hospitalapp/rutas.dart';
import 'package:hospitalapp/src/componetes/chat/bloc/chat_bloc.dart';
import 'package:hospitalapp/src/componetes/chat/data/chat_repositorio.dart';
import 'package:hospitalapp/src/componetes/citas/bloc/citas_bloc.dart';
import 'package:hospitalapp/src/componetes/citas/data/citas_repositorio.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/componetes/login/vistas/login_page.dart';




void main() async {
 WidgetsFlutterBinding.ensureInitialized();

 

 BlocSupervisor.delegate = SimpleBlocDelegate();
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
   ChatRpositorio chatrepo = ChatRpositorio();
   CitasRepocitorio citasrepo = CitasRepocitorio();
  
  @override
  Widget build(BuildContext context) {
   
    return MultiBlocProvider (
          providers: [
                      BlocProvider<LoginBloc>(
                      create: (context) => LoginBloc(),
                      ),
                      BlocProvider<ChatBloc>(
                      create: (context) => ChatBloc(repositorio: chatrepo)..add(GetMensajesEvent()),
                      ),
                      BlocProvider<CitasBloc>(
                      create: (context) => CitasBloc(repocitorio: citasrepo),
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
