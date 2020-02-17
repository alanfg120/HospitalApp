
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospitalapp/src/componetes/chat/bloc/chat_bloc.dart';
import 'package:hospitalapp/src/componetes/chat/vistas/chat_page.dart';
import 'package:hospitalapp/src/componetes/citas/vistas/citas_page.dart';
import 'package:hospitalapp/src/widgets/navigator_bar.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
 _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Widget lastPage;
  IconData lastcolor;
  
  bool syncauto;
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
    
    return Scaffold(
           key                 : scaffoldKey,
           appBar              : AppBar(
                                 title           : ListTile(
                                                   leading : _avatar(),
                                                   title   : Text("Juana de Arco",
                                                                  style: TextStyle(
                                                                         color    : Colors.white,
                                                                         fontSize : 25
                                                                         )
                                                                  ),
                                                   subtitle: Text("liberandoafrancia@gmail.com",
                                                                  style: TextStyle(color: Colors.white)
                                                                 ),
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
                                 BlocBuilder<ChatBloc,ChatState>(
                                             builder:(context,state){
                                             if(state is LoadMensajesState){
                                                 return FloatingActionButton(
                                                        backgroundColor : Color(0XFFE4097F),
                                                        child           : Icon(addIcon(currentindex),color:Colors.white),
                                                        onPressed       : (){
                                                                            add(currentindex,context);
                                                                            if(currentindex==1)
                                                                            BlocProvider.of<ChatBloc>(context)
                                                                            .add(SendMensajeEvent(mensaje: state.mensaje));
                                                                            },
                                                 );
                                             }
                                             return Container();
                                 }
                          )
                          
                               : null,
           floatingActionButtonLocation: currentindex == 0 ? floatBoton : null
          
          );
  }
  
  Widget page(index) {
     
         setState(()=>currentindex = index);
         switch (currentindex) {
                 case 0 : //lastPage = PedidosPage();
                          return CitasPage();
                          break;
                 case 1 : //lastPage = ProductosPage();
                          return ChatPage();
                          break;
                 case 2 : //lastPage = ClientesPage();
                          //return ClientesPage();
                          break;
                 case 3 : return lastPage;
                          break;
                 default: return CitasPage();
         }
  
  
  }
  
 

  void add(int currentindex,BuildContext context) {

       switch (currentindex) {
                case 0  : 
                          dialogoNewCita(context);
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

 Widget  _avatar() =>  CircleAvatar(
                       child           : Text("J",style: TextStyle(fontWeight: FontWeight.bold)),
                       backgroundColor : colorSecundary,
                       );

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
 
}

