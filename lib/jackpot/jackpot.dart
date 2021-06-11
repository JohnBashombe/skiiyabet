import 'package:flutter/material.dart';
import 'package:skiiyabet/components/price.dart';

class Jackpot extends StatefulWidget {
  @override
  _JackpotState createState() => _JackpotState();
}

class _JackpotState extends State<Jackpot> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          )),
      padding: new EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 10.0),
      child: ListView(
        children: [
          Container(
            padding: new EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.transparent),
                bottom: BorderSide(color: Colors.transparent),
                left: BorderSide(color: Colors.transparent),
                right: BorderSide(color: Colors.transparent),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.2, 0.5, 0.7, 0.9],
                colors: [
                  Colors.yellow[800],
                  Colors.yellow[700],
                  Colors.yellow[600],
                  Colors.yellow[500],
                  Colors.yellow[400],
                ],
              ),
              // color: Colors.grey.shade300,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Price.currency_symbol +
                              ' ' +
                              Price.getWinningValues(
                                  Price.jackpotWinningAmount),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text( 
                          '12-06-2021 Choisir 17 - 1x2',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '14:00:00',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '12-06-2021',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: RawMaterialButton(
                        mouseCursor: SystemMouseCursors.click,
                        padding: new EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        onPressed: null,
                        disabledElevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: Colors.black87,
                        child: Text(
                          'Choix aléatoire'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    'Choisir 17 équipes gagnantes',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Matches',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sélections',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 0.5,
          ),
          // SizedBox(height: 10.0),
          jackpotWidget(),
          jackpotWidget(),
          // SizedBox(height: 5.0),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                print('Cleaning the jackpot betslip');
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'Tout Supprimer',
                  style: TextStyle(
                    color: Colors.orange[600],
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Divider(color: Colors.grey.shade300, thickness: 0.5),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prix du Ticket:',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                Price.currency_symbol +
                    ' ' +
                    Price.getWinningValues(Price.jackpotMinimumBet),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nombre de Tickets:',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '2',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Divider(color: Colors.grey.shade300, thickness: 0.5),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Paiement Total'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                Price.currency_symbol +
                    ' ' +
                    Price.getWinningValues(Price.jackpotWinningAmount),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Divider(color: Colors.grey.shade300, thickness: 0.5),
          SizedBox(height: 15.0),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              mouseCursor: SystemMouseCursors.click,
              padding: new EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 15.0,
              ),
              onPressed: null,
              disabledElevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              fillColor: Colors.black87,    
              child: Text(   
                'Acheter le billet'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,  
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    ));
  }

  Column jackpotWidget() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Motedio Yamagata - Mito HollyHock',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '1:00 PM / Sat, 7/11 - Japan J-League Division 2',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: RawMaterialButton(
                mouseCursor: SystemMouseCursors.click,
                onPressed: null,
                fillColor: Colors.black87,
                disabledElevation: 3.0,
                padding:
                    new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '1'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      letterSpacing: 0.5),
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: RawMaterialButton(
                mouseCursor: SystemMouseCursors.click,
                onPressed: null,
                fillColor: Colors.grey.shade200,
                disabledElevation: 3.0,
                padding:
                    new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'x'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: RawMaterialButton(
                mouseCursor: SystemMouseCursors.click,
                onPressed: null,
                fillColor: Colors.grey.shade200,
                disabledElevation: 3.0,
                padding:
                    new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '2'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      letterSpacing: 0.5),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey.shade300, thickness: 0.5),
        SizedBox(height: 5.0),
      ],
    );
  }
}
