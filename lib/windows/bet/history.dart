import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/database/price.dart';
import 'package:skiiyabet/database/selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skiiyabet/methods/connexion.dart';

// this controlls the scrolling and loading more bets
ScrollController _scrollController = new ScrollController();
// array that hold values from loading
var _transactionLoader = [];
var _transactionDisplay = [];
// this indicates the one time loading limit
int transactionLoadLimit = 25;
// this display the game details or game List
// the game index to load details
int _detailIndex;
// store games and details from betslip
var betGameDetails = [];

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isDetailVisible = false;
  bool _isHistoryEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
            left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
        padding: new EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
            right: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Selection.user != null
            ?
            // display my bets list here
            !isDetailVisible
                ? myBetsView(context)
                : showFullBetDetails()
            :
            // ask the user to login first
            askLoginFirst(),
      ),
    );
  }

  Widget showFullBetDetails() {
    // this method display all games details within the Games Details
    Color colorTxt;
    String result = _transactionDisplay[_detailIndex]['result'];
    if (result.compareTo('won') == 0) {
      colorTxt = Colors.lightGreen[400];
    } else if (result.compareTo('lost') == 0) {
      colorTxt = Colors.red;
    } else {
      colorTxt = Colors.grey;
    }
    // print('Data to display: ${_transactionDisplay[index].data}');
    String minutes =
        _transactionDisplay[_detailIndex]['time'][1].toString().length > 1
            ? _transactionDisplay[_detailIndex]['time'][1].toString()
            : '0' + _transactionDisplay[_detailIndex]['time'][1].toString();
    // that's total rate
    double tR =
        double.parse(_transactionDisplay[_detailIndex]['totalRate'].toString());
    String totalRate = tR.toStringAsFixed(2);
    // that's user stake
    // double st = _transactionDisplay[_detailIndex]['stake'];
    // String stake = st.toStringAsFixed(2);
    // total Payout
    // double tP = _transactionDisplay[_detailIndex]['totalPayout'];
    // String totalPayout = tP.toStringAsFixed(2);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height - 240.0,
            child: Column(
              // padding: EdgeInsets.only(top: 0.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        if (mounted)
                          setState(() {
                            isDetailVisible = false;
                          });
                      },
                    ),
                    Container(
                      // width: 15.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 2.0),
                          bottom: BorderSide(color: Colors.grey, width: 2.0),
                          left: BorderSide(color: Colors.grey, width: 2.0),
                          right: BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        // color: Colors.lightBlue,
                      ),
                      child: Text(
                        _transactionDisplay[_detailIndex]['gameIDs']
                            .length
                            .toString(),
                        // (BetSlipData.gameIds.length.toString()),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Divider(color: Colors.grey, thickness: 0.4),
                // top row containing column decsription
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold)),
                    Text('Détails de l\'historique',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold)),
                    Text('Chances',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5.0),
                Divider(color: Colors.grey, thickness: 0.5),
                SizedBox(height: 5.0),
                // to hold all games details and results
                betGameDetails.length > 0
                    ? Column(
                        children: betGameDetails
                            .asMap()
                            .entries
                            .map(
                              (MapEntry map) => gamesFromBetslip(map.key),
                            )
                            .toList(),
                      )
                    : Center(
                        child: Text(
                          'chargement...',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                // Column(
                //   children: [
                //     gamesFromBetslip(),
                //   ],
                // ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Taux Total:',
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              Text(
                totalRate.toString(),
                // '162 115.50',
                style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 13.0),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mon Montant:',
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              Text(
                Price.getWinningValues(
                        _transactionDisplay[_detailIndex]['stake']) +
                    ' Fc',
                // stake.toString() + ' Fc',
                // '100.00 FC',
                style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 13.0),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mon Gain:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Price.getWinningValues(
                        _transactionDisplay[_detailIndex]['totalPayout']) +
                    ' Fc',
                // totalPayout.toString() + ' Fc',
                // '173 427.87 Fc',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Divider(color: Colors.grey, thickness: 0.5),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Résultat:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                result.toString().compareTo('pending') == 0
                    ? 'En attente'.toUpperCase()
                    : (result.toString().compareTo('won') == 0
                        ? 'Gagné'.toUpperCase()
                        : 'Perdu'.toUpperCase()),
                // 'Lost'.toUpperCase(),
                style: TextStyle(
                  color: colorTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Divider(color: Colors.grey, thickness: 0.5),
          // SizedBox(height: 5.0),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Pari placé le ' +
                  _transactionDisplay[_detailIndex]['date'][1].toString() +
                  '/' +
                  _transactionDisplay[_detailIndex]['date'][2].toString() +
                  '/' +
                  _transactionDisplay[_detailIndex]['date'][3].toString() +
                  ' à ' +
                  _transactionDisplay[_detailIndex]['time'][0].toString() +
                  ':' +
                  minutes +
                  ' ' +
                  _transactionDisplay[_detailIndex]['time'][2].toString(),
              // 'Bet placed on 23/11/2020 at 12:34 PM',
              style: TextStyle(color: Colors.grey, fontSize: 11.0),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.clock, size: 16.0, color: Colors.grey),
              SizedBox(width: 3.0),
              Text('En attente',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0)),
              SizedBox(width: 8.0),
              Icon(FontAwesomeIcons.checkCircle,
                  size: 16.0, color: Colors.lightGreen),
              SizedBox(width: 3.0),
              Text('Gagné',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0)),
              SizedBox(width: 8.0),
              Icon(FontAwesomeIcons.timesCircle,
                  size: 16.0, color: Colors.redAccent),
              SizedBox(width: 3.0),
              Text('Perdu',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0)),
              SizedBox(width: 8.0),
              Icon(FontAwesomeIcons.minus, size: 16.0, color: Colors.orange),
              SizedBox(width: 3.0),
              Text('Annulé',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ],
          )
        ],
      ),
    );
  }

  Column gamesFromBetslip(int index) {
    // print(betGameDetails[index].documentID);
    // get time variables
    String hour = betGameDetails[index]['time']['1'];
    String min = betGameDetails[index]['time']['2'];
    String timeIndicator = betGameDetails[index]['time']['3'];
    // get date variables
    // String day = betGameDetails[index]['date']['1'].toString();
    String mydate = betGameDetails[index]['date']['2'];
    String month = betGameDetails[index]['date']['3'];
    String year = betGameDetails[index]['date']['4'];

    // get the status needed for the icon color and type
    // print(betGameDetails[index]['result']);
    // print(betGameDetails[index]['status']);
    // double singleRate = _transactionDisplay[_detailIndex]['gameRates'][index];
    // String gameRate = _transactionDisplay[_detailIndex]['gameRates'][index].toStringAsFixed(2);
    // get the status needed for the icon color and type
    // load all ids within the betslip
    var getBetslipIDs = [];
    getBetslipIDs = _transactionDisplay[_detailIndex]['gameIDs'];
    // get the index of a particular ID
    // _transactindisplay loads betslips
    // betgameDetails loads ganeHistory -
    // print(_transactionDisplay[_detailIndex]['gameIDs']);
    int positionId =
        getBetslipIDs.indexOf(betGameDetails[index]['gameID'].toString());
    // print('The position is: $positionId');
    // should use result from betslip for this prticular game
    String statusGame =
        _transactionDisplay[_detailIndex]['gameResults'][positionId].toString();
    // String statusGame = betGameDetails[index]['status'].toString();
    // print('the result of this game is: $statusGame');
    Icon icon;
    Color color;
    if (betGameDetails[index]['status'].toString().compareTo('cancelled') ==
        0) {
      icon = Icon(FontAwesomeIcons.minus);
      color = Colors.orange;
    } else {
      if (statusGame.compareTo('null') == 0) {
        icon = Icon(FontAwesomeIcons.clock);
        color = Colors.grey;
      }
      if (statusGame.compareTo('true') == 0) {
        icon = Icon(FontAwesomeIcons.checkCircle);
        color = Colors.lightGreen[400];
      }
      if (statusGame.compareTo('false') == 0) {
        icon = Icon(FontAwesomeIcons.timesCircle);
        color = Colors.red;
      }
      if (statusGame.compareTo('cancelled') == 0) {
        icon = Icon(FontAwesomeIcons.minus);
        color = Colors.orange;
      }
    }
    // display score if not null
    String score1 =
        _transactionDisplay[_detailIndex]['gameScoreTeam1'][index].toString();
    String score2 =
        _transactionDisplay[_detailIndex]['gameScoreTeam2'][index].toString();

    if (score1.compareTo('null') == 0) score1 = '?';
    if (score2.compareTo('null') == 0) score2 = '?';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    // day + '/' +
                    mydate + '/' + month + '/' + year,
                    // '23/12/2020',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                SizedBox(height: 2.0),
                Text(hour + ':' + min + ' ' + timeIndicator,
                    // '12:53 AM',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    )),
              ],
            ),
            SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: ResponsiveWidget.isExtraSmallScreen(context)
                      ? 120
                      : ResponsiveWidget.isSmallScreen(context)
                          ? 170
                          : 200,
                  child: Text(
                    betGameDetails[index]['team1'] +
                        ' - ' +
                        betGameDetails[index]['team2'],
                    // 'Hatayspor - Balikesirspor',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      // fontWeight: FontWeight.bold,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(height: 1.0),
                Container(
                  alignment: Alignment.centerLeft,
                  width: ResponsiveWidget.isExtraSmallScreen(context)
                      ? 120
                      : ResponsiveWidget.isSmallScreen(context)
                          ? 170
                          : 200,
                  child: Text(
                    betGameDetails[index]['type'] +
                        ' - ' +
                        betGameDetails[index]['championship'],
                    // 'Football - Turkey - 1. Lig',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 1.0),
                Text(
                  _transactionDisplay[_detailIndex]['gameChoices'][index],
                  // '1x2 - FT [ 1 ]'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  score1 + '-' + score2,
                  // '3-0',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.0),
                Icon(icon.icon, size: 18.0, color: color),
                SizedBox(height: 2.0),
                Text(
                  _transactionDisplay[_detailIndex]['gameRates'][index]
                      .toStringAsFixed(2),
                  // '2.10',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey, thickness: 0.4),
        SizedBox(height: 5.0),
      ],
    );
  }

  Center askLoginFirst() {
    return Center(
      child: ConnexionRequired(),
    );
  }

  Column myBetsView(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date - Heure',
                style: TextStyle(color: Colors.grey, fontSize: 13.0)),
            Text('Détails de mon pari',
                style: TextStyle(color: Colors.grey, fontSize: 13.0)),
            Text('Résultat',
                style: TextStyle(color: Colors.grey, fontSize: 13.0)),
          ],
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey, thickness: 0.4),
        SizedBox(height: 5.0),
        _transactionDisplay.length > 0
            ? Container(
                height: ResponsiveWidget.isSmallScreen(context)
                    ? MediaQuery.of(context).size.height - 240.0
                    : MediaQuery.of(context).size.height - 170.0,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _transactionDisplay.length,
                  itemBuilder: (context, index) {
                    return myBetsWidget(context, index);
                  },
                ),
              )
            : Center(
                child: Column(
                  children: [
                    if (_isHistoryEmpty)
                      Text('Aucune donnée disponible',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          )),
                    if (_isHistoryEmpty) SizedBox(height: 5.0),
                    SpinKitCubeGrid(
                      color: Colors.lightGreen[400],
                      size: 20.0,  
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  @override
  void initState() {
    // initially load transactions with no condition
    loadBetslip(transactionLoadLimit);
    super.initState();

    //listen to body scrolling and execute itself
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Future thisData;
        // clear the loading array before adding new items
        // clear everything before adding new items
        // _transactionLoader.clear();
        // load more data + condition to filter games already loaded
        transactionLoadLimit = transactionLoadLimit + 1;
        if (mounted)
          setState(() {
            // execute this method so that new content can be added to the listview
            // secondly load transaction by listening to the scrolling view
            loadBetslip(transactionLoadLimit);
          });
      }
    });
  }

  Future loadBetslip(int limit) async {
    if (Selection.user != null) {
      String user = Selection.user.uid;
      // print('the user is : $user');
      // print('executing the loading transaction collection');
      var firestore = Firestore.instance;
      // QuerySnapshot qn;
      // load all transaction of the user
      // qn = await firestore
      await firestore
          .collection('BetSlip')
          .where('uid', isEqualTo: user.toString())
          .orderBy('sorter', descending: true)
          .limit(limit)
          .getDocuments()
          .then((result) {
        // delete all before adding new items
        _transactionLoader.clear();
        // print('FROM DB: $result');
        if (mounted)
          setState(() {
            // this condition will loop through all loaded elements
            for (var j = 0; j < result.documents.length; j++) {
              // this boolean validate if the item is not IN
              bool alreadyIn = false;
              // add the first elemets if display is empty
              if (_transactionLoader.length > 0) {
                // check if the elemet exists already in the array
                for (var i = 0; i < _transactionLoader.length; i++) {
                  if (_transactionLoader[i].documentID.toString().compareTo(
                          result.documents[j].documentID.toString()) ==
                      0) {
                    // set to true if the item exists already in the array
                    alreadyIn = true;
                    // print(_transactionLoader[i].documentID);
                    // }
                  }
                }
                // if the item does not exists in the array display then add it
                if (!alreadyIn) {
                  // show a game only if the status if different to pending.
                  if (result.documents[j]['status']
                          .toString()
                          .compareTo('pending') !=
                      0) {
                    // add the element after all checking otherwise nothing will be added
                    _transactionLoader.add(result.documents[j]);
                  }
                }
              } else {
                // show a game only if the status if different to pending.
                if (result.documents[j]['status']
                        .toString()
                        .compareTo('pending') !=
                    0) {
                  // add the first element to allow easy computing
                  _transactionLoader.add(result.documents[j]);
                }
              }
            }
          });
        return result;
      });
      // check if result is not empty to display "no data found"
      if (mounted)
        setState(() {
          if (_transactionLoader.length == 0) {
            _isHistoryEmpty = true;
          } else {
            _isHistoryEmpty = false;
          }
        });

      _transactionDisplay.clear();
      _transactionDisplay.addAll(_transactionLoader);
      // print('initial transaction to display is: $_transactionDisplay');
      // return qn.documents;
    }
  }

  Future _loadGameAfterGame(int index) async {
    // save the lenght of games in the betslip
    int _len = _transactionDisplay[_detailIndex]['gameIDs'].length;
    // print(index);
    var firestore = Firestore.instance;
    // QuerySnapshot qn;
    // load all transaction of the user
    // qn = await firestore
    //loop to get all needed games to display
    for (var j = 0; j < _len; j++) {
      // get specific game index
      String gameId = _transactionDisplay[_detailIndex]['gameIDs'][j];
      // print('Lenght is: ${_transactionDisplay[_detailIndex]['gameIDs'].length}');
      // print('Ids are: ${_transactionDisplay[_detailIndex]['gameIDs']}');
      await firestore
          .collection('GamesHistory')
          // .document(gameId)
          .where('gameID', isEqualTo: gameId)
          .getDocuments()
          .then((result) {
        // delete all before adding new items
        _transactionLoader.clear();
        // print('FROM DB: $result');
        if (mounted)
          setState(() {
            // add the fetch result to the array
            // betGameDetails.add(result);
            betGameDetails.add(result.documents[0]);
          });

        return result;
      });
    }

    // for()
  }

  Widget myBetsWidget(BuildContext context, int index) {
    // print('Data to display: ${_transactionDisplay[index].data}');
    String minutes = _transactionDisplay[index]['time'][1].toString().length > 1
        ? _transactionDisplay[index]['time'][1].toString()
        : '0' + _transactionDisplay[index]['time'][1].toString();
    // format the stake
    double s = double.parse(_transactionDisplay[index]['stake'].toString());
    String stake = s.toStringAsFixed(2);
    // format the payout
    double p =
        double.parse(_transactionDisplay[index]['totalPayout'].toString());
    String price = p.toStringAsFixed(2);
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (mounted)
                setState(() {
                  isDetailVisible = true;
                  _detailIndex = index;
                  // remove previous games to load new ones based on the betslip
                  betGameDetails.clear();
                  // load all games details from the database
                  _loadGameAfterGame(index);
                  // Window.showWindow = 15;
                  // Window.backToHistory = 0;
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => skiiyabet()));
                });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        // _transactionDisplay[index]['date'][0].toString() +
                        //     ' ' +
                        _transactionDisplay[index]['date'][1].toString() +
                            '/' +
                            _transactionDisplay[index]['date'][2].toString() +
                            '/' +
                            _transactionDisplay[index]['date'][3].toString(),
                        // '23/12/2020',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                    SizedBox(height: 2.0),
                    Text(
                        _transactionDisplay[index]['time'][0].toString() +
                            ':' +
                            minutes +
                            ' ' +
                            _transactionDisplay[index]['time'][2].toString(),
                        // '12:53 AM',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        )),
                  ],
                ),
                // SizedBox(height: 2.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Montant: ',
                          style: TextStyle(color: Colors.grey, fontSize: 11.0),
                        ),
                        Text(
                          stake.toString(),
                          // '100.00',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 4.0),
                    Row(
                      children: [
                        Text(
                          'Gain: ',
                          style: TextStyle(color: Colors.grey, fontSize: 11.0),
                        ),
                        Text(
                          price.toString(),
                          // '154034.00',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                !ResponsiveWidget.isExtraSmallScreen(context)
                    ? Text(
                        _transactionDisplay[index]['result']
                                    .toString()
                                    .compareTo('pending') ==
                                0
                            ? 'En attente'.toUpperCase()
                            : (_transactionDisplay[index]['result']
                                        .toString()
                                        .compareTo('won') ==
                                    0
                                ? 'Gagné'.toUpperCase()
                                : 'Perdu'.toUpperCase()),
                        // 'won or Lost...',
                        style: TextStyle(
                          color: _transactionDisplay[index]['result']
                                      .toString()
                                      .toLowerCase()
                                      .compareTo('won') ==
                                  0
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12.0,
                        ),
                      )
                    : Icon(Icons.more_vert,
                        size: 18.0, color: Colors.lightGreen[400]),
              ],
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey, thickness: 0.4),
        SizedBox(height: 5.0),
      ],
    );
  }
}
