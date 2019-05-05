import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/log_in.dart';
import 'package:share_sum_food/pages/theme.dart';
import 'package:share_sum_food/pages/add_food.dart';
import 'package:share_sum_food/pages/list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_sum_food/pages/map_page.dart';
import 'package:share_sum_food/pages/home.dart';

bool loggedIn = false;

void main() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  print(email);
  var isFoodSeeker = prefs.getBool("isFoodSeeker");
  print("IN MAIN " + isFoodSeeker.toString());
  //this means the user is logged in
  if (email != null && isFoodSeeker != null){
      runApp(new MaterialApp(theme: appTheme,
        home: Home(isSeeker: isFoodSeeker)
      ));
  }

  else if (email == null || isFoodSeeker == null) {
    runApp(new MaterialApp(theme: appTheme,
      home: LogIn()
    ));
  }


}


