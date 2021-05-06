import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ConnexionRequired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: new EdgeInsets.all(10.0),
      margin: new EdgeInsets.only(bottom: 15.0),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
          // color: Colors.green[100],
          border: Border(
        top: BorderSide(color: Colors.lightGreen[400], width: 2.0),
        bottom: BorderSide(color: Colors.lightGreen[400], width: 2.0),
        left: BorderSide(color: Colors.lightGreen[400], width: 2.0),
        right: BorderSide(color: Colors.lightGreen[400], width: 2.0),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'S\'il vous plaît! \nIdentifiez-Vous d\'abord',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SpinKitCubeGrid(
              color: Colors.lightGreen[400],
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
