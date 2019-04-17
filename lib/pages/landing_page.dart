import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/log_in.dart';
import 'package:share_sum_food/pages/theme.dart';
import 'package:share_sum_food/pages/register.dart';

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
            Container(
              margin: const EdgeInsets.only(top: 60.0),
              child: new MaterialButton(
                  onPressed: _handleLogInButton,
                  color: Theme.of(context).buttonColor,
                  height: 40.0,
                  child:
                      const Text("Log In", style: TextStyle(fontSize: 20.0))),
            ),
            MaterialButton(
                onPressed: _handleSignUpButton,
                child: const Text("Don't have an account? Register",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.blue,
                        decoration: TextDecoration.underline)))
          ])),
    ]));
  }
}

void _handleLogInButton() {
  runApp(
      new MaterialApp(
          home: LogIn(),
          theme: appTheme));
}

void _handleSignUpButton() {
  runApp(
      new MaterialApp(
          home: Register(),
          theme: appTheme));
}
