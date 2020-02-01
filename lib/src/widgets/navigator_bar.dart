import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {

  NavigatorBar({this.items,this.selectpage});
   final  List items;
   final  Function(int index) selectpage;

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
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
                                             Badge(
                                             showBadge    : false,
                                             badgeContent : Text('1',style:TextStyle(color: Colors.white)),
                                             child: Icon(item[0],color:item[3],size: 32.0)
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
                                setState((){
                                            widget.items.forEach((itemmenu) {
                                            
                                             if(itemmenu[2]==item[2]){
                                               itemmenu[3]= Colors.white;
                                                

                                             }
                                                
                                            else itemmenu[3]= Colors.white70;
                                                  
                                            });
                                });
                               },
                )).toList();
  } 
}

