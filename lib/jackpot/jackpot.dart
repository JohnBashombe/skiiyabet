import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/jackpot/data.dart';

class Jackpot extends StatefulWidget {
  @override
  _JackpotState createState() => _JackpotState();
}

// STORES ALL JACKPOTS DETAILS
var _jackpotGame;

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
          if (_jackpotGame != null)
            for (int i = 0; i < _jackpotGame['matches']['data'].length; i++)
              jackpotWidget(i),

          if (_jackpotGame == null)
            Center(
                child: SpinKitCircle(
              color: Colors.lightBlue,
              size: 20.0,
            )),
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
          SizedBox(height: 10.0),
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

  @override
  void initState() {
    // LOAD THE JACKPOT FROM THE DATABASE
    // ASSIGN THE DATA VALUES TO THE JACKPOT ARRAY
    _jackpotGame = JackPots.data;
    // print(_jackpotGame);
    super.initState();
  }

  Column jackpotWidget(int _index) {
    // WE STORE THE DETAILS OF THE GAME HERE
    // LET US GET THE TOTAL LENGTH OF DATA
    int _len = _jackpotGame['matches']['data'].length;
    // var gameDetails = _jackpotGame[_index];
    var _gameID = _jackpotGame['matches']['data'][_index]['id'];
    // LOCAL TEAM GAME
    var _localTeam = _jackpotGame['matches']['data'][_index]['localTeam'];
    // VISTOR TEAM OF GAME
    var _visitorTeam = _jackpotGame['matches']['data'][_index]['visitorTeam'];
    // GET THE DATE TIME
    var _dateTime = _jackpotGame['matches']['time'][_index]['date_time'];
    // GET THE GAME CHAMPIONSHIP
    var _championship =
        _jackpotGame['matches']['location'][_index]['championship'];
    // GETTING THE COUNTRY
    var _country = _jackpotGame['matches']['location'][_index]['country'];
    // WE GET THE CHOICE 1
    bool choice1 = _jackpotGame['matches']['choices'][_index]['1'];
    bool choiceX = _jackpotGame['matches']['choices'][_index]['x'];
    bool choice2 = _jackpotGame['matches']['choices'][_index]['2'];
    // THESE ARE BUTTON COLORS
    Color _colorButton1 = choice1 ? Colors.black87 : Colors.grey.shade200;
    Color _colorButtonX = choiceX ? Colors.black87 : Colors.grey.shade200;
    Color _colorButton2 = choice2 ? Colors.black87 : Colors.grey.shade200;
    // THESE ARE TEXT BUTTON COLORS
    Color _textButton1 = choice1 ? Colors.white : Colors.black87;
    Color _textButtonX = choiceX ? Colors.white : Colors.black87;
    Color _textButton2 = choice2 ? Colors.white : Colors.black87;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _localTeam.toString() + ' vs ' + _visitorTeam.toString(),
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
                    _dateTime.toString() +
                        ' - ' +
                        _country.toString() +
                        ' - ' +
                        _championship,
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
                onPressed: () {
                  print('Clicking on choice 1 : $_gameID');
                },
                fillColor: _colorButton1,
                disabledElevation: 3.0,
                padding: new EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '1'.toUpperCase(),
                  style: TextStyle(
                    color: _textButton1,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: RawMaterialButton(
                mouseCursor: SystemMouseCursors.click,
                onPressed: () {
                  print('Clicking on choice X : $_gameID');
                },
                fillColor: _colorButtonX,
                disabledElevation: 3.0,
                padding: new EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'x'.toUpperCase(),
                  style: TextStyle(
                    color: _textButtonX,
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
                onPressed: () {
                  print('Clicking on choice 2 : $_gameID');
                },
                fillColor: _colorButton2,
                disabledElevation: 3.0,
                padding: new EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '2'.toUpperCase(),
                  style: TextStyle(
                    color: _textButton2,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            )
          ],
        ),
        // DO NOT ADD THE DIVIDER WIDGET AT THE END OF THE LAST ELEMENT
        if (_index < (_len - 1))
          Column(
            children: [
              SizedBox(height: 5.0),
              Divider(color: Colors.grey.shade300, thickness: 0.5),
              SizedBox(height: 5.0),
            ],
          ),
      ],
    );
  }
}
