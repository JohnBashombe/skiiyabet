import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/app/skiiyaBet.dart';
import 'package:skiiyabet/database/price.dart';
import 'package:skiiyabet/database/selection.dart';
import 'package:skiiyabet/methods/connexion.dart';
import 'package:skiiyabet/methods/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// THE USER AMOUNT TO WITHDRAW
double withdrawAmount = 0;
// CHECK IF THE USER IS ALLOW TO WITHDRAW
bool allowRequest = true;
// HOLD REQUESTS
var _currentRequest = [];
// BLOCKER
int loadOnce = 0;

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  @override
  Widget build(BuildContext context) {
    // Load any pending request of withdraw for this particular user
    loadRequests();
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10.0),
        padding: new EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
            bottom: BorderSide(color: Colors.grey, width: 0.5),
            left: BorderSide(color: Colors.grey, width: 0.5),
            right: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 0.0),
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Retrait'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              color: Colors.grey,
              thickness: 0.4,
            ),
            SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOAD THIS IF A USER HAS LOGGED IN IT HAS DB VALUE
                if (_currentRequest.length > 0) loadTransaction(),
                // SHOW THIS IF NO USER HAS LOGGED IN
                if (Selection.user == null) ConnexionRequired(),

                Text(
                  'L\'argent retiré sera envoyé au compte électronique du numéro de téléphone associé avec ce compte de SKIIYA BET',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Retrait minimum: ' +
                      Price.getWinningValues(Price.minimumWithdraw) +
                      ' Fc \nRetrait maximum: ' +
                      Price.getWinningValues(Price.maximumWithdraw) +
                      ' Fc',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Remarque: \nRetrait maximum quotidien : ' +
                      Price.getWinningValues(Price.maximumDailyWithdraw) +
                      ' Fc',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(height: 20.0),
                Divider(
                  color: Colors.grey,
                  thickness: 0.4,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Bientôt disponible'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    padding: new EdgeInsets.all(15.0),
                    onPressed: () {
                      if (mounted)
                        setState(() {
                          // do deposit logic here
                          successMessage(context, 'En cours de developement!');
                        });
                    },
                    fillColor: Colors.lightGreen[400],
                    disabledElevation: 3.0,
                    child: Text(
                      'Vérifier'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                // Container(
                //   // margin: EdgeInsets.all(10.0),
                //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border(
                //       top:
                //           BorderSide(color: Colors.lightGreen[400], width: 2.0),
                //       bottom:
                //           BorderSide(color: Colors.lightGreen[400], width: 2.0),
                //       left:
                //           BorderSide(color: Colors.lightGreen[400], width: 2.0),
                //       right:
                //           BorderSide(color: Colors.lightGreen[400], width: 2.0),
                //     ),
                //   ),
                //   child: TextField(
                //     onChanged: (value) {
                //       if (mounted)
                //       setState(() {
                //         if (value.isEmpty) {
                //           withdrawAmount = 0.0;
                //         } else {
                //           withdrawAmount = double.parse(value);
                //         }
                //       });
                //       // print('filed double: $withdrawAmount');
                //     },
                //     cursorColor: Colors.lightGreen,
                //     maxLines: 1,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: <TextInputFormatter>[
                //       FilteringTextInputFormatter.digitsOnly
                //     ],
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 15.0,
                //         fontWeight: FontWeight.bold,
                //         letterSpacing: 0.5),
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       hintText: 'e.x. 5000 Fc',
                //       hintMaxLines: 1,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20.0),
                // Container(
                //   width: double.infinity,
                //   child: RawMaterialButton(
                //     padding: new EdgeInsets.all(15.0),
                //     onPressed: () {
                //       if (mounted)
                //       setState(() {
                //         if (Selection.user == null) {
                //           failMessage(context, 'Connectez-Vous d\'Abord');
                //         } else {
                //           if (withdrawAmount < Price.minimumWithdraw) {
                //             failMessage(context,
                //                 'Min. is: ${Price.getWinningValues(Price.minimumWithdraw)} Fc');
                //           } else if (withdrawAmount > Price.maximumWithdraw) {
                //             failMessage(context,
                //                 'Max. is: ${Price.getWinningValues(Price.maximumWithdraw)} Fc');
                //           } else if (withdrawAmount > Selection.userBalance) {
                //             failMessage(context, 'Votre Solde est insuffisant');
                //           } else {
                //             mainRequest();
                //           }
                //         }
                //       });
                //     },
                //     fillColor: Colors.lightGreen[400],
                //     disabledElevation: 3.0,
                //     child: Text(
                //       'retirez'.toUpperCase(),
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.0),
                //     ),
                //   ),
                // ),
                SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  mainRequest() {
    // GET THE DATE FOR COMPARISON
    var date = new DateTime.now();
    String _thisDay =
        date.day < 10 ? '0' + date.day.toString() : date.day.toString();
    String _thisMonth =
        date.month < 10 ? '0' + date.month.toString() : date.month.toString();
    String _thisYear = date.year.toString();

    // print('$_thisDay - $_thisMonth - $_thisYear');
    // THE VARIABLE THAT STORES DAILY MAX WITHDRAW
    double dailyMaxCash = 0.0;
    // CHECK ALSO IF THE DAILY AMOUNT HAS NOT BEEN REACHED YET
    // CHECK IF A WITHDRAWAL REQUEST IS STILL AVAILABLE
    Firestore.instance
        .collection('Withdraw')
        .where('userID', isEqualTo: Selection.user.uid)
        .getDocuments()
        .then((_result) {
      // CHECK IF ANY PARTICULAR USER WITHDRAW REQUEST IS STILL PENDIND TO DENY NEW REQUEST
      _result.documents.forEach((element) {
        // WE CHECK FOR A ACTIVE REQUEST
        if (element['status'].toString().compareTo('pending') == 0) {
          // WE CHECK FOR DAILY WITHDRAW
          allowRequest = false;
        }
        if ((element['date'][1].toString().compareTo(_thisDay) == 0) &&
            (element['date'][2].toString().compareTo(_thisMonth) == 0) &&
            (element['date'][3].toString().compareTo(_thisYear) == 0)) {
          dailyMaxCash += element['amount'];
        }
        // print(element['amount']);
      });
      // IF NO PENDING REQUEST FOUND, THEN ALLOW REQUEST
      if (allowRequest) {
        if (dailyMaxCash <= Price.maximumDailyWithdraw) {
          // SUBSTRACT THE AMOUNT TO BALANCE FIRST THEN
          Firestore.instance
              .collection('UserBalance')
              .document(Selection.user.uid)
              .updateData(
                  {'balance': FieldValue.increment(-withdrawAmount)}).then((_) {
            // ADD A NEW REQUEST
            Method.addTransactionRecords(
                'Withdraw', Selection.user.uid, withdrawAmount);
            addWithdrawRequest();
          });
        } else {
          failMessage(
              context, 'Vous avez atteint votre retrait quotidien maximal');
        }
      } else {
        // DISPLAY DENIED MESSAGE HERE
        failMessage(context, 'Vous avez une demande en cours');
      }
    });
    // OTHERWISE DENIED WITHDRAWAL REQUEST
  }

  addWithdrawRequest() {
    var date = new DateTime.now();
    String min = date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString();
    String hour =
        date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString();

    int indicRef = date.hour;
    String timeIndicator = '';
    if (indicRef < 12)
      timeIndicator = 'AM';
    else
      timeIndicator = 'PM';

    String day =
        date.day < 10 ? '0' + date.day.toString() : date.day.toString();
    String month =
        date.month < 10 ? '0' + date.month.toString() : date.month.toString();
    String year = date.year.toString();
    int today = date.weekday;
    String weekday = '';

    if (today == 1) weekday = 'Lun';
    if (today == 2) weekday = 'Mar';
    if (today == 3) weekday = 'Mer';
    if (today == 4) weekday = 'Jeu';
    if (today == 5) weekday = 'Ven';
    if (today == 6) weekday = 'Sam';
    if (today == 7) weekday = 'Dim';
    // do withdraw logic here
    // print(withdrawAmount);
    // Amount, date added, time added, date completed, time completed
    // userId, admin Id, status[pending, completed]
    Firestore.instance.collection('Withdraw').add({
      'amount': withdrawAmount,
      'userID': Selection.user.uid,
      'time': [hour.toString(), min.toString(), timeIndicator.toString()],
      'date': [
        weekday.toString(),
        day.toString(),
        month.toString(),
        year.toString()
      ],
      'timeCompleted': [],
      'dateCompleted': [],
      'adminId': 'null',
      'status': 'pending',
      'sorter': day.toString() +
          month.toString() +
          year.toString() +
          hour.toString() +
          min.toString(),
      'timestamp': new DateTime.now()
    }).then((value) {
      // UPDATE THE USER BALANCE LOCALLY
      if (mounted)
        setState(() {
          // DISPLAY THIS IF THE REQUEST HAS BEEN SENT
          // successMessage(context, 'Demande de retrait envoyée');
          // UPDATE THE USER BALANCE
          Selection.userBalance = Selection.userBalance - withdrawAmount;
          // AFTER A SUCCESSFULL PROCESS, RELOAD THE REQUEST LIST
          // RESET THE BLOCKER
          loadOnce = 0;
          // EXECUTE THE METHOD
          loadRequests();
          // Reload the screen to refresh variables
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SkiiyaBet(),
            ),
          );
        });
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   if (mounted)
  //   setState(() {
  //     // LOAD REQUEST IF THE USER HAS LOGGED IN
  //     loadRequests();
  //   });
  // }

  loadRequests() {
    if (Selection.user != null) {
      loadOnce++;
      // Make sure it loads this once
      if (loadOnce < 2) {
        // print('load once $loadOnce');
        Firestore.instance
            .collection('Withdraw')
            .where('userID', isEqualTo: Selection.user.uid)
            .getDocuments()
            .then((_result) {
          _result.documents.forEach((_element) {
            // IF A RECORD HAS A PENDING STATUS
            if (_element['status'].toString().compareTo('pending') == 0) {
              if (mounted)
                setState(() {
                  _currentRequest.add(_element);
                  // print('load here even');
                });
            }
          });
        });
        loadOnce++;
      }
    }
    // else {
    //   print('No User Found');
    // }
  }

  Widget loadTransaction() {
    String status = 'En attente',
        weekday = '..',
        day = '..',
        month = '..',
        year = '....';
    String timeIndic = '..', min = '..', hour = '..';
    double amount = 50000.0;

    if (_currentRequest.length > 0) {
      // status = _currentRequest[0]['status'].toString();
      status = 'En attente';
      // GET THE DATE VARIABLES
      weekday = _currentRequest[0]['date'][0].toString();
      day = _currentRequest[0]['date'][1].toString();
      month = _currentRequest[0]['date'][2].toString();
      year = _currentRequest[0]['date'][3].toString();
      // GET THE TIME VARIABLES
      hour = _currentRequest[0]['time'][0].toString();
      min = _currentRequest[0]['time'][1].toString();
      timeIndic = _currentRequest[0]['time'][2].toString();
      // GET THE AMOUNT
      amount = _currentRequest[0]['amount'];
    }

    return Container(
        width: double.infinity,
        padding: new EdgeInsets.all(10.0),
        margin: new EdgeInsets.only(bottom: 15.0),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.green[100],
            border: Border(
              top: BorderSide(color: Colors.lightGreen[400], width: 2.0),
              bottom: BorderSide(color: Colors.lightGreen[400], width: 2.0),
              left: BorderSide(color: Colors.lightGreen[400], width: 2.0),
              right: BorderSide(color: Colors.lightGreen[400], width: 2.0),
            )),
        child:

            // SHOW THIS IF THE USER HAS A REQUEST
            Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vous avez une demande en attente.'.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 8.0),
            Divider(thickness: 0.4, color: Colors.grey),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Montant:'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  Price.getWinningValues(amount) + ' Fc',
                  // '$amount FC',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Date de la requête: '.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  '$weekday $day/$month/$year'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Heure de la requête: '.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  '$hour:$min $timeIndic'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            // SizedBox(height: 15.0),
            SizedBox(height: 8.0),
            Divider(thickness: 0.4, color: Colors.grey),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Statut '.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 5.0),
                Row(
                  children: [
                    Text(
                      '$status'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    SpinKitChasingDots(
                      color: Colors.lightGreen,
                      size: 25.0,
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  failMessage(BuildContext context, String message) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  successMessage(BuildContext context, String message) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.lightGreen[400],
        duration: Duration(seconds: 3),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
