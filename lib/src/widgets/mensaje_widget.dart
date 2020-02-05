
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hospitalapp/src/componetes/chat/models/chat_model.dart';

class MensajeCard extends StatefulWidget {

  final List<Mensaje> mensajes;


  MensajeCard({Key key,this.mensajes}) : super(key: key);

  @override
  _MensajeCardState createState() => _MensajeCardState();
}

class _MensajeCardState extends State<MensajeCard> {
      ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
         SchedulerBinding.instance.addPostFrameCallback((_) {
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
    return  ListView.builder(
                  controller: _controller,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 70),
                  itemCount   : widget.mensajes.length,
                  itemBuilder : (context,i){
                  return Container(
                           margin    : EdgeInsets.only(bottom: 8),
                           alignment : widget.mensajes[i].recibido ? Alignment.bottomLeft : Alignment.bottomRight,
                           child     : Container(
                                       width: MediaQuery.of(context).size.width * 0.6,
                                       child: Card(
                                              shape    : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              color    : widget.mensajes[i].recibido ?  Color(0xFF01C6BD) : null,
                                              elevation: 3,
                                              child    : Padding(
                                                         padding :  EdgeInsets.all(12.0),
                                                         child   : Column(
                                                                   mainAxisSize : MainAxisSize.max,
                                                                   children     : <Widget>[
                                                                                    Container(
                                                                                    width: double.infinity,
                                                                                    child: Text(
                                                                                           widget.mensajes[i].mensaje,
                                                                                           style:TextStyle(
                                                                                                 color: widget.mensajes[i].recibido 
                                                                                                        ? Colors.white : null
                                                                                           ),
                                                                                           ),
                                                                                     ),
                                                                                    Container(
                                                                                    alignment : Alignment.topRight,
                                                                                    child     : Text("3:00 pm",
                                                                                               style:TextStyle(
                                                                                                     color: widget.mensajes[i].recibido 
                                                                                                            ? Colors.white
                                                                                                            : Colors.grey
                                                                                                     )
                                                                                                )
                                                                                    )
                                       ],
                                     )
                                   ),
                                   ),
                                 ),
                               );
                  },

           );
  
  }
}