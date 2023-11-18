import 'package:flutter/material.dart';
import './pages/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bottom Navbar Demo",
      debugShowCheckedModeBanner: false,
      home: const Index(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 255, 255),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
    );
  }
}
