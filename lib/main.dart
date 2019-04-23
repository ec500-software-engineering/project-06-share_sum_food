import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/landing_page.dart';
import 'package:share_sum_food/pages/theme.dart';
import 'package:share_sum_food/pages/home_widget.dart';

bool loggedIn = false;

void main() => runApp(new MaterialApp(
      theme: appTheme,
      home: Home(),
    ));
