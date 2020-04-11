import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hospitalapp/bloc_delegate.dart';
import 'package:hospitalapp/rutas.dart';
import 'package:hospitalapp/src/componetes/chat/bloc/chat_bloc.dart';
import 'package:hospitalapp/src/componetes/chat/data/chat_repositorio.dart';
import 'package:hospitalapp/src/componetes/citas/bloc/citas_bloc.dart';
import 'package:hospitalapp/src/componetes/citas/data/citas_repositorio.dart';
import 'package:hospitalapp/src/componetes/citas/models/turno_model.dart';
import 'package:hospitalapp/src/componetes/home/bloc/home_bloc.dart';
import 'package:hospitalapp/src/componetes/home/vistas/home_page.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/componetes/login/data/login_repocitorio.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';
import 'package:hospitalapp/src/componetes/login/vistas/login_page.dart';
import 'package:hospitalapp/src/componetes/notificaciones/bloc/notificaciones_bloc.dart';
import 'package:hospitalapp/src/componetes/notificaciones/data/notificacions_repositorio.dart';
import 'package:hospitalapp/src/plugins/push_notification.dart';
import 'package:path_provider/path_provider.dart';




void main() async {

 WidgetsFlutterBinding.ensureInitialized();
 BlocSupervisor.delegate = SimpleBlocDelegate();
 final  directorio = await getApplicationDocumentsDirectory();
 Hive.init(directorio.path);
 Hive.registerAdapter(UsuarioAdapter());
 Hive.registerAdapter(TurnoAdapter());
/*  Box<Usuario> usuarioBox = await Hive.openBox<Usuario>('usuario');
 usuarioBox.clear(); */


 runApp(MyApp());

}

class MyApp extends StatelessWidget {

   final push = PushNotificatios();

   final  colorPrimary   = Color(0xFF01C6BD);
   final  colorSecundary = Color(0XFFE4097F);   

   final ChatRpositorio   chatrepo  = ChatRpositorio();
   final CitasRepocitorio citasrepo = CitasRepocitorio();
   final LoginRepocitorio loginrepo = LoginRepocitorio();
   final NotificacionesRepocitorio notificacionrepo = NotificacionesRepocitorio();
 
 
  @override
  Widget build(BuildContext context) {
     
    push.init();

    return MultiBlocProvider (
          providers: [
                    
                      BlocProvider<HomeBloc>(
                      create: (context) => HomeBloc(),
                      ),
                      BlocProvider<LoginBloc>(
                      create: (context) => LoginBloc(repocitorio: loginrepo)..add(VericarLoginEvent()),
                      ),
                      BlocProvider<ChatBloc>(
                      create: (context) => ChatBloc(repositorio: chatrepo)..add(GetMensajesEvent()),
                      ),
                      BlocProvider<CitasBloc>(
                      create: (context) => CitasBloc(repocitorio: citasrepo),
                      ),
                      BlocProvider<NotificacionesBloc>(
                      create: (context) => NotificacionesBloc(repocitorio: notificacionrepo),
                      ),
                     

                     ],
          child: MaterialApp(
        
          debugShowCheckedModeBanner: false,
          title: 'Hospital Citas',
          theme: ThemeData(
                 primaryColor  : Color(0xFF01C6BD),
                 appBarTheme   : AppBarTheme(
                                 elevation  : 0.0, 
                                 color      : colorPrimary,
                                 brightness : Brightness.light,
                                 //iconTheme  : IconThemeData(color:Colors.teal), 
                                 textTheme  : TextTheme(title : TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 25.0,
                                                                //fontFamily: 'Alata'
                                                                ))
                                 ),
               
          ),
          home   : BlocBuilder<LoginBloc,LoginState>(
                   builder:(context,state) {
                      push.onlaunchStream.listen((data){
                      print("onlauch ok");
                      context.bloc<HomeBloc>().add(AddChatMensajeEvent());
                      });
                    if(state is AutenticandoState)
                      return LoginPage();
                    if(state is AutenticadoState){
                       return HomePage(page: 0);
                    }
                      return Scaffold(
                           body: Center(child: CircularProgressIndicator()),
                    );
                   },
          
    ),
          routes : route(),
          //initialRoute: 'login',
          ),
    );
  }
}
