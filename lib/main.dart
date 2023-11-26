import 'package:flutter/material.dart';
import 'pages/introPages/welcome.dart';
import 'pages/introPages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}
