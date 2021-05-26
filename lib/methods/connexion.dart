import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ConnexionRequired extends StatelessWidget {
  String title;
  ConnexionRequired({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: new EdgeInsets.all(10.0),
      margin: new EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.grey.shade300),
        bottom: BorderSide(color: Colors.grey.shade300),
        left: BorderSide(color: Colors.grey.shade300),
        right: BorderSide(color: Colors.grey.shade300),
      )),
      child: Column(
        children: [
          Row(
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
                child: SpinKitCircle(
                  color: Colors.lightBlue,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
