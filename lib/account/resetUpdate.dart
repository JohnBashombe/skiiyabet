import 'dart:math';
import 'package:skiiyabet/account/login.dart';
import 'package:skiiyabet/app/skiiyaBet.dart';
import 'package:skiiyabet/counter/countdown.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:skiiyabet/encryption/encryption.dart';
import 'package:skiiyabet/mywindow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_countdown_timer/countdown_timer.dart';

class RecoverPassword extends StatefulWidget {
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

String smsCode = '';
String newPassword = '';
String confirmNewPassword = '';
// show loading status
bool loadingButtonUpdate = false;
// SHOW THE PASSWORD IN PLAIN TEXT OR HIDDEN FORMAT
bool _showPasswordHiddenFormat = true;

class _RecoverPasswordState extends State<RecoverPassword> {
  // initialize the time needed to resend the SMS Code to client
  // RESEND THE NEW CODE AFTER 60 SECONDS
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  @override
  Widget build(BuildContext context) {
    // DISPLAY IF WE DETECT NO NUMBER
    if (Selection.resetPhone.isEmpty) {
      // print('the reset phone is empty');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vous n\'avez fourni aucun numéro de téléphone',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(color: Colors.grey, thickness: 0.4),
              SizedBox(height: 10.0),
              Center(
                child: RawMaterialButton(
                  padding: new EdgeInsets.all(15.0),
                  onPressed: () {
                    if (mounted)
                      setState(() {
                        Window.showWindow = 17;
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
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    'Ajouter numéro'.toUpperCase(),
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
        ),
      );
    } else {
      // print('the reset phone is not empty: ${Selection.resetPhone}');
      // IF WE DO HAVE A PHONE NUMBER THEN DISPLAY THIS
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
                  'Modifier Mot de passe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SizedBox(height: 20.0),
              Divider(color: Colors.grey, thickness: 0.4),
              SizedBox(height: 10.0),
              // Divider(color: Colors.grey, thickness: 0.4),
              // SizedBox(height: 10.0),
              Center(
                child: Text(
                  'Un code à 6 chiffres a été envoyé à ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 2.0),
              Center(
                child: Text(
                  '+243 ' + Selection.resetPhone,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
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
                        smsCode = value;
                        // print('SMS Code is: $smsCode');
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
                      hintText: 'SMS Code',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        // WE SHOW THE PLAIN TEXT OR HIDE IT
                        if (_showPasswordHiddenFormat) {
                          // HIDE
                          _showPasswordHiddenFormat = false;
                        } else {
                          // SHOW
                          _showPasswordHiddenFormat = true;
                        }
                      });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _showPasswordHiddenFormat ? 'Afficher' : 'Masquer',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            // fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        _showPasswordHiddenFormat
                            ? Icon(
                                Icons.visibility,
                                size: 18.0,
                                color: Colors.lightBlue,
                              )
                            : Icon(
                                Icons.visibility_off_rounded,
                                size: 18.0,
                                color: Colors.lightBlue,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
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
                        newPassword = value;
                        // print('New Password is: $newPassword');
                      });
                  },
                  obscureText: _showPasswordHiddenFormat,
                  cursorColor: Colors.lightBlue,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nouveau mot de passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
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
                        confirmNewPassword = value;
                        // print('Confirm New Password is: $confirmNewPassword');
                      });
                  },
                  obscureText: _showPasswordHiddenFormat,
                  cursorColor: Colors.lightBlue,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirmer mot de passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'N\'a pas reçu le code ? ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              if (!Selection.showResendSMS)
                Row(
                  children: [
                    Text(
                      'Réessayer dans ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CountdownTimer(
                      secSymbol: "s",
                      minSymbol: "m:",
                      endTime: endTime,
                      // secSymbolTextStyle: TextStyle(
                      //   fontSize: 15.0,
                      //   fontWeight: FontWeight.bold,
                      //   color: Colors.lightBlue,
                      // ),

                      hoursTextStyle:
                          TextStyle(fontSize: 1.0, color: Colors.transparent),
                      // minTextStyle:
                      //     TextStyle(fontSize: 1.0, color: Colors.transparent),
                      // secTextStyle: TextStyle(fontSize: 18, color: Colors.black),
                      textStyle: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      onEnd: () {
                        if (mounted)
                          setState(() {
                            Selection.showResendSMS = true;
                            // print("Game Over");
                          });
                      },
                    ),
                  ],
                ),
              if (Selection.showResendSMS)
                GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        // set the resend to false again
                        Selection.showResendSMS = false;
                        Selection.showResendSMSinForgot = true;
                        // redirect to reset phone
                        Window.showWindow = 17;
                        // SET THE FIELD OF PHONE NUMBER TO EMPTY
                        Selection.resetPhone = '';
                        // refresh the material page
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SkiiyaBet()));
                        // set the user phone to null
                        Selection.resetPhone = '';
                      });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'Renvoyer le code',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: loadingButtonUpdate
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
                              'Modification'.toUpperCase(),
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
                              // RESET AND UPDATE THE USER PASSWORD
                              updatePasswordMethod();
                            });
                        },
                        fillColor: Colors.black87,
                        disabledElevation: 3.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          'Modifier'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void updateUserPassword(String email) async {
    // THE NEXT USER RESET PASSWORD CODE
    String generatedCode = '';
    // RANDOM CLASS INITIALIZATION
    Random random = new Random();
    // LOOPING
    for (int i = 0; i < 6; i++) {
      // GENERATE 6 RANDOM INTEGERS AND STORE THEM IN A STRING
      generatedCode = generatedCode + random.nextInt(10).toString();
    }
    // encrypt the user password before storing it to the database
    // ENCRYPTING THE PASSWORD BEFORE SENDING IT TO THE DATABASE
    var secretKey = Encryption.encryptAESCryptoJS(newPassword, email);
    // FIREBASE USER INITIALIZATION
    FirebaseUser _auth = await FirebaseAuth.instance.currentUser();
    // update the password
    _auth.updatePassword(newPassword).then((value) {
      // update code for password reset
      Firestore.instance.collection('UserInfo').document(_auth.uid).updateData({
        'resetPassword': generatedCode, // 6 DIGITS INITIALIZATION
        'customID': secretKey, // ENCRYPTED PASSWORD
      }).then((value) {
        if (mounted)
          setState(() {
            // SET THE RESET PHONE NUMBER TO EMPTY
            // ON SUCCESSFULL PASSWORD UPDATE
            Selection.resetPhone = '';
            // log the user out
            Login.doLogout();
            // redirect to login page for sign in
            // redirect the user to login page
            Window.showWindow = 14;
            // set the show change status to true
            Selection.isPasswordChanged = true;
            // reload the main frame so that we can be redirected to the login page
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
            // hide the loading status in update and check the code
            loadingButtonUpdate = false;
          });
      });
    }).catchError((e) {
      if (mounted)
        setState(() {
          print('Update Password error: $e');
          // hide the loading status in update and check the code
          loadingButtonUpdate = false;
          // resultMessage(context, 'Error Detected', Colors.red.shade300, 3);
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            resultMessage(context, 'Pas d\'Internet', Colors.red.shade300, 3);
            // print('Internet Connection Error');
          } else {
            resultMessage(context, 'Erreur inconnue', Colors.red.shade300, 3);
          }
        });
    });
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
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  void updatePasswordMethod() {
    // show the loading status in update and check the code
    loadingButtonUpdate = true;
    // return false if one of fields is empty
    if (smsCode.length > 0 &&
        newPassword.length > 0 &&
        confirmNewPassword.length > 0) {
      if (smsCode.length > 6 || smsCode.length < 6) {
        resultMessage(
            context, 'Format du code non accepté', Colors.red.shade300, 3);
        // hide the loading status in update and check the code
        loadingButtonUpdate = false;
      } else {
        // if passwords lenght is between 6 and 15
        if ((newPassword.length > 5 && newPassword.length < 16) &&
            (confirmNewPassword.length > 5 && confirmNewPassword.length < 16)) {
          // return false if password do not match
          if (newPassword.compareTo(confirmNewPassword) == 0) {
            // Now we can perform update operation
            // get the user Id
            Firestore.instance
                .collection('UserTelephone')
                .where('telephone', isEqualTo: Selection.resetPhone)
                .limit(1)
                .getDocuments()
                .then((_result) {
              // get the user id
              // do all operations if the record exists.
              if (_result.documents.length > 0) {
                String _uid = _result.documents[0].documentID.toString();
                Firestore.instance
                    .collection('UserInfo')
                    .document(_uid)
                    .get()
                    .then((infoValue) {
                  if (infoValue['resetPassword']
                          .toString()
                          .compareTo(smsCode) ==
                      0) {
                    // GET THE USER PHONE NUMBER
                    String _tel = _result.documents[0]['telephone'].toString();
                    // BUILD THE EMAIL
                    String _customEmail = ('243' + _tel + '@gmail.com');
                    // PASSWORD ENCRYPTED
                    String _crypt = infoValue['customID'].toString();
                    // DECRYPTING THE CURRENT PASSWORD BEFORE UPDATING IT
                    var _customPassword =
                        Encryption.decryptAESCryptoJS(_crypt, _customEmail);

                    // sign the user in to update his password
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _customEmail, password: _customPassword)
                        .then((value) {
                      if (value.user != null) {
                        // update the user password
                        updateUserPassword(_customEmail);
                        // resultMessage(context, 'Chargement...',
                        //     Colors.lightGreen[400], 3);
                      } else {
                        // hide the loading status in update and check the code
                        loadingButtonUpdate = false;
                      }
                    }).catchError((e) {
                      if (mounted)
                        setState(() {
                          // if the login fails, show the trying again button
                          // hide the loading status in update and check the code
                          loadingButtonUpdate = false;
                          if (e.toString().compareTo(
                                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
                              0) {
                            resultMessage(context, 'Pas d\'Internet',
                                Colors.red.shade300, 3);
                            // print('Internet Connection Error');
                          } else {
                            resultMessage(context, 'Erreur inconnue',
                                Colors.red.shade300, 3);
                          }
                          print('login error is: $e');
                        });
                    });
                  } else {
                    if (mounted)
                      setState(() {
                        // if the user provide a wrong code
                        resultMessage(context, 'Ce code est invalide',
                            Colors.red.shade300, 3);
                        // hide the loading status in update and check the code
                        loadingButtonUpdate = false;
                      });
                  }
                });
                // FirebaseAuth.instance.

              } else {
                if (mounted)
                  setState(() {
                    // if the user provide a wrong code
                    resultMessage(context, 'Ce compte est introuvable',
                        Colors.red.shade300, 3);
                    // print('Unfound user');
                    // show button if no user has been found in the db
                    // hide the loading status in update and check the code
                    loadingButtonUpdate = false;
                  });
              }
            }).catchError((e) {
              if (e.toString().compareTo(
                      'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
                  0) {
                resultMessage(
                    context, 'Pas d\'Internet', Colors.red.shade300, 3);
                // print('Internet Connection Error');
              } else {
                resultMessage(
                    context, 'Erreur inconnue', Colors.red.shade300, 3);
              }
              print('getting the phone number');
            });
          } else {
            // if passwords are not identicals
            resultMessage(context, 'Les mots de passe ne sont pas identiques',
                Colors.red.shade300, 3);
            // hide the loading status in update and check the code
            loadingButtonUpdate = false;
          }
        } else {
          // if passwords lenght is not between 6 and 15
          resultMessage(context, 'Format de mot de passe non accepté',
              Colors.red.shade300, 3);
          // hide the loading status in update and check the code
          loadingButtonUpdate = false;
        }
      }
    } else {
      // hide the loading status in update and check the code
      loadingButtonUpdate = false;
      // if at least one field is not filled
      resultMessage(context, 'S\'il vous plaît! \nRemplissez tous les champs',
          Colors.red.shade300, 3);
    }
  }
}
