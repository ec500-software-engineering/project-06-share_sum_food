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
        body: Container(
            child: new Column(children: <Widget>[
      new Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            CircleAvatar(
                radius: 150.0,
                child: Image(
                  image: new AssetImage("logo.png"),
                  fit: BoxFit.scaleDown,
                ))
          ]))
    ])));
  }
}

Widget logInButton() {
  child:
  return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 45.0),
      child: new Container(
          child: new RaisedButton(
              onPressed: _handleLogInButton, child: const Text("Log In"))));
}

void _handleLogInButton() {}
