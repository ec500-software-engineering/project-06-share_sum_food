import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/menu_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_sum_food/widgets/masked_text.dart';
import 'package:share_sum_food/widgets/reactive_refresh_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_sum_food/logger.dart';
import 'dart:async';

class LogIn extends StatefulWidget {
  @override
  State createState() => new LogInState();
}
enum AuthStatus { SOCIAL_AUTH, PHONE_AUTH, SMS_AUTH, PROFILE_AUTH }

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LogInState extends State with TickerProviderStateMixin {
  static const String TAG = "AUTH";

  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController smsCodeController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<MaskedTextFieldState> _maskedPhoneKey = new GlobalKey<MaskedTextFieldState>();
  //local control variables
  String _errorMsg;
  String _phoneNumber;
  String _verificationId;
  Timer _timer;

  bool _isRefreshing;
  bool _codeTimedOut;
  bool _codeVerified;
  Duration _timeOut = new Duration(minutes: 2);

  final FirebaseAuth _auth = FirebaseAuth.instance; //authentication engine
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  GoogleSignInAccount _googleAccoint;

  @override
  Widget build(BuildContext context) {

  }

  //Have snack bar to display error
  showError(String msg){
      _updateRefreshing(false);
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(msg)),
      );
  }

  //Automatic verification android phones
  verificationCompleted(FirebaseUser usr) async{
    Logger.log(TAG, message: "onVerificationCompleted, user: $usr");
//    if (await )
  }
  //ensure animations display when it should display
  _updateRefreshing(bool isRefreshing){
    Logger.log(TAG, message: "Setting _isRefreshing ($_isRefreshing) to $isRefreshing");
    if (_isRefreshing) {
      setState(() {
        this._isRefreshing = false;
      });
    }
    setState(() {
      this._isRefreshing = isRefreshing;
    });
  }

  //to handle the code verified object
  Future<bool> onCodeVerified(FirebaseUser usr) async{
    final userIsValid= (usr != null && (usr.phoneNumber != null && usr.phoneNumber.isNotEmpty));
    if (userIsValid){
      setState(() {

      });
    }
  }
}
