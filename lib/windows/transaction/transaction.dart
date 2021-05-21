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
// CHECK THE SCROLL CONTROLLER BEHAVIOUR
  ScrollController _scrollController;
// DISPLAY TRANSACTIONS
  var _transactionDisplay = [];
// TRANSACTION LIMITS
  int transactionLoadLimit = 2;
// CHECK FOR DATA DISPONIBILITY
  bool _isNoTransData = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 15.0),
        padding: new EdgeInsets.all(10.0),
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
                  _transactionDisplay.length > 0
                      ? Container(
                          height: MediaQuery.of(context).size.height - 240.0,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: _transactionDisplay.length,
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
                                  ? noTransactionMade()
                                  : dataTransactionLoading(),
                            ),
                ],
              )
            : noLoginHeader(),
        // Center(
        //     child: ConnexionRequired(),
        //   ),
      ),
    );
  }

  Column noLoginHeader() {
    return Column(
      children: [
        Text('Mes Transactions'.toUpperCase(),
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

  Column dataTransactionLoading() {
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

  Column noTransactionMade() {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Text(
          'Aucune transaction effectuée',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
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
        loadTransaction(transactionLoadLimit);
      });
    super.initState();

    //listen to body scrolling and execute itself
    ScrollController()
      ..addListener(() {
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
              loadTransaction(transactionLoadLimit);
            });
        }
      });
  }

  loadTransaction(int limit) async {
    // GET THE USER ID BEFORE FETCHING THRE TRANSACTIONS
    if (Selection.user != null) {
      String user = Selection.user.uid;
      // print('the user is : $user');
      // print('executing the loading transaction collection');
      var firestore = Firestore.instance;
      // QuerySnapshot qn;
      // load all transaction of the user
      // LOAD ALL TRANSACTIONS OF THIS PARTICULAR USER
      await firestore
          .collection('Transactions')
          .where('uid', isEqualTo: user.toString())
          .orderBy('time.date_time', descending: true)
          .limit(limit)
          .getDocuments()
          .then((result) {
        // delete all before adding new items
        // _transactionLoader.clear();
        print(result.documents);
        // print('FROM DB: $result');
        if (mounted)
          setState(() {
            // IF WE HAVE NO DATA WE DISPLAY IT TO OUR USER
            if (result.documents.isEmpty) {
              // SET THE VARIABLE TO TRUE
              _isNoTransData = true;
            } else {
              // SET THE VARIABLE TO FALSE
              _isNoTransData = false;
            }
            // if (mounted)
            //   setState(() {
            // CLEAR ALL CONTENT BEFORE ADDING NEW
            _transactionDisplay.clear();
            // ADD NEW ITEMS HERE
            _transactionDisplay.addAll(result.documents);
            // return qn.documents;
            // });
            // this condition will loop through all loaded elements
            // for (var j = 0; j < result.documents.length; j++) {
            //   // this boolean validate if the item is not IN
            //   bool alreadyIn = false;
            //   // add the first elemets if display is empty
            //   if (_transactionLoader.length > 0) {
            //     // check if the elemet exists already in the array
            //     for (var i = 0; i < _transactionLoader.length; i++) {
            //       if (_transactionLoader[i].documentID.toString().compareTo(
            //               result.documents[j].documentID.toString()) ==
            //           0) {
            //         // set to true if the item exists already in the array
            //         // ASSURE THE UNIQUENESS OF EVERY ITEM
            //         alreadyIn = true;
            //         // print(_transactionLoader[i].documentID);
            //         // }
            //       }
            //     }
            //     // if the item does not exists in the array display then add it
            //     if (!alreadyIn) {
            //       // add the element after all checking otherwise nothing will be added
            //       // ADD ITEM IF IT IS NOT YET ADDED
            //       _transactionLoader.add(result.documents[j]);
            //     }
            //   } else {
            //     // add the first element to allow easy computing
            //     _transactionLoader.add(result.documents[j]);
            //   }
            // }
          });
        // return result;
      });
    }
  }

  Widget myTransactionWidget(BuildContext context, int index) {
    // print('Amount is: $amount');
    // GET THE TIME
    var _time = _transactionDisplay[index]['time']['time'];
    // GET THE DATE
    var _date = _transactionDisplay[index]['time']['date'];
    // GET THE SIGN OF THE TRANSACTION
    var _actionSign = _transactionDisplay[index]['action_sign'];
    // GET THE AMOUNT OF THE TRANSACTION
    var _amount = _transactionDisplay[index]['amount'];
    // GET THE TYPE OF THE TRANSACTION
    var _type = _transactionDisplay[index]['type'];
    // GET THE CURRENCY SYMBOL
    var _currency = _transactionDisplay[index]['currency'];

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
              _actionSign.toString() +
                  _amount.toString() +
                  ' ' +
                  _currency.toString(),
              style: TextStyle(
                color: Colors.grey,
                fontSize:
                    ResponsiveWidget.isExtraSmallScreen(context) ? 10.0 : 12.0,
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey, thickness: 0.4),
        SizedBox(height: 5.0),
      ],
    );
  }
}
