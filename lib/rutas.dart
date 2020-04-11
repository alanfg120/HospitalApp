



import 'package:flutter/material.dart';
import 'package:hospitalapp/src/componetes/citas/vistas/solicitar_page.dart';
import 'package:hospitalapp/src/componetes/home/vistas/home_page.dart';
import 'package:hospitalapp/src/componetes/login/vistas/login_page.dart';
import 'package:hospitalapp/src/componetes/login/vistas/registro_page.dart';
import 'package:hospitalapp/src/componetes/notificaciones/vistas/notificacion_page.dart';
import 'package:hospitalapp/src/componetes/notificaciones/vistas/notificaciones_page.dart';

Map<String, WidgetBuilder> route() {
  return <String, WidgetBuilder>{
    'login'     : (context) => LoginPage(),
    'registro'  : (context) => RegistroPage(),
    'home'      : (context) => HomePage(page: 0),
    'solicitar' : (context) => SolicitarCitaPage(),
    'notificaciones': (context) => NotificacionesPage(),
    'notificacion'  : (context) => NotificacionPage()
  };
}
