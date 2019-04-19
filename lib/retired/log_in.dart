import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/menu_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogIn extends StatefulWidget {
  @override
  State createState() => new LogInState();
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LogInState extends State with TickerProviderStateMixin {
  final TextEditingController _pwdController = new TextEditingController();
  final TextEditingController _usrController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var passwordField = "";
    var userNameField = "";
    var submitButton = RaisedButton(
      child: Text("Log In"),
      onPressed: () => _submitButtonHandler(userNameField, passwordField),
    );
    return Scaffold(
        appBar: new AppBar(
            title: Text("Sign In >",
                style: TextStyle(fontSize: 25.0))),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(top: 100.0),
              child: Column(
                children: <Widget>[
                  Text("Hello! Sign in to Share Sum Food",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontSize: 20.0)),
                  Spacer(),
                  Text("Username",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16.0)),
                  Container(
                      margin: new EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 0),
                      child: _userNameBox()),
                  Text("Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16.0)),
                  Container(
                      margin: new EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 10.0),
                      child: _passwordBox()),
                  Container(child: submitButton),
                  Spacer(),
                  Container(child: bottomBar()),
                ],
              ),
            )
          ],
        ));
  }

  Widget _userNameBox() {
    var textBox = Container(
        color: Theme.of(context).buttonColor,
        height: 50.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: new TextField(
          controller: _usrController,
//          decoration: new InputDecoration.collapsed(hintText: "Username"),
        ));
    return textBox;
  }

  Widget _passwordBox() {
    var textBox = Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        color: Theme.of(context).buttonColor,
        child: new TextField(
          controller: _pwdController,
//          decoration: new InputDecoration.collapsed(hintText: "Password"),
        ));
    return textBox;
  }

  void _submitButtonHandler(String usr, String pwd) {}
}
