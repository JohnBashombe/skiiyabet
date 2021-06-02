import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skiiyabet/windows/bet/widget.dart';
import 'package:http/http.dart' as http;

// this display the game details or game List
// the game index to load details
int _detailIndex;

// CHECK THE NETWORK ISSUE
bool _isNoInternetNetwork = false;
// DISPLAY TRANSACTIONS
var _histData = [];
// TRANSACTION LIMITS
int _histLoadLimit = 15;
// CHECK FOR DATA DISPONIBILITY
bool _isNoHistData = false;

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // SWITCHING PANEL VARIABLE
  bool showDetailPanel = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
            left: 10.0,
            top: ResponsiveWidget.isSmallScreen(context) ? 0.0 : 10.0),
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Selection.user != null
            ? !showDetailPanel
                ? myHistView(context)
                : showFullBetDetails()
            : notLoggedInYetHeader('Mon historique'), // SHOW LOGIN REQUIREMENTS
      ),
    );
  }

  Widget showFullBetDetails() {
    // WE STORE DATA IN THE NEW ARRAY OF DATA
    var _histDetails = _histData[_detailIndex];
    // print(_histDetails);
    // print(_detailIndex);
    // this method display all games details within the Games Details
    Color _colorItem;

    String _status = _histDetails['status'].toString();
    if (_status.compareTo('won') == 0) {
      _colorItem = Colors.lightGreen[400];
    } else if (_status.compareTo('lost') == 0) {
      _colorItem = Colors.red.shade300;
    } else if (_status.compareTo('cancelled') == 0) {
      _colorItem = Colors.orange.shade300;
    } else {
      _colorItem = Colors.grey;
    }

    // GET THE TIME
    var _time = _histDetails['time']['time'];
    // GET THE DATE
    var _date = _histDetails['time']['date'];
    // GET THE STAKE OF THE TICKET
    var _stake = _histDetails['rewards']['stake'];
    // GET THE CURRENCY SYMBOL
    var _currency = _histDetails['rewards']['currency'];
    // GET THE LENGTH OF THE THE ARRAY
    int _lenMatch = _histDetails['matches']['gameIDs'].length;
    // TOTAL RATE
    var _totalRate = _histDetails['rewards']['odds'];
    // GET THE BONUS AMOUNT
    var _toatalWinning = _histDetails['rewards']['winning'];
    // GET THE BONUS AMOUNT
    var _bonus = _histDetails['rewards']['bonus'];
    // GET THE TOTAL PAYOUT
    var _payout = _histDetails['rewards']['payout'];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height - 240.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        if (mounted)
                          setState(() {
                            // WE SET THE VARIABLE TO FALSE TO DISPLAY THE FULL LIST OF DATA
                            showDetailPanel = false;
                          });
                      },
                    ),
                    displayTicketLength(_lenMatch),
                  ],
                ),
                SizedBox(height: 10.0),
                // top row containing column decsription
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tous les détails du pari',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Divider(color: Colors.grey, thickness: 0.5),
                SizedBox(height: 5.0),
                // LOOP THROUGH DATA TO DISPLAY THE CONTENT
                for (int _i = 0; _i < _lenMatch; _i++) gamesFromTicket(_i),
              ],
            ),
          ),
          bottomData(_totalRate, _currency, _stake, _toatalWinning, _bonus,
              _payout, _status, _colorItem, _date, _time),
        ],
      ),
    );
  }

  Column gamesFromTicket(int _index) {
    // WE STORE DATA IN THE NEW ARRAY OF DATA
    var _histDetails = _histData[_detailIndex];
    // GET THE TIME
    var _time =
        _histDetails['matches']['dataTimes'][_index]['starting_at']['time'];
    // GET THE DATE
    var _date =
        _histDetails['matches']['dataTimes'][_index]['starting_at']['date'];
    // GET LOCAL TEAM
    var _localTeam = _histDetails['matches']['localTeams'][_index];
    // GET VISITOR TEAM
    var _visitorTeam = _histDetails['matches']['visitorTeams'][_index];
    // GET THE CHAMPIONSHIP
    var _league = _histDetails['matches']['teamLeagues'][_index];
    // GET THE COUNTRY
    var _country = _histDetails['matches']['teamCountries'][_index];
    // GET THE RATE
    var _rate = _histDetails['matches']['oddValues'][_index];
    // GET THE ODD NAME, CHOICE, LABEL, TOTAL, HANDICAP
    var _oddName = _histDetails['matches']['oddNames'][_index];
    var _oddLabel = _histDetails['matches']['oddLabels'][_index];
    var _oddTotal = _histDetails['matches']['oddTotals'][_index];
    var _oddHand = _histDetails['matches']['oddHandicaps'][_index];

    if (_oddName == null) _oddName = '';
    if (_oddLabel == null) _oddLabel = '';

    _oddTotal == null ? _oddTotal = '' : _oddTotal = ' ' + _oddTotal;
    _oddHand == null ? _oddHand = '' : _oddHand = ' ' + _oddHand;

    String _getGameChoice =
        _oddName.toString() + ' ($_oddLabel$_oddTotal$_oddHand) ';

    Icon _thisIcon;
    Color _thisColor;
    // GET THE STATUS
    String _status = _histDetails['matches']['teamResults'][_index].toString();
    // CHECKING
    if (_status.compareTo('cancelled') == 0) {
      _thisIcon = Icon(FontAwesomeIcons.squareFull);
      _thisColor = Colors.orange.shade300;
    } else if (_status.compareTo('null') == 0) {
      _thisIcon = Icon(FontAwesomeIcons.squareFull);
      _thisColor = Colors.grey;
    } else if (_status.compareTo('true') == 0) {
      _thisIcon = Icon(FontAwesomeIcons.squareFull);
      _thisColor = Colors.lightGreen[400];
    } else if (_status.compareTo('false') == 0) {
      _thisIcon = Icon(FontAwesomeIcons.squareFull);
      _thisColor = Colors.red.shade300;
    }

    // GET THE GAME SCORE
    var _score = _histDetails['matches']['teamScores'][_index];
    if (_score == null) _score = ' ?-?';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _date.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  _time.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
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
                    _localTeam.toString() + ' vs ' + _visitorTeam.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      // fontWeight: FontWeight.bold,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 2.0),
                Container(
                  alignment: Alignment.centerLeft,
                  width: ResponsiveWidget.isExtraSmallScreen(context)
                      ? 120
                      : ResponsiveWidget.isSmallScreen(context)
                          ? 170
                          : 200,
                  child: Text(
                    _league.toString() + ' - ' + _country.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  _getGameChoice.toString(),
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
                  _score.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.0),
                // GET THE RIGHT ICON
                Icon(
                  _thisIcon.icon,
                  size: 12.0,
                  color: _thisColor,
                ),
                SizedBox(height: 3.0),
                Text(
                  _rate.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
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

  Column myHistView(BuildContext context) {
    return Column(
      children: [
        Text('Mon Historique'.toUpperCase(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey, thickness: 0.4),
        SizedBox(height: 5.0),
        // DISPLAY ONLY IF WE HAVE DATA OR ACTIVE BETS
        _histData.length > 0
            ? Expanded(
                // height: MediaQuery.of(context).size.height - 240.0,
                child: ListView.builder(
                  // controller: _scrollController,
                  itemCount: _histData.length,
                  itemBuilder: (context, index) {
                    return myHistWidget(context, index);
                  },
                ),
              )
            : _isNoInternetNetwork
                ? Center(child: noNetworkWidget())
                : Center(
                    child: _isNoHistData
                        ? noRecordFound('Aucun pari dans l\'historique')
                        : recordLoading(),
                  ),
      ],
    );
  }

  void checkInternet() async {
    try {
      final response =
          await http.get('https://jsonplaceholder.typicode.com/albums/1');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        _isNoInternetNetwork = false;
      } else {
        // If the server did not return a 200 OK response,
        // if there is an error
        if (mounted)
          setState(() {
            // print('failed to load data');
            _isNoInternetNetwork = true;
          });
      }
    } catch (e) {
      if (mounted)
        setState(() {
          // clear the array so the condition can be reached
          // if there is an error based on network
          _isNoInternetNetwork = true;
          // print('network error is: $e');
        });
    }
  }

  @override
  void initState() {
    // initially load transactions with no condition
    if (mounted)
      setState(() {
        // LOAD BETS ON FIRST PAGE RENDERING
        loadHist(_histLoadLimit);
        // CHEKC THE INTERNET CONNECTIVITY
        checkInternet();
      });
    super.initState();
  }

  loadHist(int limit) async {
    // GET THE USER ID BEFORE FETCHING THRE TRANSACTIONS
    if (Selection.user != null) {
      // GET THE USER ID
      String user = Selection.user.uid;
      // CREATE THE INSTANCE OF FIRESTORE
      var firestore = Firestore.instance;
      // load all transaction of the user
      // LOAD ALL TRANSACTIONS OF THIS PARTICULAR USER
      await firestore
          .collection('betslip')
          .where('uid', isEqualTo: user)
          .where('update_status', isEqualTo: 'completed')
          .orderBy('time.date_time', descending: true)
          .limit(limit)
          .getDocuments()
          .then((_betResult) {
        // DISPLAYING PROCESS
        if (mounted)
          setState(() {
            // IF WE HAVE NO DATA WE DISPLAY IT TO THE SCREEN
            if (_betResult.documents.isEmpty) {
              // SET THE VARIABLE TO TRUE
              _isNoHistData = true;
            } else {
              // SET THE VARIABLE TO FALSE
              _isNoHistData = false;
            }
            // PROCEED WITH GAME ADDING HERE
            // CLEAR ALL CONTENT BEFORE ADDING NEW
            _histData.clear();
            // ADD NEW ITEMS HERE SO THAT THEY WILL BE ADDED AUTOMATICALLY TO THE LIST
            _histData.addAll(_betResult.documents);
          });
      });
    }
  }

  Widget myHistWidget(BuildContext context, int index) {
    // GET THE TIME
    var _time = _histData[index]['time']['time'];
    // GET THE DATE
    var _date = _histData[index]['time']['date'];
    // GET THE TOTAL PAYOUT
    var _payout = _histData[index]['rewards']['payout'];
    // GET THE STAKE OF THE TICKET
    var _stake = _histData[index]['rewards']['stake'];
    // GET THE CURRENCY SYMBOL
    var _currency = _histData[index]['rewards']['currency'];
    // GET THE CURRENT BET STATUS
    String _status = _histData[index]['status'].toString();
    // GET THE COLOR OF THE WIDGET STATUS
    Color _colorItem;
    if (_status.compareTo('won') == 0) {
      _colorItem = Colors.lightGreen[400];
    } else if (_status.compareTo('lost') == 0) {
      _colorItem = Colors.red.shade300;
    } else if (_status.compareTo('cancelled') == 0) {
      _colorItem = Colors.orange.shade300;
    } else {
      _colorItem = Colors.grey;
    }

    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (mounted)
                setState(() {
                  // DISPLAY THE PANEL FOR MORE DETAILS
                  showDetailPanel = true;
                  // SET THE INDEX TO DISPLAY TO THIS CURRENT INDEX
                  _detailIndex = index;
                  // CHECK THE INTERNET CONNECTIVITY
                  checkInternet();
                });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _date.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      _time.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 2.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Montant: ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11.0),
                            ),
                            Text(
                              _currency.toString() +
                                  ' ' +
                                  Price.getWinningValues(_stake),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 4.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Profit: ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11.0),
                            ),
                            Text(
                              _currency.toString() +
                                  ' ' +
                                  Price.getWinningValues(_payout),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                      FontAwesomeIcons.squareFull,
                      color: _colorItem,
                      size: 13.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey.shade300, thickness: 0.4),
        SizedBox(height: 5.0),
        // SHOW THIS WHEN THE LAST ITEM IS REACHED
        if (_histData.length - 1 == index)
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              padding: new EdgeInsets.all(10.0),
              fillColor: Colors.lightGreen[300],
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                // INCREASE THE LOADING LIMIT OF TRANSACTIONS HERE
                _histLoadLimit = _histLoadLimit + 10;
                if (mounted)
                  setState(() {
                    // WHEN CLICKED, LOAD MORE BETS AND RE-RENDERED THE SCREEN
                    // THIS WILL BE FETCHING MORE DATA THAT PREVIOUSLY FETCHED
                    loadHist(_histLoadLimit);
                  });
              },
              child: Text(
                'Plus...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
