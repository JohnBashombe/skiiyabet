import 'package:flutter/material.dart';
import 'app/skiiyaBet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // THIS IS THE MAIN METHOD FOR SKIIYA BET
    // FIREBASE INIT - FLUTTER BUILD WEB - FIREBASE SERVE - FIREBASE DEPLOY 
    return MaterialApp( 
      title: 'SKIIYA Bet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'ROBOTO',
      ),
      home: SkiiyaBet(),
    );
  }
}
