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
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("First Name"),
                        Container(
                            margin: new EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 0),
                            child: _firstNameBox()),
                      ],
                    ),
                  ],
                )

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
        width: 75.0,
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
        width: 75.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: new TextField(
          controller: _lastNameCtl,
//          decoration: new InputDecoration.collapsed(hintText: "Username"),
        ));
    return textBox;
  }


}



