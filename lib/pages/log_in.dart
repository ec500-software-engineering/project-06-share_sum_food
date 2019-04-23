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
  AuthStatus status = AuthStatus.SOCIAL_AUTH;

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

  GoogleSignInAccount _googleAccount;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  }

  //Have snack bar to display error
  showErrorSnackbar(String msg){
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
    if (userIsValid) {
      setState(() {
        // Here we change the status once more to guarantee that the SMS's
        // text input isn't available while you do any other request
        // with the gathered data
        this.status = AuthStatus.PROFILE_AUTH;
        Logger.log(TAG, message: "Changed status to $status");
      });
    }
    else {
      showErrorSnackbar("We couldn't verify your code, please try again!");
    }
    return userIsValid;
  }

  Future<Null> _signIn() async{
    GoogleSignInAccount user = _googleSignIn.currentUser;
    Logger.log(TAG, message: "New Google user as: $user");

    //if there is an error message
    final onError = (exception, stacktrace){
      Logger.log(TAG, message: "Error from _signIn: $exception");
      showErrorSnackbar(
          "Couldn't log in with your Google account, please try again!");
      user = null;
    };

    //handle sign in plz
    if (user == null){
      user = await _googleSignIn.signIn().catchError(onError);
      Logger.log(TAG, message: "Received $user");
      final GoogleSignInAuthentication googleAuth = await user.authentication;
      Logger.log(TAG, message: "Added googleAuth: $googleAuth");
      await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken))
          .catchError(onError);
    }

    if (user != null) {
      _updateRefreshing(false);
      this._googleAccount = user;
      setState(() {
        this.status = AuthStatus.PHONE_AUTH;
        Logger.log(TAG, message: "Changed status to $status");
      });
      return null;
    }
    return null;
  }

  Future<Null> _onRefresh() async {
    switch (this.status) {
      case AuthStatus.SOCIAL_AUTH:
        return await _signIn();
        break;
      case AuthStatus.PHONE_AUTH:
        return await _submitPhoneNumber();
        break;
      case AuthStatus.SMS_AUTH:
        return await _submitSmsCode();
        break;
      case AuthStatus.PROFILE_AUTH:
        break;
    }
  }

  Widget _buildBody() {
    Widget body;
    switch (this.status) {
      case AuthStatus.SOCIAL_AUTH:
        body = _buildSocialLoginBody();
        break;
      case AuthStatus.PHONE_AUTH:
        body = _buildPhoneAuthBody();
        break;
      case AuthStatus.SMS_AUTH:
      case AuthStatus.PROFILE_AUTH:
        body = _buildSmsAuthBody();
        break;
    }
    return body;
  }
}
