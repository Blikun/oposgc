
import 'package:flutter/material.dart';
import 'package:opos/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OposiTesis G.C.",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: WelcomeScreen(),  // NAVEGADOR SPLASH_SCREEN
    );
  }
}