

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitalapp/src/componetes/home/bloc/home_bloc.dart';

class NavigatorBar extends StatefulWidget {

  NavigatorBar({this.items,this.selectpage,Key key}):super(key:key);
   final  List items;
   final  Function(int index) selectpage;

  @override
  NavigatorBarState createState() => NavigatorBarState();
}

class NavigatorBarState extends State<NavigatorBar>  with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return  SafeArea (
        bottom: false,
        child: Container (
              
               child: BottomAppBar(
                      color       : Color(0xFF01C6BD),
                      shape       : CircularNotchedRectangle(),
                      notchMargin : 4.0,
                      child       : Row(  
                                     mainAxisSize      : MainAxisSize.max,
                                     mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                     children          : menuItem(widget.items)
                                    ),
               ),
        ),
    );
  }

  List<Widget> menuItem(List menuItems){
        
         return menuItems.map((item)=>
                FlatButton(
                shape     : CircleBorder(),
                padding   : EdgeInsets.symmetric(vertical: 9),
                child     : Column(
                            mainAxisSize : MainAxisSize.min,
                            children     : <Widget>[
                                             item[2] == 1  || item[2]==2 ?
                                             BlocBuilder<HomeBloc,HomeState>(
                                               builder : (context,state)=>
                                               Badge(
                                               showBadge    : item[2] == 1 ? state.chatmessajeBadge : state.notificationBadge,
                                               position: BadgePosition.topLeft(left: 15),
                                               badgeContent : item[2] == 1 ?
                                               Text(state.numberBadgeChatMessaje.toString(),style:TextStyle(color: Colors.white)):
                                               Text(state.numberBadgetNotification.toString(),style:TextStyle(color: Colors.white)),
                                               child: Icon(item[0],color:item[3],size: 32.0),
                                               animationDuration: Duration(seconds: 2),
                                               ),
                                             )
                                             :Icon(item[0],color:item[3],size: 32.0),
                                             Text(
                                             item[1],
                                             style:TextStyle(
                                                   fontSize : 11.0,
                                                   color    : item[3]
                                                   )
                                             )
                             ],
                            ),
                onPressed : (){
                                widget.selectpage(item[2]);
                                selectPage(item);
                               },
                )).toList();
  }

 selectPage(item) {
   setState((){
     widget.items.forEach((itemmenu) {
       if(itemmenu[2]==item[2]){
         itemmenu[3]= Colors.white;
       }
       else itemmenu[3]= Colors.white70;
     });
   });
 }
}



