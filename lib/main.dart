import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/log_in.dart';
import 'package:share_sum_food/pages/theme.dart';

bool loggedIn = false;

void main() => runApp(new MaterialApp(
      theme: appTheme,
      home: LogIn(),
    ));
