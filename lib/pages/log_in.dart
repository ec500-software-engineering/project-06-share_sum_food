import 'package:flutter/material.dart';
import 'package:share_sum_food/pages/menu_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_sum_food/widgets/masked_text.dart';
import 'package:flutter/cupertino.dart';
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
  String _errorMessage;
  String _phoneNumber;
  String _verificationId;
  Timer _timer;
  // Styling

  final decorationStyle = TextStyle(color: Colors.grey[50], fontSize: 16.0);
  final hintStyle = TextStyle(color: Colors.white24);

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
  // PhoneVerificationCompleted
  verificationCompleted(FirebaseUser user) async {
    Logger.log(TAG, message: "onVerificationCompleted, user: $user");
    if (await onCodeVerified(user)) {
      await _finishSignIn(user);
    } else {
      setState(() {
        this.status = AuthStatus.SMS_AUTH;
        Logger.log(TAG, message: "Changed status to $status");
      });
    }
  }

  // PhoneVerificationFailed
  verificationFailed(AuthException authException) {
    showErrorSnackbar(
        "We couldn't verify your code for now, please try again!");
    Logger.log(TAG,
        message:
        'onVerificationFailed, code: ${authException.code}, message: ${authException.message}');
  }

  // PhoneCodeSent
  codeSent(String verificationId, [int forceResendingToken]) async {
    Logger.log(TAG,
        message:
        "Verification code sent to number ${phoneNumberController.text}");
    _timer = Timer(_timeOut, () {
      setState(() {
        _codeTimedOut = true;
      });
    });
    _updateRefreshing(false);
    setState(() {
      this._verificationId = verificationId;
      this.status = AuthStatus.SMS_AUTH;
      Logger.log(TAG, message: "Changed status to $status");
    });
  }

  // PhoneCodeAutoRetrievalTimeout
  codeAutoRetrievalTimeout(String verificationId) {
    Logger.log(TAG, message: "onCodeTimeout");
    _updateRefreshing(false);
    setState(() {
      this._verificationId = verificationId;
      this._codeTimedOut = true;
    });
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

  _finishSignIn(FirebaseUser user) async {
    await _onCodeVerified(user).then((result) {
      if (result) {
        // Here, instead of navigating to another screen, you should do whatever you want
        // as the user is already verified with Firebase from both
        // Google and phone number methods
        // Example: authenticate with your own API, use the data gathered
        // to post your profile/user, etc.

        Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (context) => MainScreen(
            googleUser: _googleUser,
            firebaseUser: user,
          ),
        ));
      } else {
        setState(() {
          this.status = AuthStatus.SMS_AUTH;
        });
        showErrorSnackbar(
            "We couldn't create your profile for now, please try again later");
      }
    });
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
  Future<Null> _submitSmsCode() async {
    final error = _smsInputValidator();
    if (error != null) {
      _updateRefreshing(false);
      showErrorSnackbar(error);
      return null;
    } else {
      if (this._codeVerified) {
        await _finishSignIn(await _auth.currentUser());
      } else {
        Logger.log(TAG, message: "_signInWithPhoneNumber called");
        await _signInWithPhoneNumber();
      }
      return null;
    }
  }

  Future<void> _signInWithPhoneNumber() async {
    final errorMessage = "We couldn't verify your code, please try again!";

    await _auth
        .linkWithCredential(
      PhoneAuthProvider.getCredential(
        verificationId: _verificationId,
        smsCode: smsCodeController.text,
      ),
    )
        .then((user) async {
      await _onCodeVerified(user).then((codeVerified) async {
        this._codeVerified = codeVerified;
        Logger.log(
          TAG,
          message: "Returning ${this._codeVerified} from _onCodeVerified",
        );
        if (this._codeVerified) {
          await _finishSignIn(user);
        } else {
          showErrorSnackbar(errorMessage);
        }
      });
    }, onError: (error) {
      print("Failed to verify SMS code: $error");
      showErrorSnackbar(errorMessage);
    });
  }

  Future<bool> _onCodeVerified(FirebaseUser user) async {
    final isUserValid = (user != null &&
        (user.phoneNumber != null && user.phoneNumber.isNotEmpty));
    if (isUserValid) {
      setState(() {
        // Here we change the status once more to guarantee that the SMS's
        // text input isn't available while you do any other request
        // with the gathered data
        this.status = AuthStatus.PROFILE_AUTH;
        Logger.log(TAG, message: "Changed status to $status");
      });
    } else {
      showErrorSnackbar("We couldn't verify your code, please try again!");
    }
    return isUserValid;
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

  Future<Null> _submitPhoneNumber() async {
    final error = _phoneInputValidator();
    if (error != null) {
      _updateRefreshing(false);
      setState(() {
        _errorMessage = error;
      });
      return null;
    } else {
      _updateRefreshing(false);
      setState(() {
        _errorMessage = null;
      });
      final result = await _verifyPhoneNumber();
      Logger.log(TAG, message: "Returning $result from _submitPhoneNumber");
      return result;
    }
  }

  String get phoneNumber {
    try {
      String unmaskedText = _maskedPhoneKey.currentState?.unmaskedText;
      if (unmaskedText != null) _phoneNumber = "+55$unmaskedText".trim();
    } catch (error) {
      Logger.log(TAG,
          message: "Couldn't access state from _maskedPhoneKey: $error");
    }
    return _phoneNumber;
  }

  Future<Null> _verifyPhoneNumber() async {
    Logger.log(TAG, message: "Got phone number as: ${this.phoneNumber}");
    await _auth.verifyPhoneNumber(
        phoneNumber: this.phoneNumber,
        timeout: _timeOut,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed);
    Logger.log(TAG, message: "Returning null from _verifyPhoneNumber");
    return null;
  }


}
