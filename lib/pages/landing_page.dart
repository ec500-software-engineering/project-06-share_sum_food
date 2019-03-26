import 'package:flutter/material.dart';

class LandingPage extends  StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Material(
      color: Colors.blueAccent,
      child: new InkWell(
        child: new Column(
          children: <Widget>[
            new Text("Share Sum Food". style: new TextStyle(color: Colors.white, 
            fontSize: 50.0, FontWeight: FontWeight.bold))
          ],
        )
      ),
      );
  }
}