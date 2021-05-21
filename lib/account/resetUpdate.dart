import 'dart:math';
import 'package:skiiyabet/Responsive/responsive_widget.dart';
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
bool loadingStatusUpdate = false;

class _RecoverPasswordState extends State<RecoverPassword> {
  // initialize the time needed to resend the SMS Code to client
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  Widget build(BuildContext context) {
    if (Selection.resetPhone.isEmpty) {
      // print('the reset phone is empty');
      return Expanded(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10.0, top: 10.0),
          padding: new EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey, width: 0.5),
              left: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vous n\'avez fourni aucun numéro de téléphone',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(color: Colors.grey, thickness: 0.5),
              SizedBox(height: 10.0),
              Center(
                child: RawMaterialButton(
                  padding: new EdgeInsets.all(15.0),
                  onPressed: () {
                    if (mounted)
                      setState(() {
                        Window.showWindow = 17;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SkiiyaBet()));
                      });
                  },
                  fillColor: Colors.lightGreen[400],
                  disabledElevation: 3.0,
                  child: Text(
                    'Ajouter un numéro de téléphone',
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
      return Expanded(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10.0, top: 10.0),
          padding: new EdgeInsets.all(15.0),
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
                  'Modifier Mot de passe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Divider(color: Colors.grey, thickness: 0.4),
              SizedBox(height: 20.0),
              // Divider(color: Colors.grey, thickness: 0.4),
              // SizedBox(height: 10.0),
              Center(
                child: Text(
                  'Un code à 6 chiffres a été envoyé à ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
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
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(
                    Icons.sms,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'SMS Code à 6 chiffres',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 5.0),
              Container(
                // padding: EdgeInsets.only(left: 5.0),
                height: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      // top:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                      // left:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      // right:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                    )),
                child: TextField(
                  onChanged: (value) {
                    if (mounted)
                      setState(() {
                        smsCode = value;
                        // print('SMS Code is: $smsCode');
                      });
                  },
                  cursorColor: Colors.lightGreen,
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
              SizedBox(height: 20.0),
              // Divider(color: Colors.grey, thickness: 0.4),
              // SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.vpn_key,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Nouveau mot de passe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 5.0),
              Container(
                // padding: EdgeInsets.only(left: 5.0),
                height: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      // top:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                      // left:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      // right:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                    )),
                child: TextField(
                  onChanged: (value) {
                    if (mounted)
                      setState(() {
                        newPassword = value;
                        // print('New Password is: $newPassword');
                      });
                  },
                  obscureText: true,
                  cursorColor: Colors.lightGreen,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // fillColor: Colors.deepOrange[400],
                      // contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Nouveau mot de passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 20.0),
              // Divider(color: Colors.grey, thickness: 0.4),
              // SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.vpn_key,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Confirmer le mot de passe',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                  ),
                ],
              ),
              // SizedBox(height: 5.0),
              Container(
                // padding: EdgeInsets.only(left: 5.0),
                height: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      // top:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      bottom: BorderSide(color: Colors.grey, width: 1.0),
                      // left:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      // right:
                      //     BorderSide(color: Colors.lightGreen[400], width: 2.0),
                    )),
                child: TextField(
                  onChanged: (value) {
                    if (mounted)
                      setState(() {
                        confirmNewPassword = value;
                        // print('Confirm New Password is: $confirmNewPassword');
                      });
                  },
                  obscureText: true,
                  cursorColor: Colors.lightGreen,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // fillColor: Colors.deepOrange[400],
                      // contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Confirmer le mot de passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 15.0),
              // SizedBox(height: 20.0),
              Text(
                'N\'a pas reçu le code?',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(height: 3.0),

              if (!Selection.showResendSMS)
                Row(
                  children: [
                    Text(
                      'Réessayer dans',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        // fontWeight: FontWeight.w300,
                      ),
                    ),
                    CountdownTimer(
                      secSymbol: "s",
                      endTime: endTime,
                      hoursTextStyle:
                          TextStyle(fontSize: 1, color: Colors.black),
                      minTextStyle: TextStyle(fontSize: 1, color: Colors.black),
                      // secTextStyle: TextStyle(fontSize: 18, color: Colors.black),
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
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              // SizedBox(height: 5.0),
              // Divider(color: Colors.grey, thickness: 0.5),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: loadingStatusUpdate
                    ? RawMaterialButton(
                        padding: new EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: null,
                        fillColor: Colors.lightGreen[200],
                        disabledElevation: 1.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Vérification',
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
                              // show the loading status in update and check the code
                              loadingStatusUpdate = true;
                              // testing();
                              // return false if one of fields is empty
                              if (smsCode.length > 0 &&
                                  newPassword.length > 0 &&
                                  confirmNewPassword.length > 0) {
                                if (smsCode.length > 6 || smsCode.length < 6) {
                                  resultMessage(
                                      context,
                                      'Format de code non accepté',
                                      Colors.red,
                                      3);
                                  // hide the loading status in update and check the code
                                  loadingStatusUpdate = false;
                                } else {
                                  // if passwords lenght is between 6 and 15
                                  if ((newPassword.length > 5 &&
                                          newPassword.length < 16) &&
                                      (confirmNewPassword.length > 5 &&
                                          confirmNewPassword.length < 16)) {
                                    // return false if password do not match
                                    if (newPassword
                                            .compareTo(confirmNewPassword) ==
                                        0) {
                                      // Now we can perform update operation
                                      // get the user Id
                                      Firestore.instance
                                          .collection('UserTelephone')
                                          .where('telephone',
                                              isEqualTo: Selection.resetPhone)
                                          .limit(1)
                                          .getDocuments()
                                          .then((_result) {
                                        // get the user id
                                        // do all operations if the record exists.
                                        if (_result.documents.length > 0) {
                                          Firestore.instance
                                              .collection('UserInfo')
                                              .document(_result
                                                  .documents[0].documentID
                                                  .toString())
                                              .get()
                                              .then((infoValue) {
                                            if (infoValue['resetPassword']
                                                    .toString()
                                                    .compareTo(smsCode) ==
                                                0) {
                                              String access = ('243' +
                                                  _result.documents[0]
                                                      ['telephone'] +
                                                  '@gmail.com');
                                              var customID =
                                                  Encryption.decryptAESCryptoJS(
                                                      infoValue['customID'],
                                                      access);
                                              // sign the user in to update his password
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: access,
                                                      password: customID)
                                                  .then((value) {
                                                if (value.user != null) {
                                                  // update the user password
                                                  updateUserPassword(access);
                                                  resultMessage(
                                                      context,
                                                      'Chargement...',
                                                      Colors.lightGreen[400],
                                                      3);
                                                } else {
                                                  // hide the loading status in update and check the code
                                                  loadingStatusUpdate = false;
                                                }
                                              }).catchError((e) {
                                                // if the login fails, show the trying again button
                                                // hide the loading status in update and check the code
                                                loadingStatusUpdate = false;
                                                if (e.toString().compareTo(
                                                        'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
                                                    0) {
                                                  resultMessage(
                                                      context,
                                                      'Pas d\'Internet',
                                                      Colors.red,
                                                      3);
                                                  // print('Internet Connection Error');
                                                } else {
                                                  resultMessage(
                                                      context,
                                                      'Erreur inconnue',
                                                      Colors.red,
                                                      3);
                                                }
                                                // print('login error is: $e');
                                              });
                                            } else {
                                              // if the user provide a wrong code
                                              resultMessage(
                                                  context,
                                                  'Ce Code est invalide',
                                                  Colors.red,
                                                  3);
                                              // hide the loading status in update and check the code
                                              loadingStatusUpdate = false;
                                            }
                                          });
                                          // FirebaseAuth.instance.

                                        } else {
                                          if (mounted)
                                            setState(() {
                                              // if the user provide a wrong code
                                              resultMessage(
                                                  context,
                                                  'Utilisateur non trouvé',
                                                  Colors.red,
                                                  3);
                                              // print('Unfound user');
                                              // show button if no user has been found in the db
                                              // hide the loading status in update and check the code
                                              loadingStatusUpdate = false;
                                            });
                                        }
                                      }).catchError((e) {
                                        if (e.toString().compareTo(
                                                'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
                                            0) {
                                          resultMessage(context,
                                              'Pas d\'Internet', Colors.red, 3);
                                          // print('Internet Connection Error');
                                        } else {
                                          resultMessage(context,
                                              'Erreur inconnue', Colors.red, 3);
                                        }
                                      });
                                    } else {
                                      // if passwords are not identicals
                                      resultMessage(
                                          context,
                                          'Les mots de passe ne correspondent pas',
                                          Colors.red,
                                          3);
                                      // hide the loading status in update and check the code
                                      loadingStatusUpdate = false;
                                    }
                                  } else {
                                    // if passwords lenght is not between 6 and 15
                                    resultMessage(
                                        context,
                                        'Format de mot de passe non accepté',
                                        Colors.red,
                                        3);
                                    // hide the loading status in update and check the code
                                    loadingStatusUpdate = false;
                                  }
                                }
                              } else {
                                // hide the loading status in update and check the code
                                loadingStatusUpdate = false;
                                // if at least one field is not filled
                                resultMessage(
                                    context,
                                    'S\'il vous plaît! \nRemplissez tous les champs',
                                    Colors.red,
                                    3);
                              }
                            });
                        },
                        fillColor: Colors.lightGreen[400],
                        disabledElevation: 3.0,
                        child: Text(
                          'Changer Mot de Passe',
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
    // print('the current user ID : $id');
    String generatedCode = '';
    Random random = new Random();
    for (int i = 0; i < 6; i++) {
      generatedCode = generatedCode + random.nextInt(10).toString();
    }
    // encrypt the user password before storing it to the database
    var secretKey = Encryption.encryptAESCryptoJS(newPassword, email);

    FirebaseUser _auth = await FirebaseAuth.instance.currentUser();
    // update the password
    _auth.updatePassword(newPassword).then((value) {
      // update code for password reset
      Firestore.instance.collection('UserInfo').document(_auth.uid).updateData({
        'resetPassword': generatedCode,
        'customID': secretKey,
      }).then((value) {
        if (mounted)
          setState(() {
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
            loadingStatusUpdate = false;
          });
      });
    }).catchError((e) {
      if (mounted)
        setState(() {
          // hide the loading status in update and check the code
          loadingStatusUpdate = false;
          // resultMessage(context, 'Error Detected', Colors.red, 3);
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            resultMessage(context, 'Pas d\'Internet', Colors.red, 3);
            // print('Internet Connection Error');
          } else {
            resultMessage(context, 'Erreur inconnue', Colors.red, 3);
          }
        });
    });
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
