import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospitalapp/src/componetes/chat/bloc/chat_bloc.dart';
import 'package:hospitalapp/src/componetes/chat/models/chat_model.dart';
import 'package:hospitalapp/src/componetes/chat/vistas/chat_page.dart';
import 'package:hospitalapp/src/componetes/citas/vistas/citas_page.dart';
import 'package:hospitalapp/src/componetes/home/bloc/home_bloc.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/componetes/notificaciones/vistas/notificaciones_page.dart';
import 'package:hospitalapp/src/widgets/navigator_bar.dart';
import 'package:hospitalapp/src/plugins/websocket.dart';
import 'package:hospitalapp/src/plugins/push_notification.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.page}) : super(key: key);
  final int page;
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {

    conectionMqtt = mqtt.conectionMqttStream.listen((data) {});
    requestMqtt   = mqtt.mesaajeMqttStream.listen((messje) {});
    onresume      = push.onresumeStream.listen((data) {});
    onmessage     = push.onmessageStream.listen((data) {});

    currentindex = widget.page;

    if (widget.page == 2)
      menuItemslist = [
        [MaterialCommunityIcons.calendar_plus, "Citas", 0, Colors.white70],
        [MaterialCommunityIcons.chat_outline, "Chat", 1, Colors.white70],
        [MaterialCommunityIcons.bell, "Notificaciones", 2, Colors.white],
        [
          MaterialCommunityIcons.settings_outline,
          "Configuracion",
          3,
          Colors.white70
        ],
      ];
    super.initState();
  }

  @override
  void dispose() {
    conectionMqtt ?.cancel();
    requestMqtt   ?.cancel();
    onmessage     ?.cancel();
    onresume      ?.cancel();
    super.dispose();
  }

  static MqttService      mqtt = MqttService();
  static PushNotificatios push = PushNotificatios();

  StreamSubscription conectionMqtt;
  StreamSubscription requestMqtt;
  StreamSubscription onresume;
  StreamSubscription onmessage;

  Widget    lastPage;
  IconData  lastIcon;
  GlobalKey navigatorKey = GlobalKey<NavigatorBarState>();

  var colorPrimary   = Color(0xFF01C6BD);
  var colorSecundary = Color(0XFFE4097F);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final floatBoton  = FloatingActionButtonLocation.centerDocked;

  int currentindex = 0;

  List menuItemslist = [
    [MaterialCommunityIcons.calendar_plus, "Citas", 0, Colors.white],
    [MaterialCommunityIcons.chat_outline, "Chat", 1, Colors.white70],
    [MaterialCommunityIcons.bell, "Notificaciones", 2, Colors.white70],
    [
      MaterialCommunityIcons.settings_outline,
      "Configuracion",
      3,
      Colors.white70
    ],
  ];
 
  @override
  Widget build(BuildContext context) {

    final state = context.bloc<LoginBloc>().state;

    requestMqtt.onData((messaje) {
      context.bloc<ChatBloc>().add(RequestMensajeEvent(
          mensaje: Mensaje.fromJson(mqtt.onMessage(messaje))));
      if (currentindex != 1)
        context.bloc<HomeBloc>().add(AddChatMensajeEvent());
    });

    conectionMqtt.onData((connection) {
      print(connection);
    });

    onresume.onData((data) {
      context.bloc<HomeBloc>().add(AddNotificationEvent());
    });

    onmessage.onData((message) {
      context.bloc<HomeBloc>().add(AddNotificationEvent());
    });

    return Scaffold(
           key                          : scaffoldKey,
           appBar                       : currentindex != 2 ?
                                          AppBar(
                                          leading        : state is AutenticadoState
                                                           ? _avatar(state.usuario.nombre[0])
                                                           : null,  
                                          title          : ListTile(
                                                           title    : state is AutenticadoState
                                                                      ? Text(state.usuario.nombre,style: TextStyle(color: Colors.white, fontSize: 20))
                                                                      : null,
                                                           subtitle : state is AutenticadoState
                                                                      ? Text(state.usuario.email,style: TextStyle(color: Colors.white))
                                                                      : null
                                                           ),
                                         brightness      : Brightness.dark,
                                         backgroundColor : colorPrimary,
           ):
           null,
           body                         : page(currentindex),
           bottomNavigationBar          : NavigatorBar(
                                          key        : navigatorKey,
                                          items      : menuItemslist,
                                          selectpage : (index) {
                                                                page(index);
                                                                add(currentindex, context);
                                                               },
           ),
           floatingActionButton         : currentindex < 2
                                          ? FloatingActionButton(
                                             child           : Icon(addIcon(currentindex), color: Colors.white),
                                             onPressed       : () {
                                                                   if (currentindex == 1) {
                                                                     final stateChat = context.bloc<ChatBloc>().state;
                                                                    if (stateChat is LoadMensajesState) 
                                                                      context.bloc<ChatBloc>().add(SendMensajeEvent(mensaje: stateChat.mensaje));
                                                                   }
                                             },
                                             backgroundColor : Color(0XFFE4097F),
                                             )
                                            : null,
           floatingActionButtonLocation : currentindex == 0 ? floatBoton : null
    );
  }

  Widget page(index) {
    setState(() {
      currentindex = index;
    });
    switch (currentindex) {
    
      case 0  :  return CitasPage();
                 break;
      case 1  :  return ChatPage();
                 break;
      case 2  :  return NotificacionesPage();
                 break;
      case 3  :  return lastPage; 
                 break;
      default :  return CitasPage();

    }
  }

  void add(int currentindex, BuildContext context) {
    switch (currentindex) {
      case 0:
        //context.bloc<HomeBloc>().add(AddChatMensajeEvent());
        break;
      case 1:
        context.bloc<HomeBloc>().add(ResetChatMensajeEvent());
        break;
      case 2:
        context.bloc<HomeBloc>().add(ResetNotificationEvent());
        break;
      case 3:
        //context.bloc<HomeBloc>().add(AddNotificationEvent());
        break;
      default:
    }
  }

  IconData addIcon(int currentindex) {
    switch (currentindex) {

      case 0  : lastIcon = MaterialCommunityIcons.calendar_plus;
                return MaterialCommunityIcons.calendar_plus;

      case 1  : lastIcon = MaterialCommunityIcons.send_circle;
                return MaterialCommunityIcons.send_circle;

      default : return lastIcon;
    }
  }

  Widget _avatar(letra) 
        => Padding(
           padding : EdgeInsets.all(6.0),
           child   : CircleAvatar(
                     child           : Text(letra, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                     backgroundColor : colorSecundary,
           ),
        );
}
