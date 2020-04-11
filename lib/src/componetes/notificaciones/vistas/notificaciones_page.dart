

import 'package:flutter/material.dart';
import 'package:hospitalapp/src/componetes/notificaciones/models/notificacion_model.dart';

class NotificacionesPage extends StatefulWidget {
  NotificacionesPage({Key key}) : super(key: key);

  @override
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
var  colorPrimary     = Color(0xFF01C6BD); 
  var  colorSecundary   = Color(0XFFE4097F); 
List<Notificacion> notificaciones = [
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: false),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: true),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: true),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: true),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: false),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: true),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: true),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: true),
  Notificacion(titulo: 'Nueva cita',body: 'tu cita ha sido asignada el dia martes a las 6pm con el doctor',leida: true),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar : AppBar(
                    title      : Text("Notificaciones"),
                    leading    : Icon(Icons.notifications,color: colorSecundary),
                    brightness : Brightness.dark,
           ),
           body   : _notificaciones(notificaciones)
    );
  
  }
   Widget _notificaciones(List<Notificacion> notificaciones){
     return ListView.builder(
                 itemCount  : notificaciones.length,
                 itemBuilder: (context,index)=>
                               Container(
                                 color: notificaciones[index].leida ? Colors.transparent :Colors.black12 ,
                                 child: ListTile(
                                        trailing: Icon(Icons.perm_contact_calendar,color: colorSecundary),
                                        title   : Text(notificaciones[index].titulo),
                                        subtitle: Text(notificaciones[index].body,overflow: TextOverflow.ellipsis,),
                                        onTap: (){},
                                 ),
                               )
           );
   }
}
