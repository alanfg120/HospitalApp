import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hospitalapp/src/componetes/chat/bloc/chat_bloc.dart';
import 'package:hospitalapp/src/componetes/chat/models/chat_model.dart';
import 'package:hospitalapp/src/widgets/mensaje_widget.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final Color primaryColor   = Color(0XFFE4097F); 
  final Color secundaryColor = Color(0xFF01C6BD);   
   
  TextEditingController _controlerChat = TextEditingController();
   
  @override
  Widget build(BuildContext context) {

    final double     paddingInput     = MediaQuery.of(context).size.width * 0.05;
    final EdgeInsets paddingTextfield = EdgeInsets.only(left: 15,right:paddingInput,bottom: 20);

    return  Scaffold(
               body  : BlocBuilder<ChatBloc,ChatState>(
                        builder:(context,state){
                                 if(state is LoadingChatState)
                                    return Center(child: CircularProgressIndicator());
                                 if(state is LoadMensajesState)
                                 return  _listMensaje(state.mensajes);
                                 
                              return Container();
                             }
                               
              ),
              
             bottomSheet : _inputChat(paddingTextfield),
            
             );
    
    }
           
  Widget _inputChat(paddingTextfield)=>
                         BlocBuilder<ChatBloc,ChatState>(
                           builder:(context,state){
                          if(state is LoadMensajesState){
                           _controlerChat.text = state.mensaje.mensaje;
                           return Padding(
                           padding : paddingTextfield,
                           child   : TextField(
                                     controller      : _controlerChat,
                                     focusNode       : FocusNode(),
                                     keyboardType    : TextInputType.multiline,
                                     maxLines        : null,
                                     decoration: InputDecoration(
                                                 filled         : true,
                                                 fillColor      : Colors.white,
                                                 prefixIcon     : Icon(MaterialCommunityIcons.chat_outline,color: primaryColor),
                                                 contentPadding : EdgeInsets.all(10),
                                                 hintText       : "Escriba tu Mensaje",
                                                
                                                 enabledBorder  : OutlineInputBorder(
                                                                  borderRadius : BorderRadius.circular(50),
                                                                  borderSide   : BorderSide(color:Colors.white)
                                                 ),
                                                 focusedBorder  : OutlineInputBorder(
                                                                  borderRadius : BorderRadius.circular(50),
                                                                  borderSide   : BorderSide(color:Colors.white)
                                                    )
                                     ),
                                     onChanged: (value){
                                       state.mensaje.mensaje=value;
                                     },
                                   ),
                           );
                          }           
                          return Container();          
                         }
                         );

Widget _listMensaje(List<Mensaje> mensajes) {
         return GestureDetector(
           onTap: ()=>SystemChannels.textInput.invokeMethod('TextInput.hide'),
           child: MensajeCard(mensajes: mensajes)
           );
}
}

/* ListView(
                           children: <Widget>[
                             Container(
                               margin: EdgeInsets.only(bottom: 15),
                               alignment:Alignment.topRight,
                               child: Container(
                                 width: MediaQuery.of(context).size.width * 0.6,
                                 child: Card(
                             
                                 elevation: 3,
                                 child: Padding(
                                   padding:  EdgeInsets.all(12.0),
                                   child: Column(
                                     mainAxisSize: MainAxisSize.max,
                                     children: <Widget>[
                                       Container(
                                         width: double.infinity,
                                         //alignment: Alignment.topRight,
                                         child: Text("Hola Buenos Dias",
                                              //softWrap: true,
                                               //textAlign: TextAlign.left,
                                               ),
                                       ),
                                       Container(
                                         alignment: Alignment.topRight,
                                         child: Text("3:00 pm",style:TextStyle(color: Colors.grey)))
                                     ],
                                   )
                                 ),
                                 ),
                               ),
                             ), 
                            
                           ],
                           ), */