import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';




class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  final _correoController    = TextEditingController();
  final _usuarioController    = TextEditingController();
  final _passwordController  = TextEditingController();
  final _cedulaController    = TextEditingController();
  
  final _focousuario   = FocusNode();
  final _focoemail     = FocusNode();
  final _focopassword  = FocusNode();
  final _fococedula    = FocusNode();

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
           key: _scaffoldKey,
           body: GestureDetector(
                 onTap: ()=>FocusScope.of(context).unfocus(),
                 child: SingleChildScrollView(
                        child: BlocConsumer<LoginBloc,LoginState>(
                               listener: (context,state){
                                         if(state is AutenticandoState){
                                           switch (state.registro) {
                                                   case 'REGISTRADO' : _snackBar("Usuario Registrado");
                                                                       break;
                                                   case 'DUPLICADO'  :_snackBar("Usuario Ya Existe");
                                                                       break;
                                                   case 'ERROR'      :_snackBar("Ocurrio un Error");
                                                                       break;
                                           }
                                         }
                           },
                           builder: (context,state){
                                     if(state is AutenticandoState){
                                       _usuarioController.text  = state.usuario.nombre;
                                       _correoController.text   = state.usuario.email;
                                       _passwordController.text = state.usuario.password;
                                       _cedulaController.text   = state.usuario.cedula;
                                       return  Form(
                                               child: Container(
                                                      //padding: EdgeInsets.all(33),
                                                      child: Column(
                                                             children: <Widget>[
                                                                        logo(),
                                                                        //SizedBox(height: 30),
                                                                        input("Nombres Y Apellidos",_usuarioController,Icon(MaterialCommunityIcons.account_card_details),_focousuario,state.usuario),
                                                                        SizedBox(height: 10),
                                                                        input("Email",_correoController,Icon(MaterialCommunityIcons.account_outline),_focoemail,state.usuario),
                                                                        SizedBox(height: 10),
                                                                        input("Contraseña",_passwordController,Icon(MaterialCommunityIcons.lock_open_outline),_focopassword,state.usuario),
                                                                        SizedBox(height: 10),
                                                                        input("Cedula",_cedulaController,Icon(MaterialCommunityIcons.id_card),_fococedula,state.usuario),
                                                                        SizedBox(height: 10),
                                                                        registroButton(state),
                                                                        ],
                                                        ),
                                               ),
                                               );
                           }
                           return Container();
                           },
                           ),
                         ),
                   ),
           );
            
  
  }

Widget input
       (String texto, TextEditingController controller,Icon icono,foco,Usuario usuario){
        TextInputAction textinput;
         if(texto == 'Email' || texto == 'Contraseña' || texto == "Nombres Y Apellidos")
               textinput=TextInputAction.next;
         else  textinput=TextInputAction.done;
         return Padding(
                padding : EdgeInsets.symmetric(horizontal: 40,vertical: 8),
                child   : TextFormField(
                          textInputAction    : textinput,
                          focusNode          : foco,
                          obscureText        : texto == 'Contraseña' ? true : false,
                          controller         : controller,
                          decoration         : InputDecoration(
                                               contentPadding : EdgeInsets.all(10),
                                               prefixIcon     : icono,
                                               hintText       : texto,
                                               border         : OutlineInputBorder()
                                              ),
                          onEditingComplete :(){
                                                 switch (texto) {
                                                   
                                                   case 'Nombres Y Apellidos': FocusScope.of(context).requestFocus(_focoemail);
                                                                       break;
                                                   case 'Email'    : FocusScope.of(context).requestFocus(_focopassword);
                                                                       break;
                                                   case 'Contraseña' : FocusScope.of(context).requestFocus(_fococedula);
                                                                       break;
                                                   case 'Cedula'     : //FocusScope.of(context).requestFocus(_fococedula);
                                                                       break;
                                                   default           : break;    
                                                 }
                                               },
                          onChanged         :(value){
                                               switch (texto) {
                                                 case 'Nombres Y Apellidos': usuario.nombre = value;
                                                                       break;
                                                  case 'Email'      : usuario.email = value;
                                                                      break;
                                                  case 'Contraseña' : usuario.password = value;
                                                                      break;
                                                  case 'Cedula'     : usuario.cedula   = value;
                                                                      break;
                                                  default           : break;    
                                                }
                                              },            
         ),
       );
 }
  Widget registroButton(AutenticandoState state) => Padding(
                             padding : EdgeInsets.symmetric(horizontal: 40),
                             child   : MaterialButton(
                                       height    : 50,
                                       minWidth  : double.maxFinite,
                                       color     : Color(0XFFE4097F),
                                       child     : Text("Registrar",
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
                                          BlocProvider.of<LoginBloc>(context).add(RegistroEvent(usuario:state.usuario));
                                       },
                             ),
  );

  Widget singGoogle() => Column(
                         children: <Widget>[
                         Text("o Registrate Mediante la Cuenta de"),
                         SizedBox(height: 15),
                         GestureDetector(
                         child: Card(
                                shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20.0),
                                       ),
                                child: Padding(
                                       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                                       child: Image(
                                              height : 40,
                                              width  : 80,
                                              image  : AssetImage('assets/google.png'),
                                              ),
                                ),
                         ),
                         onTap: (){
                         
                         },
                         ),
                         
                         ]);

  Widget logo() =>   Container(
                     alignment  : Alignment.bottomLeft,
                     height     : MediaQuery.of(context).size.height * 0.30,
                     margin     : EdgeInsets.only(bottom: 35),
                     decoration : BoxDecoration(
                                  color        : Color(0xFF01C6BD),
                                  borderRadius : BorderRadius.only(bottomRight: Radius.circular(70))
                                  ),
                     child      : Padding(
                                  padding : EdgeInsets.all(8.0),
                                  child   : Text("Registrese",
                                            style: TextStyle(
                                                   fontSize : 30,
                                                   color    : Colors.white
                                                   )
                                            ),
                     ),
                     );

  void _snackBar(String mensaje) async {
    _scaffoldKey.currentState.showSnackBar(
       SnackBar(
       content: Text(mensaje),
       behavior: SnackBarBehavior.floating,
       duration: Duration(seconds: 1)
       )
     )..closed.then((rason){
        if(mensaje=="Usuario Registrado")
        Navigator.pop(context);
     });
  }





}
