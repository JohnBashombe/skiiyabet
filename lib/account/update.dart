import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skiiyabet/account/login.dart';
import 'package:skiiyabet/app/skiiyaBet.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:skiiyabet/encryption/encryption.dart';
import 'package:skiiyabet/methods/connexion.dart';
import 'package:skiiyabet/mywindow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  // FIELDS ERROR HANDLERS
  bool lenOld = false;
  bool lenNew = false;
  bool lenConNew = false;
  // INITIALIZE FIELDS
  String oldPassword = '';
  String newPassword = '';
  String newConfirmPassword = '';
  // messages variables
  String messOld = '';
  String messNew = '';
  String messConNew = '';
  // display loding state of button
  bool displayUpdateLoading = false;
  // SHOW THE PASSWORD IN PLAIN TEXT OR HIDDEN FORMAT
  bool _showPasswordHiddenFormat = true;
  //Create an instance of the current user.
  FirebaseUser _auth;

  @override
  Widget build(BuildContext context) {
    // IF WE HAVE A USER THEN SHOW THIS
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
        child: Selection.user == null
            ? ListView(
                padding: EdgeInsets.only(top: 0.0),
                children: [
                  headerDescriptor(),
                  ConnexionRequired(),
                ],
              )
            : ListView(
                padding: EdgeInsets.only(top: 0.0),
                children: [
                  headerDescriptor(),
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
                        child: Text(
                          _showPasswordHiddenFormat
                              ? 'afficher le mot de passe'
                              : 'masquer le mot de passe',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            // fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                            if (isNoData(value)) {
                              lenOld = false;
                            }
                            // execute if the lenght is >6 and <15
                            else if (isNoSized(value)) {
                              lenOld = true;
                              messOld = 'Longueur de mot de passe non accepté';
                              return false;
                            } else {
                              lenOld = false;
                              messOld = '';
                              oldPassword = value;
                              return true;
                            }
                          });
                      },
                      obscureText: _showPasswordHiddenFormat,
                      cursorColor: Colors.lightBlue,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            new RegExp(r'[a-zA-Z0-9]')),
                      ],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ancien mot de passe',
                          hintMaxLines: 1,
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0)),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  if (lenOld)
                    Text(
                      messOld,
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                            if (isNoData(value)) {
                              lenNew = false;
                            } else if (isNoSized(value)) {
                              lenNew = true;
                              messNew = 'Longueur de mot de passe non accepté';
                              return false;
                            } else {
                              lenNew = false;
                              messNew = '';
                              newPassword = value;
                              return true;
                            }
                          });
                      },
                      obscureText: _showPasswordHiddenFormat,
                      cursorColor: Colors.lightBlue,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            new RegExp(r'[a-zA-Z0-9]')),
                      ],
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
                  SizedBox(height: 5.0),
                  if (lenNew)
                    Text(
                      messNew,
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                            if (isNoData(value)) {
                              lenConNew = false;
                            }
                            // execute if the lenght is >6 and <15
                            else if (isNoSized(value)) {
                              lenConNew = true;
                              messConNew =
                                  'Longueur de mot de passe non accepté';
                              return false;
                            } else {
                              lenConNew = false;
                              messConNew = '';
                              newConfirmPassword = value;
                              return true;
                            }
                          });
                      },
                      obscureText: _showPasswordHiddenFormat,
                      cursorColor: Colors.lightBlue,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            new RegExp(r'[a-zA-Z0-9]')),
                      ],
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
                  SizedBox(height: 5.0),
                  if (lenConNew)
                    Text(
                      messConNew,
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    child: displayUpdateLoading
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
                                  'Chargement',
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
                            padding: EdgeInsets.all(15.0),
                            onPressed: () {
                              if (mounted)
                                setState(() {
                                  // UPDATE THE PASSWORD LOGIC GOES HERE
                                  updatepasswordMethod();
                                });
                            },
                            fillColor: Colors.black87,
                            disabledElevation: 3.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              'Changer'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                  ),
                  SizedBox(height: 50.0),
                ],
              ),
      ),
    );
  }

  bool isNoSized(String input) {
    if (input.length < 6 || input.length > 15) {
      return true;
    }
    return false;
  }

  bool isNoData(String input) {
    if (input.isEmpty) {
      return true;
    }
    return false;
  }

  showMessage(Color color, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: color,
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

  headerDescriptor() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'Changer mot de passe',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  // UPDATE PASSWORD LOGIC
  void updatepasswordMethod() {
    // show the loading status of the button
    displayUpdateLoading = true;
    if (oldPassword.length < 6 || oldPassword.length > 15) {
      // check if the old input password is well formatted
      lenOld = true;
      messOld = 'Mot de passe invalide';
      // hide the loading status of the button
      displayUpdateLoading = false;
    } else {
      lenOld = false;
      if (newPassword.length < 6 || newPassword.length > 15) {
        // confirm the lenght of the new password
        lenNew = true;
        messNew = 'Mot de passe invalide';
        // hide the loading status of the button
        displayUpdateLoading = false;
      } else {
        lenNew = false;
        if (newConfirmPassword.length < 6 || newConfirmPassword.length > 15) {
          // if the confirm new password is right
          lenConNew = true;
          messConNew = 'Mot de passe invalide';
          // hide the loading status of the button
          displayUpdateLoading = false;
        } else {
          // check if old and new password match
          if (newPassword.compareTo(newConfirmPassword) == 0) {
            lenConNew = false;
            // do update password process in here
            // check if the user has logged in first
            if (Selection.user == null) {
              // hide the loading status of the button
              displayUpdateLoading = false;
              showMessage(Colors.red.shade300, 'Connecter votre compte d\'abord');
            } else {
              // REFORMAT THE PHONE NUMBER
              String phone = Selection.userTelephone.substring(1, 10);
              // print(phone);
              String code = '243';
              String _generatedEmail = (code + phone + '@gmail.com');
              // print('generated Email: $generatedEmail');
              // ENCRYPTING THE PASSWORD BEFORE SENDING IT TO THE DATABASE
              var _secretKey =
                  Encryption.encryptAESCryptoJS(newPassword, _generatedEmail);
              // SIGNING THE USER IN
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _generatedEmail, password: oldPassword)
                  .then((_user) async {
                // value.user
                // if this account exists then change the user password
                // GET THE CURRENT USER
                _auth = await FirebaseAuth.instance.currentUser();
                // UPDATE THE PASSWORD OOF THIS USER
                _auth.updatePassword(newPassword).then((value) {
                  // print(_auth.uid);
                  // UPDATE BASIC USER INFO
                  Firestore.instance.collection('UserInfo').document(_auth.uid)
                      // ADDING THE ENCRYPTED PASSWORD
                      .updateData({'customID': _secretKey}).then((value) {
                    // if the user has successfully updated the password
                    showMessage(Colors.lightGreen[400], 'Mot de passe changé');
                    // sign the user out to test the new password
                    // LOG THIS VERY USER OUT
                    Login.doLogout();
                    // redirect the user to login page
                    Window.showWindow = 14;
                    // set the show change status to true
                    Selection.isPasswordChanged = true;
                    // hide the loading status of the button
                    displayUpdateLoading = false;
                    // reload the main frame so that we can be redirected to the login page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SkiiyaBet()));
                  }).catchError((e) {
                    if (mounted)
                      setState(() {
                        // hide the loading status of the button
                        displayUpdateLoading = false;
                        // if password reset failed
                        showMessage(
                            Colors.red.shade300, 'La mise à jour a échoué');
                      });
                  });
                }).catchError((e) {
                  if (mounted)
                    setState(() {
                      // hide the loading status of the button
                      displayUpdateLoading = false;
                      // if password reset failed
                      showMessage(
                          Colors.red.shade300, 'La mise à jour a échoué');
                    });
                });
                // print(catchError);
                // print('sign in successfully');
              }).catchError((e) {
                if (mounted)
                  setState(() {
                    // hide the loading status of the button
                    displayUpdateLoading = false;
                    // display if the account was found or any other error
                    // print('the login error is: $e');
                    showMessage(Colors.red.shade300, 'Ancien mot de passe incorrect');
                  });
              });
            }
          } else {
            // hide the loading status of the button
            displayUpdateLoading = false;
            messConNew = 'Les mots de passe ne sont pas identiques';
            lenConNew = true;
            // return false;
          }
        }
      }
    }
  }
}
