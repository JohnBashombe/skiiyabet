import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skiiyabet/methods/connexion.dart';
import 'package:http/http.dart' as http;
import 'package:skiiyabet/methods/methods.dart';

double _depositAmount = 3000;

// CHECKING OPERATORS
bool _isOrangeMoney = false;
bool _isAirtelMoney = false;
bool _isMPesa = false;

class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
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
            Center(
              child: Text(
                'Dépôt'.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.4,
            ),
            SizedBox(height: 8.0),
            if (Selection.user == null) ConnexionRequired(),
            // SizedBox(height: 5.0),
            Text(
              'Comment déposer?'.toUpperCase(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   'Coming Soon',
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: 13.0,
            //   ),
            // ),
            SizedBox(height: 5.0),
            Text(
              'Avant de pouvoir placer un pari, vous devez d\'abord déposer de l\'argent sur votre compte de pari.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.0,
              ),
            ),
            Text(
              'Si vous n\'avez pas d\'argent sur votre compte SKIIYA BET, vous devez d\'abord effectuer un dépôt avant de placer des paris.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              (!_isAirtelMoney && !_isOrangeMoney && !_isMPesa)
                  ? 'Systèmes de dépôt disponible'
                  : 'Ton système de dépôt disponible',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.4,
            ),
            SizedBox(height: 10.0),
            // IF ONE OF THE NETWORK OPERATOR IS DETECTED
            if (_isAirtelMoney || _isOrangeMoney || _isMPesa)
              Center(
                child: Container(
                  height: 70.0,
                  child: Image.asset(
                    _isAirtelMoney
                        ? 'images/airtel-money.png'
                        : _isOrangeMoney
                            ? 'images/orange-money.png'
                            : 'images/m-pesa.jpeg',
                    // color: Colors.lightBlue,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (!_isAirtelMoney && !_isOrangeMoney && !_isMPesa)
              Container(
                padding: new EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.0,
                        width: 60.0,
                        child: Image.asset(
                          'images/airtel-money.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        height: 50.0,
                        width: 60.0,
                        child: Image.asset('images/orange-money.png',
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        height: 50.0,
                        width: 60.0,
                        child: Image.asset(
                          'images/m-pesa.jpeg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (_isAirtelMoney || _isOrangeMoney || _isMPesa)
              SizedBox(height: 10.0),
            // Container(
            //   width: double.infinity,
            //   child: RawMaterialButton(
            //     padding: new EdgeInsets.all(15.0),
            //     onPressed: () {
            //       if (mounted)
            //         setState(() {
            //           // do deposit logic here
            //           successMessage(context, 'En cours de developement!');
            //         });
            //     },
            //     fillColor: Colors.lightGreen[400],
            //     disabledElevation: 3.0,
            //     child: Text(
            //       'Vérifier'.toUpperCase(),
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15.0),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10.0),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Dépôt à partir du site',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 14.0,
            //       ),
            //     ),
            //     SizedBox(height: 5.0),
            //     Text(
            //       '(conseillé)',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 12.0,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 10.0),
            Text(
              'Dépôt minimum: ' +
                  Price.currency_symbol +
                  ' ' +
                  Price.getWinningValues(Price.minimumDeposit),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'Dépôt maximum: ' +
                  Price.currency_symbol +
                  ' ' +
                  Price.getWinningValues(Price.maximumDeposit),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Entrer le montant:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  // margin: EdgeInsets.all(10.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                      bottom: BorderSide(color: Colors.grey.shade300),
                      left: BorderSide(color: Colors.grey.shade300),
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      if (mounted)
                        setState(() {
                          _depositAmount = double.parse(value);
                        });
                    },
                    cursorColor: Colors.lightBlue,
                    maxLines: 1,
                    initialValue: '3000',
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
                SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  child: RawMaterialButton(
                    padding: new EdgeInsets.all(15.0),
                    onPressed: () {
                      if (mounted)
                        setState(() {
                          if (Selection.user == null) {
                            failMessage(
                                context, 'Connecter votre compte d\'abord');
                          } else if (Selection.isUserBlocked == true) {
                            failMessage(
                                context, 'Désolé! Ce compte est bloqué.');
                          } else {
                            if (_depositAmount < Price.minimumDeposit) {
                              failMessage(context,
                                  'Le dépôt minimum est: ${Price.currency_symbol} ${Price.getWinningValues(Price.minimumDeposit)}');
                            } else if (_depositAmount > Price.maximumDeposit) {
                              failMessage(context,
                                  'Le dépôt minimum est: ${Price.currency_symbol} ${Price.getWinningValues(Price.maximumDeposit)}');
                            } else {
                              // do deposit logic here
                              print('Mix with the deposit API here');
                              if (_isAirtelMoney) {
                                print('The deposit is with airtel Money');
                              }
                              if (_isOrangeMoney) {
                                print('the Desposit is with Orange Money');
                                makeOrangeMoneyDeposit(_depositAmount);
                              }
                              if (_isMPesa) {
                                print('The Deposit is with Vodacom MPesa');
                              }
                              successMessage(
                                  context, 'Demande de dépôt en cours...');
                            }
                          }
                        });
                    },
                    fillColor: Colors.black87,
                    disabledElevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      'Déposez Maintenant'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Que se passe-t-il ensuite?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Votre compte sera mis à jour automatiquement.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
                // SizedBox(height: 5.0),
              ],
            ),
            SizedBox(height: 5.0),
            // SizedBox(height: 8.0),
            skiiyaWidget(),
            // airtelMoneyWidget(),
            orangeMoneyWidget(),
            // mPesaWidget(),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (mounted)
      setState(() {
        // LET US GET THE NETWORK OPERATOR
        getNetworkOperator();
        // print('loaded on start');
      });
    super.initState();
  }

  getNetworkOperator() {
    // GET THE USER PHONE NUMBER
    // WE WILL CHANGE THE DEFAULT NUMBER TO AN ORANGE NUMBER FOR
    // DEVELOPMENT PURPOSES
    // String _phone = Selection.userTelephone;
    String _phone = '0894093795';
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
  }

  Widget skiiyaWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 0.5, color: Colors.grey.shade300),
        // SizedBox(height: 5.0),
        Text(
          'Pour déposer de l\'argent sur votre compte, voir les instructions ci-dessous:',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12.0,
          ),
        ),
        // SizedBox(height: 10.0),
        SizedBox(height: 5.0),
        Divider(thickness: 0.5, color: Colors.grey.shade300),
        Text(
          'Dépôt sur le site de SKIIYA BET',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          '1. Connectez-vous sur skiiyabet.com',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '2. Sélectionnez "Dépôt" dans le menu',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '3. Entrez un montant de dépôt',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '4. Cliquez sur le bouton de "DÉPÔSEZ MAINTENANT"',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '5. Vous recevrez une demande d\'approbation sur votre téléphone',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '6. Lors de l\'approbation, le montant sera crédité sur votre compte de pari instantanément',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
      ],
    );
  }

  Widget orangeMoneyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.0),
        Divider(thickness: 0.5, color: Colors.grey.shade300),
        // SizedBox(height: 5.0),
        Text(
          'Dépôt via Orange Money',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          '1. Composez le *124#',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '2. Sélectionnez l\'option CDF',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '3. Sélectionnez l\'option 1. Envoi de l\'argent',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '4. Sélectionnez l\'option 1. Entrer Numero Surnom',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '5. Tapez SKIIYA',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '6. Entrez le montant que vous souhaitez déposer en CDF',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '7. Entrez votre code PIN pour valider le dépôt',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
        SizedBox(height: 2.0),
        Text(
          '8. Lors de l\'approbation, le montant sera crédité sur votre compte',
          style: TextStyle(color: Colors.black87, fontSize: 12.0),
        ),
      ],
    );
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

  void makeOrangeMoneyDeposit(double _depositAmount) async {
    // String _userPhone = Selection.userTelephone;
    String _defaultNum = '0894093795';
    String _userPhone = '+243' + _defaultNum.substring(1, (_defaultNum.length));
    // print(_userPhone);
    // print(_userPhone.length);
    print(_defaultNum);
    // print(_userPhone.substring(1, (_userPhone.length)));
    print('Making a deposit with orange Money');
    // START SENDING A DESPOSIT REQUEST TO ORANGE SERVER
    // var username = 'foo';
    // var password = 'foo';
    // var credential = base64.encode(utf8.encode('$username:$password'));
    var client = http.Client();

    var _port = '8080'; // PORT OF COMPANY
    var _serverIp = '151.101.1.195'; // IP ADDRESS OF COMPANY
    // var _token = 'wsdl'; // GET THE TOKEN FROM ORANGE MONEY
    var _token = '1063655'; // GET THE TOKEN FROM ORANGE MONEY

    var request = http.Request(
      'Deposit',
      Uri.parse(
          'https://$_serverIp:$_port/apigatewayom/apigwomService?$_token'),
    );
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Authorization $_token',
      'content-type': 'text/xml',
    });

    var _amount = 300; // AMOUNT TO DEPOSIT BY THE USER
    var _currency = 'CDF'; // CURRENCY SUPPORTED
    var _merchantNumer = '0899536676'; // COMPANY NUMBER
    var _clientNumber = '0894093795'; // CLIENT NUMBER
    var _agentCode = '1063655'; // CODE OF THE AGENT IN CDF
    var _transID = '0001646238236'; // TRANSACTION ID

    // SETTING THE XML BODY
    // var xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.ws1.com/">' +
    //     '<soapenv:Header/>' +
    //     '<soapenv:Body>' +
    //     '<ser:doS2M>' +
    //     '<subsmsisdn>$_clientNumber</subsmsisdn>' +
    //     '<PartnId>$_agentCode</PartnId>' +
    //     '<mermsisdn>$_merchantNumer</mermsisdn>' +
    //     '<transid>$_transID</transid>' +
    //     '<currency>$_currency</currency>' +
    //     '<amount>$_amount</amount>' +
    //     '<callbackurl>http://callbackurlws/wscallbacktestService</callbackurl>' +
    //     '<message_s2m> Vous avez sollicité un dépôt pour un montant de $_currency $_amount sur SKIIYA BET. Confirmez en tapant votre code PIN : </message_s2m>' +
    //     '</ser:doS2M>' +
    //     '</soapenv:Body>' +
    //     '</soapenv:Envelope>';

    // CHECKING THE BALANCE OF THE ACCOUNT
    var xml =
        '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.ws1.com/">' +
            '<soapenv:Header/>' +
            '<soapenv:Body>' +
            '<ser:TcheckBal>' +
            '<subsmsisdn>$_merchantNumer</subsmsisdn>' +
            '<currency>$_currency</currency>' +
            '<PartnId>$_agentCode</PartnId>' +
            '<transid>$_transID</transid>' +
            '</ser:TcheckBal>' +
            '</soapenv:Body>' +
            '</soapenv:Envelope>';

    // RESPONSE EXAMPLE
    //  <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
    //  <S:Body>
    //  <ns2:TcheckBalResponse xmlns:ns2="http://services.ws1.com/">
    //  <return>
    //  <balance>13.86</balance>
    //  <partnId>449</partnId>
    //  <resultCode>200</resultCode>
    //  <resultDesc>Success</resultDesc>
    //  <transId>4555566</transId>
    //  </return>
    //  </ns2:TcheckBalResponse>
    //  </S:Body>
    // </S:Envelope>

    // ADD THE XML CONTENT TO THE BODY
    request.body = xml;

    // SENDING THE REQUEST
    var streamedResponse = await client.send(request).catchError((e) {
      print('response error is: ${e.toString()}');
    });
    if (streamedResponse != null) {
      print(streamedResponse.statusCode);
      // GETTING THE BODY
      var responseBody = await streamedResponse.stream
          .transform(utf8.decoder)
          .join()
          .catchError((e) {
        print('body response error is: $e');
      });
      print(responseBody);
      // ON SUCCESSFULL DEPOSIT RESPONSE, ADD IT TO THE DEPOSIT COLLECTION
      // ADD TO DEPOSIT COLLECTION
      // addToDepositCollection(_depositAmount);
    } else {
      print('Could not reach the server properly due to an error');
    }

    // CLOSING THE CONNECTION
    client.close();
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

  void addToDepositCollection(double _depositAmount) async {
    // LET US GET THE USER ID
    String _uid = Selection.user.uid;
    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    String _date = _getDate();
    // WE GET THE CUSTOM TIME HERE
    var _time = _getTime();
    // GET THE CURRENT DATE TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // STORE THE TIMESTAMP
    int _timestamp = _datetime.toUtc().millisecondsSinceEpoch;

    // ADD A NEW REQUEST
    Method.addNewTransaction(
            'Dépôt', _depositAmount, '+', Selection.userTelephone)
        .then((_trans) {
      // LET US GET THE TRANSACTION ID HERE
      String _transID = _trans.documentID.toString();

      Firestore.instance.collection('UserBalance').document(_uid).updateData(
        {
          'balance': FieldValue.increment(_depositAmount),
          'last_trans_id': '$_transID',
        },
      ).then((_) {
        // ADD TO THE DEPOSIT COLLECTION
        Firestore.instance.collection('deposit').add({
          'uid': _uid,
          'amount': _depositAmount,
          'action_sign': '+',
          'currency': Price.currency_symbol,
          'admin_id': null,
          'trans_id': _transID,
          'status': 'pending',
          'time': {
            'time': '$_time',
            'date': '$_date',
            'date_time': '$_datetime',
            'timestamp': _timestamp,
            'timezone': 'UTC',
            'created': FieldValue.serverTimestamp(),
          },
        }).catchError((e) {
          // ADD THE DEPOSIT COLLECTION
          failMessage(context, 'Une erreur est survenue.');
        });
        // INCREASE THE USER BALANCE
        if (mounted)
          setState(() {
            // UPDATE THE USER BALANCE AUTOMATICALLY
            Selection.userBalance = Selection.userBalance + _depositAmount;
          });
        // addWithdrawRequest(withdrawAmount);
      }).catchError((e) {
        // BALANCE UPDATE ERROR
        failMessage(context, 'Une erreur est survenue.');
      });
    }).catchError((e) {
      // TRANSACTION UPDATE ERROR
      failMessage(context, 'Une erreur est survenue.');
    });
  }
}
