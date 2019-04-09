import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  State createState() => new LogInState();
}

class LogInState extends State with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController()
  @override
  Widget build(BuildContext context) {
    var passwordField = "";
    var userNameField = "";
    var submitButton  = RaisedButton(
      child: Text("Log In"),
      onPressed: () => _submitButtonHandler(userNameField,passwordField),
    );

  }
  Widget _userNameBox(){
    var textBox = Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: new TextField(
        controller: _textController,
        decoration: 
          new InputDecoration.collapsed(hintText: "Username"),
      )
    );
  }

  void _submitButtonHandler(String usr, String pwd){

  }
}

