import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/theme.dart';

class LandingPage extends StatefulWidget {
  @override
  State createState() => new LandingPageState();
}

class LandingPageState extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Container(
          //          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(color: Colors.lightGreen[100]),
          child: new Column(children: <Widget>[
            new Container(
                margin: const EdgeInsets.only(top: 80.0),
                child: new Image(
                  image: new AssetImage("lib/pages/logo.png"),
                  fit: BoxFit.scaleDown,
                )),
            new Text("Welcome to \n Share Sum Food",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                textAlign: TextAlign.center),
            new RaisedButton(
                onPressed: _handleLogInButton, child: const Text("Log In"))
          ])),
    ]));
  }
}

Widget logInButton() {
  child:
  return new Container(
//      margin: const EdgeInsets.symmetric(horizontal: 45.0),
      child: new Container(
          child: new RaisedButton(
              onPressed: _handleLogInButton, child: const Text("Log In"))));
}

void _handleLogInButton() {}
