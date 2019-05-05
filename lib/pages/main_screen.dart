import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_sum_food/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_sum_food/pages/add_food.dart';

class MainScreen extends StatefulWidget {
  final GoogleSignInAccount googleUser;
  final FirebaseUser firebaseUser;

  const MainScreen(
      {Key key, @required this.googleUser, @required this.firebaseUser})
      : assert(googleUser != null),
        assert(firebaseUser != null),
        super(key: key);

  @override
  State createState() => new MainScreenState(googleUser, firebaseUser);
}

class MainScreenState extends State with TickerProviderStateMixin {
  GoogleSignInAccount googleUser;
  FirebaseUser firebaseUser;

  MainScreenState(GoogleSignInAccount _googleUser, FirebaseUser _firebaseUser){
    this.googleUser = _googleUser;
    this.firebaseUser = _firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text("Welcome")
            ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Offstage(
              offstage: googleUser.photoUrl == null,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(googleUser.photoUrl)),
            ),
            SizedBox(height: 8.0),
            Text(googleUser.displayName, style: theme.textTheme.title),
            Text(googleUser.email),
            Padding(padding: EdgeInsets.only(top:20.0)),

            Text("Are you a food provider?",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),),

            Padding(padding: EdgeInsets.only(top:20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    height: 50.0,
                    minWidth: 80.0,
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.black,
                    child: new Text("YES"),
                    onPressed: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isFoodSeeker", false);
                      return Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Home(isSeeker: false)));
                    },
                    splashColor: Colors.blue,
                  ),
                  MaterialButton(
                    height: 50.0,
                    minWidth: 80.0,
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.black,
                    child: new Text("NO"),
                    onPressed: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isFoodSeeker", true);
                      return Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Home(isSeeker: true)));
                    },
                    splashColor: Colors.redAccent,
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }

  _handleFoodSeeker(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFoodSeeker", true);
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => Home()));
  }


   _handleFoodProvider(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFoodSeeker", false);
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => AddFood()));
  }
}
