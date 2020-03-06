





import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitalapp/src/componetes/citas/bloc/citas_bloc.dart';
import 'package:hospitalapp/src/componetes/citas/models/status_model.dart';
import 'package:hospitalapp/src/componetes/citas/models/turno_model.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';

class SolicitarCitaPage extends StatefulWidget {
  SolicitarCitaPage({Key key}) : super(key: key);

  @override
  _SolicitarCitaPageState createState() => _SolicitarCitaPageState();
}

class _SolicitarCitaPageState extends State<SolicitarCitaPage> {

  TextEditingController _controller = TextEditingController();
  String tipocita;
  String errormessaje;
var _scaffoldKey = GlobalKey<ScaffoldState>();
  final Color primaryColor = Color(0XFFE4097F);
  final Color secundaryColor = Color(0xFF01C6BD);
  bool  swicht = false;
  int groupradio = -1;
    final List citas = [
    'Medicina Generar',
    'Odontologia',
    'Crecimiento y Desarrollo',
    'Control de Hipertension',
    'Citologia',
    'Planificacion'
  ];
  @override
  Widget build(BuildContext context) {

    Usuario usuario;
    final stateUsuario = context.bloc<LoginBloc>().state;
    if(stateUsuario is AutenticadoState)
        usuario = stateUsuario.usuario;

   return Scaffold(
           key: _scaffoldKey,
           appBar: AppBar(
                   brightness:    Brightness.dark,
                   title          : Text("Solicite tu Cita", 
                                    style: TextStyle(color: Colors.white)
                                  ),
                   backgroundColor: secundaryColor,
                   iconTheme: IconThemeData(
                    color: Colors.white
                   ),
      ),
      body: BlocConsumer<CitasBloc,CitasState>(
              listener: (context,state){
               switch (state.status) {
                 case StatusCitas.loading    : dialogoNewCita(context);
                                     break;
                 case StatusCitas.aceptada   : Navigator.pop(context);
                                     _snakbar("Solicitud Aceptada");
                                     break;
                 case StatusCitas.no_aceptada: Navigator.pop(context);
                                     _snakbar("Solicitud  No Aceptada");
                                     break;
                 case StatusCitas.duplicado  : Navigator.pop(context);
                                     _snakbar("Ya Envisate Una Solicitud");
                                     break;
                 case StatusCitas.error  : Navigator.pop(context);
                                     _snakbar("Ocurrio Error");
                                     break;
                 default:
               }
              },
              builder:(context,state)=> GestureDetector(
              onTap: ()=>FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(children: <Widget>[
                                Text("Selecione Tipo de Cita",
                                style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 20),
                                ..._opcionesCitas(citas),
                                Text("Asignacion Automatica",
                                style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 20),
                                _asigtauto(),
                                 SizedBox(height: 20),
                                _observaciones(),
                                SizedBox(height: 20),
                                _solicitarBottom(context,usuario)
                               ]
                  ),
            ),
          ),
        ),
      ),
    );
  }

List<Widget> _opcionesCitas(List citas){
return  citas.asMap().entries.map((item)=>Row(
              children: <Widget>[
                  Radio(
                  activeColor: Color(0xFF01C6BD),
                  groupValue: groupradio,
                  value: item.key,
                  onChanged: (value){
                    setState(() {
                      groupradio = value;
                      tipocita   = item.value;
                    });
                  },
                ),
                Text(item.value)
              ],
            )).toList();
}

Widget  _asigtauto() {
  return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
                     Flexible(
                     child: FractionallySizedBox(
                     widthFactor: 0.6,
                     child: Text(
                     "Si esta Opcion esta Activa la cita sera Asignada Atomaticamente",
                       )
                     )
                     ),
                     Switch(
                     activeColor: Color(0xFF01C6BD),
                     value: swicht, 
                     onChanged: (value){
                        setState(() {
                          swicht = value;
                        });
                     })
                            ],  
          );
}

 Widget _observaciones() {
   return TextField(
          controller      : _controller,
          keyboardType    : TextInputType.multiline,
          maxLines        : null,
          decoration: InputDecoration(
                      hintText      : "Observaciones",
                      helperText    : "Escriba alguna sugerencia",
                      border        : OutlineInputBorder(),
                      enabledBorder : OutlineInputBorder(
                                     borderSide: BorderSide(
                                     color     : Color(0xFF01C6BD)
                                     )
                      )
                      ),
          );
 }

 Widget _solicitarBottom(BuildContext context,Usuario usuario) {
   return  MaterialButton(
           height    : 50,
           minWidth  : double.maxFinite,
           color     : Color(0XFFE4097F),
           child     : Text("Solicitar",
                            style: TextStyle(
                                   color      : Colors.white,
                                   fontSize   : 18,
                                   fontWeight : FontWeight.bold
                                   )
                           ),
           shape     :RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30)
                      ) ,                
           onPressed :(){
           
             final turno = Turno(
                           nombre: usuario.nombre,
                           email : usuario.email,
                           cedula: usuario.cedula,
                           automatica: swicht,
                           observaciones: _controller.text,
                           tipocita: tipocita,
                           numero:'' 
             );
             if(groupradio>-1)
             context.bloc<CitasBloc>().add(SolicitarTurnoEvent(turno:turno));
             else {
                 _snakbar("Debes escojer un tipo de Cita");
                 errormessaje = "Debes escojer un tipo de Cita";
             }
           },
   );
 }
dialogoNewCita(BuildContext context) {
    showDialog(
        context: context,
        builder:(context)=>
        AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title    : Text(
                   "Solicitando Turno Espere",
                    style: TextStyle(color: Colors.white),
                   ),
        content  :Container(
                  height   : 35,
                  alignment: Alignment.center,
                  child    : CircularProgressIndicator(
                             valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
                  )),  
        )
      );
  }
  _snakbar(String mensaje) {
    _scaffoldKey.currentState.showSnackBar(
       SnackBar(
       content: Text(mensaje),
       duration: Duration(seconds: 1),
       behavior: SnackBarBehavior.floating,
       )
    )..closed.then((data){
      if(mensaje != errormessaje)
      Navigator.pop(context);
    });
 }
}

