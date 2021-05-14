import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/database/selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skiiyabet/methods/connexion.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10.0),
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
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date - Heure',
                          style: TextStyle(color: Colors.grey, fontSize: 13.0)),
                      Text('Type',
                          style: TextStyle(color: Colors.grey, fontSize: 13.0)),
                      Text('[ Fc ]',
                          style: TextStyle(color: Colors.grey, fontSize: 13.0)),
                    ],
                  ),
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
                      : Center(
                          child: Column(
                            children: [
                              Text(
                                'Chargement ou Aucune Donnée',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              SpinKitCubeGrid(
                                color: Colors.lightGreen[400],
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                ],
              )
            : Column(
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
              ),
        // Center(
        //     child: ConnexionRequired(),
        //   ),
      ),
    );
  }

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // initially load transactions with no condition
    loadTransaction(transactionLoadLimit);
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
            loadTransaction(transactionLoadLimit);
          });
      }
    });
  }

  var _transactionLoader = [];
  var _transactionDisplay = [];

  int transactionLoadLimit = 5;

  Future loadTransaction(int limit) async {
    if (Selection.user != null) {
      String user = Selection.user.uid;
      // print('the user is : $user');
      // print('executing the loading transaction collection');
      var firestore = Firestore.instance;
      // QuerySnapshot qn;
      // load all transaction of the user
      // qn = await firestore
      await firestore
          .collection('Transactions')
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
                  // add the element after all checking otherwise nothing will be added
                  _transactionLoader.add(result.documents[j]);
                }
              } else {
                // add the first element to allow easy computing
                _transactionLoader.add(result.documents[j]);
              }
            }
          });
        return result;
      });

      _transactionDisplay.clear();
      _transactionDisplay.addAll(_transactionLoader);
      // print('initial transaction to display is: $_transactionDisplay');
      // return qn.documents;
    }
  }

  Widget myTransactionWidget(BuildContext context, int index) {
    // double amount = _transactionDisplay[index]['amount'];
    // print('Amount is: $amount');
    return Column(
      children: [
        // SizedBox(height: 5.0),
        // Divider(color: Colors.grey, thickness: 0.4),
        // SizedBox(height: 5.0),
        Row(
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
                        _transactionDisplay[index]['time'][1].toString() +
                        ' ' +
                        _transactionDisplay[index]['time'][2].toString(),
                    // '12:53 AM',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _transactionDisplay[index]['type']
                              .toString()
                              .compareTo('Betting') ==
                          0
                      ? 'Pari'.toUpperCase()
                      : _transactionDisplay[index]['type']
                                  .toString()
                                  .compareTo('Reward') ==
                              0
                          ? 'Gain'.toUpperCase()
                          : _transactionDisplay[index]['type']
                                      .toString()
                                      .compareTo('Deposit') ==
                                  0
                              ? 'Dépôt'.toUpperCase()
                              : 'Retrait'.toUpperCase(),
                  // 'Deposit'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Text(
              (_transactionDisplay[index]['type']
                                  .toString()
                                  .compareTo('Deposit') ==
                              0 ||
                          _transactionDisplay[index]['type']
                                  .toString()
                                  .compareTo('Reward') ==
                              0
                      ? '+'
                      : '-') +
                  _transactionDisplay[index]['amount'].toString().toUpperCase(),
              // '+ 1500'.toUpperCase(),
              style: TextStyle(
                // color: Colors.green,
                color: _transactionDisplay[index]['type']
                            .toString()
                            .compareTo('Deposit') ==
                        0
                    ? Colors.green
                    : Colors.grey,
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
