import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:skiiyabet/methods/connexion.dart';
import 'package:skiiyabet/methods/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// THE USER AMOUNT TO WITHDRAW
double withdrawAmount = 0;
// CHECK IF THE USER IS ALLOW TO WITHDRAW
bool allowRequest = false;
// HOLD REQUESTS
var _currentRequest;

// CHECKING OPERATORS
bool _isOrangeMoney = false;
bool _isAirtelMoney = false;
bool _isMPesa = false;

// CHECK IF WE HAVE A PENDING REQUEST
bool _isRequestPending = false;

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        padding: new EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOAD THIS IF A USER HAS LOGGED IN IT HAS DB VALUE
                // DISPLAY PENDING TRANSACTION
                if (Selection.user != null) loadTransaction(),
                // SHOW THIS IF NO USER HAS LOGGED IN
                if (Selection.user == null) ConnexionRequired(),

                Text(
                  'L\'argent retiré sera envoyé au compte électronique du numéro associé avec ce compte',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Retrait minimum: ' +
                      Price.currency_symbol +
                      ' ' +
                      Price.getWinningValues(Price.minimumWithdraw) +
                      '\nRetrait maximum: ' +
                      Price.currency_symbol +
                      ' ' +
                      Price.getWinningValues(Price.maximumWithdraw),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Remarque: \nRetrait maximum quotidien : ' +
                      Price.currency_symbol +
                      ' ' +
                      Price.getWinningValues(Price.maximumDailyWithdraw),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                // IF ONE OF THE NETWORK OPERATOR IS DETECTED
                if (!_isAirtelMoney && !_isOrangeMoney && !_isMPesa)
                  paymentOption('Airtel Money | Orange Money | Vodacom M-Pesa'),
                if (_isAirtelMoney) paymentOption('Airtel Money'),
                if (_isOrangeMoney) paymentOption('Orange Money'),
                if (_isMPesa) paymentOption('Vodacom M-Pesa'),
                SizedBox(height: 10.0),
                // IF ONE OF THE NETWORK OPERATOR IS DETECTED
                if (_isAirtelMoney || _isOrangeMoney || _isMPesa)
                  Center(
                    child: Container(
                      height: 70.0,
                      width: 100.0,
                      child: Image.asset(
                        _isAirtelMoney
                            ? 'assets/images/airtel-money.png'
                            : _isOrangeMoney
                                ? 'assets/images/orange-money.png'
                                : 'assets/images/m-pesa.jpeg',
                        // color: Colors.lightBlue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                if (!_isAirtelMoney && !_isOrangeMoney && !_isMPesa)
                  Container(
                    padding: new EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imgDisplay('assets/images/airtel-money.png'),
                        SizedBox(width: 5.0),
                        imgDisplay('assets/images/orange-money.png'),
                        SizedBox(width: 5.0),
                        imgDisplay('assets/images/m-pesa.jpeg'),
                      ],
                    ),
                  ),
                if (_isAirtelMoney || _isOrangeMoney || _isMPesa)
                  SizedBox(height: 10.0),

                // SHOW THIS IF WE HAVE ANY PENDING REQUEST
                if (!_isRequestPending)
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                            bottom: BorderSide(color: Colors.grey.shade300),
                            left: BorderSide(color: Colors.grey.shade300),
                            right: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            if (mounted)
                              setState(() {
                                if (value.isEmpty) {
                                  withdrawAmount = 0.0;
                                } else {
                                  withdrawAmount = double.parse(value);
                                }
                              });
                            // print('filed double: $withdrawAmount');
                          },
                          cursorColor: Colors.lightGreen[400],
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Montant',
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintMaxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        child: RawMaterialButton(
                          padding: new EdgeInsets.all(15.0),
                          onPressed: () {
                            if (mounted)
                              setState(() {
                                if (Selection.user == null) {
                                  failMessage(context,
                                      'Connectez votre compte d\'Abord.');
                                } else if (Selection.isUserBlocked == true) {
                                  failMessage(
                                      context, 'Désolé! Ce compte est bloqué.');
                                } else {
                                  if (withdrawAmount < Price.minimumWithdraw) {
                                    failMessage(context,
                                        'Le montant minimum est: ${Price.currency_symbol} ${Price.getWinningValues(Price.minimumWithdraw)}');
                                  } else if (withdrawAmount >
                                      Price.maximumWithdraw) {
                                    failMessage(context,
                                        'Le montant maximum est: ${Price.currency_symbol} ${Price.getWinningValues(Price.maximumWithdraw)}');
                                  } else if (withdrawAmount >
                                      Selection.userBalance) {
                                    failMessage(context,
                                        'Votre solde est insuffisant.');
                                  } else {
                                    successMessage(
                                        context, 'En cours de developement...');
                                    // mainRequest();
                                  }
                                }
                              });
                          },
                          fillColor: Colors.black87,
                          disabledElevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            'retirez maintenant'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded imgDisplay(String url) {
    return Expanded(
      child: Container(
        height: 70.0,
        width: 90.0,
        child: Image.asset(
          url,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Text paymentOption(String option) {
    return Text(option,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ));
  }

  getNetworkOperator() {
    // GET THE USER PHONE NUMBER
    String _phone = Selection.userTelephone;
    // print('THE PHONE: $_phone');
    if (_phone.compareTo('') != 0) {
      // LET US GET THE AIRTEL NUMBER
      if (_phone.substring(0, 2) == '09') {
        _isAirtelMoney = true;
        _isOrangeMoney = false;
        _isMPesa = false;
        // print('airtel money');
      } else if (_phone.substring(0, 3) == '084' ||
          _phone.substring(0, 3) == '085' ||
          _phone.substring(0, 3) == '089') {
        _isOrangeMoney = true;
        _isAirtelMoney = false;
        _isMPesa = false;
        // print('orange et tigo money');
      } else if (_phone.substring(0, 3) == '081' ||
          _phone.substring(0, 3) == '082') {
        _isMPesa = true;
        _isAirtelMoney = false;
        _isOrangeMoney = false;
        // print('m-pesa');
      }
    }
    // else {
    //   print('no phone number');
    // }
    // print('checking operator...');
  }

  mainRequest() async {
    // LET US GET THE USER ID
    String _uid = Selection.user.uid;
    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    String _date = _getDate();
    // WE GET THE CUSTOM TIME HERE
    var _time = _getTime();

    // THE VARIABLE THAT STORES DAILY MAX WITHDRAW
    double dailyMaxCash = 0.0;
    // CHECK ALSO IF THE DAILY AMOUNT HAS NOT BEEN REACHED YET
    // CHECK IF A WITHDRAWAL REQUEST IS STILL AVAILABLE
    await Firestore.instance
        .collection('withdraw')
        .where('uid', isEqualTo: _uid)
        .getDocuments()
        .then((_withdrawRequest) {
      // CHECK ONLY IF WE HAVE DATA
      if (_withdrawRequest != null) {
        // CHECK IF ANY PARTICULAR USER WITHDRAW REQUEST IS STILL PENDIND TO DENY NEW REQUEST
        _withdrawRequest.documents.forEach((element) {
          // GET THE STATUS OF THE EACH AND EVERY TRANSACTION
          String _status = element['status'].toString();
          // WE CHECK FOR A ACTIVE REQUEST
          if (_status.compareTo('pending') != 0) {
            // WE CHECK FOR DAILY WITHDRAW
            allowRequest = true;
          }
          // GET THE REQUEST DATE AND TIME TO COMPARE FOR MAXIMUM AMOUNT TO WITHDRAW PER SINGLE DAY
          String _requestTime = element['time']['time'];
          String _requestDate = element['time']['date'];
          // WE GET THE TOTAL AMOUNT TO WITHDRAWAWN IN A SINGLE DATA
          if (_requestTime.compareTo(_time) == 0 &&
              _requestDate.compareTo(_date) == 0) {
            // ADD IT TO THE SUM
            dailyMaxCash += element['amount'];
          }
        });
      }
      // IF NO PENDING REQUEST FOUND, THEN ALLOW REQUEST
      if (allowRequest) {
        // IF THE DAILY WITHDRAW BALANCE IS LESS THAN THE MAXIMUM DAILY
        // THEN ALLOW THE REQUEST TO BE PROCESSED
        if (dailyMaxCash <= Price.maximumDailyWithdraw) {
          // SUBSTRACT THE AMOUNT TO BALANCE FIRST THEN
          // ADD A NEW REQUEST
          Method.addNewTransaction(
                  'Retrait', withdrawAmount, '-', Selection.userTelephone)
              .then((_trans) {
            // LET US GET THE TRANSACTION ID HERE
            String _transID = _trans.documentID.toString();
            Firestore.instance
                .collection('UserBalance')
                .document(_uid)
                .updateData(
              {
                'balance': FieldValue.increment(-withdrawAmount),
                'last_trans_id': '$_transID',
              },
            ).then((_) {
              // ADD A NEW WITHDRAW REQUEST TO THE COLLECTION
              addWithdrawRequest(withdrawAmount);
            }).catchError((e) {
              // BALANCE UPDATE ERROR
              failMessage(context, 'Une erreur est survenue.');
            });
          }).catchError((e) {
            // TRANSACTION UPDATE ERROR
            failMessage(context, 'Une erreur est survenue.');
          });
        } else {
          failMessage(
              context, 'Vous avez atteint votre retrait quotidien maximal');
        }
      } else {
        // DISPLAY DENIED MESSAGE HERE
        failMessage(context, 'Vous avez une demande de retrait en cours');
        // LOAD ALL TRANSACTIONS
        loadWithdrawRequest();
      }
    });
    // OTHERWISE DENIED WITHDRAWAL REQUEST
  }

  static String _getTime() {
    // GET CURRENT TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // GET MINUTE IN A CUSTOM FORMAT
    String _minute = _formatOf10(_datetime.minute);
    // GET HOUR IN A CUSTOM FORMAT
    String _hour = _formatOf10(_datetime.hour);
    // GET SECOND IN A CUSTOM FORMAT
    String _second = _formatOf10(_datetime.second);
    // RETURN A STRING IN TIME FORMAT
    return _hour + ':' + _minute + ':' + _second;
  }

  static String _getDate() {
    // GET CURRENT TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    // WE GET THE DAY
    String _day = _formatOf10(_datetime.day);
    // WE GET THE MONTH
    String _month = _formatOf10(_datetime.month);
    // WE GET THE YEAR
    String _year = _datetime.year.toString();
    // RETURN A STRING IN DATE FORMAT
    return _day + '-' + _month + '-' + _year;
  }

  static String _formatOf10(int _newVal) {
    // WE CREATE AN EMPTY VALUE
    String _val = _newVal.toString();
    // IF THE VALUE IS LESS THAN 10 ADD A ZERO BEFORE
    // OTHERWISE DO NOT ADD ANYTHING BEFORE THE VALUE
    if (_newVal < 10) _val = '0' + _newVal.toString();
    // RETURN THE MODIFIED VALUE
    return _val;
  }

  addWithdrawRequest(double _amount) {
    // GET THE PHONE NUMBER
    String _userPhone = Selection.userTelephone;
    // WE GET THE USER ID
    String _uid = Selection.user.uid;
    // GET THE CURRENT DATE TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // STORE THE TIMESTAMP
    int _timestamp = _datetime.toUtc().millisecondsSinceEpoch;

    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    String _date = _getDate();
    // WE GET THE CUSTOM TIME HERE
    var _time = _getTime();

    // ADD THE REQUEST TO THE DATABASE
    Firestore.instance.collection('withdraw').add({
      'uid': _uid,
      'amount': _amount,
      'action_sign': '-',
      'currency': Price.currency_symbol,
      'admin_id': null,
      'status': 'pending',
      'phone': _userPhone,
      'time': {
        'time': '$_time',
        'date': '$_date',
        'date_time': '$_datetime',
        'timestamp': _timestamp,
        'timezone': 'UTC',
        'created': FieldValue.serverTimestamp(),
      },
      'time_completed': {
        'time': null,
        'date': null,
        'date_time': null,
        'timestamp': null,
        'timezone': null
      },
    }).then((value) {
      // UPDATE THE USER BALANCE LOCALLY
      if (mounted)
        setState(() {
          // DISPLAY THIS IF THE REQUEST HAS BEEN SENT
          // successMessage(context, 'Demande de retrait envoyée');
          // UPDATE THE USER BALANCE
          Selection.userBalance = Selection.userBalance - withdrawAmount;
          // AFTER A SUCCESSFULL PROCESS, RELOAD THE REQUEST LIST
          // EXECUTE THE METHOD
          loadWithdrawRequest();
        });
    }).catchError((e) {
      // ADD WITHDRAW REQUEST ERROR
      failMessage(context, 'Une erreur est survenue');
    });
  }

  @override
  void initState() {
    if (mounted)
      setState(() {
        // LET US GET THE NETWORK OPERATOR
        getNetworkOperator();
        // LOAD REQUEST IF THE USER HAS LOGGED IN
        // WE DO CHECK FOR REQUESTS OF THIS CURRENT USER
        loadWithdrawRequest();
        // print('loaded on start');
      });
    super.initState();
  }

  loadWithdrawRequest() async {
    // CHECK IF THE USER IS DIFFERENT FROM NULL
    if (Selection.user != null) {
      // GET THE USER ID
      String _uid = Selection.user.uid;
      // GET THE PENDING TRANSACTION
      await Firestore.instance
          .collection('withdraw')
          .where('uid', isEqualTo: _uid)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .getDocuments()
          .then((_getRequest) {
        // IF THE REQUEST IS NOT EMPTY
        if (_getRequest.documents.isNotEmpty) {
          if (mounted)
            setState(() {
              // SET THE REQUEST TO THE VALUE
              _currentRequest = _getRequest.documents;
              // SET THE REQUEST TO TRUE
              _isRequestPending = true;
            });
        } else {
          // SET THE REQUEST TO FALSE
          if (mounted)
            setState(() {
              _isRequestPending = false;
            });
        }
      });
    }
  }

  Widget loadTransaction() {
    // GET THE STATUS
    String _status = '...';
    // GET THE TIME
    String _time = '...';
    // GET THE DATE
    String _date = '...';
    // GET THE RECORD AMOUNT
    double _amount = 0.0;
    // GET THE CURRENCY SYMBOL
    String _currency = '...';
    // SET DATA IF WE HAVE THEM
    if (_currentRequest != null) {
      _status = 'En attente';
      _time = _currentRequest[0]['time']['time'];
      _date = _currentRequest[0]['time']['date'];
      _amount = _currentRequest[0]['amount'];
      _currency = _currentRequest[0]['currency'];
    }

    return Container(
        width: double.infinity,
        padding: new EdgeInsets.all(10.0),
        margin: new EdgeInsets.only(bottom: 15.0),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
              bottom: BorderSide(color: Colors.grey.shade300),
              left: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(color: Colors.grey.shade300),
            )),
        child:
            // SHOW THIS IF THE USER HAS A REQUEST
            Column(
          children: [
            Text(
              _isRequestPending
                  ? 'Vous avez une demande de retrait en attente.'
                  : 'Vous n\'avez aucune demande de retrait en attente.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
            // DO NOT DISPLAY THIS WIDGET IF WE HAVE NO DATA AT ALL
            if (_isRequestPending)
              Column(
                children: [
                  SizedBox(height: 8.0),
                  Divider(thickness: 0.4, color: Colors.grey.shade300),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Montant:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        _currency + ' ' + Price.getWinningValues(_amount),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Date - Temps: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        _date + ' ' + _time,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Divider(thickness: 0.4, color: Colors.grey.shade300),
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
                      Row(
                        children: [
                          Text(
                            _status,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          SpinKitCircle(
                            color: Colors.lightBlue,
                            size: 20.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
          ],
        ));
  }

  failMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
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
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.lightGreen[400],
        duration: Duration(seconds: 4),
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
