import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospitalapp/src/componetes/login/bloc/login_bloc.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';




class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _correoController    = TextEditingController();
  final _passwordController  = TextEditingController();
  
  final _focousuario   = FocusNode();
  final _focopassword  = FocusNode();
  
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           key: _scaffoldKey,
           body: GestureDetector(
                 onTap: ()=>FocusScope.of(context).unfocus(),
                 child: SingleChildScrollView(
                           child: BlocConsumer<LoginBloc,LoginState>(
                           listener: (contex,state){
                             if(state is AutenticadoState)
                                Navigator.pushReplacementNamed(context, 'home');
                             if(state is AutenticandoState)
                                if(state.registro == "ERROR")
                                _snackBar("Datos Incorrectos");
                           },
                           builder: (context,state){
                           if(state is AutenticandoState){
                              _correoController.text   = state.usuario.email;
                              _passwordController.text = state.usuario.password;
                              return  Form(
                                   child: Container(
                                          //padding: EdgeInsets.all(33),
                                          child: Column(
                                                 children: <Widget>[
                                                            logo(),
                                                            //SizedBox(height: 30),
                                                            input("Email",_correoController,Icon(MaterialCommunityIcons.account_outline),_focousuario,state.usuario),
                                                            SizedBox(height: 10),
                                                            input("Contraseña",_passwordController,Icon(MaterialCommunityIcons.lock_open_outline),_focopassword,state.usuario),
                                                            SizedBox(height: 10),
                                                            olvidoPassword(),
                                                            SizedBox(height: 20),
                                                            registroButton(state.usuario),
                                                            SizedBox(height: 20),
                                                            singUptext()
                                                            
                                                           ],
                                            ),
                                   ),
                                   );
                           }
                           return Center(child: CircularProgressIndicator());
                           },
                           ),
                         ),
                   ),
           );
            
  
  }

Widget input(String texto, TextEditingController controller,Icon icono,foco,Usuario state){
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
                                            case 'Email'    : FocusScope.of(context).requestFocus(_focopassword);
                                                                break;
                                            case 'Contraseña' : //FocusScope.of(context).requestFocus(_fococompania);
                                                                break;
                                           default           :  break;    
                                          }
                                        },
                   onChanged         :(value){
                                        switch (texto) {
                                           case 'Email'    : state.email      = value;
                                                               break;
                                           case 'Contraseña' : state.password   = value;
                                                               break;
                                           default           : break;    
                                         }
                
                                       },            
         ),
       );
 }
  Widget registroButton(Usuario usuario) => Padding(
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
                                         context.bloc<LoginBloc>().add(AuthEvent(usuario: usuario));
                                         
                                       },
                             ),
  );

  Widget singGoogle() => Column(
                         children: <Widget>[
                         Text("o Ingresa Mediante la Cuenta de"),
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
                          // BlocProvider.of<LoginBloc>(context).add(RegGoogleEvent());
                         },
                         ),
                         
                         ]);

  Widget logo() =>   Container(
                     alignment  : Alignment.bottomRight,
                     height     : MediaQuery.of(context).size.height * 0.30,
                     margin     : EdgeInsets.only(bottom: 35),
                     decoration : BoxDecoration(
                                  color        : Color(0xFF01C6BD),
                                  borderRadius : BorderRadius.only(bottomLeft: Radius.circular(70))
                                  ),
                     child      : Padding(
                                  padding : EdgeInsets.all(8.0),
                                  child   : Text("Iniciar Sesion",
                                            style: TextStyle(
                                                   fontSize: 30,
                                                   color: Colors.white
                                                   )
                                            ),
                     ),
                     );

  void _snackBar(String mensaje) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(
       content: Text(mensaje),
       behavior: SnackBarBehavior.floating,
       duration: Duration(seconds: 1),
       )
     );

  }
  Widget olvidoPassword()=> Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                   child: Text("Olvidaste tu Contraseña?"),
                                   onTap: (){print("object");},
                            ),
                           );

  Widget singUptext()=> Container(
                        padding : EdgeInsets.all(10),
                        child   : Center(
                                  child: RichText(
                                         text: TextSpan(
                                               text    : 'No tienes Una Cuenta?',
                                               style   : TextStyle(color: Colors.black),
                                               children: <TextSpan>[
                                                         TextSpan(
                                                         text      : ' Registrate',
                                                         style     : TextStyle(
                                                         color     : Colors.blueAccent, fontSize: 16),
                                                         recognizer: TapGestureRecognizer()
                                                         ..onTap = () => Navigator.pushNamed(context, 'registro')
                                                         )
                                                        ]
                                         )
                                  ),
                         )
                        );


}