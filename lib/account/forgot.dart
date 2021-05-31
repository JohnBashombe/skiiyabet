import 'package:skiiyabet/app/skiiyaBet.dart';
import 'package:skiiyabet/components/selection.dart';
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
                          Window.showWindow = 14;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SkiiyaBet()));
                        });
                    },
                    fillColor: Colors.lightBlue.shade300,
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
                  child: Selection.showResendSMSinForgot
                      ? // check if there is a loding status or not
                      loadingPhoneReset
                          ? RawMaterialButton(
                              padding: new EdgeInsets.symmetric(vertical: 15.0),
                              onPressed: null,
                              fillColor: Colors.lightGreen[200],
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
                                      resultMessage(context,
                                          'Numéro non accepté', Colors.red, 3);
                                      // return;
                                      // hide the loading status
                                      loadingPhoneReset = false;
                                    } else {
                                      resultMessage(
                                          context,
                                          'Vérification du numéro...',
                                          Colors.lightGreen[400],
                                          2);
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
                              fillColor: Colors.lightGreen[400],
                              disabledElevation: 3.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(
                                'Envoyer'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                      : RawMaterialButton(
                          padding: new EdgeInsets.all(15.0),
                          onPressed: () {
                            if (mounted)
                              setState(() {
                                // redirect to update password
                                Window.showWindow = 19;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SkiiyaBet()));
                              });
                          },
                          fillColor: Colors.lightGreen[400],
                          disabledElevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            'Terminer le processus',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
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
            resultMessage(context, 'Numéro non enregistré', Colors.red, 3);
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
            .then((thisResult) {
          // generate the code then update the user reset field then send the code to the user number
          // generating the user reset password
          String generatedCode = thisResult['resetPassword'].toString();
          // sending the code to the user number now
          TwilioFlutter twilioFlutter = TwilioFlutter(
              accountSid:
                  'ACbb2ae40e19e030055d04a1787f2a325b', // replace *** with Account SID
              authToken:
                  'a21e567a1d705578a4acb6b652d95391', // replace xxx with Auth Token
              twilioNumber: '+17172592892' // replace .... with Twilio Number
              );

          twilioFlutter
              .sendSMS(
                  toNumber: '+243' + phone,
                  messageBody:
                      'Le code de confirmation pour modifier votre mot de passe sur SKIIYA BET est: ' +
                          generatedCode + '\nPlus d\'info sur https://www.skiiyabet.com')
              .then((value) {
            if (mounted)
              setState(() {
                // print('message sent successfully');
                // redirect to update password
                Selection.showResendSMSinForgot = false;
                Window.showWindow = 19;
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
                // hide the loading status
                loadingPhoneReset = false;
              });
          }).catchError((e) {
            resultMessage(context, 'SMS non envoyé', Colors.red, 3);
            //   // print('The error while sending sms is: $e');
          });
        });
      }
    }).catchError((e) {
      if (mounted)
        setState(() {
          // hide the loading status
          loadingPhoneReset = false;
          // print('Error occured while fetching : $e');
          // resultMessage(context, 'Error Detected', Colors.red, 3);
          // print('login error: $e');
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            resultMessage(context, 'Internet network error', Colors.red, 3);
            // print('Internet Connection Error');
          } else {
            resultMessage(context, 'Erreur inconnue', Colors.red, 3);
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
    return Scaffold.of(context).showSnackBar(
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
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
