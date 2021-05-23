import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skiiyabet/methods/connexion.dart';
import 'package:http/http.dart' as http;

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  // CHECK THE NETWORK ISSUE
  bool _isNoInternetNetwork = false;
// DISPLAY TRANSACTIONS
  var _transData = [];
// TRANSACTION LIMITS
  int _transLoadLimit = 15;
// CHECK FOR DATA DISPONIBILITY
  bool _isNoTransData = false;

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
            ? Column(
                children: [
                  Text('Mes Transactions'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Date - Heure',
                  //         style: TextStyle(color: Colors.grey, fontSize: 13.0)),
                  //     Text('Type',
                  //         style: TextStyle(color: Colors.grey, fontSize: 13.0)),
                  //     Text('[ Fc ]',
                  //         style: TextStyle(color: Colors.grey, fontSize: 13.0)),
                  //   ],
                  // ),
                  SizedBox(height: 5.0),
                  Divider(color: Colors.grey, thickness: 0.4),
                  SizedBox(height: 5.0),
                  _transData.length > 0
                      ? Container(
                          height: MediaQuery.of(context).size.height - 240.0,
                          child: ListView.builder(
                            itemCount: _transData.length,
                            itemBuilder: (context, index) {
                              return myTransactionWidget(context, index);
                            },
                          ),
                        )
                      // IF NO INTERNET NETWORK DISPLAY THIS
                      : _isNoInternetNetwork
                          ? Center(child: noNetworkWidget())
                          : Center(
                              child: _isNoTransData
                                  ? noRecordFound(
                                      'Aucune transaction effectuée')
                                  : recordLoading(),
                            ),
                ],
              )
            : notLoggedInYetHeader('Mes Transactions'),
      ),
    );
  }

  void checkInternet() async {
    try {
      final response =
          await http.get('https://jsonplaceholder.typicode.com/albums/1');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // print('fetched successfully');
        _isNoInternetNetwork = false;
      } else {
        // If the server did not return a 200 OK response,
        // if there is an error
        if (mounted)
          setState(() {
            // print('failed to load data');
            _isNoInternetNetwork = true;
          });
        // then throw an exception.
        // throw Exception('Failed to load album');
      }
    } catch (e) {
      if (mounted)
        setState(() {
          // clear the array so the condition can be reached
          // data.clear();
          // if there is an error based on network
          _isNoInternetNetwork = true;
          // print('network error is: $e');
        });
    }
  }

  @override
  void initState() {
    // initially load transactions with no condition
    // LOAD TRANSACTION WHEN THE WIDGET IS RENDERED
    if (mounted)
      setState(() {
        // WE LOAD THE TRANSACTION ON RENDERING
        loadTransaction(_transLoadLimit);
        // CHEKC THE INTERNET CONNECTIVITY
        checkInternet();
      });
    // SUPER CLASS
    super.initState();
  }

  loadTransaction(int limit) async {
    // GET THE USER ID BEFORE FETCHING THRE TRANSACTIONS
    if (Selection.user != null) {
      // GET THE USER ID
      String user = Selection.user.uid;
      // CREATE THE INSTANCE OF FIRESTORE
      var firestore = Firestore.instance;
      // load all transaction of the user
      // LOAD ALL TRANSACTIONS OF THIS PARTICULAR USER
      await firestore
          .collection('Transactions')
          .where('uid', isEqualTo: user.toString())
          .orderBy('time.date_time', descending: true)
          .limit(limit)
          .getDocuments()
          .then((_transResult) {
        // DISPLAYING
        if (mounted)
          setState(() {
            // IF WE HAVE NO DATA WE DISPLAY IT TO THE SCREEN
            if (_transResult.documents.isEmpty) {
              // SET THE VARIABLE TO TRUE
              _isNoTransData = true;
            } else {
              // SET THE VARIABLE TO FALSE
              _isNoTransData = false;
            }
            // PROCEED WITH GAME ADDING HERE
            // CLEAR ALL CONTENT BEFORE ADDING NEW
            _transData.clear();
            // ADD NEW ITEMS HERE SO THAT THEY WILL BE ADDED AUTOMATICALLY TO THE LIST
            _transData.addAll(_transResult.documents);
          });
      });
    }
  }

  Widget myTransactionWidget(BuildContext context, int index) {
    // GET THE TIME
    var _time = _transData[index]['time']['time'];
    // GET THE DATE
    var _date = _transData[index]['time']['date'];
    // GET THE SIGN OF THE TRANSACTION
    var _actionSign = _transData[index]['action_sign'];
    // GET THE AMOUNT OF THE TRANSACTION
    var _amount = _transData[index]['amount'];
    // GET THE TYPE OF THE TRANSACTION
    var _type = _transData[index]['type'];
    // GET THE CURRENCY SYMBOL
    var _currency = _transData[index]['currency'];

    return Column(
      children: [
        Row(
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
            Text(
              _type.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              _currency.toString() +
                  ' ' +
                  _actionSign.toString() +
                  Price.getWinningValues(_amount),
              style: TextStyle(
                color: Colors.grey,
                fontSize:
                    ResponsiveWidget.isExtraSmallScreen(context) ? 10.0 : 12.0,
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey.shade300, thickness: 0.4),
        SizedBox(height: 5.0),
        // SHOW THIS ONLY IF WE ARE AT THE BOTTOM OF THE LIST
        // if (_transData.length - 1 == index) SizedBox(height: 10.0),
        if (_transData.length - 1 == index)
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
                _transLoadLimit = _transLoadLimit + 10;
                if (mounted)
                  setState(() {
                    // WHEN CLICKED, LOAD MORE TRANSACTION AND RE-RENDERED THE SCREEN
                    // THIS WILL BE FETCHING MORE DATA THAT PREVIOUSLY FETCHED
                    loadTransaction(_transLoadLimit);
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

Column notLoggedInYetHeader(String header) {
  return Column(
    children: [
      Text(header.toUpperCase(),
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      SizedBox(height: 10.0),
      Divider(thickness: 0.4, color: Colors.grey),
      SizedBox(height: 15.0),
      ConnexionRequired(),
    ],
  );
}

Column noNetworkWidget() {
  return Column(
    children: [
      SizedBox(height: 10.0),
      Text(
        'Pas de réseau internet',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Column recordLoading() {
  return Column(
    children: [
      SizedBox(height: 10.0),
      Text(
        'Chargement...',
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10.0),
      SpinKitCircle(
        color: Colors.lightBlue,
        size: 20.0,
      ),
    ],
  );
}

Column noRecordFound(String message) {
  return Column(
    children: [
      SizedBox(height: 10.0),
      Text(
        message.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
