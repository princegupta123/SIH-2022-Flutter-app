import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  //const ForgotPassword({Key? key}) : super(key: key);
  static const routeName = '/forgotpassword';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('first verify mobile no with otp then you can reset password ..'),)
    );
  }
}
