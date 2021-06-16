import 'dart:math';

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
// LET US GET THE TICKET PRICE BASED ON SELECTION
double _ticketPrice = 0.0;

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
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Jackpot',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'Résultats',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'Mon Compte',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'Règles',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Divider(
            color: Colors.grey.shade300,
            thickness: 0.5,
          ),
          SizedBox(height: 5.0),
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
                          _jackpotGame != null
                              ? _jackpotGame['time']['date'].toString() +
                                  ' ' +
                                  _jackpotGame['description']['name']
                                      .toString() +
                                  ' - ' +
                                  _jackpotGame['description']['bet_type']
                                      .toString()
                                      .toUpperCase()
                              : 'chargement...',
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
                          _jackpotGame != null
                              ? _jackpotGame['time']['time'].toString()
                              : 'chargement...',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _jackpotGame != null
                              ? _jackpotGame['time']['date'].toString()
                              : 'chargement...',
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
                        onPressed: () {
                          // PICK A RANDOM SELECTION FOR FASTER BETTING
                          randomPick();
                        },
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
                    _jackpotGame != null
                        ? _jackpotGame['description']['description'].toString()
                        : 'chargement...',
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
          SizedBox(height: 15.0),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                unselect_all_games();
                // print('Cleaning the jackpot betslip');
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
                    Price.getWinningValues(Price.jackpotStake),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
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
                _ticketCounter().toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          // Divider(color: Colors.grey.shade300, thickness: 0.5),
          // SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prix Total',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                Price.currency_symbol +
                    ' ' +
                    Price.getWinningValues(_ticketPrice),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.0,
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
                onPressed: () {
                  print('Buying the ticket');
                },
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
              )),
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
    // var _gameID = _jackpotGame['matches']['data'][_index]['id'];
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
                        _championship.toString(),
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
                  // print('Clicking on choice 1 : $_gameID');
                  if (mounted)
                    setState(() {
                      // IF THIS BUTTON IS ACTIVATED
                      if (_jackpotGame['matches']['choices'][_index]['1'] ==
                          true) {
                        // DE-ACTIVATE IT
                        _jackpotGame['matches']['choices'][_index]['1'] = false;
                      } else {
                        // OTHERWISE ACTIVATE IT
                        _jackpotGame['matches']['choices'][_index]['1'] = true;
                      }
                    });
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
                  // print('Clicking on choice X : $_gameID');
                  if (mounted)
                    setState(() {
                      // IF THIS BUTTON IS ACTIVATED
                      if (_jackpotGame['matches']['choices'][_index]['x'] ==
                          true) {
                        // DE-ACTIVATE IT
                        _jackpotGame['matches']['choices'][_index]['x'] = false;
                      } else {
                        // OTHERWISE ACTIVATE IT
                        _jackpotGame['matches']['choices'][_index]['x'] = true;
                      }
                    });
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
                  // print('Clicking on choice 2 : $_gameID');
                  if (mounted)
                    setState(() {
                      // IF THIS BUTTON IS ACTIVATED
                      if (_jackpotGame['matches']['choices'][_index]['2'] ==
                          true) {
                        // DE-ACTIVATE IT
                        _jackpotGame['matches']['choices'][_index]['2'] = false;
                      } else {
                        // OTHERWISE ACTIVATE IT
                        _jackpotGame['matches']['choices'][_index]['2'] = true;
                      }
                    });
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

  int _ticketCounter() {
    // COUNT THE NUMBER OF TICKETS
    int _thisCounter = 0;
    // INCREASER OF THE NUMBER OF TICKETS
    int _increaser = 0;
    // CHECK IF WE HAVE ALL GAMES SELECTED BEFORE ADDING THE NUMBER OF TICKETS
    if (all_games_selected()) {
      // SET THE COUNTER TO ONE IF ALL GAMES ARE SELECTED
      _thisCounter = 1;
      // INCREASE THE NUMBER OF TICKETS OF NEW SELECTIONS
      int _thisLenght = _jackpotGame['matches']['data'].length;
      // LOOP THROUGH ALL JACKPOT DATA
      for (int i = 0; i < _thisLenght; i++) {
        // INCREASE THE INCREASER
        if (_jackpotGame['matches']['choices'][i]['1'] == true) _increaser++;
        if (_jackpotGame['matches']['choices'][i]['x'] == true) _increaser++;
        if (_jackpotGame['matches']['choices'][i]['2'] == true) _increaser++;
      }
      // WE REDUCE THE NUMBER OF THE LENGHT OF AVALAIBLE GAMES BEFORE SUMMING UP
      _increaser = _increaser - _thisLenght;
    }
    // UPDATE THE COUNTER VARIABLE
    _thisCounter = _thisCounter + _increaser;
    // CONDITIONS
    if (_increaser > 0) {
      // INCREASE THE PRICE TIMES THE VALUE
      _ticketPrice = (Price.jackpotStake * pow(2, _increaser));
    } else {
      // GET THE NORMAL PRICE BASED ON THE COUNTER
      _ticketPrice = Price.jackpotStake * _thisCounter;
    }

    // RETURN THE SUM OF CURRENT SELCTION OR MORE IF ANY
    return _thisCounter;
  }

  // WILL CHECK IF ALL GAMES HAVE BEEN SELECTED BEFORE BUYING THE TICKET
  bool all_games_selected() {
    // GET THE NUMBER OF GAMES SELECTED
    bool _getSelected = true;
    // SETTING ALL VARIABLES TO FALSE TO UNSELECT THEM
    int _thisLenght = _jackpotGame['matches']['data'].length;
    // LOOP THROUGH ALL JACKPOT DATA
    for (int i = 0; i < _thisLenght; i++) {
      // CONDITION
      if (_jackpotGame['matches']['choices'][i]['1'] == false &&
          _jackpotGame['matches']['choices'][i]['x'] == false &&
          _jackpotGame['matches']['choices'][i]['2'] == false) {
        // SET THE FULL COMPLETION TO FALSE
        _getSelected = false;
        // BREAKE THE LOOP HERE
        break;
      }
    }
    return _getSelected;
  }

  void unselect_all_games() {
    if (mounted)
      setState(() {
        // SETTING ALL VARIABLES TO FALSE TO UNSELECT THEM
        int _thisLenght = _jackpotGame['matches']['data'].length;
        // LOOP THROUGH ALL JACKPOT DATA
        for (int i = 0; i < _thisLenght; i++) {
          // SET ALL THREE DATA INPUT TO FALSE
          _jackpotGame['matches']['choices'][i]['1'] = false;
          _jackpotGame['matches']['choices'][i]['x'] = false;
          _jackpotGame['matches']['choices'][i]['2'] = false;
        }
      });
  }

  void randomPick() {
    if (mounted)
      setState(() {
        // PICK A RANDOM SELECTION
        unselect_all_games();
        int _thisLenght = _jackpotGame['matches']['data'].length;
        // LOOP THROUGH ALL JACKPOT DATA
        for (int i = 0; i < _thisLenght; i++) {
          Random r = new Random();
          // GET ARANDOM INDEX HERE
          int _indexPicked = r.nextInt(3);
          // INCREASE THE INCREASER
          if (_indexPicked == 0)
            _jackpotGame['matches']['choices'][i]['1'] = true;
          if (_indexPicked == 1)
            _jackpotGame['matches']['choices'][i]['x'] = true;
          if (_indexPicked == 2)
            _jackpotGame['matches']['choices'][i]['2'] = true;
        }
      });
  }
}
