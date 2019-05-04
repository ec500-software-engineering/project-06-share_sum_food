import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_sum_food/pages/log_in.dart';

class Options extends StatefulWidget {
  @override
  State createState() => new OptionsState();
}

class OptionsState extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Options>"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 50.0,
              minWidth: 80.0,
              color: Theme.of(context).buttonColor,
              textColor: Colors.black,

              child: new Text("Sign Out"),
              onPressed: _onHandlingSignOut,
              splashColor: Colors.redAccent,
            ),
          ],
        ),
      )
    );
  }

  _onHandlingSignOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    runApp(MaterialApp(home: LogIn(), theme: Theme.of(context)));
  }
}