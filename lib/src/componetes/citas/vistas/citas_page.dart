import 'package:flutter/material.dart';

class CitasPage extends StatefulWidget {
  CitasPage({Key key}) : super(key: key);

  @override
  _CitasPageState createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: Center(child: Text("Citas")),
           );
  }
}