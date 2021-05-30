import 'package:flutter/material.dart';
import 'app/skiiyaBet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // THIS IS THE MAIN METHOD FOR SKIIYA BET
    return MaterialApp(
      title: 'SkiiYa Bet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'ROBOTO',
      ),
      home: SkiiyaBet(),
    );
  }
}
