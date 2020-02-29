import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospitalapp/src/componetes/citas/bloc/citas_bloc.dart';
import 'package:hospitalapp/src/componetes/citas/models/turno_model.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';

class CitasPage extends StatefulWidget {
  CitasPage({Key key}) : super(key: key);

  @override
  _CitasPageState createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
   final Color primaryColor   = Color(0XFFE4097F); 
  final Color secundaryColor = Color(0xFF01C6BD);   
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitasBloc,CitasState>(
          builder: (context,state)=>
           Scaffold(
             body: Center(
               child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                         GestureDetector(
                         onTap: (){
                                    Navigator.pushNamed(context, 'solicitar');
                                   
                                   // _sendTurno(context);
                                  },
                         child: _card("Pedir cita",MaterialCommunityIcons.calendar_plus)
                         ),
                         SizedBox(height: 10),
                         _card("Tus citas",MaterialCommunityIcons.calendar_range),
                       
                    ],
                     ),
             ),
             ),
    );
  }

  Widget _card(String s, IconData icon) {
    return Container(
           height: 180,
           width : 300,
           child : Card(
                   elevation: 3,
                   shape    : RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                   child    : Padding(
                              padding:EdgeInsets.all(20.0),
                              child: Column(
                                     mainAxisSize: MainAxisSize.max,
                                     children: <Widget>[
                                        Container(
                                        alignment: Alignment.topLeft,
                                        child    : Text(s,style:TextStyle(fontSize: 30,color:secundaryColor))),
                                        Container(
                                        alignment:Alignment.bottomRight,
                                        child    : Icon(icon,size: 70,color: primaryColor))
                                     ],
                               ),
                             ),
                    ),
            );
  }

  

  void _sendTurno(BuildContext context) {
    final stateUsuario = context.bloc<LoginBloc>().state;
    if(stateUsuario is AutenticadoState){
      final turno = Turno(
                    nombre: stateUsuario.usuario.nombre,
                    cedula: stateUsuario.usuario.cedula,
                    email : stateUsuario.usuario.email
                    );
      context.bloc<CitasBloc>().add(SolicitarTurnoEvent(turno: turno));

    }
      
  }
}