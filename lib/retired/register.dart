import 'package:flutter/material.dart';

bool isRestaurant = false;

class Register extends StatefulWidget {
  @override
  State createState() => new RegisterState();
}

class RegisterState extends State with TickerProviderStateMixin {
  final TextEditingController _firstNameCtl = new TextEditingController();
  final TextEditingController _lastNameCtl = new TextEditingController();
  final TextEditingController _emailCtl = new TextEditingController();
  final TextEditingController _pwdCtl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userNameField = "";
    var passwordField = "";
    var submitButton = RaisedButton(
      child: Text("Register"),
      onPressed: () => _submitButtonHandler(userNameField, passwordField),
    );
    return Scaffold(
      appBar: new AppBar(
          title: Text("Register",
              style: TextStyle(fontSize: 25.0))),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            margin: new EdgeInsets.only(top: 100.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Check if you're a food provider "),
                    Checkbox(
                        value: isRestaurant,
                        onChanged: (value) {
                          setState(() {
                            isRestaurant = true;});
                        }
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("First Name"),
                        Container(
//                            margin: new EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 0),
                            child: _firstNameBox()),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("Last Name"),
                        Container(
//                            margin: new EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 0),
                            child: _lastNameBox()),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
                  child: Column(
                    children: <Widget>[
                      Text("Email", textAlign: TextAlign.left,),
                    _emailBox()
                  ],
                )),
                Container(
                    margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0),
                    child: Column(
                      children: <Widget>[
                        Text("Password", textAlign: TextAlign.left,),
                        _pwdBox()
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: submitButton),
              ]
            )
          )
        ]
      )
    );
  }

  Widget _firstNameBox() {
    var textBox = Container(
        color: Theme.of(context).buttonColor,
        width: 150.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: new TextField(
          controller: _firstNameCtl,
//          decoration: new InputDecoration.collapsed(hintText: "Username"),
        ));
    return textBox;
  }

  Widget _lastNameBox() {
    var textBox = Container(
        color: Theme.of(context).buttonColor,
        width: 150.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: new TextField(
          controller: _lastNameCtl,
//          decoration: new InputDecoration.collapsed(hintText: "Username"),
        ));
    return textBox;
  }

  Widget _emailBox() {
    var textBox = Container(
        color: Theme.of(context).buttonColor,
        width: 270.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: new TextField(
          controller: _emailCtl,
//          decoration: new InputDecoration.collapsed(hintText: "Username"),
        ));
    return textBox;
  }

  Widget _pwdBox() {
    var textBox = Container(
        color: Theme.of(context).buttonColor,
        width: 270.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: new TextField(
          controller: _pwdCtl,
//          decoration: new InputDecoration.collapsed(hintText: "Username"),
        ));
    return textBox;
  }

  void _submitButtonHandler(String username, String password){}
}



