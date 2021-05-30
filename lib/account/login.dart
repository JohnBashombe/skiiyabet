import 'dart:math';
import 'package:skiiyabet/app/skiiyaBet.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:skiiyabet/encryption/encryption.dart';
import 'package:skiiyabet/mywindow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// CHANGE FROM LOGIN TO REGISTER
bool _showLoginPage = true;
// INITIALIZE THE FIREBASE AUTH INSTANCE
FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  // DO LOGOUT OF THE USER
  static void doLogout() async {
    // SIGN THE USER OUT
    _auth.signOut();
    // INITIALIZE THE SESSION
    var session = FlutterSession();
    // SET ALL TO DEFAULTS
    Selection.user = null; // FIREBASE USER
    Selection.userBalance = 0.0; // USER BALANCE
    Selection.userTelephone = ''; // USER TELEPHONE
    // SET ALL LOCAL VARIABLES TO NULL
    await session.set("_ph_1_", null);
    await session.set("_ph_2_", null);
    await session.set("_p1_", null);
    await session.set("_p2_", null);
  }
}

class _LoginState extends State<Login> {
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  // INITIALIZE THE VARIABLE KEYS
  final _formKeyPhone = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();
  // SAVE THE VALUE OF DATA AND MAIN VARIABLES
  String _phoneNumber = ''; // PHONE NUMBER
  String _password = ''; // PASSWORD
  String _passwordConfirm = ''; // CONFIRM PASSWORD
  // these are material displaying variables
  // this store the phone to be checked
  // FIELDS FILTERS
  String _numberFilter = ''; // PHONE NUMBER FILTER
  String _passwordFilter = ''; // PASSWORD FILTER
  String _confirmPasswordFilter = ''; // CONFIRM PASSWORD FILTER
  // ERROR MESSAGES VARIABLES
  String _phoneMessage = ''; // PHONE NUMBER MESSAGE
  String _passwordError = ''; // PASSWORD ERROR MESSAGE
  String _passwordConfirmError = ''; // CONFIRM PASSWORD ERROR MESSAGE
  // ERRORS HANDLERS
  bool _displayPhoneError = false; // PHONE NUMBER HANDLER ERROR
  bool _displayPasswordError = false; // PASSORD HANDLER ERROR
  bool _displayConfirmPasswordError = false; // CONFIRM PASSWORD HANDLER ERROR
  // SUCCESS HANDLERS
  bool _displayPhoneSuccess = false; // PHONE HANDLER SUCCESS
  bool _displayPasswordSuccess = false; // PASSWORD HANDLER SUCCESS
  bool _displayConfirmPasswordSuccess = false; // CONFIRM HANDLER SUCCESS
  // FIELD VALIDATORS
  bool _validNumber = false; // PHONE NUMBER VALIDATOR
  bool _validPassword = false; // PASSWORD VALIDATOR
  bool _validConfirmPassword = false; // CONFIRM HANDLER SUCCESS
  // boolean that displays the loading process.. on buttons
  // SHOW LOGIN LOADING BUTTON ACTION HANDLER
  bool loadingLoginButton = false; // LOGIN LOADER BUTTON ACTION
  // boolean that displays the loading process.. on buttons
  // SHOW REGISTER LOADING BUTTON ACTION HANDLER
  bool loadingRegisterButton = false; // REGISTER LOADER BUTTON ACTION

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10.0, top: 10.0),
        padding: new EdgeInsets.all(15.0),
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
            if (Selection.isPasswordChanged)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        Selection.isPasswordChanged = false;
                      });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: new EdgeInsets.all(10.0),
                    margin: new EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 1.0),
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                        left: BorderSide(color: Colors.grey, width: 1.0),
                        right: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: Text(
                        'Votre mot de passe a été modifié. \n    Connectez-vous maintenant!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Bienvenue!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w200,
                  ),
                )),
            SizedBox(height: 20.0),
            Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        // display the login page
                        _showLoginPage = true;
                      });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: new EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        border: Border(
                          // top: BorderSide(
                          //     color: _showLoginPage
                          //         ? Colors.lightGreen[400]
                          //         : Colors.grey,
                          //     width: 5.0),
                          bottom: BorderSide(
                            color: _showLoginPage
                                ? Colors.lightGreen[400]
                                : Colors.grey,
                            width: 2.0,
                          ),
                          // left: BorderSide(
                          //     color: _showLoginPage
                          //         ? Colors.lightGreen[400]
                          //         : Colors.grey,
                          //     width: 5.0),
                          // right: BorderSide(
                          //     color: _showLoginPage
                          //         ? Colors.lightGreen[400]
                          //         : Colors.grey,
                          //     width: 5.0),
                        ),
                        // borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          // _showLoginPage
                          //     ? Icon(
                          //         Icons.check,
                          //         color: Colors.lightGreen[400],
                          //         size: 20.0,
                          //       )
                          //     : Icon(
                          //         Icons.verified_user,
                          //         color: Colors.black,
                          //         size: 20.0,
                          //       ),
                          // SizedBox(width: 10.0),
                          Text(
                            'Connexion'.toUpperCase(),
                            style: TextStyle(
                              color: _showLoginPage
                                  ? Colors.lightGreen[400]
                                  : Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        // display the register page
                        _showLoginPage = false;
                        // set the confirm password to empty so that it can be reconfirmed
                        _confirmPasswordFilter = '';
                        _passwordConfirmError = '';
                        _displayConfirmPasswordSuccess = false;
                        _displayConfirmPasswordError = false;
                      });
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: new EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        border: Border(
                          // top: BorderSide(
                          // color: !_showLoginPage
                          //     ? Colors.lightGreen[400]
                          //     : Colors.grey,
                          // width: 5.0),
                          bottom: BorderSide(
                              color: !_showLoginPage
                                  ? Colors.lightGreen[400]
                                  : Colors.grey,
                              width: 2.0),
                          // left: BorderSide(
                          //     color: !_showLoginPage
                          //         ? Colors.lightGreen[400]
                          //         : Colors.grey,
                          //     width: 5.0),
                          // right: BorderSide(
                          //     color: !_showLoginPage
                          //         ? Colors.lightGreen[400]
                          //         : Colors.grey,
                          //     width: 5.0),
                        ),
                        // borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          // !_showLoginPage
                          //     ? Icon(
                          //         Icons.check,
                          //         color: Colors.lightGreen[400],
                          //         size: 20.0,
                          //       )
                          //     : Icon(
                          //         Icons.add_circle_outlined,
                          //         color: Colors.black,
                          //         size: 20.0,
                          //       ),
                          // SizedBox(width: 10.0),
                          Text(
                            'Inscription'.toUpperCase(),
                            style: TextStyle(
                              color: !_showLoginPage
                                  ? Colors.lightGreen[400]
                                  : Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 20.0),
            getPhone(context),
            SizedBox(height: 10.0),
            // Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 10.0),
            getPassword(context),
            SizedBox(height: 10.0),
            // if (!_showLoginPage) Divider(color: Colors.grey, thickness: 0.4),
            if (!_showLoginPage) SizedBox(height: 10.0),
            if (!_showLoginPage) getConfirmPassword(context),
            if (!_showLoginPage) SizedBox(height: 10.0),
            getValidator(context),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  getValidator(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (_showLoginPage) SizedBox(height: 5.0),
        if (_showLoginPage)
          GestureDetector(
            onTap: () {
              if (mounted)
                setState(() {
                  Window.showJackpotIndex = 0;
                  // show help and how to play page
                  Window.showWindow = 17;
                  // this is here because of login is outside of the main app but will be set inside
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
                });
            },
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: 16.0,
                  ),
                  SizedBox(width: 3.0),
                  Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Mot de passe oublié?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          // decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: 5.0),
        GestureDetector(
          onTap: () {
            if (mounted)
              setState(() {
                Window.showJackpotIndex = 2;
                // show help and how to play page
                Window.showWindow = 3;
                // this is here because of login is outside of the main app but will be set inside
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
              });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Colors.black,
                size: 16.0,
              ),
              SizedBox(width: 3.0),
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    'J\'accepte les conditions d\'utilisation',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      // decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0),
        _showLoginPage
            ? Container(
                width: double.infinity,
                child: loadingLoginButton
                    ? RawMaterialButton(
                        padding: new EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: null,
                        fillColor: Colors.lightGreen[200],
                        disabledElevation: 1.0,
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
                        padding: new EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: () {
                          if (mounted)
                            setState(() {
                              // hide the action button and display the loading button
                              loadingLoginButton = true;
                              // set the show window to false
                              Selection.isPasswordChanged = false;
                              // Window.showWindow = 0;
                              // print(_numberFilter.length);
                              // print(_numberFilter);
                              if (_numberFilter.length != 9) {
                                _displayPhoneError = true;
                                _displayPhoneSuccess = false;
                                _validNumber = false;
                                _phoneMessage = 'Numéro non accepté';
                                // show the action button and hide the loading button
                                loadingLoginButton = false;
                              } else if (_passwordFilter.length < 6 ||
                                  _passwordFilter.length > 15) {
                                _displayPasswordError = true;
                                _displayPasswordSuccess = false;
                                _validPassword = false;
                                _passwordError = 'Format non accepté';
                                // show the action button and hide the loading button
                                loadingLoginButton = false;
                              } else {
                                // print('this phone number: $_phoneNumber');
                                // check if the phone number is valid
                                if (checkNumber(_phoneNumber)) {
                                  // check if the password is valid
                                  if (_checkPassword(_password)) {
                                    // do login or register here
                                    doUserLogin(_phoneNumber, _password);
                                    // print('do login here bro!');
                                  } else {
                                    // to be displayed when the password meet the requirements
                                    _displayPasswordError = true;
                                    _displayPasswordSuccess = false;
                                    _validPassword = false;
                                    _passwordError = 'Format non accepté';
                                    // show the action button and hide the loading button
                                    loadingLoginButton = false;
                                  }
                                } else {
                                  // show the action button and hide the loading button
                                  loadingLoginButton = false;
                                  // to be displayed if everything is ok in phone input
                                  _displayPhoneError = true;
                                  _displayPhoneSuccess = false;
                                  _validNumber = false;
                                  _phoneMessage = 'Mauvais Format du numéro';
                                  return;
                                }
                              }
                            });
                        },
                        fillColor: Colors.lightGreen[400],
                        disabledElevation: 5.0,
                        child: Text(
                          'connexion'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
              )
            : Container(
                width: double.infinity,
                child: loadingRegisterButton
                    ? RawMaterialButton(
                        padding: new EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: null,
                        fillColor: Colors.lightGreen[200],
                        disabledElevation: 1.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Création',
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
                        padding: new EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: () {
                          if (mounted)
                            setState(() {
                              loadingRegisterButton = true;
                              // Window.showWindow = 0;
                              // print(_numberFilter.length);
                              // print(_numberFilter);
                              if (_numberFilter.length != 9) {
                                _displayPhoneError = true;
                                _displayPhoneSuccess = false;
                                _validNumber = false;
                                _phoneMessage = 'Numéro invalide';
                                // show th register again because of an error
                                loadingRegisterButton = false;
                              } else if (_passwordFilter.length < 6 ||
                                  _passwordFilter.length > 15) {
                                _displayPasswordError = true;
                                _displayPasswordSuccess = false;
                                _validPassword = false;
                                _passwordError = 'Format invalide';
                                // show th register again because of an error
                                loadingRegisterButton = false;
                              } else if (_confirmPasswordFilter.length < 6 ||
                                  _confirmPasswordFilter.length > 15) {
                                _displayConfirmPasswordError = true;
                                _displayConfirmPasswordSuccess = false;
                                _validConfirmPassword = false;
                                _passwordConfirmError = 'Format invalide';
                                // show th register again because of an error
                                loadingRegisterButton = false;
                              } else {
                                // print('password: $_password');
                                // print('confirm password: $_passwordConfirm');
                                // print('this phone number: $_phoneNumber');
                                // check if the phone number is valid
                                if (checkNumber(_phoneNumber)) {
                                  // check if the password is valid
                                  if (_checkPassword(_password)) {
                                    // check if the user has confirmed the password
                                    if (_checkConfirmPassword(
                                        _passwordConfirm)) {
                                      // do login or register here
                                      doUserRegister(_phoneNumber, _password);
                                      // print('do register here bro!');
                                    }
                                  } else {
                                    // to be displayed when the password meet the requirements
                                    _displayPasswordError = false;
                                    _displayPasswordSuccess = true;
                                    _validPassword = true;
                                    _passwordError = 'Format accepté';
                                    // show th register again because of an error
                                    loadingRegisterButton = false;
                                  }
                                } else {
                                  // show th register again because of an error
                                  loadingRegisterButton = false;
                                  // to be displayed if everything is ok in phone input
                                  _displayPhoneError = true;
                                  _displayPhoneSuccess = false;
                                  _validNumber = false;
                                  _phoneMessage = 'Numéro non accepté';
                                  return;
                                }
                              }
                            });
                        },
                        fillColor: Colors.lightGreen[400],
                        disabledElevation: 5.0,
                        child: Text(
                          'Inscription'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
              ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }

  getPhone(BuildContext context) {
    return Form(
      key: _formKeyPhone,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Téléphone',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Colors.grey,
            ),
          ),
          // SizedBox(height: 5.0),
          Row(
            children: [
              Container(
                height: 40.0,
                padding: new EdgeInsets.only(left: 5.0, top: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    // top: BorderSide(color: Colors.lightGreen[400], width: 3.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                    // left: BorderSide(color: Colors.lightGreen[400], width: 3.0),
                  ),
                  // borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  '+ (243) -',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  height: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border(
                        // top: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                        // left: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                        // right: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                      )),
                  child: TextFormField(
                    onChanged: (value) {
                      if (mounted)
                        setState(() {
                          // hide the top message for password changed status
                          Selection.isPasswordChanged = false;
                          _numberFilter = value;
                          if (!checkNumber(value)) {
                            return;
                          }
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
                        // fillColor: Colors.deepOrange[400],
                        // contentPadding: EdgeInsets.all(10.0),
                        hintText: '972..',
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
          SizedBox(height: 3.0),
          if (_displayPhoneError)
            Text(
              _phoneMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (_displayPhoneSuccess)
            Row(
              children: [
                Text(
                  _phoneMessage,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_validNumber)
                  Icon(
                    Icons.check,
                    size: 16.0,
                    color: Colors.green,
                  )
              ],
            ),
        ],
      ),
    );
  }

  bool checkNumber(String value) {
    if (value.isEmpty) {
      _phoneNumber = '';
      _displayPhoneError = false;
      _displayPhoneSuccess = false;
      return false;
    } else {
      // if (value.length == 1) {
      //   _displayPhoneError = false;
      //   _phoneMessage = '';
      //   print('reached');
      // }
      // tell the user to remove the first 0 if entered
      if (value.substring(0, 1).toString().compareTo('0') == 0) {
        _displayPhoneError = true;
        _phoneMessage = 'Retirer le 1er \"0"';
        return false;
      }
      // check if the phone is congo network based
      // Verify this condition only if we have 2 or more characters
      if (value.length > 1) {
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
            _displayPhoneError = false;
            _displayPhoneSuccess = true;
            _validNumber = true;
            _phoneMessage = 'Format accepté';
            // return true;
          } else if (value.length < 9) {
            _displayPhoneError = false;
            _displayPhoneSuccess = true;
            _validNumber = false;
            _phoneMessage = 'Vérification...';
            return false;
          }
        } else {
          _displayPhoneError = true;
          _displayPhoneSuccess = false;
          _phoneMessage = 'Numéro non accepté en R.D Congo';
          return false;
        }
      }

      if (value.length > 9) {
        _displayPhoneError = true;
        _displayPhoneSuccess = false;
        _phoneMessage = 'Numéro trop long';
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

  bool _checkPassword(String value) {
    if (value.isEmpty) {
      // _phoneNumber = '';
      _displayPasswordError = false;
      return false;
    } else {
      if (value.length < 6) {
        _displayPasswordError = true;
        _displayPasswordSuccess = false;
        _validPassword = false;
        _passwordError = 'La longueur minimale est 6';
        return false;
      } else if (value.length > 15) {
        _displayPasswordError = true;
        _displayPasswordSuccess = false;
        _validPassword = false;
        _passwordError = 'La longueur maximale est 15';
        return false;
      } else {
        _displayPasswordError = false;
        _displayPasswordSuccess = true;
        _validPassword = true;
        _passwordError = 'Format accepté';
      }
    }
    _password = value.toString();
    return true;
  }

  bool _checkConfirmPassword(String value) {
    if (value.isEmpty) {
      // _phoneNumber = '';
      _displayConfirmPasswordError = false;
      return false;
    } else {
      // store the value into the confirm password variable
      _passwordConfirm = value.toString();
      if (value.length < 6) {
        // check for lenght condition
        _displayConfirmPasswordError = true;
        _displayConfirmPasswordSuccess = false;
        _validConfirmPassword = false;
        _passwordConfirmError = 'La longueur minimale est de 6';
        return false;
      } else if (value.length > 15) {
        // check for lenght condition
        _displayConfirmPasswordError = true;
        _displayConfirmPasswordSuccess = false;
        _validConfirmPassword = false;
        _passwordConfirmError = 'La longueur maximale est de 15';
        return false;
      } else if (_password
              .toString()
              .compareTo(_confirmPasswordFilter.toString()) ==
          0) {
        _displayConfirmPasswordError = false;
        _displayConfirmPasswordSuccess = true;
        _validConfirmPassword = true;
        _passwordConfirmError = 'Mots de passe identiques';
      } else {
        _displayConfirmPasswordError = true;
        _displayConfirmPasswordSuccess = false;
        _validConfirmPassword = false;
        _passwordConfirmError = 'Mots de passe non identiques';
        return false;
      }
    }
    return true;
  }

  getPassword(BuildContext context) {
    return Form(
      key: _formKeyPassword,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Mot de Passe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: Colors.grey,
              )),
          // SizedBox(height: 5.0),
          Row(
            children: [
              Container(
                height: 40.0,
                padding: new EdgeInsets.only(left: 5.0, top: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    // top: BorderSide(color: Colors.lightGreen[400], width: 3.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                    // left: BorderSide(color: Colors.lightGreen[400], width: 3.0),
                  ),
                  // borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(
                  Icons.vpn_key,
                  size: 18.0,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  height: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border(
                        // top: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                        // left: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                        // right: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                      )),
                  child: TextField(
                    onChanged: (result) {
                      if (mounted)
                        setState(() {
                          // hide the top message for password changed status
                          Selection.isPasswordChanged = false;
                          _passwordFilter = result;
                          _checkPassword(result);
                        });
                    },
                    cursorColor: Colors.lightGreen,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
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
                      hintText: 'Password',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_displayPasswordError)
            Row(
              children: [
                Text(
                  _passwordError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (_displayPasswordSuccess)
            Row(
              children: [
                Text(
                  _passwordError,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_validPassword)
                  Icon(
                    Icons.check,
                    size: 16.0,
                    color: Colors.green,
                  )
              ],
            ),
        ],
      ),
    );
  }

  getConfirmPassword(BuildContext context) {
    return Form(
      key: _formKeyConfirmPassword,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Confirmez Mot de Passe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: Colors.grey,
              )),
          SizedBox(height: 5.0),
          Row(
            children: [
              Container(
                height: 40.0,
                padding: new EdgeInsets.only(left: 5.0, top: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    // top: BorderSide(color: Colors.lightGreen[400], width: 3.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                    // left: BorderSide(color: Colors.lightGreen[400], width: 3.0),
                  ),
                  // borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(
                  Icons.vpn_key,
                  size: 18.0,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  height: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border(
                        // top: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                        // left: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                        // right: BorderSide(
                        //     color: Colors.lightGreen[400], width: 3.0),
                      )),
                  child: TextField(
                    onChanged: (result) {
                      if (mounted)
                        setState(() {
                          _confirmPasswordFilter = result;
                          _checkConfirmPassword(result);
                        });
                    },
                    cursorColor: Colors.lightGreen,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
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
                      hintText: 'Confirmez Mot de Passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_displayConfirmPasswordError)
            Row(
              children: [
                Text(
                  _passwordConfirmError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (_displayConfirmPasswordSuccess)
            Row(
              children: [
                Text(
                  _passwordConfirmError,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_validConfirmPassword)
                  Icon(
                    Icons.check,
                    size: 16.0,
                    color: Colors.green,
                  )
              ],
            ),
        ],
      ),
    );
  }

  successMessage(BuildContext context, String message) {
    // ignore: deprecated_member_use
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

  failMessage(BuildContext context, String message) {
    // ignore: deprecated_member_use
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

  setSessionLogin(String _telephone, String _password) async {
    // Encrypting the email before saving it to user Device
    String _telephoneOriginal = Encryption.encryptAESCryptoJS(
      _telephone,
      '_skiiya_sarl_session_login_',
    );
    // String customEmail = email;
    // Encrypting the password before saving it to user device
    String _passOriginal = Encryption.encryptAESCryptoJS(
      _password, // USER PASSWORD
      _telephone, // USER PHONE
    );
    // print(customEmail);
    // print(customID);
    // EMAIL
    int _phoneParts = _telephoneOriginal.length / 2 as int;
    String _phone1 = _telephoneOriginal.substring(0, (_phoneParts));
    String _phone2 =
        _telephoneOriginal.substring(_phoneParts, (_telephoneOriginal.length));
    // PASSCODE
    int _passParts = _passOriginal.length / 2 as int;
    String _pass1 = _passOriginal.substring(0, (_passParts));
    String _pass2 = _passOriginal.substring(_passParts, (_passOriginal.length));
    // using session to store user login details
    var session = FlutterSession();
    // sB = SKIIYA BET
    await session.set("_ph_1_", _phone1.toString());
    await session.set("_ph_2_", _phone2.toString());
    await session.set("_p1_", _pass1.toString());
    await session.set("_p2_", _pass2.toString());
  }

  doUserLogin(String telephone, String passCode) async {
    String code = '243';
    String generatedEmail = code + telephone + '@gmail.com';
    // print('login has been reached and email is $generatedEmail');
    await _auth
        .signInWithEmailAndPassword(email: generatedEmail, password: passCode)
        .then((result) {
      Selection.user = result.user;
      // store credentials to session
      setSessionLogin(telephone.toString(), passCode.toString());
      // save the current user into the local storage for upcoming connection
      // Selection.getUserIdFromLocal = result.user.uid;
      // get the right user balance and the right user phone number
      // print('ID is ${Selection.getUserIdFromLocal}');
      // // VERIFY IF THE USER IS BLOCKED IN THE SYSTEM
      Firestore.instance
          .collection('UserInfo')
          .document(result.user.uid)
          .get()
          .then((_result) {
        // GET THE BLOCKING STATUS
        // bool isBlocked = false;
        // if (_result['isBlocked'] == null) {
        //   // create the column if not there already
        //   Firestore.instance
        //       .collection('UserInfo')
        //       .document(result.user.uid)
        //       .updateData({'isBlocked': false});
        //   // The column has been created
        //   // print('This blocked status is now created');
        // }
        if (_result['isBlocked'] == true) {
          // logout the user if he is being blocked in the system
          Login.doLogout();
          // print('The user has been blocked');
          failMessage(context, 'Désolé! Ce compte est bloqué.');
          if (mounted)
            setState(() {
              // placed under so that the effect won't be visible
              // show the action button and hide the loading button
              loadingLoginButton = false;
              // show th register again because of an error
              loadingRegisterButton = false;
              // successMessage(context, 'Félicitations! \nconnexion réussie');
            });
        } else {
          Firestore.instance
              .collection('UserBalance')
              .document(result.user.uid)
              .get()
              .then((_result) {
            // ADD THE USER PHONE TO LOCAL VARIABLE
            Selection.userTelephone = '0' + telephone;
            // LOAD THE USER BALANCE TOO INTO A VARIABLE
            Selection.userBalance = double.parse(_result['balance'].toString());
            // successMessage(context, 'Login Success!');
            // if the login is successful then go ack to home Page
            if (mounted)
              setState(() {
                // placed under so that the effect won't be visible
                // show the action button and hide the loading button
                loadingLoginButton = false;
                // show th register again because of an error
                loadingRegisterButton = false;
                // successMessage(context, 'Félicitations! \nconnexion réussie');
              });
            Window.showWindow = 0;
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
          }).catchError((e) {
            // print('loading user data error : $e');
            if (mounted)
              setState(() {
                // show the action button and hide the loading button
                loadingLoginButton = false;
                // show th register again because of an error
                loadingRegisterButton = false;
              });
            failMessage(context, 'Erreur de chargement.');
          });
        }
      });
    }).catchError((e) {
      if (mounted)
        setState(() {
          // show the action button and hide the loading button
          loadingLoginButton = false;
          // show th register again because of an error
          loadingRegisterButton = false;
          // print('login error: $e');
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            failMessage(context, 'Pas d\'Internet');
            // print('Internet Connection Error');
          } else {
            failMessage(context, 'Mot de Passe Incorrect');
          }
        });
    });
  }

  doUserRegister(String telephone, String passCode) async {
    // print('do register here bro!');
    String code = '243';
    String generatedEmail = code + telephone + '@gmail.com';
    // print('register has been reached and email is $generatedEmail');
    // print('register passcode is $passCode');

    await _auth
        .createUserWithEmailAndPassword(
            email: generatedEmail, password: passCode)
        .then((result) {
      if (result == null) {
        // print('We could not create a new account with this email');
        failMessage(context, 'La création du compte a échoué!');
        if (mounted)
          setState(() {
            // show th register again because of an error
            loadingRegisterButton = false;
          });
      } else {
        // encrypt the user password before storing it to the database
        var secretKey = Encryption.encryptAESCryptoJS(passCode, generatedEmail);
        // var decrypted = Encryption.decryptAESCryptoJS(encrypted, "password");
        String generatedCode = '';
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
          generatedCode = generatedCode + random.nextInt(10).toString();
        }

        // print('We did create a new account and id is: ${result.user.uid}');
        // add the balance section and the phone number section too
        // ADD USER BALANCE DETAILS HERE
        Firestore.instance
            .collection('UserBalance')
            .document(result.user.uid)
            .setData({'balance': 0.0, 'lastTransactionID': null});
        // ADD USER TELEPHONE DETAILS HERE
        Firestore.instance
            .collection('UserTelephone')
            .document(result.user.uid)
            .setData({'telephone': telephone});
        // ADD USER DETAILS INTO THE COLLECTION
        Firestore.instance
            .collection('UserInfo')
            .document(result.user.uid)
            .setData({
          'resetPassword': generatedCode,
          'customID': secretKey.toString(),
          'isBlocked': false, // FOR BLOCKING USERS
          'isActivated': false, // FOR ACTIVATING ACCOUNTS
        }).then((value) {
          // print('value aupdated successfully');
          Selection.user = result.user;
          // sign in the user directly
          successMessage(context, 'Félicitations! \nCompte créé!');
          doUserLogin(telephone, passCode);
        }).catchError((e) {
          if (mounted)
            setState(() {
              // show th register again because of an error
              loadingRegisterButton = false;
            });
          // if fail while creating an account
          // print('add you featured content error: $e');
          failMessage(context, 'Échec de l\'enregistrement!');
        });
      }
    }).catchError((e) {
      if (mounted)
        setState(() {
          // show th register again because of an error
          loadingRegisterButton = false;
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            failMessage(context, 'Pas d\'Internet');
            // print('Internet Connection Error');
          } else {
            failMessage(context, 'Numéro pris');
          }
        });
      // if fail while creating an account
      // print('We could not create a new account Error : $e');
      // failMessage(context, 'Verify or Change Data');
    });
  }
}
