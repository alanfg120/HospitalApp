
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospitalapp/src/componetes/chat/bloc/chat_bloc.dart';
import 'package:hospitalapp/src/componetes/chat/models/chat_model.dart';
import 'package:hospitalapp/src/componetes/chat/vistas/chat_page.dart';
import 'package:hospitalapp/src/componetes/citas/vistas/citas_page.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/widgets/navigator_bar.dart';
import 'package:hospitalapp/src/plugins/websocket.dart';



class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
 _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  @override
  void initState() { 
    conectionMqtt = mqtt.conectionMqttStream.listen((data){});
    requestMqtt   = mqtt.mesaajeMqttStream.listen((messje){});
    super.initState();
    
  }
  @override
  void dispose() { 
    conectionMqtt?.cancel();
    requestMqtt?.cancel();
    super.dispose();
  }
  static MqttService mqtt = MqttService();
  StreamSubscription conectionMqtt;
  StreamSubscription requestMqtt;

  Widget lastPage;
  IconData lastcolor;
  
  bool connect;

  var  colorPrimary     = Color(0xFF01C6BD); 
  var  colorSecundary   = Color(0XFFE4097F); 

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final floatBoton  = FloatingActionButtonLocation.centerDocked;
  
  int currentindex    = 0;

  List menuItemslist  = [
                         [MaterialCommunityIcons.calendar_plus         , "Citas"         ,0 , Colors.white],
                         [MaterialCommunityIcons.chat_outline          , "Chat"          ,1 , Colors.white70],
                         [MaterialCommunityIcons.bell                  , "Notificaciones",2 , Colors.white70],
                         [MaterialCommunityIcons.settings_outline      , "Configuracion" ,3 , Colors.white70],
                        ];
  List itemsSettings  = [
                         [Icon(Icons.lock)               ,Text("Cambiar contraseña")],
                         [Icon(Icons.refresh)            ,Text("Sincronizacion Automatica")],
                         [Icon(Icons.power_settings_new) ,Text("Cerrar Sesion")],
                        ];

  @override
  Widget build(BuildContext context) {

    final state = context.bloc<LoginBloc>().state;
      requestMqtt.onData((messaje){
         context.bloc<ChatBloc>()
         .add(RequestMensajeEvent(mensaje: Mensaje.fromJson(mqtt.onMessage(messaje))));
      });
      conectionMqtt.onData((data){
       print(data);
      
       scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(data),behavior: SnackBarBehavior.floating));
     });
        return Scaffold(
               key                 : scaffoldKey,
               appBar              : AppBar(
                                     title           : ListTile(
                                                       leading : state is AutenticadoState ?
                                                                 _avatar(state.usuario.nombre[0]):null,
                                                       title   : state is AutenticadoState ?
                                                                 Text(state.usuario.nombre,
                                                                      style: TextStyle(
                                                                             color    : Colors.white,
                                                                             fontSize : 25
                                                                             )
                                                                      )
                                                                : null,
                                                       subtitle: state is AutenticadoState ?
                                                                 Text(state.usuario.email,
                                                                      style: TextStyle(color: Colors.white)
                                                                     )
                                                                : null
                                                      ),
                                     backgroundColor : colorPrimary,
                                     brightness      : Brightness.dark,
                                     ),
               body                : page(currentindex), 
               bottomNavigationBar : NavigatorBar(
                                     selectpage : (index){
                                                   page(index);
                                                 
                                                      
                                                  },
                                     items      : menuItemslist
                                     ),
               floatingActionButton: currentindex  < 2 ?
                                    
                                                
                                                
                                                      FloatingActionButton(
                                                            backgroundColor : Color(0XFFE4097F),
                                                            child           : Icon(addIcon(currentindex),color:Colors.white),
                                                            onPressed       : (){
                                                                                add(currentindex,context);
                                                                                if(currentindex==1){
                                                                                  final state = context.bloc<ChatBloc>().state;
                                                                                  if(state is LoadMensajesState)
                                                                                     context.bloc<ChatBloc>().add(SendMensajeEvent(mensaje: state.mensaje));
                                                                                }
                                                                                
                                                                                },
                                                     )
                                                 
                                           
                                     
                             
                              
                                   : null,
               floatingActionButtonLocation: currentindex == 0 ? floatBoton : null
              
              );
      }
      
      Widget page(index) {
         
             setState((){
                         currentindex = index;
                         //requestMqtt?.cancel();
                        });
             switch (currentindex) {
                     case 0 : //lastPage = PedidosPage();
                              return CitasPage();
                              break;
                     case 1 : //lastPage = ProductosPage();
                              return ChatPage();
                              break;
                     case 2 : //lastPage = ClientesPage();
                              return CitasPage();
                              break;
                     case 3 : return lastPage;
                              break;
                     default: return CitasPage();
             }
      
      
      }
      
     
    
      void add(int currentindex,BuildContext context) {
    
           switch (currentindex) {
                    case 0  : 
                             
                              break;
                    case 1  : //Navigator.pushNamed(context, 'formproducto'); 
                              //FocusScope.of(context).requestFocus(FocusNode());
                             
                              break;
                    case 2  : //Navigator.pushNamed(context, 'formcliente'); 
                            
                              break;
                    default :
           }
    
      }
     
      IconData addIcon(int currentindex) {
           
           switch (currentindex) {
                    case 0  : lastcolor=MaterialCommunityIcons.calendar_plus;
                              return MaterialCommunityIcons.calendar_plus;
                    case 1  : lastcolor=MaterialCommunityIcons.send_circle;
                              return MaterialCommunityIcons.send_circle;
                    
                    default : return lastcolor;
           }
    
      }
    
     Widget  _avatar(letra) =>  CircleAvatar(
                           child           : Text(letra,style: TextStyle(fontWeight: FontWeight.bold)),
                           backgroundColor : colorSecundary,
                           );
    
      
     


  
}

