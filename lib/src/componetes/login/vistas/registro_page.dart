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
  final _passwordController  = TextEditingController();
  final _cedulaController    = TextEditingController();
  
  final _focousuario   = FocusNode();
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
                         
                           child: BlocBuilder<LoginBloc,LoginState>(
                           builder: (context,state){
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
                                                            input("Usuario",_correoController,Icon(MaterialCommunityIcons.account_outline),_focousuario,state.usuario),
                                                            SizedBox(height: 10),
                                                            input("Contraseña",_passwordController,Icon(MaterialCommunityIcons.lock_open_outline),_focopassword,state.usuario),
                                                            SizedBox(height: 10),
                                                            input("Cedula",_passwordController,Icon(MaterialCommunityIcons.id_card),_fococedula,state.usuario),
                                                            SizedBox(height: 10),
                                                            registroButton(),
                                                            SizedBox(height: 20),
                                                            singGoogle(),
                                                            ],
                                            ),
                                   ),
                                   );
                           },
                           ),
                         ),
                   ),
           );
            
  
  }

Widget input
       (String texto, TextEditingController controller,Icon icono,foco,Usuario usuario){
        TextInputAction textinput;
         if(texto == 'Usuario' || texto == 'Contraseña')
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
                                                   case 'Usuario'    : FocusScope.of(context).requestFocus(_focopassword);
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
                                                  case 'Usuario'    : usuario.username = value;
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
  Widget registroButton() => Padding(
                             padding : EdgeInsets.symmetric(horizontal: 40),
                             child   : MaterialButton(
                                       height    : 50,
                                       minWidth  : double.maxFinite,
                                       color     : Color(0XFFE4097F),
                                       child     : Text("Ingresar",
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

  void _snackBar(GlobalKey<ScaffoldState> scaffoldKey) {
     scaffoldKey.currentState.showSnackBar(
       SnackBar(content: Text("Ya puedes Ingresar"))
     );

  }





}
