import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/log_in.dart';
import 'package:share_sum_food/pages/theme.dart';
import 'package:share_sum_food/pages/add_food.dart';
import 'package:share_sum_food/globals.dart';
import 'package:share_sum_food/pages/list.dart';

bool loggedIn = false;

void main(){
  if (!Globals().isLoggedIn){
    runApp(new MaterialApp(theme: appTheme,
      home: LogIn(),
    ));
  }
  else if (Globals().isLoggedIn && (Globals().isDonor && !Globals().isSeeker)){
    runApp(new MaterialApp(theme: appTheme,
      home: AddFood(),
    ));
  }
  else if (Globals().isLoggedIn && (!Globals().isDonor && Globals().isSeeker)){
    runApp(new MaterialApp(theme: appTheme,
      home: List(),
    ));
  }

}


