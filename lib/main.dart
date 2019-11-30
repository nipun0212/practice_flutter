import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice_flutter/login/login.dart';
import 'package:practice_flutter/login/otp.dart';
import 'package:practice_flutter/sample.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login': (context) => Login(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/otp': (context) => OTP(),
          '/counter': (context) => Counter()
        },
        title: "Reward Magement",
        home: Login());
  }
}
