import 'package:flutter_session/flutter_session.dart';
import 'package:skiiyabet/app/skiiyaBet.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:skiiyabet/encryption/encryption.dart';
import 'package:skiiyabet/mywindow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

// this store the phone to be checked
String _numberFilter = '';
String _phoneNumber = '';
// save the firebase instance here
Firestore _auth = Firestore.instance;
// show the loading status
bool loadingPhoneReset = false;
// GET THE CURRENT RESET VALUE
int _getResetCode = 1;
// GET THE CURRENT RESET DATE
int _getResetTimestamp = 0;

class _ForgotPasswordState extends State<ForgotPassword> {
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
                'Réinitialisation',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: 10.0),
            Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 10.0),
            Selection.showResendSMSinForgot
                ? Center(
                    child: Text(
                      'Donner votre numéro de téléphone pour réinitialiser le mot de passe',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Vous avez actuellement demandé un SMS pour la réinitialisation du mot de passe.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
            if (Selection.showResendSMSinForgot) SizedBox(height: 3.0),
            if (Selection.showResendSMSinForgot)
              Center(
                child: Text(
                  'Vous recevrez un code à 6 chiffres sur votre téléphone.\nDes frais supplementaires peuvent s\'appliquer',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (Selection.showResendSMSinForgot) SizedBox(height: 20.0),
            // if (Selection.showResendSMSinForgot)
            //   Text(
            //     'Téléphone',
            //     style: TextStyle(
            //       fontSize: 11.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // if (Selection.showResendSMSinForgot) SizedBox(height: 5.0),
            if (Selection.showResendSMSinForgot)
              Row(
                children: [
                  Container(
                    height: 50.0,
                    padding: new EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300),
                        bottom: BorderSide(color: Colors.grey.shade300),
                        left: BorderSide(color: Colors.grey.shade300),
                        // right: BorderSide(color: Colors.grey.shade300),
                      ),
                      // borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      '+243',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                            bottom: BorderSide(color: Colors.grey.shade300),
                            left: BorderSide(color: Colors.grey.shade300),
                            right: BorderSide(color: Colors.grey.shade300),
                          )),
                      child: TextField(
                        onChanged: (value) {
                          if (mounted)
                            setState(() {
                              _numberFilter = value;
                              // if (!checkNumber(value)) {
                              //   return;
                              // }
                              // print(_numberFilter);
                            });
                        },
                        cursorColor: Colors.lightBlue,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone',
                            hintMaxLines: 1,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0)),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20.0),
            // Divider(color: Colors.grey, thickness: 0.5),
            // SizedBox(height: 15.0),
            Row(
              children: [
                Container(
                  width: 80.0,
                  child: RawMaterialButton(
                    padding: new EdgeInsets.symmetric(vertical: 15.0),
                    onPressed: () {
                      if (mounted)
                        setState(() {
                          // REDIRECTING TO LOGIN PAGE
                          Window.showWindow = 14;
                          // REFRESHING THE MATERIAL PAGE ROUTE
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SkiiyaBet(),
                            ),
                          );
                        });
                    },
                    fillColor: Colors.black54,
                    disabledElevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      'Connexion',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  // width: double.infinity,
                  // check if there is some unfinished restting process
                  // check if there is a loding status or not
                  child: Selection.showResendSMSinForgot
                      ? loadingPhoneReset
                          ? RawMaterialButton(
                              padding: new EdgeInsets.symmetric(vertical: 15.0),
                              onPressed: null,
                              fillColor: Colors.black54,
                              disabledElevation: 1.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'En traitement',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  SizedBox(width: 3.0),
                                  SpinKitCircle(
                                    color: Colors.white,
                                    size: 13.0,
                                  ),
                                ],
                              ),
                            )
                          : RawMaterialButton(
                              padding: new EdgeInsets.all(15.0),
                              onPressed: () {
                                if (mounted)
                                  setState(() {
                                    // show the loading status
                                    loadingPhoneReset = true;
                                    if (!checkNumber(_numberFilter)) {
                                      resultMessage(
                                          context,
                                          'Format non accepté',
                                          Colors.red.shade300,
                                          3);
                                      // hide the loading status
                                      loadingPhoneReset = false;
                                    } else if (Selection.isUserBlocked ==
                                        true) {
                                      // SHOW A BLOCKING STATUS MESSAGE
                                      resultMessage(
                                          context,
                                          'Désolé! Ce compte est bloqué.',
                                          Colors.red.shade300,
                                          5);
                                    }
                                    // else if (Selection.allowSMSReset ==
                                    //     false) {
                                    //   // SHOW A BLOCKING STATUS MESSAGE
                                    //   resultMessage(
                                    //       context,
                                    //       'Vous avez demandé le code plusieurs fois.\nVeuillez réessayer plus tard',
                                    //       Colors.red.shade300,
                                    //       10);
                                    // }
                                    else {
                                      // UPDATE THE LOCAL VARIABLE FOR A FUTURE QUICK CHECKING
                                      Selection.isUserBlocked = false;
                                      resultMessage(
                                          context,
                                          'Vérification du numéro...',
                                          Colors.lightGreen[400],
                                          3);
                                      // set the number filter to phone
                                      _phoneNumber = _numberFilter;
                                      Selection.resetPhone = _phoneNumber;
                                      // set the not reset phone before ending of count to true
                                      // Selection.noShowResendSMSinForgot = true;
                                      // verify phone number
                                      executeFunction(_phoneNumber);
                                    }
                                  });
                              },
                              fillColor: Colors.black87,
                              disabledElevation: 3.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(
                                'Envoyer'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                      : RawMaterialButton(
                          padding: new EdgeInsets.all(15.0),
                          onPressed: () {
                            if (mounted)
                              setState(() {
                                // REDIRECTING TO UPDATE PASSWORD
                                Window.showWindow = 19;
                                // RENDERING THE MAIN ROUTE
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SkiiyaBet(),
                                  ),
                                );
                              });
                          },
                          fillColor: Colors.black87,
                          disabledElevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Terminer le processus',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void executeFunction(String phone) async {
    // print('the phone number is: $phone');
    await _auth
        .collection('UserTelephone')
        .where('telephone', isEqualTo: _phoneNumber)
        .limit(1)
        .getDocuments()
        .then((result) {
      if (result.documents.length == 0) {
        if (mounted)
          setState(() {
            // if the number has been not registered so far
            resultMessage(
                context, 'Numéro non enregistré', Colors.red.shade300, 3);
            // hide the loading status
            loadingPhoneReset = false;
            // set to empty the phone number reset
            Selection.resetPhone = '';
          });
      } else {
        // GET THE USER ID
        String _userId = result.documents[0].documentID.toString();
        // GET USER INFO
        Firestore.instance
            .collection('UserInfo')
            .document(_userId)
            .get()
            .then((thisResult) async {
          // LET US GET THE USER BLOCKING STATUS TO SEE IF HE IS ELIGIBLE
          // TO GET THE RESET PASSWORD CONFIRMATION CODE
          bool _blockedStatus = thisResult['isBlocked'];

          // INCREASE THE COUNT RESET SMS BY 1
          await countResetRequest().then((_) {
            // CONDITION FOR CODE SENDING
            if (Selection.allowSMSReset == true) {
              if (_blockedStatus == false) {
                // print('SENDING THE SMS CODE');
                // generate the code then update the user reset field then send the code to the user number
                // generating the user reset password
                String generatedCode = thisResult['resetPassword'].toString();
                // sending the code to the user number now
                // INITIALIZING THE TWILIO PACKAGE FOR MESSAGING
                 TwilioFlutter(
                  // replace *** with Account SID
                  accountSid: 'ACbb2ae40e19e030055d04a1787f2a325b',
                  // replace xxx with Auth Token
                  authToken: 'a21e567a1d705578a4acb6b652d95391',
                  // replace .... with Twilio Number
                  // twilioNumber: 'SKIIYA SARL',
                  twilioNumber: '+17172592892',
                  // SENDING A TWILIO REQUEST WITH TO THE SERVER WITH THIS PHONE NUMBER, CODE AND CONTENT
                )
                    .sendSMS(
                  toNumber: '+243' + phone,
                  messageBody:
                      'Le code pour modifier votre mot de passe sur SKIIYA BET est: ' +
                          generatedCode +
                          '\n\nPlus d\'info sur https://www.skiiyabet.com',
                )
                    .then((value) {
                  if (mounted)
                    setState(() {
                      // print("FINAL RESULT IS: $value");
                      // print('message sent successfully');
                      // redirect to update password
                      // REDIRECT TO ADD PHONE NUMBER
                      Selection.showResendSMSinForgot = false;
                      // REDIRECT TO UPDATE PASSWORD PANEL
                      Window.showWindow = 19;
                      // RENDERING OF THE MAIN CONTENT
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SkiiyaBet()));
                      // hide the loading status
                      loadingPhoneReset = false;
                    });
                }).catchError((e) {
                  // ERROR MESSAGE IF THE CODE WAS NOT SENT
                  resultMessage(
                      context, 'SMS non envoyé', Colors.red.shade300, 3);
                  //   // print('The error while sending sms is: $e');
                });
              } else {
                // SHOW A BLOCKING STATUS MESSAGE
                resultMessage(context, 'Désolé! Ce compte est bloqué.',
                    Colors.red.shade300, 10);
                // UPDATE THE LOCAL VARIABLE FOR A FUTURE QUICK CHECKING
                Selection.isUserBlocked = true;
              }
            } else {
              // IF THE ALLOW IS SET TO FALSE
              // JUST SET THE LOADING ACTION TO FALSE
              if (mounted)
                setState(() {
                  // hide the loading status
                  loadingPhoneReset = false;
                });
            }
          });
        });
      }
    }).catchError((e) {
      if (mounted)
        setState(() {
          // hide the loading status
          loadingPhoneReset = false;
          // print('login error: $e');
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            resultMessage(
                context, 'Internet network error', Colors.red.shade300, 3);
            // print('Internet Connection Error');
          } else {
            resultMessage(context, 'Erreur inconnue', Colors.red.shade300, 3);
          }
        });
    });
  }

  bool checkNumber(String value) {
    if (value.isEmpty) {
      // _phoneNumber = '';
      // _displayPhoneError = false;
      // _displayPhoneSuccess = false;
      return false;
    } else {
      // if (value.length == 1) {
      //   _displayPhoneError = false;
      //   _phoneMessage = '';
      //   print('reached');
      // }
      // tell the user to remove the first 0 if entered
      if (value.substring(0, 1).toString().compareTo('0') == 0) {
        // _displayPhoneError = true;
        // _phoneMessage = 'Remove the 1st \"0"';
        return false;
      }
      // check if the phone is congo network based
      if ((((value.substring(0, 1).toString().compareTo('8') == 0) &&
              (value.substring(1, 2).toString().compareTo('4') == 0)) ||
          ((value.substring(0, 1).toString().compareTo('8') == 0) &&
              (value.substring(1, 2).toString().compareTo('5') == 0)) ||
          ((value.substring(0, 1).toString().compareTo('8') == 0) &&
              (value.substring(1, 2).toString().compareTo('9') == 0)) ||
          ((value.substring(0, 1).toString().compareTo('8') == 0) &&
              (value.substring(1, 2).toString().compareTo('1') == 0)) ||
          ((value.substring(0, 1).toString().compareTo('8') == 0) &&
              (value.substring(1, 2).toString().compareTo('2') == 0)) ||
          ((value.substring(0, 1).toString().compareTo('9') == 0) &&
              (value.substring(1, 2).toString().compareTo('7') == 0)) ||
          ((value.substring(0, 1).toString().compareTo('9') == 0) &&
              (value.substring(1, 2).toString().compareTo('9') == 0)))) {
        if ((value.length == 9)) {
          // display success only if the number is right and valid
          // print(value.substring(1, 2).toString());
          // _displayPhoneError = false;
          // _displayPhoneSuccess = true;
          // _validNumber = true;
          // _phoneMessage = 'Valid Phone Number';
          return true;
        } else if (value.length < 9) {
          // _displayPhoneError = false;
          // _displayPhoneSuccess = true;
          // _validNumber = false;
          // _phoneMessage = 'Checking...';
          return false;
        }
      } else {
        // _displayPhoneError = true;
        // _displayPhoneSuccess = false;
        // _phoneMessage = 'Invalid Phone Number';
        return false;
      }

      if (value.length > 9) {
        // _displayPhoneError = true;
        // _displayPhoneSuccess = false;
        // _phoneMessage = 'Phone number too long';
        return false;
      }

      // get only nine numbers and give a damn about the rest
      // else if (value.length == 9) {
      // _phoneNumber = value.substring(0, 9);
      _phoneNumber = value.toString();
      //   print(value.substring(0, 9));
      //   return true;
      // }
      // print('the extracted phone number is: $_phoneNumber');
      // else {
      //   _phoneNumber = value;
      //   _displayPhoneError = false;
      // }
    }
    return true;
  }

  resultMessage(BuildContext context, String message, Color color, int sec) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: color,
        duration: Duration(seconds: sec),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future countResetRequest() async {
    // INITIALIZE THE SESSION
    var session = FlutterSession();
    // GET ALL VVALUES FROM LOCAL STORAGE
    String _permission1 = await session.get('_permission_1_');
    String _permission2 = await session.get('_permission_2_');
    // GET ALL VVALUES OF DATES FROM LOCAL STORAGE
    String _dateTime1 = await session.get('_duration_1_');
    String _dateTime2 = await session.get('_duration_2_');
    // CONDITIONS TO AVOID NON NULL VALUES
    if ((_permission1.toString().compareTo('null') != 0 &&
            _permission1.toString().compareTo('') != 0) &&
        (_permission2.toString().compareTo('null') != 0 &&
            _permission2.toString().compareTo('') != 0) &&
        (_dateTime1.toString().compareTo('null') != 0 &&
            _dateTime1.toString().compareTo('') != 0) &&
        (_dateTime2.toString().compareTo('null') != 0 &&
            _dateTime2.toString().compareTo('') != 0)) {
      // GET THE PERMISSION FROM LOCAL STORAGE
      String _getThisCode = Encryption.decryptAESCryptoJS(
        (_permission1 + _permission2), // PASS ENCRYPT
        '_permission_', // MODULE OF ENCRYPTION
      );

      _getResetCode = int.parse(_getThisCode);
      // GET THE DATE
      String _getThisdate = Encryption.decryptAESCryptoJS(
        (_dateTime1 + _dateTime2), // PASS ENCRYPT
        '_permission_', // MODULE OF ENCRYPTION
      );

      _getResetTimestamp = int.parse(_getThisdate);
    }
    // GET THE CURRENT TIMESTAMP
    int _currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    // print('will execute this $_getResetCode  $_getResetTimestamp');
    // GET COUNTER FOR VERIFICATION
    if (_getResetCode <= 2) {
      // print('pass here');
      // SET THE ALLOW REQUEST TO TRUE
      Selection.allowSMSReset = true;
      // INCREASE THE RESET CODE BY 1
      // print('The code will be sent TRYING: $_getResetCode');
      _getResetCode++;
      // print('access this here');
      // ENCRYPTING THE COUNTER AND THE TIMESTAMP
      await encyptAndStoreData(_getResetCode, _currentTimestamp);
    } else {
      // print('Code trying $_getResetCode');
      // int _timeMaxReset = 300000;
      // print('DIFF: ');
      // print(_currentTimestamp - _getResetTimestamp);
      // WE SUBSTRACT THE MINUTES BETWEEN THEM TO GET THE PENDING MINUTES
      int _min = DateTime.fromMillisecondsSinceEpoch(_currentTimestamp)
          .difference(DateTime.fromMillisecondsSinceEpoch(_getResetTimestamp))
          .inMinutes;
      // UPDATE THE VALUE IF IT IS GREATER THAN 5 MINUTES
      // print('The minutes are : ON TOP: $_min');
      if ((_min) >= 10) {
        // print('allow to reset password again');
        // SET THE ALLOW REQUEST TO TRUE
        if (mounted)
          setState(() {
            // SET ALLOW CODE RESENT TO TRUE
            Selection.allowSMSReset = true;
            // print('The minutes are in allow: $_min');
            // SET THE RESET CODE TO ITS INITIAL VALUE
            _getResetCode = 1;
            // INCREASE THE CODE COUNTER
            _getResetCode++;
          });
        // ENCRYPTING THE DATA
        // ENCRYPTING THE INITIAL COUNTER AND THE TIMESTAMP
        await encyptAndStoreData(_getResetCode, _currentTimestamp);
      } else {
        // print('You have have reached your daily update reset limit');
        // print('do not allow to reset password yet');
        // SET THE ALLOW REQUEST TO FALSE
        Selection.allowSMSReset = false;
        // print(DateTime.fromMillisecondsSinceEpoch(_currentTimestamp).second);
        // print(DateTime.fromMillisecondsSinceEpoch(_currentTimestamp).minute);
        // print(DateTime.fromMillisecondsSinceEpoch(_currentTimestamp).hour);
        // print('Separator');
        // print(DateTime.fromMillisecondsSinceEpoch(_getResetTimestamp)
        //     .millisecond);
        // print(DateTime.fromMillisecondsSinceEpoch(_getResetTimestamp).second);
        // print(DateTime.fromMillisecondsSinceEpoch(_getResetTimestamp).minute);
        // print(DateTime.fromMillisecondsSinceEpoch(_getResetTimestamp).hour);
        // print('OLD');

        // print('The minutes are in deny: $_min');
        // print('-=++++++++++++++++++++++++++++++++++++');
        // print('The seconds are: $_sec');
        // ONLY SHOW POSITIVE INTEGER VALUES
        _min = 10 - _min;
        if (_min < 1) _min = 1;
        String _output = _min <= 1 ? '$_min Minute' : '$_min Minutes';
        // LET US GET THE REMAINING SECONDS
        // PRINT AN ERROR MESSAGE
        if (mounted)
          setState(() {
            // SHOW A BLOCKING STATUS MESSAGE
            resultMessage(
              context,
              'Vous avez demandé le code plusieurs fois.\nVeuillez réessayer dans $_output.',
              Colors.red.shade300,
              5,
            );
          });
      }
    }
  }

  Future encyptAndStoreData(int _getResetCode, int _currentTimestamp) async {
    // INITIALIZE THE SESSION
    var session = FlutterSession();
    String _codeOrig = Encryption.encryptAESCryptoJS(
      _getResetCode.toString(), // USER CODE RESET COUNTER
      '_permission_', // STRING OF ENCRYPTION
    );
    String _dateOrig = Encryption.encryptAESCryptoJS(
      _currentTimestamp.toString(), // USER CODE RESET TIMESTAMP
      '_permission_', // STRING OF ENCRYPTION
    );

    // SHRINKING THE PART INTO TWO
    int _pemissionPart = _codeOrig.length / 2 as int;
    // GETTING THE FIRST PART OF THE PERMISSION
    String _perm1 = _codeOrig.substring(0, (_pemissionPart));
    // GETTING THE SECOND PART OF THE PERMISSION
    String _perm2 = _codeOrig.substring(_pemissionPart, (_codeOrig.length));
    // SETTING THE PERMISSION INTO LOCAL VARIABLES
    await session.set("_permission_1_", _perm1.toString());
    await session.set("_permission_2_", _perm2.toString());

    // SHRINKING DATE-TIME THE PART INTO TWO
    int _datePart = _dateOrig.length / 2 as int;
    // GETTING THE FIRST PART OF THE PERMISSION
    String _date1 = _dateOrig.substring(0, (_datePart));
    // GETTING THE SECOND PART OF THE PERMISSION
    String _date2 = _dateOrig.substring(_datePart, (_dateOrig.length));
    // SET THE DATE VARIABLE INTO LOCAL STORAGE
    await session.set("_duration_1_", _date1.toString());
    await session.set("_duration_2_", _date2.toString());
    // print('NEW DATA SAVED---------------------------------------------');
  }
}
