import 'dart:async';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:skiiyabet/account/login.dart';
import 'package:skiiyabet/app/entities/oddSelection.dart';
import 'package:skiiyabet/encryption/encryption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/database/betslip.dart';
import 'package:skiiyabet/database/price.dart';
import 'package:skiiyabet/database/selection.dart';
import 'package:skiiyabet/mywindow.dart';
import 'package:skiiyabet/methods/methods.dart';
import 'package:skiiyabet/account/forgot.dart';
import 'package:skiiyabet/account/resetUpdate.dart';
import 'package:skiiyabet/account/update.dart';
import 'package:skiiyabet/help/help.dart';
// import 'package:skiiyabet/jackpot/jackpot.dart';
import 'package:skiiyabet/windows/bet/bets.dart';
import 'package:skiiyabet/windows/bet/history.dart';
import 'package:skiiyabet/windows/transaction/deposit.dart';
import 'package:skiiyabet/windows/support/support.dart';
import 'package:skiiyabet/windows/transaction/transaction.dart';
import 'package:skiiyabet/windows/transaction/withdraw.dart';
import 'package:http/http.dart' as http;

import 'entities/fetching.dart';

// create a variable that loads game details
DocumentSnapshot matchMoreOdds;
Color color, colorBg, colorRounded, colorCaption;
int _selectedIndex = 0;
// store loaded games
var data = [];
// this array contains
var loadSideDataArrayChamp = [];
var loadSideDataArrayCountry = [];
// this variable indicated which field should have load more
int fieldLoadMore = 0;
// display the betslip error message
bool _displayTextError = false;
bool _displayTextMaxError = false;
// variable from search panel
// store loaded results
var _queryResults = [];
// store filtered results
var _queryDisplay = [];
// check weither input is empty or not to display no data found
bool _isQueryEmpty = true;
// this variable display betting slip error message
bool showBetslipMessagePanel = false;
String showBetslipMessage = '';
// color to show along with the message
Color showBetslipMessageColor = Colors.black;
Color showBetslipMessageColorBg = Colors.red[200];
// bool _resendCode = false;
FirebaseAuth _auth = FirebaseAuth.instance;
// boolean that displays the loading process.. on buttons
bool _loadingBettingButton = false;

// FTECH MATCH INSTAMCE
FetchMatch _fetchMatch = new FetchMatch();

// This array stores all the selected indices of championships
// // THIS VARIABLE ASSIGN THE VALUE OF THE SELECTED CHAMPIONSHIP IN DESKTOP MODE
int _indexChampionSelection = -1;

// Store all fetched matches and ready-to-use
// ignore: deprecated_member_use
var _matches = []; // CONTAINS ALL MATCHES
var _leagues = []; // CONTAINS ALL LEAGUES
var _countries = []; // CONTAINS ALL COUNTRIES

// CONTAINS THE ODDS OF MATCHES AND INDEXES
var oddsGameArray = [];

// THE COLOR OF THE ODD BUTTONS
Color _buttonColor = Colors.grey.shade200;
Color _labelColor = Colors.black87;

// THIS VARIABLE SWITCH WINDOWS FROM HOME PAGE GAMES TO MORE ODDS WINDOW
bool switchToMoreMatchOddsWindow = false;

// THIS WILL CONTAIN THE CURRENT MATCH TO LOAD MORE ODDS
var moreOddsMatch;
// IT STORE THE ODDS OF THE GAME WE WILL NEDD
var moreLoadedMatchOdds;

class SkiiyaBet extends StatefulWidget {
  @override
  _SkiiyaBetState createState() => _SkiiyaBetState();
}

class _SkiiyaBetState extends State<SkiiyaBet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              elevation: 0,
              excludeHeaderSemantics: true,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Text(
                    'Skiiya'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ResponsiveWidget.isSmallScreen(context)
                            ? 17.0
                            : 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'Bet'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: ResponsiveWidget.isSmallScreen(context)
                            ? 17.0
                            : 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                Container(
                  height: ResponsiveWidget.isSmallScreen(context) ? 50.0 : 59.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: new EdgeInsets.only(right: 10.0),
                        width: ResponsiveWidget.isSmallScreen(context)
                            ? (MediaQuery.of(context).size.width - 60.0) * 0.60
                            : (MediaQuery.of(context).size.width - 60.0) * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // scrollDirection: Axis.horizontal,
                          children: [
                            if (ResponsiveWidget.isLargeScreen(context) ||
                                ResponsiveWidget.customScreen(context) ||
                                ResponsiveWidget.isMediumScreen(context))
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, right: 10.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.grey, width: 1.5))),
                                  // child: IconButton(
                                  //     icon: Icon(Icons.notifications), onPressed: null),
                                ),
                              ),
                            // SizedBox(width: 10.0),
                            // display this phone number and amount if the user has logged in
                            (Selection.user != null)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(width: 2.0),
                                      Text(
                                        // '0972 977 512',
                                        Selection.userTelephone.toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 1.0,
                                      ),
                                      Text(
                                        // Price.getWinningValues(Price.balance) +' Fc',
                                        Price.getWinningValues(
                                                Selection.userBalance) +
                                            ' Fc',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? 13.0
                                                  : 14.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (mounted)
                                        setState(() {
                                          // on click display the login button
                                          // redirect to login page
                                          Window.showWindow = 14;
                                        });
                                    },
                                    child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 35.0,
                                                // padding: new EdgeInsets.symmetric(
                                                //     horizontal: 5.0),
                                                child: ButttonWithIcon(
                                                  icon: Icons.login,
                                                  buttonColor:
                                                      Colors.lightGreen[400],
                                                  color: Colors.white,
                                                  title: ResponsiveWidget
                                                          .isExtraSmallScreen(
                                                              context)
                                                      ? 'Mon\nCompte'
                                                      : 'Mon Compte',
                                                  onPressed: () {
                                                    if (mounted)
                                                      setState(() {
                                                        // on click display the login button
                                                        // redirect to login page
                                                        Window.showWindow = 14;
                                                      });
                                                  },
                                                ))
                                          ],
                                        )),
                                  ),
                            SizedBox(width: 10.0),
                            // display the counter in the app bar with NO ACTION
                            if (!(ResponsiveWidget.isMediumScreen(context) ||
                                ResponsiveWidget.isSmallScreen(context)))
                              Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Container(
                                  padding: EdgeInsets.only(left: 8.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: Colors.grey, width: 1.5))),
                                  child: Container(
                                    // width: 15.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                        bottom: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                        left: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                        right: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      // color: Colors.lightBlue,
                                    ),
                                    child: Text(
                                      (BetSlipData.gameIds.length.toString()),
                                      style: TextStyle(
                                        color: Colors.lightGreen[400],
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            // display the counter in the app bar with A CLICKING ACTION
                            if (ResponsiveWidget.isMediumScreen(context) ||
                                ResponsiveWidget.isSmallScreen(context))
                              GestureDetector(
                                onTap: () {
                                  if (mounted)
                                    setState(() {
                                      Window.showWindow = 20;
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (_) => SkiiyaBet()));
                                    });
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 8.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.5))),
                                      child: Container(
                                        // width: 15.0,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Colors.lightGreen[400],
                                                width: 3.0),
                                            bottom: BorderSide(
                                                color: Colors.lightGreen[400],
                                                width: 3.0),
                                            left: BorderSide(
                                                color: Colors.lightGreen[400],
                                                width: 3.0),
                                            right: BorderSide(
                                                color: Colors.lightGreen[400],
                                                width: 3.0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          // color: Colors.lightBlue,
                                        ),
                                        child: Text(
                                          (BetSlipData.gameIds.length
                                              .toString()),
                                          style: TextStyle(
                                            color: Colors.lightGreen[400],
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : null,
      body: GestureDetector(
        onTap: () {
          if (mounted)
            setState(() {
              FocusScope.of(context).requestFocus(new FocusNode());
              // print('clicked');
            });
        },
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!ResponsiveWidget.isSmallScreen(context))
                Column(
                  children: [
                    Container(
                      width: 50.0,
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                            width: 0.4,
                          ),
                        ),
                      ),
                      child: ListView(
                          // padding: EdgeInsets.only(left: 0.0),
                          children: _sideMenuList
                              .asMap()
                              .entries
                              .map((MapEntry map) => _sideMenuMethod(map.key))
                              .toList()),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border(
                          right: BorderSide(color: Colors.grey, width: 0.4),
                        ),
                      ),
                      child: Center(
                        child: ClipOval(
                          child: (Selection.user == null)
                              ? Container(
                                  width: 40.0,
                                  height: 40.0,
                                  // padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen[400],
                                  ),
                                  child: IconButton(
                                    tooltip: 'CONNECTEZ-VOUS'.toUpperCase(),
                                    icon: Icon(
                                      FontAwesomeIcons.signInAlt,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (mounted)
                                        setState(() {
                                          Window.showWindow = 14;
                                        });
                                    },
                                  ))
                              : Container(
                                  width: 40.0,
                                  height: 40.0,
                                  // padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen[400],
                                  ),
                                  child: IconButton(
                                    tooltip: 'Paramètres'.toUpperCase(),
                                    icon: Icon(
                                      Icons.settings,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (mounted)
                                        setState(() {
                                          // show the update password and the log out button
                                          Window.showWindow = 21;
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (_) => SkiiyaBet()));
                                        });
                                    },
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              topAppBar(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ResponsiveWidget.isSmallScreen(context)
          ? CurvedNavigationBar(
              // backgroundColor: Colors.white70, thisBottomColor
              height: 50.0,
              color: Colors.lightGreen[400],
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              onTap: (int value) {
                if (mounted)
                  setState(() {
                    Selection.bottomCurrentTab = value;
                    if (value == 0) {
                      // print('home');
                      Window.showWindow = 0;
                    } else if (value == 1) {
                      // print('search');
                      Window.showWindow = 4; // call search panel
                    } else if (value == 2) {
                      // print('deposit');
                      Window.showWindow = 8; // call deposit panel
                    } else if (value == 3) {
                      // print('withdraw');
                      Window.showWindow = 9; // call deposit panel
                    } else if (value == 4) {
                      // print('my bets');
                      Window.showWindow = 11; // call bets panel
                    } else if (value == 5) {
                      // print('account');
                      Window.showWindow = 21; // call account menu panel
                    }
                  });
              },
              items: [
                  Icon(Icons.home,
                      size: 16.0,
                      color: Selection.bottomCurrentTab == 0
                          ? Colors.black
                          : Colors.white),
                  Icon(Icons.search,
                      size: 16.0,
                      color: Selection.bottomCurrentTab == 1
                          ? Colors.black
                          : Colors.white),
                  Icon(Icons.credit_card,
                      size: 16.0,
                      color: Selection.bottomCurrentTab == 2
                          ? Colors.black
                          : Colors.white),
                  Icon(Icons.monetization_on,
                      size: 16.0,
                      color: Selection.bottomCurrentTab == 3
                          ? Colors.black
                          : Colors.white),
                  Icon(Icons.business_center,
                      size: 16.0,
                      color: Selection.bottomCurrentTab == 4
                          ? Colors.black
                          : Colors.white),
                  Icon(FontAwesomeIcons.user,
                      size: 16.0,
                      color: Selection.bottomCurrentTab == 5
                          ? Colors.black
                          : Colors.white),
                ])
          : null,
    );
  }

  List<IconData> _sideMenuList = [
    Icons.search,
    Icons.home,
    Icons.trending_up,
    Icons.credit_card,
    Icons.monetization_on,
    Icons.archive,
    Icons.business_center,
    Icons.history,
    Icons.phone,
  ];
  List<String> _sideMenuToolTip = [
    'Recherche',
    'Accueil',
    'Matches Populaires',
    'Dépôt',
    'Retrait',
    'Mes Transactions',
    'Mes Paris',
    'Historique',
    'Nos Contacts',
  ];
  List<bool> _sideMenuBottom = [
    true,
    false,
    true,
    false,
    false,
    true,
    false,
    true,
    false,
  ];

  Widget _sideMenuMethod(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (mounted)
              setState(() {
                // SET THE CHAMPIONSHIP HIGHLIGHT ICON TO NULL IN DESKTOP MODE
                // WE GIVE IT A VALUE OF -1 SO THAT NO CHAMPIONSHIP WILL BE SELECTED
                _indexChampionSelection = -1;

                Window.selectedMenu = index;
                // print(Window.selectedMenu);
                if (Window.selectedMenu == 0) {
                  // matchMoreOdds = new DocumentSnapshot();
                  Window.showWindow = 4; // call search panel
                } else if (Window.selectedMenu == 1) {
                  Window.showWindow = 0;
                  Window.showJackpotIndex = 0;
                  // call home panel
                  // set all loading to all popular matches to be found
                  // clear list games before adding more
                  data.clear();
                  // set the field type to filter
                  fieldLoadMore = 0;
                  // load all games bases on their timestamp
                  // filter games by most popular ones
                  loadingGames(fieldLoadMore);
                  // loadingGames(1);
                } else if (Window.selectedMenu == 2) {
                  Window.showJackpotIndex = 0;
                  Window.showWindow = 0; // call trending matches panel
                  // set all loading to all popular matches to be found
                  // clear list games before adding more
                  data.clear();
                  // set the field type to filter
                  fieldLoadMore = 1;
                  // load all games bases on their timestamp
                  // filter games by most popular ones
                  loadingGames(fieldLoadMore);
                  // loadingGames(1);
                }
                // else if (Window.selectedMenu == 3) {
                //   Window.showWindow = 0; // call upcoming matches panel
                //   Window.showJackpotIndex = 0;
                // }
                else if (Window.selectedMenu == 3) {
                  Window.showWindow = 8; // call deposit panel
                } else if (Window.selectedMenu == 4) {
                  Window.showWindow = 9; // call withdraw panel
                } else if (Window.selectedMenu == 5) {
                  Window.showWindow = 10; // call transactions panel
                } else if (Window.selectedMenu == 6) {
                  Window.showWindow = 11; // call My Active Bets panel
                } else if (Window.selectedMenu == 7) {
                  Window.showWindow = 12; // call Bets History panel
                } else if (Window.selectedMenu == 8) {
                  Window.showWindow = 13; // call contact Us panel
                }
              });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: Window.selectedMenu == index
                    ? BorderSide(color: Colors.lightGreen[400], width: 5.0)
                    : BorderSide(color: Colors.grey, width: 0.0),
              ),
            ),
            child: IconButton(
              tooltip: _sideMenuToolTip[index],
              icon: Icon(_sideMenuList[index],
                  color: Window.selectedMenu == index
                      ? Colors.lightGreen[400]
                      : Colors.grey,
                  size: 23.0),
              onPressed: null,
            ),
          ),
        ),
        if (_sideMenuBottom[index])
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey,
              thickness: 0.4,
            ),
          )
      ],
    );
  }

  topAppBar(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: ResponsiveWidget.isSmallScreen(context) ? 40.5 : 60.0,
          width: ResponsiveWidget.isSmallScreen(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width - 60.0,
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          ),
          child: Column(
            children: [
              if (!ResponsiveWidget.isSmallScreen(context))
                Container(
                  height: ResponsiveWidget.isSmallScreen(context) ? 50.0 : 59.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: ResponsiveWidget.isSmallScreen(context)
                            ? (MediaQuery.of(context).size.width - 60.0) * 0.40
                            : (MediaQuery.of(context).size.width - 60.0) * 0.75,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: ResponsiveWidget.isSmallScreen(context)
                                  ? EdgeInsets.symmetric(horizontal: 10.0)
                                  : EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Skiiya'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            ResponsiveWidget.isSmallScreen(
                                                    context)
                                                ? 17.0
                                                : 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 3.0),
                                  Text(
                                    'Bet'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize:
                                            ResponsiveWidget.isSmallScreen(
                                                    context)
                                                ? 17.0
                                                : 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            if (!ResponsiveWidget.isSmallScreen(context))
                              Row(
                                children: _topMenu
                                    .asMap()
                                    .entries
                                    .map(
                                      (MapEntry map) => myTopMenu(
                                        map.key,
                                      ),
                                    )
                                    .toList(),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: new EdgeInsets.only(right: 5.0),
                        width: ResponsiveWidget.isSmallScreen(context)
                            ? (MediaQuery.of(context).size.width - 60.0) * 0.60
                            : (MediaQuery.of(context).size.width - 60.0) * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // scrollDirection: Axis.horizontal,
                          children: [
                            if (ResponsiveWidget.isLargeScreen(context) ||
                                ResponsiveWidget.customScreen(context) ||
                                ResponsiveWidget.isMediumScreen(context))
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, right: 5.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.grey, width: 1.0))),
                                  // child: IconButton(
                                  //     icon: Icon(Icons.notifications), onPressed: null),
                                ),
                              ),
                            // SizedBox(width: 10.0),
                            // isUserLoggedIn
                            (Selection.user != null)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(width: 2.0),
                                      Text(
                                        Selection.userTelephone.toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 1.0,
                                      ),
                                      Text(
                                        Price.getWinningValues(
                                                Selection.userBalance) +
                                            ' Fc',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? 13.0
                                                  : 14.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                : MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 35.0,
                                            // padding: new EdgeInsets.symmetric(
                                            //     horizontal: 5.0),
                                            child: ButttonWithIcon(
                                              icon: Icons.login,
                                              buttonColor:
                                                  Colors.lightGreen[400],
                                              color: Colors.white,
                                              title: 'Mon Compte',
                                              onPressed: () {
                                                if (mounted)
                                                  setState(() {
                                                    // on click display the login button
                                                    // redirect to login page
                                                    Window.showWindow = 14;
                                                  });
                                              },
                                            ))
                                      ],
                                    )),
                            // if (ResponsiveWidget.isMediumScreen(context) ||
                            //     ResponsiveWidget.isSmallScreen(context))
                            SizedBox(width: 5.0),
                            // display the counter in the app bar with NO ACTION
                            if (!(ResponsiveWidget.isMediumScreen(context) ||
                                ResponsiveWidget.isSmallScreen(context)))
                              Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 1.0))),
                                  child: Container(
                                    // width: 15.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                        bottom: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                        left: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                        right: BorderSide(
                                            color: Colors.lightGreen[400],
                                            width: 3.0),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      // color: Colors.lightBlue,
                                    ),
                                    child: Text(
                                      (BetSlipData.gameIds.length.toString()),
                                      style: TextStyle(
                                        color: Colors.lightGreen[400],
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            // display the counter in the app bar with A CLICKING ACTION
                            if (ResponsiveWidget.isMediumScreen(context) ||
                                ResponsiveWidget.isSmallScreen(context))
                              GestureDetector(
                                onTap: () {
                                  if (mounted)
                                    setState(() {
                                      Window.showWindow = 20;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SkiiyaBet()));
                                    });
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: Colors.grey,
                                                width: 1.5))),
                                    child: Container(
                                      // width: 15.0,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.lightGreen[400],
                                              width: 3.0),
                                          bottom: BorderSide(
                                              color: Colors.lightGreen[400],
                                              width: 3.0),
                                          left: BorderSide(
                                              color: Colors.lightGreen[400],
                                              width: 3.0),
                                          right: BorderSide(
                                              color: Colors.lightGreen[400],
                                              width: 3.0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        // color: Colors.lightBlue,
                                      ),
                                      child: Text(
                                        (BetSlipData.gameIds.length.toString()),
                                        style: TextStyle(
                                          color: Colors.lightGreen[400],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              if (ResponsiveWidget.isSmallScreen(context))
                Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  margin: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _topMenu
                        .asMap()
                        .entries
                        .map(
                          (MapEntry map) => myTopMenu(
                            map.key,
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
        appBody(context),
      ],
    );
  }

  List<String> _topMenu = [
    'Football',
    // 'Jackpot',
    'Mes Paris',
    'Besoin d\'Aide?',
  ];

  Widget myTopMenu(int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (mounted)
            setState(() {
              // SET THE CHAMPIONSHIP HIGHLIGHT ICON TO NULL IN DESKTOP MODE
              // WE GIVE IT A VALUE OF -1 SO THAT NO CHAMPIONSHIP WILL BE SELECTED
              // _indexChampionSelection = -1;

              Window.showJackpotIndex = index;
              if (Window.showJackpotIndex == 0) {
                Window.selectedMenu = 1;
                Window.showWindow = 0; // home Page
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
              }
              if (Window.showJackpotIndex == 1) {
                Window.showWindow = 11; // call bets panel
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
                // Window.showWindow = 2; // show jackpot panel
              }
              if (Window.showJackpotIndex == 2) {
                Window.showWindow = 3; // show help panel
              }
            });
        },
        child: Container(
          padding: new EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(
              bottom: Window.showJackpotIndex == index
                  ? BorderSide(
                      color: Colors.lightGreen[400],
                      width:
                          ResponsiveWidget.isSmallScreen(context) ? 4.0 : 3.0,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Text(
            _topMenu[index],
            style: TextStyle(
              color:
                  Window.showJackpotIndex == index ? Colors.black : Colors.grey,
              fontSize: 12.0,
              fontWeight: Window.showJackpotIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget appBody(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ResponsiveWidget.isLargeScreen(context)
              ? (MediaQuery.of(context).size.width - 50.0 - 300.0)
              : (ResponsiveWidget.customScreen(context)
                  ? (MediaQuery.of(context).size.width - 50.0 - 300.0)
                  : ResponsiveWidget.isMediumScreen(context)
                      ? (MediaQuery.of(context).size.width - 50.0)
                      : (MediaQuery.of(context).size.width)),
          height: ResponsiveWidget.isSmallScreen(context)
              // web view and padding limits
              ? MediaQuery.of(context).size.height - 100.0 - 55.5
              // mobile view and padding limit
              // ? MediaQuery.of(context).size.height - 100.0 - 55.5 - 40.0
              : MediaQuery.of(context).size.height - 60.0,
          padding: ResponsiveWidget.isLargeScreen(context)
              ? EdgeInsets.all(20.0)
              : EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
          decoration: BoxDecoration(color: Colors.white70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  // if (ResponsiveWidget.isLargeScreen(context)) JackpotPub(),
                  // if (ResponsiveWidget.isLargeScreen(context))
                  //   SizedBox(height: 25.0),
                  if (ResponsiveWidget.isLargeScreen(context))
                    _tournamentIntro(),
                  if (ResponsiveWidget.isLargeScreen(context))
                    SizedBox(height: 10.0),
                  if (ResponsiveWidget.isLargeScreen(context)) tournament(),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    if (!ResponsiveWidget.isLargeScreen(context))
                      if (Window.showWindow == 0)
                        Container(
                          height: 25.0,
                          // margin: new EdgeInsets.only(
                          //     left: 15.0, bottom: 15.0, top: 5.0),
                          margin: EdgeInsets.only(
                              left: ResponsiveWidget.isBigScreen(context)
                                  ? 15.0
                                  : 10.0,
                              bottom: 15.0,
                              top: 5.0),
                          // padding: new EdgeInsets.symmetric(horizontal: 8.0),
                          child: loadSideDataArrayChamp.length > 0
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: loadSideDataArrayChamp.length,
                                  itemBuilder: (context, index) {
                                    return _topChampionshipMobile(
                                        loadSideDataArrayChamp[index],
                                        loadSideDataArrayCountry[index]);
                                  })
                              : Center(
                                  // execute this for network error
                                  child: (isNoInternetNetwork)
                                      ? Text('Pas d\'Internet'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            // fontStyle: FontStyle.italic,
                                          ))
                                      : SpinKitCubeGrid(
                                          color: Colors.lightGreen[400],
                                          size: 20.0,
                                        ),
                                ),
                          // Text(
                          //     'Chargement...',
                          //     style: TextStyle(
                          //       color: Colors.lightGreen[400],
                          //       fontSize: 14.0,
                          //       fontWeight: FontWeight.bold,
                          //       fontStyle: FontStyle.italic,
                          //     ),
                          //   ),
                        ),
                    if (Window.showWindow == 0)
                      // if (ResponsiveWidget.isLargeScreen(context) ||
                      //     ResponsiveWidget.customScreen(context))
                      Container(
                        width: double.infinity,
                        // padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.only(
                            left: ResponsiveWidget.isBigScreen(context)
                                ? 15.0
                                : 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: _betFilters(),
                      ),
                    // SizedBox(height: 10.0),
                    // if no button has been clicked so far then.
                    _changeWindow(context),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (ResponsiveWidget.customScreen(context) ||
            ResponsiveWidget.isLargeScreen(context))
          betSlip(context),
      ],
    );
  }

  String selectedMobileTopItem = '';

  _topChampionshipMobile(String championship, String country) {
    return GestureDetector(
      onTap: () async {
        final _thisLocalData = await Selection.getCategory(championship);
        // we will now check if a championship has been adde so it won't be added again
        if (mounted)
          setState(() {
            // set the match top to an index that does not exists
            _selectedIndex = -1;
            // set the clicked item to the one selected
            selectedMobileTopItem = championship;
            // clear all old value of data array so that filtered ones can be added
            data.clear();
            for (var i = 0; i < (_thisLocalData.length); i++) {
              // execute this if the array contains elements
              if (data.length > 0) {
                int verifier = 0;
                // check if the array contains already the championship
                for (var j = 0; j < data.length; j++) {
                  if (data[j]
                          .documentID
                          .toString()
                          .compareTo(_thisLocalData[i].documentID.toString()) ==
                      0) {
                    verifier++;
                  }
                }
                // add the championship if it is not added yet
                if (verifier == 0) {
                  // add the current match to data array
                  data.add(_thisLocalData[i]);
                }
              }
              // else execute this
              else {
                data.add(_thisLocalData[i]);
              }
            }
            // print('The championship is $championship and country is $country');
            // Window.showWindow = 0;
          });
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightGreen[400], width: 2.0),
                  bottom: BorderSide(color: Colors.lightGreen[400], width: 2.0),
                  left: BorderSide(color: Colors.lightGreen[400], width: 2.0),
                  right: BorderSide(
                    color: Colors.lightGreen[400],
                    width: 2.0,
                  ),
                ),
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  championship.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
                SizedBox(width: 4.0),
                // Icon(Icons.more_horiz, color: Colors.lightGreen, size: 12.0),
                Text(
                  '| ' + country,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
                if (selectedMobileTopItem.toString().compareTo(championship) ==
                    0)
                  Row(
                    children: [
                      SizedBox(
                        width: 3.0,
                      ),
                      Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.lightBlue[400],
                          size: 15.0,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }

  _changeWindow(BuildContext context) {
    int val = Window.showWindow;
    if (val == 0) {
      // show home Games
      return games();
    } else if (val == 1) {
      // show a game full details
      return singleGame();
    } else if (val == 2) {
      // show jackpot panel
      // Will be added later on
      // return Jackpot();
      return games();
    } else if (val == 3) {
      // show help panel
      return Help();
    } else if (val == 4) {
      // show Search panel
      return search();
    } else if (val == 8) {
      // show Deposit panel
      return Deposit();
    } else if (val == 9) {
      // show Withdraw panel
      return Withdraw();
    } else if (val == 10) {
      // show User Full Transaction panel
      return Transactions();
    } else if (val == 11) {
      // show Active User Bets panel
      return Bets();
    } else if (val == 12) {
      // show History panel
      return History();
    } else if (val == 13) {
      // show contact panel
      return Contact();
    } else if (val == 14) {
      // show contact panel
      return Login();
    }
    // else if (val == 15) {
    //   // show bet details panel
    //   return BetDetails();
    // }
    // else if (val == 16) {
    //   return RegisterAcount();
    // }
    else if (val == 17) {
      return ForgotPassword();
    } else if (val == 18) {
      return UpdatePassword();
    } else if (val == 19) {
      return RecoverPassword();
    } else if (val == 20) {
      return betSlip(context);
    } else if (val == 21) {
      return accountMenu();
    } else {
      // show home Games
      return games();
    }
  }

  List<String> _betMenuList = [
    'Tous les Matches | ',
    // 'Matches Populaires | ',
    // 'Domicile + Grand Points | ',
    // 'Domicile + Petits Points | ',
    // 'Extérieur + Grand Points | ',
    // 'Extérieur + Petits Points | ',
  ];

  Widget _buildMenu(int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (mounted)
            setState(() {
              // SET THE CHAMPIONSHIP HIGHLIGHT ICON TO NULL IN DESKTOP MODE
              // WE GIVE IT A VALUE OF -1 SO THAT NO CHAMPIONSHIP WILL BE SELECTED
              // _indexChampionSelection = -1;

              // set the selected championship to none if one item is clicked here
              // selectedMobileTopItem = '';
              // _selectedIndex = index;
              // // load games on event clicking on
              // // 'Matches','Popular Bets', 'Home & High Odds', 'Away & High Odds',
              // // clear all data to reload new ones and filtered
              // data.clear();
              // // when clicked on match index, load matches with all games
              // if (_selectedIndex == 0) {
              //   // set all loading to all matches to be found
              //   fieldLoadMore = 0;
              //   // load all games bases on their timestamp
              //   loadingGames(fieldLoadMore);
              // }
              //  else if (_selectedIndex == 1) {
              //   // set all loading to all popular matches to be found
              //   fieldLoadMore = 1;
              //   // load all games bases on their timestamp
              //   // filter games by most popular ones
              //   loadingGames(fieldLoadMore);
              //   // loadingGames(1);
              // } else if (_selectedIndex == 2) {
              //   // loadingGames(2); // set all loading to home games and with high odds
              //   fieldLoadMore = 2;
              //   // load all games bases on their timestamp
              //   // filter games by home games and with high odds
              //   loadingGames(fieldLoadMore);
              // } else if (_selectedIndex == 3) {
              //   // set all loading to home games and with low odds
              //   fieldLoadMore = 3;
              //   // filter games by home games and with low odds
              //   loadingGames(fieldLoadMore);
              // } else if (_selectedIndex == 4) {
              //   // set all loading to away games and with high odds
              //   fieldLoadMore = 4;
              //   // filter games by away games and with high odds
              //   loadingGames(fieldLoadMore);
              // } else if (_selectedIndex == 5) {
              //   // set all loading to away games and with low odds
              //   fieldLoadMore = 5;
              //   // filter games by away games and with low odds
              //   loadingGames(fieldLoadMore);
              // }
              // Window.showWindow = 0;
            });
          // print(_selectedIndex);
        },
        child: Container(
          padding: const EdgeInsets.only(right: 15.0),
          child: Row(
            children: [
              Text(
                _betMenuList[index],
                style: TextStyle(
                  color: _selectedIndex == index
                      ? Colors.lightGreen[400]
                      : Colors.grey,
                  fontSize: 14.0,
                  fontWeight: _selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _betFilters() {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.only(right: 0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.4),
          left: BorderSide(color: Colors.grey, width: 0.4),
          right: BorderSide(color: Colors.grey, width: 0.4),
        ),
      ),
      child: Container(
        height: 35.0,
        padding: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _betMenuList
              .asMap()
              .entries
              .map(
                (MapEntry map) => _buildMenu(map.key),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _tournamentIntro() {
    return Container(
      width: 180.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tournois & Pays',
            style: TextStyle(
                color: Colors.grey,
                // fontWeight: FontWeight.bold,
                fontSize: 12.0),
          ),
          // Icon(Icons.format_line_spacing, color: Colors.grey, size: 20.0),
        ],
      ),
    );
  }

  ScrollController _scrollController = new ScrollController();

  void loadingGames(int choice) async {
    final _game = await Selection.getPosts(choice);
    if (mounted)
      setState(() {
        checkInternet();
        // add a condition so that existing members can't be added twice
        for (var i = 0; i < _game.length; i++) {
          // do not execute this if data array is empty
          if (data.length > 0) {
            // if the array contains at least one element then execute this
            // loop through elements to get the id
            int id = 0;
            for (var j = 0; j < data.length; j++) {
              // if the new id is equal to one old, do not add it again
              if ((data[j]
                      .documentID
                      .toString()
                      .compareTo(_game[i].documentID.toString()) ==
                  0)) {
                id++;
              }
            }
            if (id == 0) {
              // print('added for the first time');
              // if data array does not contain thegame then add it
              data.add(_game[i]);
              // else if the match exist already do not add it anyhow
            }
            // else{
            //   print('added already');
            // }
          } else {
            // if the array is empty, add the first element with no condition
            data.add(_game[i]);
          }
        }
      });
  }

  var sideDataSortedChamp = [];
  var sideDataSortedCountry = [];

  void loadSideData() async {
    //  var results = [];
    final _thiLocalData = await Selection.getCountData();
    // we will now check if a championship has been adde so it won't be added again
    if (mounted)
      setState(() {
        for (var i = 0; i < (_thiLocalData.length); i++) {
          // execute this if the array contains elements
          if (sideDataSortedChamp.length > 0) {
            int verifier = 0;
            // check if the array contains already the championship
            for (var j = 0; j < sideDataSortedChamp.length; j++) {
              if (sideDataSortedChamp[j]
                      .toString()
                      .compareTo(_thiLocalData[i]['championship'].toString()) ==
                  0) {
                verifier++;
              }
            }
            // add the championship if it is not added yet
            if (verifier == 0) {
              // add the championship
              sideDataSortedChamp.add(_thiLocalData[i]['championship']);
              // add the country or the region
              sideDataSortedCountry.add(_thiLocalData[i]['country']);
            }
          }
          // else execute this
          else {
            // add the championship
            sideDataSortedChamp.add(_thiLocalData[i]['championship']);
            // add the country
            sideDataSortedCountry.add(_thiLocalData[i]['country']);
          }
          // print(qn.documents[i]['championship']);
        }
        // Save the loaded values into arrays
      });

    loadSideDataArrayChamp = sideDataSortedChamp;
    loadSideDataArrayCountry = sideDataSortedCountry;

    // THIS METHOD FILTER THE 5 MAIN CHAMPIONSHIP AT TOP
    // PREMIER LEAGUE
    _filterMainChampionships(loadSideDataArrayChamp, loadSideDataArrayCountry,
        'Premier League', 'England', 0);
    // BUNDESLIGA
    _filterMainChampionships(loadSideDataArrayChamp, loadSideDataArrayCountry,
        'Bundesliga', 'Germany', 1);
    // ITALY
    _filterMainChampionships(loadSideDataArrayChamp, loadSideDataArrayCountry,
        'Serie A', 'Italy', 2);
    // LA LIGA
    _filterMainChampionships(loadSideDataArrayChamp, loadSideDataArrayCountry,
        'La Liga', 'Spain', 3);
    // LIGUE 1
    _filterMainChampionships(loadSideDataArrayChamp, loadSideDataArrayCountry,
        'Ligue 1', 'France', 4);
  }

// THIS METHOD PUT THE FIVE TOP CHAMPIONSIPS AT THE TOP
  _filterMainChampionships(var _champs, var _countries, String champ,
      String country, int _thisIndex) {
    // CHECK IF WE HAVE ENOUGH DATA IN THE ARRAY OF CHAMPIONSHIPS
    if (_champs.length <= _thisIndex) {
      // print('this index is outside of array: $championship');
      // IF THE CHAMPIONSHIP INDEX IS NOT IN ARRAY LENGHT
      // THE PUT IT AT THE LAST PLACE
      _thisIndex = _champs.length - 1;
    }
    // print(loadSideDataArrayChamp.length);
    // print("Index: $_thisIndex");
    // LET US CHECK IF WE HAVE PREMIER LEAGUE MATCH
    if (_champs.contains(champ)) {
      // LET US CREATE A TEMPORARY VALUE WHERE THE CHAMPIONSHIP AT CURRENT INDEX WILL BE STORED
      // FOR CHAMPIONSHIP
      String _tempChamp = '';
      // FOR COUNTRY
      String _tempCountry = '';
      // FOR RESIDUAL INDEX
      int _tempCount = 0;
      // Store the index of premier league
      int index = _champs.indexOf(champ);
      // print('The index is: $index and Premier League catched');
      // WE STORE THE VALUES TEMPORARILY IN VARIABLES
      _tempCount = index;
      _tempChamp = _champs[_thisIndex];
      _tempCountry = _countries[_thisIndex];
      // WE PUT 'PREMIER LEAGUE' AT INDEX 0
      _champs[_thisIndex] = champ;
      _countries[_thisIndex] = country;

      // WE PUT OLD VALUES AT PREMIER LEAGUE INDEX
      _champs[_tempCount] = _tempChamp;
      _countries[_tempCount] = _tempCountry;
    }
  }

  @override
  void initState() {
    // WE FIRST LOAD ALL THE GAMES HERE
    _fetchMatch.fetchMatchDetails(Selection.loadLimit).then((value) {
      // print(value);
      // WE SET THE VALUE TO THE MATCHES ARRAY
      _matches = value;
      // LET US INSERT DATA INTO THE SELECTION ARRAY
      for (int i = 0; i < _matches.length; i++) {
        // print(_matches[i].id);
        // WE ADD ONLY THE ID OF THE GAME TO THE ARRAY COLLECTION
        oddsGameArray.add(OddsArray.fromDatabase(_matches[i]));
      }
    });
    // LET US LOAD LEAGUES HERE
    _fetchMatch.fetchLeagues().then((value) {
      // WE SET THE VALUE TO THE MATCHES ARRAY
      // print(value['league']['data'][0]);
      if (value.length > 0) {
        _leagues = value[0]['data'];
        // print(value[0]['data'][0]);
      }
    });

    // LET US LOAD LEAGUES HERE
    _fetchMatch.fetchCountries().then((value) {
      // WE SET THE VALUE TO THE MATCHES ARRAY
      _countries = value;
    });
    // this match check weither matches are still available or have expired
    // checkMatchValidity();
    // New methods loading...
    removedTheOldMatch();
    // keep loading user balance
    loopUserDetails();
    // placed here because this widget execute only once
    // this method helps us to detect if a certain user was already logged in
    if (mounted)
      setState(() {
        // reload from existing session and set new values
        // logged the user in if existed before
        reLoginUser(); // uncomment after coding
      });
    // this loadingGames method load only once at first lunch
    loadingGames(fieldLoadMore);
    loadSideData();
    super.initState();
    // _data = Selection.getPosts(0);
    // print('Chargement code executed');
    // _itemCount = Selection.getCountData();
    // _countCountries = Selection.getCountCountryData();
    //listen to body scrolling and execute itself
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          // print('loading new games');
          // Future thisData;
          // add and load 10 more games on every bottom list reach
          // load more data + condition to filter games already loaded
          Selection.loadLimit = Selection.loadLimit + 15;
          // if (mounted)
          var _newMatches = [];
          // WE FIRST LOAD ALL THE GAMES HERE
          _fetchMatch.fetchMatchDetails(Selection.loadLimit).then((_getData) {
            // print(value);
            // WE SET THE VALUE TO THE MATCHES ARRAY
            _matches = _getData;
            // LOOPS
            for (int i = 0; i < _getData.length; i++) {
              // VALIDATE A NEW MATCH
              bool _isNotPresent = true;
              // MATCHES LOOPING
              for (int j = 0; j < _matches.length; j++) {
                // WE COMPARE LOADED MATCHES WITH CURRENT MATCHES
                if (_getData[i] == _matches[j]) {
                  // SET TRUE FOR MATCHING
                  _isNotPresent = false;
                  // BREAK THE LOOP FOR PROCESSING
                  break;
                }
              }
              // IF THE MATCH HAS NOT YET BEEN LOADED
              if (_isNotPresent) {
                // print('This is a new match ${_getData[i].id}');
                _newMatches.add(_getData[i]);
              }
            }
            // LET US INSERT DATA INTO THE SELECTION ARRAY
            for (int i = 0; i < _newMatches.length; i++) {
              // print(_matches[i].id);
              // WE ADD ONLY THE ID OF THE GAME TO THE ARRAY COLLECTION
              oddsGameArray.add(OddsArray.fromDatabase(_newMatches[i]));
            }
          });
          // setState(() {
          //   // execute this method so that new content can be added to the listview
          //   loadingGames(fieldLoadMore);
          // });
        });
      }
    });
  }

  Widget games() {
    // SHOW THE GAME HOME PANEL INITIALLY
    if (!switchToMoreMatchOddsWindow) {
      return Expanded(
          child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
            bottom: BorderSide(color: Colors.grey, width: 0.3),
            left: BorderSide(color: Colors.grey, width: 0.3),
            right: BorderSide(color: Colors.grey, width: 0.3),
          ),
        ),
        margin: EdgeInsets.only(
            left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: _matches.length > 0
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: _matches.length,
                  itemBuilder: (context, _index) {
                    return singleMatch(_matches[_index], _index);
                  },
                )
              : Center(
                  child:
                      // isNoInternetNetworkOrOtherError
                      (isNoInternetNetwork)
                          ? // if there is a network error
                          GestureDetector(
                              onTap: () {
                                if (mounted)
                                  setState(() {
                                    // on click of this item, reload games to check for update
                                    loadingGames(fieldLoadMore);
                                    // load championship content
                                    loadSideData();
                                    // hide the error message
                                    isNoInternetNetwork = false;
                                    // isNoInternetNetworkOrOtherError = false;
                                    // load user details too
                                    // print('User phone: ${Selection.userTelephone}');
                                    if (Selection.userTelephone.compareTo('') !=
                                        0) {
                                      // if the phone is not empty, then reloggin the user
                                      reLoginUser();
                                    }
                                  });
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      size: 35.0,
                                      color: Colors.black,
                                    ),
                                    Text('Problème d\'Internet'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          // fontStyle: FontStyle.italic,
                                        )),
                                    Text(
                                        'Cliquez Ici pour Mettre à Jour'
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                          // fontStyle: FontStyle.italic,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          //     )) // else do this
                          : SpinKitCubeGrid(
                              color: Colors.lightGreen[400],
                              size: 25.0,
                            ),
                ),
        ),
      ));
    } else {
      // THEN SHOW THE GAME DETAILS ON GAME CLICK
      return singleGame();
    }
  }

  Widget singleMatch(var _thisMatch, int index) {
    // we assign the context at position Index to the document snapshot document
    // DocumentSnapshot match = _thisData[index];
    //snapshot.data[index]
    // match = data[index];
    // print(match);
    var id = _thisMatch.id;
    // var team1 = match['team1'];
    var team1 = _thisMatch.localTeam['data']['name'];
    var team2 = _thisMatch.visitorTeam['data']['name'];
    // var team2 = match['team2'];
    // GET THE TIME OF THE MATCH
    var time = _thisMatch.time['starting_at']['time'];
    // GET THE DATE OF THE GAME
    var date = _thisMatch.time['starting_at']['date'];
    // var championship = match['championship'];
    // var country = match['country'];
    // // load time details
    var championship;
    var country;
    int _leagueIndex;
    // LET US LOAD CHAMPIONSHIPS
    // ONLY IF WE HAVE DATA IN THE ARRAY
    if (_leagues.length > 0)
      for (int j = 0; j < _leagues.length; j++) {
        if (_leagues[j]['id'] == _thisMatch.league_id) {
          championship = _leagues[j]['name'];
          _leagueIndex = j;
          // print('the ligue is ${_leagues[_lpLg]['name']}');
          // WE BREAK THE LOOP FOR BETTER PROCESSING
          break;
        }
      }

    // LET US GET THE CORRECT COUNTRY HERE
    // ONLY IF WE HAVE DATA IN THE ARRAY
    if (_countries.length > 0)
      for (int j = 0; j < _countries.length; j++) {
        if (_leagues[_leagueIndex]['country_id'] == _countries[j]['id']) {
          country = ' - ' + _countries[j]['name'];
          // print('the country name is ${_countries[j]['name']}');
          // WE BREAK THE LOOP FOR BETTER PROCESSING
          break;
        }
      }
    // print(_thisMatch.threeWayOdds['id']);
    // print(_thisMatch.threeWayOdds['name']);
    // print(_thisMatch.threeWayOdds['bookmaker']['data'][0]['id']);
    // print(_thisMatch.threeWayOdds['bookmaker']['data'][0]['name']);
    // print(_thisMatch.threeWayOdds['bookmaker']['data'][0]['odds']['data'][0]['label']);
    // print(_thisMatch.threeWayOdds['bookmaker']['data'][0]['odds']['data'][0]['value']);
    // print(_thisMatch.threeWayOdds['bookmaker']['data'][0]['odds']['data'][0]['winning']);
    // THIS STORE THE DATA FOR THREE WAY ODDS
    var _threeWayData =
        _thisMatch.threeWayOdds['bookmaker']['data'][0]['odds']['data'];

    return Column(
      children: [
        GestureDetector(
            onTap: () {
              if (mounted)
                setState(() {
                  // SWITCH THE VIEW TO A LOAD MORE WINDOWS
                  switchToMoreMatchOddsWindow = true;
                  // print('Match id: $id : Details Requested');
                  // Window.showWindow = 1;
                  // THIS VARIABLE STORE THE CURRENT GAME SELECTED
                  // CHECK IF THE CURRENT GAME IS STILL THE SAME
                  // if (moreOddsMatch != null) {
                  //   if (moreOddsMatch.id != _thisMatch.id) {}
                  // } else {
                  // IF WE HAVE ANY VALUE IN THE ARRA, LOAD NEW DATA
                  if (moreOddsMatch == null) {
                    moreOddsMatch = _thisMatch;
                    // START FETCHING THE MATCHES ODDS HERE
                    _fetchMatch
                        .fetchAllGameOdds(moreOddsMatch.id.toString())
                        .then((value) {
                      // STORE THE ODDS OF THE MATCH IN THE ARRAY
                      moreLoadedMatchOdds = value;
                      // odds loop
                      // print(value['odds'][0]['id']);
                      // print(value['odds'][0]['name']);
                      // print(value['odds'][0]['bookmaker']['data'][0]['id']);
                      // print(value['odds'][0]['bookmaker']['data'][0]['name']); // data loop
                      // print(value['odds'][0]['bookmaker']['data'][0]['odds']['data'][0]['label']);
                      // print(value['odds'][0]['bookmaker']['data'][0]['odds']['data'][0]['value']);
                      // print(value['odds'][0]['bookmaker']['data'][0]['odds']['data'][0]['winning']);
                    });
                  }
                  // IF THE TWO IDS DO NOT MATCH, LOAD NEW CONTENT
                  else if (moreOddsMatch.id != _thisMatch.id) {
                    // WE SET THE SELECTED MATCH TO NULL
                    moreOddsMatch = null;
                    // WE SET THE ARRAYS VALUE TO NULL
                    moreLoadedMatchOdds = null;
                    // SET THE NEW GAME AS ID
                    moreOddsMatch = _thisMatch;
                    // START FETCHING THE MATCHES ODDS HERE
                    _fetchMatch
                        .fetchAllGameOdds(moreOddsMatch.id.toString())
                        .then((value) {
                      // STORE THE ODDS OF THE MATCH IN THE ARRAY
                      moreLoadedMatchOdds = value;
                    });
                  }

                  // }
                  // OTHERWISE DO NOTHING
                });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child:
                  // SizedBox(height: 5.0),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: $id',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )),
                      Container(
                        width: ResponsiveWidget.isExtraSmallScreen(context)
                            ? 200.0
                            : ResponsiveWidget.isSmallScreen(context)
                                ? 200
                                : 250,
                        child: Row(
                          children: [
                            Container(
                              width: ResponsiveWidget.isExtraSmallScreen(
                                      context)
                                  ? 200.0
                                  : ResponsiveWidget.isSmallScreen(context)
                                      ? 200
                                      : ResponsiveWidget.isSmallScreen(context)
                                          ? 300
                                          : 250,
                              child: Text(
                                team1 + ' - ' + team2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 14.0
                                          : 16.0,
                                  // decoration: TextDecoration.underline,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            // SizedBox(width: 2.0,),
                            // if (!ResponsiveWidget.isExtraSmallScreen(context) &&
                            //     !ResponsiveWidget.isSmallScreen(context))
                            //   Icon(
                            //     Icons.bar_chart_rounded,
                            //     size: 20.0,
                            //     color: Colors.grey,
                            //   )
                          ],
                        ),
                      ),
                      SizedBox(height: 1.0),
                      Container(
                        width: ResponsiveWidget.isExtraSmallScreen(context)
                            ? 100.0
                            : ResponsiveWidget.isSmallScreen(context)
                                ? 150
                                : 250,
                        child: Text(
                          championship + country,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                              // decoration: TextDecoration.underline,
                              ),
                          maxLines: 4,

                          // overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            time.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ResponsiveWidget.isSmallScreen(context)
                                  ? 13.0
                                  : 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        // thurs 17/09
                        date.toString(),
                        // 'day' + ' ' + 'mydate' + '/' + 'month',
                        // match.date[0] + ' : ' + match.date[1] + ' /' + match.date[3],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Divider(
              //   color: Colors.grey,
              //   thickness: 0.3,
              // ),
            )),
        // FOR BETTING SELECTION BUTTONS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // WE LOOP THE AMOUNT OF DATA AVAILABLE IN THE ARRAY
            for (int _i = 0; _i < _threeWayData.length; _i++)
              threeWayWidget(
                index, // INDEX OF GAME IN THE ARRAY
                _thisMatch.threeWayOdds['bookmaker']['data'][0]['odds']['data'],
                _thisMatch.threeWayOdds['id'], // CONTAINS THE ID OF THE ODD
                _thisMatch.threeWayOdds['name'], // CONTAINS THE NAME OF THE ODD
                _i, // CONTAINS THE INDEX OF THE ODD
              ),
          ],
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey, thickness: 0.4),
      ],
    );
  }

  oneTimesTwoContainer(String identifier, String team, double rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResponsiveWidget.isExtraSmallScreen(context)
            ? Text(
                identifier,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              )
            : ResponsiveWidget.isSmallScreen(context)
                ? Container(
                    width: 35.0,
                    height: 27.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: colorRounded, width: 1.0),
                        bottom: BorderSide(color: colorRounded, width: 1.0),
                        left: BorderSide(color: colorRounded, width: 1.0),
                        right: BorderSide(color: colorRounded, width: 1.0),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      color: colorCaption,
                    ),
                    child: Text(
                      identifier,
                      style: TextStyle(
                        color: colorRounded,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      maxLines: 4,
                    ),
                  )
                : Container(
                    width: ResponsiveWidget.customScreen(context)
                        ? 120.0
                        : ResponsiveWidget.isLargeScreen(context)
                            ? 80.0
                            : ResponsiveWidget.isExtraLargeScreen(context)
                                ? 150.0
                                : ResponsiveWidget.isMediumScreen(context)
                                    ? 80
                                    : 80,
                    child: Text(
                      team,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.0,
                      ),
                      maxLines: 4,
                    ),
                  ),
        Container(
          width: 32.0,
          alignment: Alignment.centerRight,
          child: Text(rate.toStringAsFixed(2),
              style: TextStyle(color: color, fontSize: 12.0)),
        ),
      ],
    );
  }

  topMatchesButtonDrawDesign(double rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResponsiveWidget.isExtraSmallScreen(context)
            ? Text(
                'X',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              )
            : ResponsiveWidget.isSmallScreen(context)
                ? Container(
                    width: 35.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'X',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                      ),
                      maxLines: 4,
                    ),
                  )
                : Text(
                    'X',
                    style: TextStyle(
                      // fontSize: 12.0,
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.0,
                    ),
                    maxLines: 4,
                  ),
        Container(
          width: 32.0,
          alignment: Alignment.centerRight,
          child: Text(rate.toStringAsFixed(2),
              style: TextStyle(color: color, fontSize: 12.0)),
        ),
      ],
    );
  }

  topHomeButtonFunction(DocumentSnapshot match, int index) {
    // get the positioned point
    int getPoint = Selection.gameOddsArray.indexOf(match.documentID);
    if (Selection.gameOddsArray[getPoint + index] == true) {
      // this method unselect all choices for that ID
      unselectOdds(match.documentID);
      // remove the match from the betslip too
      removeMatchFromBetSlip(match);
    } else {
      // this method selects only the specified index
      selectOdds(match.documentID, index);
      // add match to betslip if clicked
      addMatchToBetSlip(match, index);
    }
    loadBetslipMatches();
  }

  unselectOddsButton(int _gameOddIndex) {
    // THIS BUTTON UNSELECT THE CURRENT GAME INDEX AND UPDATE COLORS
    oddsGameArray[_gameOddIndex].oddID = null;
    oddsGameArray[_gameOddIndex].oddName = null;
    oddsGameArray[_gameOddIndex].oddIndex = null;
    oddsGameArray[_gameOddIndex].oddLabel = null;
    oddsGameArray[_gameOddIndex].oddValue = null;
    // CHANGE THE COLORS TO DEFAULTS COLORS
    _buttonColor = Colors.grey.shade200;
    _labelColor = Colors.black87;
  }

  selectOddsButton(int _gameOddIndex, int _oddId, String _oddName,
      int _oddIndex, String _label, String _value) {
    // WE SET THE VALUES OF THE GAME INTO THE ARRAY
    // WE UPDATE THE VALUES AND THE COLORS
    oddsGameArray[_gameOddIndex].oddID = _oddId;
    oddsGameArray[_gameOddIndex].oddName = _oddName;
    oddsGameArray[_gameOddIndex].oddIndex = _oddIndex;
    oddsGameArray[_gameOddIndex].oddLabel = _label;
    oddsGameArray[_gameOddIndex].oddValue = _value;
    // WE PRECISE THE RIGHT BUTTON FOR SELECTION
    // UPDATE THE COLOR OF THE BUTTON AND OF THE LABEL
    customColors();
  }

  // DEFAULT COLORS
  defaultColors() {
    // INITIAL VALUES OF COLORS
    _buttonColor = Colors.grey.shade200;
    _labelColor = Colors.black87;
  }

  // CUSTOM COLORS
  customColors() {
    // COLOR OF SELECTION
    _buttonColor = Colors.lightGreen[400];
    _labelColor = Colors.white70;
  }

  // UPDATE THE COLORS OF THE BUTTONS AND GET THE GAME INDEX IN THE ODDS ARRAY
  int renderButton(var _data, int _gameId, int _oddId, int _oddIndex) {
    // RETURN THE INDEX OF THE GAME IN THE ARRAY OF ODDS
    int _gameOddIndex;

    // LET US UPDATE THE COLOR OF THE BUTTON ON SELECTION
    for (int j = 0; j < _data.length; j++) {
      // CHECK IF THE IDs MATCH THEN BREAK THE LOOP FOR A BETTER PROCESSING
      if (_gameId == _data[j].gameID) {
        // IF DATA IS EMPTY, UPDATE WITH DEFAULT COLORS
        if (_data[j].oddID == null ||
            _data[j].oddName == null ||
            _data[j].oddIndex == null ||
            _data[j].oddLabel == null ||
            _data[j].oddValue == null) {
          // SET THE COLORS
          // UPDATE THE COLORS
          defaultColors();
        } else {
          // WE PRECISE THE RIGHT BUTTON FOR SELECTION
          // WE NEED THE SAME GAME ID AND THE SAME GAME INDEX
          if ((_data[j].oddID == _oddId) && (_data[j].oddIndex == _oddIndex)) {
            // UPDATE ONLY IF IT IS THE RIGHT BUTTON OR SELECTION
            customColors();
          } else {
            // UPDATE THE COLORS
            defaultColors();
          }
        }
        _gameOddIndex = j;
        // WE BREAK THE LOOP
        break;
      }
    }
    return _gameOddIndex;
  }

  threeWayWidget(
      int _gameIndex, var _match, int _oddId, String _oddName, int _oddIndex) {
    // GET THE RIGHT DATA WITH THE RIGHT INDEX
    var _threeWayData = _match[_oddIndex];
    // GET THE LENGTH OF THE THREE WAY ODDS DATA
    int _dataLength = _match.length;
    // CONTAINS THE LABEL OF THE BUTTON
    var _label = _threeWayData['label'];
    // CONTAINS THE VALUE OF THE BUTTON
    var _value = _threeWayData['value'];

    // INDEX OF GAME IN THE ARRAY OF ODDS
    // GETTING THE ID OF THE GAME
    int _gameId = _matches[_gameIndex].id;

    // WE GET THE INDEX OF THE SELECTION AND UPDATE THE COLORS AT THE SAME TIME HERE
    int _gameOddIndex = renderButton(oddsGameArray, _gameId, _oddId, _oddIndex);

    return Expanded(
      child: Container(
        margin: new EdgeInsets.only(
            right: (_oddIndex < _dataLength - 1) ? 5.0 : 0.0),
        child: RawMaterialButton(
          onPressed: () {
            if (mounted)
              setState(() {
                // CHECK IF THE GAME HAS BEEN SELECTED BEFORE IF NOT
                if (oddsGameArray[_gameOddIndex].oddID == null ||
                    oddsGameArray[_gameOddIndex].oddName == null ||
                    oddsGameArray[_gameOddIndex].oddIndex == null ||
                    oddsGameArray[_gameOddIndex].oddLabel == null ||
                    oddsGameArray[_gameOddIndex].oddValue == null ||
                    // UPDATE ALSO IF THE INDEX IS NOT THE SAME
                    oddsGameArray[_gameOddIndex].oddIndex != _oddIndex) {
                  // UPDATE THE VALUES IN THE ARRAY
                  selectOddsButton(_gameOddIndex, _oddId, _oddName, _oddIndex,
                      _label, _value);
                } else {
                  // WE SET THE VALUES TO NULL TO UNSELECT EVERY THING HERE
                  unselectOddsButton(_gameOddIndex);
                }
              });
          },
          fillColor: _buttonColor,
          padding: new EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _label.toString(),
                style: TextStyle(
                  color: _labelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
                maxLines: 4,
              ),
              Container(
                width: 32.0,
                alignment: Alignment.centerRight,
                child: Text(
                  _value.toString(),
                  style: TextStyle(
                    color: _labelColor,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  oddDataAndOddId(var oddData, int _oddId) {
    // oddData = moreLoadedMatchOdds['odds'][0]
    // print(moreLoadedMatchOdds['odds'][3]['id']);
    // print(moreLoadedMatchOdds['odds'][3]['name']);
    // print(moreLoadedMatchOdds['odds'][0]['bookmaker']['data'][0]['id']);
    // print(moreLoadedMatchOdds['odds'][0]['bookmaker']['data'][0]
    //     ['name']); // data loop
    // print(moreLoadedMatchOdds['odds'][0]['bookmaker']['data'][0]['odds']['data']
    //     [0]['label']);
    // print(moreLoadedMatchOdds['odds'][0]['bookmaker']['data'][0]['odds']['data']
    //     [0]['value']);
    // print(moreLoadedMatchOdds['odds'][3]['bookmaker']['data'][0]['odds']['data']
    //     [0]);
    var oddArray = oddData['bookmaker']['data'][0]['odds']['data'];
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              oddData['name'],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 5.0),
            // IF ODDS VALUES ARE LESS THAN 3 OR EQUAL TO 3
            if (oddArray.length <= 3)
              Row(
                children: [
                  for (int j = 0; j < oddArray.length; j++)
                    allOddsWidget(oddArray, _oddId, oddData['name'], j),
                ],
              ),
            // IF ODDS VALUES ARE GREATER THAN 3
            if (oddArray.length > 3)
              for (int j = 0; j < oddArray.length - 1; j = j + 2)
                Row(
                  children: [
                    allOddsWidget(oddArray, _oddId, oddData['name'], j),
                    allOddsWidget(oddArray, _oddId, oddData['name'], (j + 1)),
                  ],
                ),
            // SizedBox(height: 10.0),
            SizedBox(height: 8.0),
            Divider(color: Colors.grey, thickness: 0.5),
            SizedBox(height: 8.0),
          ],
        ),
      ],
    );
  }

  allOddsWidget(var data, int _oddId, String _oddName, int _oddIndex) {
    // data = ['bookmaker']['data'][0]['odds']['data']
    // INDEX OF GAME IN THE ARRAY OF ODDS
    // GETTING THE ID OF THE GAME
    // int _gameId = moreOddsMatch.id;
    // GET THE LENGTH OF THE THREE WAY ODDS DATA
    // int _dataLength = 2;
    // CONTAINS THE LABEL OF THE BUTTON
    var _label = data[_oddIndex]['label'];
    // CONTAINS THE VALUE OF THE BUTTON
    var _value = data[_oddIndex]['value'];

    var total;
    // GET THE TOTAL ATTRIBUTE BEFORE UPDATING
    if (data[_oddIndex]['total'] == null) {
      total = '';
    } else {
      total = ' ' + data[_oddIndex]['total'];
    }

    var handicap;
    // GET THE HANDICAP ATTRIBUTE BEFORE UPDATING
    if (data[_oddIndex]['handicap'] == null) {
      handicap = '';
    } else {
      handicap = ' (' + data[_oddIndex]['handicap'] + ')';
    }

    // LET US GET THE INDEX OF GAME ID
    int _gameId = moreOddsMatch.id;

    // WE GET THE INDEX OF THE SELECTION AND UPDATE THE COLORS AT THE SAME TIME HERE
    int _gameOddIndex = renderButton(oddsGameArray, _gameId, _oddId, _oddIndex);

    return Expanded(
      child: Container(
        margin: new EdgeInsets.only(
            right: (_oddIndex < data.length - 1) ? 8.0 : 0.0),
        child: RawMaterialButton(
          onPressed: () {
            if (mounted)
              setState(() {
                // print('odd details requested');
                // CHECK IF THE GAME HAS BEEN SELECTED BEFORE IF NOT
                if (oddsGameArray[_gameOddIndex].oddID == null ||
                    oddsGameArray[_gameOddIndex].oddName == null ||
                    oddsGameArray[_gameOddIndex].oddIndex == null ||
                    oddsGameArray[_gameOddIndex].oddLabel == null ||
                    oddsGameArray[_gameOddIndex].oddValue == null ||
                    // UPDATE ALSO IF THE INDEX IS NOT THE SAME
                    oddsGameArray[_gameOddIndex].oddIndex != _oddIndex) {
                  // UPDATE THE VALUES IN THE ARRAY
                  selectOddsButton(_gameOddIndex, _oddId, _oddName, _oddIndex,
                      _label, _value);
                } else {
                  // WE SET THE VALUES TO NULL TO UNSELECT EVERY THING HERE
                  unselectOddsButton(_gameOddIndex);
                }
              });
          },
          fillColor: _buttonColor,
          padding: new EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _label.toString() + total.toString() + handicap.toString(),
                style: TextStyle(
                  color: _labelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
                maxLines: 4,
              ),
              Text(
                _value.toString(),
                style: TextStyle(
                  color: _labelColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  drawWidget(DocumentSnapshot match, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        Selection.gameOddsArray.indexOf(match.documentID) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              topHomeButtonFunction(match, index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: topMatchesButtonDrawDesign(match['oneTimesTwo']['2']),
      ),
    );
  }

  team2Widget(DocumentSnapshot match, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(match.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              topHomeButtonFunction(match, index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: oneTimesTwoContainer(
            '2', match['team2'], match['oneTimesTwo']['3']),
      ),
    );
  }

  Widget betSlip(BuildContext _context) {
    return Container(
      margin: ResponsiveWidget.isMediumScreen(context) ||
              ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.only(left: 10.0)
          : null,
      width: ResponsiveWidget.isLargeScreen(context)
          ? 300.0
          : (ResponsiveWidget.customScreen(context) ? 300.0 : double.infinity),
      height: ResponsiveWidget.isLargeScreen(context)
          ? MediaQuery.of(context).size.height - 60.0
          : (ResponsiveWidget.customScreen(context)
              ? MediaQuery.of(context).size.height - 60.0
              : ResponsiveWidget.isMediumScreen(context)
                  ? MediaQuery.of(context).size.height - 80.0
                  // web view and padding limits
                  : MediaQuery.of(context).size.height - 120 - 20 - 27 - 10.0),
      // mobile view and padding limits
      // : MediaQuery.of(context).size.height -
      //     (120.0 - 20.0 - 27.0 - 10.0 - 40.0)),
      padding: ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.all(5.0)
          : EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: ResponsiveWidget.isLargeScreen(context)
            ? Colors.grey[300]
            : (ResponsiveWidget.customScreen(context)
                ? Colors.grey[300]
                : Colors.white70),
        border: (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.customScreen(context))
            ? null
            : Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey),
              ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white70),
              child: ListView(
                padding: EdgeInsets.only(top: 0.0),
                children: [
                  Container(
                    padding: (ResponsiveWidget.isLargeScreen(context) ||
                            ResponsiveWidget.customScreen(context))
                        ? EdgeInsets.all(10.0)
                        : EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[100],
                        border: Border(
                          top: BorderSide(color: Colors.lightGreen, width: 2),
                          bottom:
                              BorderSide(color: Colors.lightGreen, width: 2),
                          left: BorderSide(color: Colors.lightGreen, width: 2),
                          right: BorderSide(color: Colors.lightGreen, width: 2),
                        ),
                      ),
                      child: Text(
                        Method.displayUserBonus(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11.0,
                          // fontWeight: FontWeight.bold,
                        ),
                        // maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.4,
                    height: 0,
                  ),
                  if (BetSlipData.gameIds.length == 0)
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Aucun Match Ajouté'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11.0,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  if (BetSlipData.gameIds.length == 0)
                    Divider(
                      color: Colors.grey,
                      thickness: 0.4,
                      height: 0,
                    ),
                  if (BetSlipData.gameIds.length > 0) loadBetslipMatches(),
                  Container(
                    padding: (ResponsiveWidget.isLargeScreen(context) ||
                            ResponsiveWidget.customScreen(context))
                        ? EdgeInsets.all(10.0)
                        : EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 3.0),
                        if (BetSlipData.gameIds.length > 0)
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                // hide the show error panel on the BETSLIP panel
                                showBetslipMessagePanel = false;
                                // clear all games logic goes here
                                clearGamesSelected();
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'EFFACEZ TOUT',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          // fontStyle: FontStyle.italic,
                                          // decoration: TextDecoration.underline,
                                          fontSize: 12.0),
                                    ),
                                    // SizedBox(width: 2.0),
                                    Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                      size: 15.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // Text('Stake:',
                        //     style: TextStyle(fontWeight: FontWeight.bold)),
                        // SizedBox(height: 5.0),
                        // SizedBox(height: 3.0),
                        Text(
                          'Montant Min: ' +
                              Price.minimumBetPrice.toString() +
                              ' Fc',
                          style: TextStyle(color: Colors.grey, fontSize: 11.0),
                        ),
                        SizedBox(height: 2.0),
                        // Method.showUserBettingStake(),
                        SizedBox(height: 3.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border(
                                top: BorderSide(
                                    color: _displayTextError
                                        ? Colors.red
                                        : Colors.lightGreen[400],
                                    width: 2.0),
                                bottom: BorderSide(
                                    color: _displayTextError
                                        ? Colors.red
                                        : Colors.lightGreen[400],
                                    width: 2.0),
                                left: BorderSide(
                                    color: _displayTextError
                                        ? Colors.red
                                        : Colors.lightGreen[400],
                                    width: 2.0),
                                right: BorderSide(
                                    color: _displayTextError
                                        ? Colors.red
                                        : Colors.lightGreen[400],
                                    width: 2.0),
                              )),
                          child: TextField(
                            cursorColor: _displayTextError
                                ? Colors.red
                                : Colors.lightGreen,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Mon Montant',
                                hintMaxLines: 1,
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0)),
                            onChanged: (value) {
                              // print(value);
                              if (mounted)
                                setState(() {
                                  //   try {
                                  // hide the display message status panel
                                  showBetslipMessagePanel = false;
                                  if (value.isEmpty) {
                                    Price.stake = 0;
                                    _displayTextError = false;
                                  } else {
                                    Price.stake = double.parse(value);
                                    if (Price.stake < Price.minimumBetPrice) {
                                      _displayTextError = true;
                                      _displayTextMaxError = false;
                                    } else if (Price.stake > Price.maxStake) {
                                      _displayTextMaxError = true;
                                      _displayTextError = false;
                                    } else {
                                      _displayTextError = false;
                                      _displayTextMaxError = false;
                                    }
                                  }
                                });
                            },
                          ),
                        ),
                        _displayTextError
                            ? Text(
                                'Montant Min est: ${Price.getCommaValue(Price.minimumBetPrice)} Fc',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 11.0,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : _displayTextMaxError
                                ? Text(
                                    'Montant Max est: ${Price.getCommaValue(Price.maxStake)} Fc',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 11.0,
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    '',
                                    style: TextStyle(fontSize: 1.0),
                                  ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Taux total',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.0)),
                            Row(
                              children: [
                                Text(
                                  Method.totalRate()
                                      .toStringAsFixed(2)
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Gains Possible',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                )),
                            Row(
                              children: [
                                Text(
                                  // possibleWinning().toStringAsFixed(2),
                                  Price.getWinningValues(
                                      Method.possibleWinning()),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                Method.pourcentageRate.toString() +
                                    '% Gain Bonus',
                                // Text(pourcentageRate.toString() + '% win Bonus',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                )),
                            Row(
                              children: [
                                Text(
                                  Price.getWinningValues(Method.bonusAmount()),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Divider(color: Colors.grey, thickness: 0.5),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Paiement Total'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                )),
                            Row(
                              children: [
                                Text(
                                  Price.getWinningValues(Method.totalPayout()),
                                  style: TextStyle(
                                    color: Colors.lightGreen,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        // Divider(color: Colors.red, height: 1.0),
                        // SizedBox(height: 5.0),
                        if (showBetslipMessagePanel)
                          GestureDetector(
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  showBetslipMessagePanel = false;
                                });
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: new EdgeInsets.all(10.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: showBetslipMessageColorBg,
                                  border: Border(
                                    top: BorderSide(
                                        color: showBetslipMessageColor,
                                        width: 1.0),
                                    bottom: BorderSide(
                                        color: showBetslipMessageColor,
                                        width: 1.0),
                                    left: BorderSide(
                                        color: showBetslipMessageColor,
                                        width: 1.0),
                                    right: BorderSide(
                                        color: showBetslipMessageColor,
                                        width: 1.0),
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'MESSAGE'.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                              // fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          Icon(
                                            Icons.close,
                                            size: 15.0,
                                            color: Colors.black,
                                          ),
                                        ],
                                      )),
                                  Divider(color: Colors.black, thickness: 0.4),
                                  SizedBox(height: 4.0),
                                  Text(
                                    showBetslipMessage,
                                    style: TextStyle(
                                      color: showBetslipMessageColor,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        // SizedBox(height: 5.0),
                        // Divider(color: Colors.red, height: 1.0),
                        SizedBox(height: 10.0),
                        Container(
                          width: double.infinity,
                          child: _loadingBettingButton
                              ? RawMaterialButton(
                                  padding:
                                      new EdgeInsets.symmetric(vertical: 15.0),
                                  onPressed: null,
                                  fillColor: Colors.lightGreen[200],
                                  disabledElevation: 1.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Placement du Pari',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(width: 3.0),
                                      SpinKitCubeGrid(
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                    ],
                                  ),
                                )
                              : RawMaterialButton(
                                  padding: new EdgeInsets.all(15.0),
                                  onPressed: () {
                                    if (mounted)
                                      setState(() {
                                        // print(Selection.userBalance);
                                        // print(Price.minimumBetPrice);
                                        // print(Price.stake);
                                        // show the loading state button
                                        _loadingBettingButton = true;
                                        if (BetSlipData.gameIds.length <= 0) {
                                          // showMessage(context,Colors.red, 'Add Match First');
                                          // show the error panel and the message alongside
                                          showBetslipMessagePanel = true;
                                          showBetslipMessage =
                                              'S\'IL VOUS PLAÎT! \nSelectionnez un Match d\'abord';
                                          // these are panel border color and the bg color
                                          showBetslipMessageColor =
                                              Colors.black;
                                          showBetslipMessageColorBg =
                                              Colors.red[200];
                                          // hide the loading state button
                                          _loadingBettingButton = false;
                                          // print('Add Match first');
                                        } else if (Selection.user == null) {
                                          // show the error panel and the message alongside
                                          showBetslipMessagePanel = true;
                                          showBetslipMessage =
                                              'S\'IL VOUS PLAÎT! \nConnectez-Vous d\'abord.';
                                          // showMessage(context, Colors.red,
                                          //     'Please! Login First');
                                          // these are panel border color and the bg color
                                          showBetslipMessageColor =
                                              Colors.black;
                                          showBetslipMessageColorBg =
                                              Colors.red[200];
                                          // hide the loading state button
                                          _loadingBettingButton = false;
                                          // print('Please Login First');
                                        }
                                        // check if the user provided a balance amount
                                        else if (Price.stake <
                                            Price.minimumBetPrice) {
                                          // show the error panel and the message alongside
                                          showBetslipMessagePanel = true;
                                          showBetslipMessage =
                                              'S\'IL VOUS PLAÎT! \nLe Montant minimum est ${Price.minimumBetPrice} Fc.';
                                          // showMessage(context, Colors.red,
                                          //     'Please! Login First');
                                          // these are panel border color and the bg color
                                          showBetslipMessageColor =
                                              Colors.black;
                                          showBetslipMessageColorBg =
                                              Colors.red[200];
                                          // hide the loading state button
                                          _loadingBettingButton = false;
                                        }
                                        // check if the maximum games is respected
                                        else if (BetSlipData.gameIds.length >
                                            Price.maxGames) {
                                          // show the error panel and the message alongside
                                          showBetslipMessagePanel = true;
                                          showBetslipMessage =
                                              'S\'IL VOUS PLAÎT! \nLa Limite pour un Pari est de [ ${Price.maxGames} ] Matches';
                                          // showMessage(context, Colors.red,
                                          //     'Please! Login First');
                                          // these are panel border color and the bg color
                                          showBetslipMessageColor =
                                              Colors.black;
                                          showBetslipMessageColorBg =
                                              Colors.red[200];
                                          // hide the loading state button
                                          _loadingBettingButton = false;
                                        }

                                        // check if the user has balance in his account
                                        // we check if the user balance is greater than 200
                                        // and if the user balance is greater or equal to stake
                                        else if ((Selection.userBalance >=
                                                Price.minimumBetPrice) &&
                                            (Selection.userBalance >=
                                                Price.stake)) {
                                          // place a bet logic database process should go in here
                                          // this variable told us if we can keep doing processes if everything is ok
                                          int continueProcess = 0;
                                          // String getStartedMatch = '';
                                          // TO DO
                                          // check if selected match are still available
                                          for (int v = 0;
                                              v < BetSlipData.gameIds.length;
                                              v++) {
                                            Firestore.instance
                                                .collection('Games')
                                                .document(
                                                    BetSlipData.gameIds[v])
                                                .get()
                                                .then((value) {
                                              if ((value['status']
                                                          .toString()
                                                          .compareTo(
                                                              'pending') ==
                                                      0) &&
                                                  (value.exists == true)) {
                                                // when the last game will be checked and the keep process if true then continue execution process
                                                // if (v ==
                                                //     BetSlipData.gameIds.length -
                                                //         1) {
                                                //   // print('last element is: at $v');
                                                //   // games availability is checked then continue with adding it to betslip

                                                // }
                                                // print(
                                                //     '${BetSlipData.gameIds[v]} is still available bro!');
                                              } else {
                                                // update the window if new elements are to be rendered
                                                if (mounted)
                                                  setState(() {
                                                    // set the keep process variable to false
                                                    continueProcess = 1;
                                                    // this will display if a game has already started
                                                    // show the error panel and the message alongside
                                                    showBetslipMessagePanel =
                                                        true;
                                                    showBetslipMessage =
                                                        ' ${BetSlipData.team1s[v]} VS ${BetSlipData.team2s[v]} a déjà commencé';
                                                    // showMessage(context, Colors.red,
                                                    //     'Please! Login First');
                                                    // these are panel border color and the bg color
                                                    showBetslipMessageColor =
                                                        Colors.black;
                                                    showBetslipMessageColorBg =
                                                        Colors.red[200];
                                                    // showBetslipMessagePanel = true;
                                                    // print(
                                                    //     '${BetSlipData.gameIds[v]} is no longer available bro!');

                                                    // hide the loading state button
                                                    _loadingBettingButton =
                                                        false;
                                                  });
                                              }
                                            });
                                            // check if the current match is still available to keep looping
                                            if (continueProcess == 1) {
                                              // if one match from the betslip has already started then stop looping
                                              break;
                                            }
                                          }

                                          if (continueProcess == 0) {
                                            if (mounted)
                                              setState(() {
                                                // update user balance in users collection
                                                Method.updateUserBalance()
                                                    .then((value) {
                                                  // add the transaction in the transaction collection
                                                  // Firebase;
                                                  Method.addTransactionRecords(
                                                          'Betting',
                                                          Selection.user.uid,
                                                          Price.stake)
                                                      .then((value) {
                                                    // print(value);
                                                    // if all conditions are verified keep doing the betting process
                                                    // Add the match in the betslip collection
                                                    Method.addBetslipToRecords()
                                                        .then((value) {
                                                      // if the game was placed successfully then reload user info data
                                                      Firestore.instance
                                                          .collection(
                                                              'UserBalance')
                                                          .document(Selection
                                                              .user.uid)
                                                          .get()
                                                          .then((_result) {
                                                        if (mounted)
                                                          setState(() {
                                                            // AFTER PLACING A BET, DARE UPDATE THE USER BALANCE ON SCREEN
                                                            Selection
                                                                    .userBalance =
                                                                _result[
                                                                    'balance'];
                                                            // print(
                                                            //     'balance changed to ${Selection.userBalance}');
                                                          });
                                                      });
                                                      // display the success message if everything went right
                                                      showBetslipMessagePanel =
                                                          true;
                                                      showBetslipMessage =
                                                          'FÉLICITATIONS! PARI AJOUTÉ';
                                                      // these are displaying colors for the success message
                                                      showBetslipMessageColor =
                                                          Colors.white;
                                                      showBetslipMessageColorBg =
                                                          Colors
                                                              .lightGreen[400];
                                                      // showMessage(context, Colors.lightGreen[400],
                                                      //     'Placing your Bets');
                                                      clearGamesSelected();
                                                      // after everything completed, hide the placing bet loading status buttton
                                                      if (mounted)
                                                        setState(() {
                                                          // hide the loading state button
                                                          _loadingBettingButton =
                                                              false;
                                                        });
                                                      // print('Placing your bets');
                                                    }).catchError((e) {
                                                      if (mounted)
                                                        setState(() {
                                                          // hide the loading state button
                                                          _loadingBettingButton =
                                                              false;
                                                          showBetslipMessagePanel =
                                                              true;

                                                          if (e
                                                                  .toString()
                                                                  .compareTo(
                                                                      'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
                                                              0) {
                                                            showBetslipMessage =
                                                                'Pas d\'Internet';
                                                            // print('Pas d\'Internet');
                                                          } else {
                                                            // print('Error 1: $e');
                                                            showBetslipMessage =
                                                                'Unknown Error';
                                                          }
                                                        });
                                                      // print(
                                                      //     'error while adding to betslip is: $e');
                                                    });
                                                  }).catchError((e) {
                                                    if (mounted)
                                                      setState(() {
                                                        // hide the loading state button
                                                        _loadingBettingButton =
                                                            false;
                                                        showBetslipMessagePanel =
                                                            true;

                                                        if (e.toString().compareTo(
                                                                'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
                                                            0) {
                                                          showBetslipMessage =
                                                              'Pas d\'Internet';
                                                          // print('Pas d\'Internet');
                                                        } else {
                                                          // print('Error 2: $e');
                                                          showBetslipMessage =
                                                              'Unknown Error';
                                                        }
                                                      });
                                                    print(
                                                        'The error is while adding transaction $e');
                                                  });
                                                }).catchError((e) {
                                                  if (mounted)
                                                    setState(() {
                                                      // hide the loading state button
                                                      _loadingBettingButton =
                                                          false;
                                                      showBetslipMessagePanel =
                                                          true;

                                                      if (e.toString().compareTo(
                                                              'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
                                                          0) {
                                                        showBetslipMessage =
                                                            'Pas d\'Internet';
                                                        // print('Pas d\'Internet');
                                                      } else {
                                                        // print('Error 3: $e');
                                                        showBetslipMessage =
                                                            'Unknown Error';
                                                      }
                                                    });
                                                  // print(
                                                  //     'error while updating user balance in main is: $e');
                                                });
                                              });
                                          }
                                        } else {
                                          // show the error panel and the message alongside
                                          showBetslipMessagePanel = true;
                                          showBetslipMessage =
                                              'Désolez! \nVotre solde est insuffisant.';
                                          // showMessage(context, Colors.red,
                                          //     'Please! Login First');
                                          // these are panel border color and the bg color
                                          showBetslipMessageColor =
                                              Colors.black;
                                          showBetslipMessageColorBg =
                                              Colors.red[200];
                                          // hide the loading state button
                                          _loadingBettingButton = false;
                                        }
                                      });
                                  },
                                  fillColor: Colors.lightGreen[400],
                                  disabledElevation: 5.0,
                                  child: Text(
                                    'Pariez Ici'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadBetslipMatches() {
    return Column(
      children: BetSlipData.gameIds
          .asMap()
          .entries
          .map(
            (MapEntry map) => slipMatches(
                BetSlipData.team1s[map.key],
                BetSlipData.team2s[map.key],
                // BetSlipData.oddTypes[map.key],
                BetSlipData.gameChoices[map.key],
                BetSlipData.rates[map.key],
                BetSlipData.gameIds[map.key]),
          )
          .toList(),
    );
  }

  Widget slipMatches(
      String team1, String team2, String choice, double rate, String id) {
    return Column(
      children: [
        Container(
          padding: (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.customScreen(context))
              ? EdgeInsets.all(10.0)
              : EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        tooltip: 'Supprimez ce Match',
                        alignment: Alignment.centerLeft,
                        constraints:
                            BoxConstraints(maxHeight: 25.0, maxWidth: 35.0),
                        icon: Icon(Icons.close, size: 18.0, color: Colors.grey),
                        onPressed: () {
                          if (mounted)
                            setState(() {
                              // remove a single match from betslip
                              removeSingleMatch(id);
                            });
                        }),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: ResponsiveWidget.isExtraSmallScreen(context)
                              ? 140.0
                              : 180.0,
                          child: Text(
                            team1 + ' - ' + team2,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey,
                              // letterSpacing: 1.0,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 4,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          choice,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                rate.toStringAsFixed(2).toString(),
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.4,
          height: 0,
        ),
      ],
    );
  }

  Widget singleGame() {
    // var _oddData = moreLoadedMatchOdds['odds'];

    return Expanded(
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
              bottom: BorderSide(color: Colors.grey, width: 0.3),
              left: BorderSide(color: Colors.grey, width: 0.3),
              right: BorderSide(color: Colors.grey, width: 0.3),
            ),
          ),
          margin: EdgeInsets.only(
              left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: ListView(
              padding: EdgeInsets.only(top: 0.0),
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.0,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      if (mounted)
                        setState(() {
                          // Window.showWindow = 0;
                          // SET THE VALUE TO FALSE TO DISPLAY THE HOME PAGE OF GAMES
                          switchToMoreMatchOddsWindow = false;
                          // WE SET THE SELECTED MATCH TO NULL
                          // moreOddsMatch = null;
                          // // WE SET THE ARRAYS VALUE TO NULL
                          // moreLoadedMatchOdds = null;
                        });
                    },
                  ),
                ),
                matchIntro(),
                SizedBox(height: 8.0),
                Divider(color: Colors.grey, thickness: 0.5),
                SizedBox(height: 8.0),
                Column(
                  children: [
                    // IF WE HAVE ONE MATCH DATA LOADED
                    if (moreLoadedMatchOdds != null)
                      for (int _i = 0;
                          _i < moreLoadedMatchOdds['odds'].length;
                          _i++)
                        // WE SAVE THE ODD DATA AND THE ODD ID
                        oddDataAndOddId(moreLoadedMatchOdds['odds'][_i],
                            moreLoadedMatchOdds['odds'][_i]['id']),
                    // Text(
                    //   moreLoadedMatchOdds['odds'][_i]['name'],
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 15.0,
                    //     letterSpacing: 1.0,
                    //   ),
                    // ),
                    // ELSE DISPLAY A LOADING SCREEN
                    if (moreLoadedMatchOdds == null)
                      SpinKitCircle(
                        color: Colors.lightGreen[400],
                        size: 18.0,
                      )
                  ],
                ),
                // Divider(color: Colors.grey, thickness: 0.5),
                // SizedBox(height: 8.0),
                // teamToWin(),
                // overUnder(),
                // SizedBox(height: 8.0),
                // Divider(color: Colors.grey, thickness: 0.5),
                // SizedBox(height: 8.0),
                // bothTeamsToScore(),
                // SizedBox(height: 8.0),
                // Divider(color: Colors.grey, thickness: 0.5),
                // SizedBox(height: 8.0),
                // doubleChance(),
                // SizedBox(height: 8.0),
                // Divider(color: Colors.grey, thickness: 0.5),
                // SizedBox(height: 8.0),
                // oddEven(),
                // SizedBox(height: 8.0),
                // Divider(color: Colors.grey, thickness: 0.5),
                // SizedBox(height: 8.0),
                // halfOdds(),
                // SizedBox(height: 8.0),
                // Divider(color: Colors.grey, thickness: 0.5),
                // SizedBox(height: 8.0),
                // cleanSheet(),
                // Divider(color: Colors.grey, thickness: 0.5),
                // SizedBox(height: 8.0),
                // otherBets(),
              ],
            ),
          )),
    );
  }

  loadSingleGameButtonAction(int index) {
    // get the positioned point
    int getPoint = Selection.gameOddsArray.indexOf(matchMoreOdds.documentID);
    if (Selection.gameOddsArray[getPoint + index] == true) {
      // this method unselect all choices for that ID
      unselectOdds(matchMoreOdds.documentID);
      // remove the match from the betslip too
      removeMatchFromBetSlip(matchMoreOdds);
    } else {
      // this method selects only the specified index
      selectOdds(matchMoreOdds.documentID, index);
      // add match to betslip if clicked
      addMatchToBetSlip(matchMoreOdds, index);
    }
    // Navigator.push(context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
    loadBetslipMatches();
  }

  moreOddsMethodContainer(String type, double rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: TextStyle(fontSize: 12.0, color: color),
        ),
        Text(double.parse(rate.toString()).toStringAsFixed(2).toString(),
            style: TextStyle(color: color, fontSize: 12.0)),
      ],
    );
  }

  teamToWin() {
    // print('loaded before error');
    // load all 1x2 values attributed to it
    var rate1x2 = matchMoreOdds['oneTimesTwo'];
    bool _gamePopularity = false;
    // try {
    _gamePopularity = matchMoreOdds['isPopular'];
    // } catch (e) {
    //   print('the annoing error is: $e');
    //   _gamePopularity = false;
    // }
    // print('loaded after error');
    // print(matchMoreOdds['isPopular']);
    // print(_gamePopularity);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1X2',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Plein Temps',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            if (_gamePopularity == true)
              Icon(
                Icons.trending_up,
                color: Colors.lightGreen[400],
                size: 25.0,
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            oneTimesTwoTeam1FullTime(rate1x2, 1),
            SizedBox(width: 5.0),
            oneTimesTwoTeamDrawFullTime(rate1x2, 2),
            SizedBox(width: 5.0),
            oneTimesTwoTeam2FullTime(rate1x2, 3),
          ],
        ),
        Text(
          '1ère Mi-Temps',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            oneTimesTwoTeam1FirstHalf(rate1x2, 4),
            SizedBox(width: 5.0),
            oneTimesTwoTeamDrawFirstHalf(rate1x2, 5),
            SizedBox(width: 5.0),
            oneTimesTwoTeam2FirstHalf(rate1x2, 6),
          ],
        ),
        Text(
          '2ème Mi-Temps',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            oneTimesTwoTeam1SecondHalf(rate1x2, 7),
            SizedBox(width: 5.0),
            oneTimesTwoTeamDrawSecondHalf(rate1x2, 8),
            SizedBox(width: 5.0),
            oneTimesTwoTeam2SecondHalf(rate1x2, 9),
          ],
        ),
      ],
    );
  }

  oneTimesTwoTeam2SecondHalf(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: oneTimesTwoContainer('2', matchMoreOdds['team2'], rate1x2['9']),
      ),
    );
  }

  oneTimesTwoTeamDrawSecondHalf(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: topMatchesButtonDrawDesign(rate1x2['8']),
      ),
    );
  }

  oneTimesTwoTeam1SecondHalf(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: oneTimesTwoContainer('1', matchMoreOdds['team1'], rate1x2['7']),
      ),
    );
  }

  oneTimesTwoTeam2FirstHalf(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: oneTimesTwoContainer('2', matchMoreOdds['team2'], rate1x2['6']),
      ),
    );
  }

  oneTimesTwoTeamDrawFirstHalf(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: topMatchesButtonDrawDesign(rate1x2['5']),
      ),
    );
  }

  oneTimesTwoTeam1FirstHalf(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: oneTimesTwoContainer('1', matchMoreOdds['team1'], rate1x2['4']),
      ),
    );
  }

  oneTimesTwoTeam2FullTime(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: oneTimesTwoContainer('2', matchMoreOdds['team2'], rate1x2['3']),
      ),
    );
  }

  oneTimesTwoTeamDrawFullTime(var rate1x2, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: topMatchesButtonDrawDesign(rate1x2['2']),
      ),
    );
  }

  oneTimesTwoTeam1FullTime(var rate1x2, int index) {
    // print('after the error and bolean is:');
    // print('the index is: ${Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)}');
    // print(Selection.gameOddsArray[
    //     (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: oneTimesTwoContainer('1', matchMoreOdds['team1'], rate1x2['1']),
      ),
    );
  }

  overUnder() {
    //  load all over under values attributed to it
    var rateOverUnder = matchMoreOdds['overUnder'];
    // print(rateOverUnder['1']);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PLUS DE / SOUS',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Plein Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        // over 0.5 and Under 0.5
        // display only if values are not zeros
        if ((rateOverUnder['1'] != 0) && (rateOverUnder['2'] != 0))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              overUnderOver_0_5(rateOverUnder, 10),
              SizedBox(width: 5.0),
              overUnderUnder_0_5(rateOverUnder, 11),
            ],
          ),
        // display only if values are not zeros
        if ((rateOverUnder['3'] != 0) && (rateOverUnder['4'] != 0))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              overUnderOver_1_5(rateOverUnder, 12),
              SizedBox(width: 5.0),
              overUnderUnder_1_5(rateOverUnder, 13),
            ],
          ),
        // display only if values are not zeros
        if ((rateOverUnder['5'] != 0) && (rateOverUnder['6'] != 0))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              overUnderOver_2_5(rateOverUnder, 14),
              SizedBox(width: 5.0),
              overUnderUnder_2_5(rateOverUnder, 15),
            ],
          ),
        // display only if values are not zeros
        if ((rateOverUnder['7'] != 0) && (rateOverUnder['8'] != 0))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              overUnderOver_3_5(rateOverUnder, 16),
              SizedBox(width: 5.0),
              overUnderUnder_3_5(rateOverUnder, 17),
            ],
          ),
        // display only if values are not zeros
        if ((rateOverUnder['9'] != 0) && (rateOverUnder['10'] != 0))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              overUnderOver_4_5(rateOverUnder, 18),
              SizedBox(width: 5.0),
              overUnderUnder_4_5(rateOverUnder, 19),
            ],
          ),
        // display only if values are not zeros
        if ((rateOverUnder['11'] != 0) && (rateOverUnder['12'] != 0))
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              overUnderOver_5_5(rateOverUnder, 20),
              SizedBox(width: 5.0),
              overUnderUnder_5_5(rateOverUnder, 21),
            ],
          ),
      ],
    );
  }

  overUnderUnder_5_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Under 5.5', rateOverUnder['12']),
      ),
    );
  }

  overUnderOver_5_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Over 5.5', rateOverUnder['11']),
      ),
    );
  }

  overUnderUnder_4_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Under 4.5', rateOverUnder['10']),
      ),
    );
  }

  overUnderOver_4_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Over 4.5', rateOverUnder['9']),
      ),
    );
  }

  overUnderUnder_3_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Under 3.5', rateOverUnder['8']),
      ),
    );
  }

  overUnderOver_3_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Over 3.5', rateOverUnder['7']),
      ),
    );
  }

  overUnderUnder_2_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Under 2.5', rateOverUnder['6']),
      ),
    );
  }

  overUnderOver_2_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Over 2.5', rateOverUnder['5']),
      ),
    );
  }

  overUnderUnder_1_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Under 1.5', rateOverUnder['4']),
      ),
    );
  }

  overUnderOver_1_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Over 1.5', rateOverUnder['3']),
      ),
    );
  }

  overUnderUnder_0_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Under 0.5', rateOverUnder['2']),
      ),
    );
  }

  overUnderOver_0_5(var rateOverUnder, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Over 0.5', rateOverUnder['1']),
      ),
    );
  }

  bothTeamsToScore() {
    //  load all BTS values attributed to it
    var rateBTS = matchMoreOdds['bothTeamsToScore'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LES DEUX EQUIPES MARQUENT',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Plein Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bothTeamToScoreYes(rateBTS, 22),
            SizedBox(width: 5.0),
            bothTeamToScoreNo(rateBTS, 23),
          ],
        ),
      ],
    );
  }

  bothTeamToScoreNo(var rateBTS, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('No', rateBTS['2']),
      ),
    );
  }

  bothTeamToScoreYes(var rateBTS, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Oui', rateBTS['1']),
      ),
    );
  }

  oddEven() {
    // load odd/even rate
    var rateOddEven = matchMoreOdds['oddEven'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IMPAIR / PAIR',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Plein Temps',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            oddEvenFullTimeOdd(rateOddEven, 24),
            SizedBox(width: 5.0),
            oddEvenFullTimeEven(rateOddEven, 25),
          ],
        ),
        SizedBox(height: 5.0),
        // SizedBox(height: 5.0),
        Text(
          matchMoreOdds['team1'] + ' - Plein Temps',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            oddEvenTeam1Odd(rateOddEven, 26),
            SizedBox(width: 5.0),
            oddEvenTeam1Even(rateOddEven, 27),
          ],
        ),
        SizedBox(height: 5.0),
        // SizedBox(height: 5.0),
        Text(
          matchMoreOdds['team2'] + ' - Plein Temps',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            oddEvenTeam2Odd(rateOddEven, 28),
            SizedBox(width: 5.0),
            oddEvenTeam2Even(rateOddEven, 29),
          ],
        ),
      ],
    );
  }

  oddEvenTeam2Even(var rateOddEven, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Pair', rateOddEven['6']),
      ),
    );
  }

  oddEvenTeam2Odd(var rateOddEven, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Impair', rateOddEven['5']),
      ),
    );
  }

  oddEvenTeam1Even(var rateOddEven, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Pair', rateOddEven['4']),
      ),
    );
  }

  oddEvenTeam1Odd(var rateOddEven, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Impair', rateOddEven['3']),
      ),
    );
  }

  oddEvenFullTimeEven(var rateOddEven, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Pair', rateOddEven['2']),
      ),
    );
  }

  oddEvenFullTimeOdd(var rateOddEven, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Impair', rateOddEven['1']),
      ),
    );
  }

  halfOdds() {
    // load specific array content values
    var rateHalf = matchMoreOdds['half'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mi-Temps'.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'La Mi-Temps avec plus de Buts',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            halfWithMoreGoalsFirst(rateHalf, 30),
            SizedBox(width: 5.0),
            halfWithMoreGoalsSecond(rateHalf, 31),
            SizedBox(width: 5.0),
            halfWithMoreGoalsEqual(rateHalf, 32),
          ],
        ),
        SizedBox(height: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Text(
              matchMoreOdds['team1'] + ' gagner soit une Mi-Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            team1WinEitherHalfYes(rateHalf, 33),
            SizedBox(width: 5.0),
            team1WinEitherHalfNo(rateHalf, 34),
          ],
        ),
        SizedBox(height: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Text(
              matchMoreOdds['team2'] + ' gagner soit une Mi-Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            team2WinEitherHalfYes(rateHalf, 35),
            SizedBox(width: 5.0),
            team2WinEitherHalfNo(rateHalf, 36),
          ],
        ),
        SizedBox(height: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Text(
              matchMoreOdds['team1'] + ' marquer dans les deux mi-temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            team1ScoreInBothHalvesYes(rateHalf, 37),
            SizedBox(width: 5.0),
            team1ScoreInBothHalvesNo(rateHalf, 38),
          ],
        ),
        SizedBox(height: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Text(
              matchMoreOdds['team2'] + ' marquer dans les deux mi-temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            team2ScoreInBothHalvesYes(rateHalf, 39),
            SizedBox(width: 5.0),
            team2ScoreInBothHalvesNo(rateHalf, 40),
          ],
        ),
      ],
    );
  }

  team2ScoreInBothHalvesNo(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Non', rateHalf['11']),
      ),
    );
  }

  team2ScoreInBothHalvesYes(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Oui', rateHalf['10']),
      ),
    );
  }

  team1ScoreInBothHalvesNo(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Non', rateHalf['9']),
      ),
    );
  }

  team1ScoreInBothHalvesYes(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Oui', rateHalf['8']),
      ),
    );
  }

  team2WinEitherHalfNo(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Non', rateHalf['7']),
      ),
    );
  }

  team2WinEitherHalfYes(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Oui', rateHalf['6']),
      ),
    );
  }

  team1WinEitherHalfNo(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Non', rateHalf['5']),
      ),
    );
  }

  team1WinEitherHalfYes(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Oui', rateHalf['4']),
      ),
    );
  }

  halfWithMoreGoalsEqual(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Égale', rateHalf['3']),
      ),
    );
  }

  halfWithMoreGoalsSecond(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('2eme', rateHalf['2']),
      ),
    );
  }

  halfWithMoreGoalsFirst(var rateHalf, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('1ère', rateHalf['1']),
      ),
    );
  }

  cleanSheet() {
    // load specific array content values
    var rateCleanSheet = matchMoreOdds['cleanSheet'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FEUILLE PROPRE',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              matchMoreOdds['team1'] + ' -  Plein Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cleanSheetTeam1FullTimeYes(rateCleanSheet, 41),
            SizedBox(width: 5.0),
            cleanSheetTeam1FullTimeNo(rateCleanSheet, 42),
          ],
        ),
        SizedBox(height: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Text(
              matchMoreOdds['team2'] + ' - Plein Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cleanSheetTeam2FullTimeYes(rateCleanSheet, 43),
            SizedBox(width: 5.0),
            cleanSheetTeam2FullTimeNo(rateCleanSheet, 44),
          ],
        ),
      ],
    );
  }

  cleanSheetTeam2FullTimeNo(var rateCleanSheet, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Non', rateCleanSheet['4']),
      ),
    );
  }

  cleanSheetTeam2FullTimeYes(var rateCleanSheet, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Oui', rateCleanSheet['3']),
      ),
    );
  }

  cleanSheetTeam1FullTimeNo(var rateCleanSheet, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Non', rateCleanSheet['2']),
      ),
    );
  }

  cleanSheetTeam1FullTimeYes(var rateCleanSheet, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('Oui', rateCleanSheet['1']),
      ),
    );
  }

  doubleChance() {
    var rateDC = matchMoreOdds['doubleChance'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DOUBLE CHANCE',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Plein Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            doubleChance1(rateDC, 45),
            SizedBox(width: 5.0),
            doubleChance2(rateDC, 46),
            SizedBox(width: 5.0),
            doubleChance3(rateDC, 47),
          ],
        ),
      ],
    );
  }

  doubleChance3(var rateDC, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer(
            '12', rateDC.toString().compareTo('null') == 0 ? 0 : rateDC['3']),
      ),
    );
  }

  doubleChance2(var rateDC, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer(
            '2X', rateDC.toString().compareTo('null') == 0 ? 0 : rateDC['2']),
      ),
    );
  }

  doubleChance1(var rateDC, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer(
            '1X', rateDC.toString().compareTo('null') == 0 ? 0 : rateDC['1']),
      ),
    );
  }

  otherBets() {
    // load specific array content values
    var rateOther = matchMoreOdds['other'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AUTRES',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '1X2 et les deux équipes marquent - Plein Temps',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            yes1(rateOther, 48),
            SizedBox(width: 5.0),
            no1(rateOther, 49),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            yes2(rateOther, 50),
            SizedBox(width: 5.0),
            no2(rateOther, 51),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            yesX(rateOther, 52),
            SizedBox(width: 5.0),
            noX(rateOther, 53),
          ],
        ),
      ],
    );
  }

  noX(var rateOther, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('X - Non', rateOther['6']),
      ),
    );
  }

  yesX(var rateOther, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('X - Oui', rateOther['5']),
      ),
    );
  }

  no2(var rateOther, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('2 - Non', rateOther['4']),
      ),
    );
  }

  yes2(var rateOther, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('2 - Oui', rateOther['3']),
      ),
    );
  }

  no1(var rateOther, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('1 - Non', rateOther['2']),
      ),
    );
  }

  yes1(var rateOther, int index) {
    // update the coloration of the button
    updateColors(Selection.gameOddsArray[
        (Selection.gameOddsArray.indexOf(matchMoreOdds.documentID)) + index]);
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          if (mounted)
            setState(() {
              loadSingleGameButtonAction(index);
            });
        },
        fillColor: colorBg,
        padding: new EdgeInsets.symmetric(horizontal: 5.0),
        child: moreOddsMethodContainer('1 - Oui', rateOther['1']),
      ),
    );
  }

  matchIntro() {
    // moreOddsMatch
    var team1 = moreOddsMatch.localTeam['data']['name'];
    var team2 = moreOddsMatch.visitorTeam['data']['name'];
    // var team2 = match['team2'];
    // GET THE TIME OF THE MATCH
    var time = moreOddsMatch.time['starting_at']['time'];
    // GET THE DATE OF THE GAME
    var date = moreOddsMatch.time['starting_at']['date'];

    var championship;
    var country;
    int _leagueIndex;
    // LET US LOAD CHAMPIONSHIPS
    // ONLY IF WE HAVE DATA IN THE ARRAY
    if (_leagues.length > 0)
      for (int j = 0; j < _leagues.length; j++) {
        if (_leagues[j]['id'] == moreOddsMatch.league_id) {
          championship = _leagues[j]['name'];
          _leagueIndex = j;
          // print('the ligue is ${_leagues[_lpLg]['name']}');
          // WE BREAK THE LOOP FOR BETTER PROCESSING
          break;
        }
      }

    // LET US GET THE CORRECT COUNTRY HERE
    // ONLY IF WE HAVE DATA IN THE ARRAY
    if (_countries.length > 0)
      for (int j = 0; j < _countries.length; j++) {
        if (_leagues[_leagueIndex]['country_id'] == _countries[j]['id']) {
          country = ' - ' + _countries[j]['name'];
          // print('the country name is ${_countries[j]['name']}');
          // WE BREAK THE LOOP FOR BETTER PROCESSING
          break;
        }
      }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.toString(),
              // matchMoreOdds['date']['1'] + ' ' + day + '/' + month,
              // 'sat 11/09',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              time.toString(),
              // hour + ':' + minute + ' ' + matchMoreOdds['time']['3'],
              // '05:00 PM',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Text(
          team1.toString() + ' - ' + team2.toString(),
          // matchMoreOdds['team1'] + ' - ' + matchMoreOdds['team2'],
          // 'Liverpool vs Man City',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          championship + country,
          // 'Premier League - England - Football',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  updateColors(bool select) {
    // try {
    // print('the selected boolean value is: $select');
    if (select) {
      color = Colors.white;
      colorBg = Colors.lightGreen[400];
      colorRounded = Colors.white70;
      colorCaption = Colors.lightGreen[400];
    } else {
      colorCaption = Colors.white70;
      color = Colors.black;
      colorBg = Colors.grey[300];
      colorRounded = Colors.lightGreen[400];
    }
    // } catch (e) {
    //   print('the very stupid error is $e');
    // }
  }

  removeMatchFromBetSlip(DocumentSnapshot match) {
    var getPosition = BetSlipData.gameIds.indexOf(match.documentID);
    BetSlipData.team1s.removeAt(getPosition); // remove team1
    BetSlipData.team2s.removeAt(getPosition); // remove Team 2
    // BetSlipData.oddTypes.removeAt(getPosition); // remove oddTypes
    BetSlipData.gameChoices.removeAt(getPosition); // remove Team Choosen 1-X-2
    BetSlipData.rates.removeAt(getPosition); // remove rate of selected team
    BetSlipData.gameIds.removeAt(getPosition); // remove id
  }

  unselectOdds(String id) {
    // create an empty list that will replace the old values in the array
    var defaultList = [];
    for (var i = 0; i < Selection.maxLength; i++) {
      defaultList.add(false);
    }
    // get the point where the id starts counting
    int getPoint = Selection.gameOddsArray.indexOf(id);
    // replace all values with new ones [default ones]
    Selection.gameOddsArray.replaceRange(
        (getPoint + 1), (getPoint + (Selection.maxLength + 1)), defaultList);
  }

  selectOdds(String id, int position) {
    // get the point where the id starts counting
    int getPoint = Selection.gameOddsArray.indexOf(id);
    // First we set all the values to default values[false]
    // then we can update only the index value
    unselectOdds(id);
    // replace the value in the main array
    Selection.gameOddsArray
        .replaceRange((getPoint + position), (getPoint + position), [true]);
  }

  addMatchToBetSlip(DocumentSnapshot match, int index) {
    // check if the maximum amount of betting is reached
    // if (BetSlipData.gameIds.length < 2) {
    // these variables contain needed values for betslip
    var id = match.documentID, team1 = match['team1'], team2 = match['team2'];
    String teamChoosen = '';
    double rate = 0;
    // hide the show error panel in BETSLIP every time a match is selected or changed
    showBetslipMessagePanel = false;
    // print(match['oneTimesTwo']['1']);
    // this is 1x2 conditions
    if (index == 1) {
      teamChoosen = Selection.reference[0];
      rate = match['oneTimesTwo']['1'];
    } else if (index == 2) {
      teamChoosen = Selection.reference[1];
      rate = match['oneTimesTwo']['2'];
    } else if (index == 3) {
      teamChoosen = Selection.reference[2];
      rate = match['oneTimesTwo']['3'];
    } else if (index == 4) {
      teamChoosen = Selection.reference[3];
      rate = match['oneTimesTwo']['4'];
    } else if (index == 5) {
      teamChoosen = Selection.reference[4];
      rate = match['oneTimesTwo']['5'];
    } else if (index == 6) {
      teamChoosen = Selection.reference[5];
      rate = match['oneTimesTwo']['6'];
    } else if (index == 7) {
      teamChoosen = Selection.reference[6];
      rate = match['oneTimesTwo']['7'];
    } else if (index == 8) {
      teamChoosen = Selection.reference[7];
      rate = match['oneTimesTwo']['8'];
    } else if (index == 9) {
      teamChoosen = Selection.reference[8];
      rate = match['oneTimesTwo']['9'];
    }
    // this is over and under conditions
    else if (index == 10) {
      teamChoosen = Selection.reference[9];
      rate = match['overUnder']['1'];
    } else if (index == 11) {
      teamChoosen = Selection.reference[10];
      rate = match['overUnder']['2'];
    } else if (index == 12) {
      teamChoosen = Selection.reference[11];
      rate = match['overUnder']['3'];
    } else if (index == 13) {
      teamChoosen = Selection.reference[12];
      rate = match['overUnder']['4'];
    } else if (index == 14) {
      teamChoosen = Selection.reference[13];
      rate = match['overUnder']['5'];
    } else if (index == 15) {
      teamChoosen = Selection.reference[14];
      rate = match['overUnder']['6'];
    } else if (index == 16) {
      teamChoosen = Selection.reference[15];
      rate = match['overUnder']['7'];
    } else if (index == 17) {
      teamChoosen = Selection.reference[16];
      rate = match['overUnder']['8'];
    } else if (index == 18) {
      teamChoosen = Selection.reference[17];
      rate = match['overUnder']['9'];
    } else if (index == 19) {
      teamChoosen = Selection.reference[18];
      rate = match['overUnder']['10'];
    } else if (index == 20) {
      teamChoosen = Selection.reference[19];
      rate = match['overUnder']['11'];
    } else if (index == 21) {
      teamChoosen = Selection.reference[20];
      rate = match['overUnder']['12'];
    }
    // this is Both teams to score panel
    else if (index == 22) {
      teamChoosen = Selection.reference[21];
      rate = match['bothTeamsToScore']['1'];
    } else if (index == 23) {
      teamChoosen = Selection.reference[22];
      rate = match['bothTeamsToScore']['2'];
    }
    // this is odd and even conditions
    else if (index == 24) {
      teamChoosen = Selection.reference[23];
      rate = match['oddEven']['1'];
    } else if (index == 25) {
      teamChoosen = Selection.reference[24];
      rate = match['oddEven']['2'];
    } else if (index == 26) {
      teamChoosen = Selection.reference[25];
      rate = match['oddEven']['3'];
    } else if (index == 27) {
      teamChoosen = Selection.reference[26];
      rate = match['oddEven']['4'];
    } else if (index == 28) {
      teamChoosen = Selection.reference[27];
      rate = match['oddEven']['5'];
    } else if (index == 29) {
      teamChoosen = Selection.reference[28];
      rate = match['oddEven']['6'];
    }
    // half odds display here
    else if (index == 30) {
      teamChoosen = Selection.reference[29];
      rate = match['half']['1'];
    } else if (index == 31) {
      teamChoosen = Selection.reference[30];
      rate = match['half']['2'];
    } else if (index == 32) {
      teamChoosen = Selection.reference[31];
      rate = match['half']['3'];
    } else if (index == 33) {
      teamChoosen = Selection.reference[32];
      rate = match['half']['4'];
    } else if (index == 34) {
      teamChoosen = Selection.reference[33];
      rate = match['half']['5'];
    } else if (index == 35) {
      teamChoosen = Selection.reference[34];
      rate = match['half']['6'];
    } else if (index == 36) {
      teamChoosen = Selection.reference[35];
      rate = match['half']['7'];
    } else if (index == 37) {
      teamChoosen = Selection.reference[36];
      rate = match['half']['8'];
    } else if (index == 38) {
      teamChoosen = Selection.reference[37];
      rate = match['half']['9'];
    } else if (index == 39) {
      teamChoosen = Selection.reference[38];
      rate = match['half']['10'];
    } else if (index == 40) {
      teamChoosen = Selection.reference[39];
      rate = match['half']['11'];
    }
    // clean sheet odds display here
    else if (index == 41) {
      teamChoosen = Selection.reference[40];
      rate = match['cleanSheet']['1'];
    } else if (index == 42) {
      teamChoosen = Selection.reference[41];
      rate = match['cleanSheet']['2'];
    } else if (index == 43) {
      teamChoosen = Selection.reference[42];
      rate = match['cleanSheet']['3'];
    } else if (index == 44) {
      teamChoosen = Selection.reference[43];
      rate = match['cleanSheet']['4'];
    }
    // draw no bet odds display here
    else if (index == 45) {
      teamChoosen = Selection.reference[44];
      rate = match['doubleChance']['1'];
    } else if (index == 46) {
      teamChoosen = Selection.reference[45];
      rate = match['doubleChance']['2'];
    } else if (index == 47) {
      teamChoosen = Selection.reference[46];
      rate = match['doubleChance']['3'];
    }
    // other odds goes here [1x2 and both teams to score]
    else if (index == 48) {
      teamChoosen = Selection.reference[47];
      rate = match['other']['1'];
    } else if (index == 49) {
      teamChoosen = Selection.reference[48];
      rate = match['other']['2'];
    } else if (index == 50) {
      teamChoosen = Selection.reference[49];
      rate = match['other']['3'];
    } else if (index == 51) {
      teamChoosen = Selection.reference[50];
      rate = match['other']['4'];
    } else if (index == 52) {
      teamChoosen = Selection.reference[51];
      rate = match['other']['5'];
    } else if (index == 53) {
      teamChoosen = Selection.reference[52];
      rate = match['other']['6'];
    } else {
      teamChoosen = Selection.reference[53];
      rate = 0.0;
    }

    if (BetSlipData.gameIds.contains(id)) {
      // get the position of the current ids and update everything
      int getIdPosition = BetSlipData.gameIds.indexOf(id);
      // if existed before, delete previous then update everything
      BetSlipData.team1s[getIdPosition] = team1;
      BetSlipData.team2s[getIdPosition] = team2;
      // BetSlipData.oddTypes[getIdPosition] = type;
      BetSlipData.gameChoices[getIdPosition] = teamChoosen;
      BetSlipData.rates[getIdPosition] = rate;
      BetSlipData.gameIds[getIdPosition] = id;
    } else {
      // if the id was not iserted so far then add it into the betslip
      BetSlipData.team1s.add(team1); // add team1
      BetSlipData.team2s.add(team2); // add Team 2
      // BetSlipData.oddTypes.add(type); // add oddTypes
      BetSlipData.gameChoices.add(teamChoosen); // add Team Choosen 1-X-2
      BetSlipData.rates.add(rate); // add rate of selected team
      BetSlipData.gameIds.add(id); // add id
    }
    // } else {
    //   print(BetSlipData.gameIds.length);
    //   var id = match.documentID;
    //   if (BetSlipData.gameIds.contains(id)) {
    //     removeMatchFromBetSlip(match);
    //   }
    // }
  }

  Widget tournament() {
    return Expanded(
      child: Container(
        width: 180.0,
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.1),
            bottom: BorderSide(color: Colors.grey, width: 0.1),
            left: BorderSide(color: Colors.grey, width: 0.1),
            right: BorderSide(color: Colors.grey, width: 0.1),
          ),
        ),
        child: loadSideDataArrayChamp.length > 0
            ? ListView.builder(
                itemCount: loadSideDataArrayChamp.length,
                itemBuilder: (context, index) {
                  // load the first and the following index
                  return championship(loadSideDataArrayChamp[index],
                      loadSideDataArrayCountry[index]);
                },
              )
            : Center(
                child: (isNoInternetNetwork)
                    ? Text('Pas d\'Internet!'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          // fontStyle: FontStyle.italic,
                        ))
                    : SpinKitCubeGrid(
                        color: Colors.lightGreen[400],
                        size: 20.0,
                      ),
              ),
      ),
    );
  }

  championship(String championship, String country) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final _thisLocalData = await Selection.getCategory(championship);
          // we will now check if a championship has been adde so it won't be added again
          if (mounted)
            setState(() {
              // get the index of the selected item
              // // ASSIGN THE SELECTED CHAMPIONSHIP TO A NEW ICON
              _indexChampionSelection =
                  loadSideDataArrayChamp.indexOf(championship);

              // print('selection of $championship');
              // print('state is $_getChampionship');
              // clear all old value of data array so that filtered ones can be added
              data.clear();
              for (var i = 0; i < (_thisLocalData.length); i++) {
                // execute this if the array contains elements
                if (data.length > 0) {
                  int verifier = 0;
                  // check if the array contains already the championship
                  for (var j = 0; j < data.length; j++) {
                    if (data[j].documentID.toString().compareTo(
                            _thisLocalData[i].documentID.toString()) ==
                        0) {
                      verifier++;
                    }
                  }
                  // add the championship if it is not added yet
                  if (verifier == 0) {
                    // add the current match to data array
                    data.add(_thisLocalData[i]);
                    // add the championship
                  }
                }
                // else execute this
                else {
                  // add match if not yet added
                  data.add(_thisLocalData[i]);
                }
              }
            });
        },
        child: Column(
          children: [
            Container(
              padding: new EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 105.0,
                        child: Text(
                          championship,
                          style: TextStyle(
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Text(
                        country,
                        style: TextStyle(color: Colors.grey, fontSize: 11.0),
                      ),
                    ],
                  ),

                  Icon(
                    // SHOW A DIFFERENT ICON IF A CHAMPIONSHIP IS SELECTED
                    _indexChampionSelection ==
                            loadSideDataArrayChamp.indexOf(championship)
                        ? Icons.verified
                        : Icons.arrow_forward_ios,
                    // SHOW A DIFFERENT COLOR WHEN A CHAMPIONSHIP IS SELECTED
                    color: _indexChampionSelection ==
                            loadSideDataArrayChamp.indexOf(championship)
                        ? Colors.lightBlue[400]
                        : Colors.lightGreen[400],
                    size: 20.0,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
          ],
        ),
      ),
    );
  }

  Widget search() {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 5.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  height: 60.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border(
                        top: BorderSide(color: Colors.lightGreen, width: 1.5),
                        bottom:
                            BorderSide(color: Colors.lightGreen, width: 1.5),
                        left: BorderSide(color: Colors.lightGreen, width: 1.5),
                        right: BorderSide(color: Colors.lightGreen, width: 1.5),
                      )),
                  child: TextField(
                    cursorColor: Colors.lightGreen,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter,
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[a-zA-Z0-9\s]')), // create a pattern for text only
                    ],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cherchez un Match',
                        icon: Icon(
                          Icons.search,
                          color: Colors.lightGreen[400],
                        ),
                        hintMaxLines: 1,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0)),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        if (mounted)
                          setState(() {
                            _queryResults.clear();
                            _queryDisplay.clear();
                            _isQueryEmpty = true;
                          });
                        return;
                      }
                      try {
                        if (mounted)
                          setState(() {
                            // if reaches here it means the value is not empty
                            _isQueryEmpty = false;
                            // everytime a value is changed, do update the results
                            loadingSearch(value);
                          });
                      } catch (e) {
                        // caught the error if any one show in the user typing
                        print('Erreur: $e');
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Mes Résultats'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5.0),
                Divider(color: Colors.grey, thickness: 0.5),
                // if something has been found in collection, execute this
                _queryResults.length > 0
                    // if both contents are greater than 0 print this
                    ? _queryDisplay.length > 0
                        ? MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Column(
                              children: _queryDisplay.map<Widget>(
                                (result) {
                                  // return Container(child: Text(word['team1']));
                                  return thisResult(result);
                                },
                              ).toList(),
                            ),
                          )
                        // if there is no matching content then do thi
                        : Center(
                            child: (isNoInternetNetwork)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text('Pas d\'Internet'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          // fontStyle: FontStyle.italic,
                                        )),
                                  )
                                : Column(
                                    children: [
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Aucun Match Trouvé',
                                        style: TextStyle(
                                          color: Colors.lightGreen[400],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      SpinKitCubeGrid(
                                        color: Colors.lightGreen[400],
                                        size: 20.0,
                                        // lineWidth: 5.0,
                                      ),
                                    ],
                                  ),
                          )
                    // if the query is empty return three dots
                    : _isQueryEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Center(
                              child: Text(
                                'Résultats de la Recherche',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          )
                        // if that means nothing has been found in collection
                        : Center(
                            child: (isNoInternetNetwork)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text('Pas d\'Internet'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          // fontStyle: FontStyle.italic,
                                        )),
                                  )
                                : Column(
                                    children: [
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Aucun Match Trouvé',
                                        style: TextStyle(
                                          color: Colors.lightGreen[400],
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      SpinKitCubeGrid(
                                        color: Colors.lightGreen[400],
                                        size: 20.0,
                                        // lineWidth: 5.0,
                                      ),
                                    ],
                                  ),
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  thisResult(DocumentSnapshot result) {
    return GestureDetector(
      onTap: () {
        if (mounted)
          setState(() {
            // matchMoreOdds = null;
            try {
              // print('loading ${result['team1']} and ${result['team2']}');
              // assign the results to match more odds and load game details
              // we need to add the game first to the array is not added yet
              // Selection.gameOddsArray
              // check first if the id already does not exist
              if (!Selection.gameOddsArray.contains(result.documentID)) {
                int currentPosition = Selection.gameOddsArray.length;
                for (var j = 0; j < (Selection.maxLength + 1); j++) {
                  if (j == 0) {
                    // add the id at the first position
                    Selection.gameOddsArray
                        .insert(currentPosition, result.documentID);
                  } else {
                    // add false values at the remaining position
                    Selection.gameOddsArray
                        .insert((currentPosition + j), false);
                  }
                }
                // print('This game does not exist yet');
              }
              // else {
              //   print('This game exists already');
              // }
              matchMoreOdds = result;
              // print(matchMoreOdds.data);
              // print(result.documentID);
              // print(matchMoreOdds.documentID);
              _queryDisplay.clear();
              _queryResults.clear();

              _isQueryEmpty = true;
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
              // go to match detail page
              Window.showWindow = 1;
              // go to home page content
              Window.selectedMenu = 1;
              // select the home bottom as the current tab
              // Selection.bottomCurrentTab = 0;
              // set the jackpot index to football selection
              Window.showJackpotIndex = 0;
            } catch (e) {
              // print('the stupid error is $e');
            }
          });
      },
      child: Column(
        children: [
          SizedBox(height: 5.0),
          Row(
            children: [
              Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.blue),
              SizedBox(width: 4.0),
              Container(
                width: ResponsiveWidget.isExtraSmallScreen(context)
                    ? 150
                    : ResponsiveWidget.isSmallScreen(context)
                        ? 250
                        : (ResponsiveWidget.isMediumScreen(context) ||
                                ResponsiveWidget.customScreen(context) ||
                                ResponsiveWidget.isExtraLargeScreen(context))
                            ? 450
                            : 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['team1'] + ' - ' + result['team2'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ResponsiveWidget.isExtraSmallScreen(context)
                            ? 11.0
                            : 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.clip,
                    ),
                    // SizedBox(height: 3.0),
                    Text(
                      result['date']['1'] +
                          ' ' +
                          result['date']['2'] +
                          '/' +
                          result['date']['3'] +
                          ' - ' +
                          result['time']['1'] +
                          ':' +
                          result['time']['2'] +
                          ' ' +
                          result['time']['3'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          SizedBox(height: 5.0),
          Divider(color: Colors.grey, thickness: 0.4),
        ],
      ),
    );
  }

  bool isNoInternetNetwork = false;
  // bool isNoInternetNetworkOrOtherError = false;

  void checkInternet() async {
    try {
      final response =
          await http.get('https://jsonplaceholder.typicode.com/albums/1');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // print('fetched successfully');
        isNoInternetNetwork = false;
      } else {
        // If the server did not return a 200 OK response,
        // if there is an error
        if (mounted)
          setState(() {
            // print('failed to load data');
            isNoInternetNetwork = true;
          });
        // then throw an exception.
        // throw Exception('Failed to load album');
      }
    } catch (e) {
      if (mounted)
        setState(() {
          // clear the array so the condition can be reached
          // data.clear();
          // if there is an error based on network
          isNoInternetNetwork = true;
          // print('network error is: $e');
        });
    }
  }

  loadingSearch(String search) {
    // starting letters will be stored in an array ['B','R'] for e.g. Barcelona and Real Madrid
    // we will use the or operator to load and search through them
    // load all matches starting with the letter only
    var capitalizedValue =
        search.substring(0, 1).toUpperCase() + search.substring(1);

    if ((_queryResults.length == 0) && (search.length == 1)) {
      // cehck for internet connectivity first of all
      checkInternet();
      // print('The value to send on server is: $capitalizedValue');
      // _queryResults.add('match found');
      // this method sent the letter to be located in firebase games collection
      sentRequest(capitalizedValue);
      // when receiving values, the will be stored in the query array
      // query array will be filtered to matching search key and results will be stored in the _display results
      // _display results will be then displayed to the screen.
    } else {
      if (mounted)
        setState(() {
          // print('the full search string is $capitalizedValue');
          _queryDisplay = [];
          _queryResults.forEach((element) {
            if ((element['team1']
                    .toString()
                    .toLowerCase()
                    .startsWith(capitalizedValue.toLowerCase())) ||
                (element['team2']
                    .toString()
                    .toLowerCase()
                    .startsWith(capitalizedValue.toLowerCase()))) {
              _queryDisplay.add(element);
              // print(element);
            }
          });
          // check if games are there
          // if (_queryDisplay.length > 0) {
          //   // if arrays are not empty then display the results
          //   // isNoInternetNetworkSearch = false;
          //   // isNoInternetNetworkOrOtherErrorSearch =   false;
          // }
        });
    }
    // print(_queryDisplay.length);
  }

  sentRequest(String request) async {
    var _thisData = Firestore.instance;
    // This query snapshot load all games available in the system
    QuerySnapshot qn = await _thisData
        .collection('Games')
        .where('searchKey', arrayContains: request)
        .getDocuments();

    if (mounted)
      setState(() {
        // add all results to the first array
        for (var j = 0; j < qn.documents.length; j++) {
          // we add all fetched values to the query results array
          _queryResults.add(qn.documents[j]);
          _queryDisplay.add(qn.documents[j]);
        }
      });
    // return qn.documents;
  }

  // sesssion management
  reLoginUser() async {
    var session = FlutterSession();
    // await session.set("email", null);
    String userID = await session.get("sB1");
    String userID1 = await session.get("sB2");
    String customID = await session.get("sB3");
    String customID1 = await session.get("sB4");
    // LocalStorage storage = new LocalStorage('SKIIYA_BET');
    // print(Selection.user.uid);
    // if (email.compareTo('null') != 0) {
    //   if (id1.compareTo('null') != 0) {
    //     if (id2.compareTo('null') != 0) {
    // print('data logins is different from null');
    // print('Phone: $userID$userID1 and Passcode: $customID$customID1');
    // RELOGGIN THE USER IF NO USER IS FOUND
    if (Selection.user == null) {
      if (userID == null ||
          userID1 == null ||
          customID == null ||
          customID1 == null) {
        // print('values are null, No relogin will be made');
      } else {
        // print('login process started');
        doSessionUserLogin((userID + userID1), (customID + customID1));
      }
    }
    //  else {
    //   print('User logged in already');
    // }
    //     }
    //   }
    //   // else {
    //   //   print('password is empty $password');
    //   // }
    // }
  }

  // static setSessionLogin(String telephone, String pass) async {
  //   // Encrypting the email before saving it to user Device
  //   String tel = Encryption.encryptAESCryptoJS(telephone, 'SKIIYA_Telephone');
  //   // String customEmail = email;
  //   // Encrypting the password before saving it to user device
  //   String customID = Encryption.encryptAESCryptoJS(pass, tel);
  //   // print(customEmail);
  //   // print(customID);
  //   // EMAIL
  //   int partTelephone = tel.length / 2 as int;
  //   String partTelephone1 = customID.substring(0, (partTelephone));
  //   String partTelephone2 =
  //       customID.substring(partTelephone, (customID.length));
  //   // PASSCODE
  //   int partPass = customID.length / 2 as int;
  //   String partPass1 = customID.substring(0, (partPass));
  //   String partPass2 = customID.substring(partPass, (customID.length));
  //   // using session to store user login details
  //   var session = FlutterSession();
  //   await session.set("userID", partTelephone1.toString());
  //   await session.set("userID1", partTelephone2.toString());
  //   await session.set("customID", partPass1.toString());
  //   await session.set("customID1", partPass2.toString());
  // }

  doSessionUserLogin(String telephone, String passCode) async {
    // String code = '243';
    checkInternet();
    String congoCode = '243';
    // print('The telephone is: $telephone');
    // print('The passcode is: $passCode');
    String phone =
        Encryption.decryptAESCryptoJS(telephone, 'SKIIYA001_Telephone');
    String email = congoCode + phone + '@gmail.com';
    String pass = Encryption.decryptAESCryptoJS(passCode, phone);
    // print('login has been reached and phone is $phone');
    // print('login has been reached and email is $email');
    // print('login has been reached and code is $code');
    // String email =
    //     Encryption.decryptAESCryptoJS(generatedEmail, generatedEmail);
    // String email = generatedEmail;
    await _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      Selection.user = result.user;
      // store credentials to session
      // setSessionLogin(phone.toString(), passCode.toString());
      // save the current user into the local storage for upcoming connection
      // get the right user balance and the right user phone number
      Firestore.instance
          .collection('UserInfo')
          .document(result.user.uid)
          .get()
          .then((_result) {
        // GET THE BLOCKING STATUS
        // bool isBlocked = false;
        if (_result['isBlocked'] == null) {
          // create the column if not there already
          Firestore.instance
              .collection('UserInfo')
              .document(result.user.uid)
              .updateData({'isBlocked': false});
          // The column has been created
          // print('This blocked status is now created');
        }
        if (_result['isBlocked'] == true) {
          // logout the user if he is being blocked in the system
          Login.doLogout();
          // print('The user has been blocked');
        } else {
          Firestore.instance
              .collection('UserBalance')
              .document(result.user.uid)
              .get()
              .then((_result) {
            if (mounted)
              setState(() {
                // String id = _result.documentID.toString();
                // print('the ID is $id');
                Selection.userTelephone = '0' + phone;
                Selection.userBalance = _result['balance'];
                // successMessage(context, 'Login Success!');
                // hide all messages error based
                isNoInternetNetwork = false;
                // isNoInternetNetworkOrOtherError = false;
              });
          }).catchError((e) {
            // print('error: $e');
          });
        }
      });
    }).catchError((e) {
      if (mounted)
        setState(() {
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            // display internet connection problems
            isNoInternetNetwork = true;
          } else {
            // show other error messages
            isNoInternetNetwork = false;
          }
        });
    });
  }

  Widget accountMenu() {
    return Expanded(
      child: Container(
        padding: new EdgeInsets.all(10.0),
        margin: new EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 1.0),
            bottom: BorderSide(color: Colors.grey, width: 1.0),
            left: BorderSide(color: Colors.grey, width: 1.0),
            right: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 0.0),
          children: [
            if (Selection.user != null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        Window.showWindow = 12;
                        // print('Showing history panel');
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => SkiiyaBet()));
                      });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' > Historique',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 22.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            if (Selection.user != null) SizedBox(height: 2.0),
            if (Selection.user != null)
              Divider(color: Colors.grey, thickness: 1.0),
            if (Selection.user != null) SizedBox(height: 2.0),

            if (Selection.user != null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        Window.showWindow = 10;
                        // print('Showing transaction panel');
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => SkiiyaBet()));
                      });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' > Transactions',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 22.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            if (Selection.user != null) SizedBox(height: 2.0),
            if (Selection.user != null)
              Divider(color: Colors.grey, thickness: 1.0),
            if (Selection.user != null) SizedBox(height: 2.0),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if (mounted)
                    setState(() {
                      Window.showWindow = 13;
                      // print('Showing transaction panel');
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => SkiiyaBet()));
                    });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' > Nos Contacts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 22.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Divider(color: Colors.grey, thickness: 1.0),
            SizedBox(height: 2.0),
            if (Selection.user != null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        Window.showWindow = 18;
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => SkiiyaBet()));
                      });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' > Modifiez Mot de Passe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 22.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            if (Selection.user != null) SizedBox(height: 2.0),
            if (Selection.user != null)
              Divider(color: Colors.grey, thickness: 1.0),
            if (Selection.user != null) SizedBox(height: 5.0),
            if (Selection.user == null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        Window.showWindow = 14;
                        // print('Showing transaction panel');
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => SkiiyaBet()));
                      });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' > Connexion / Inscription',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 22.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            // if (Selection.user != null) SizedBox(height: 2.0),
            if (Selection.user != null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        // log out the current user from the system
                        Login.doLogout();
                        // reload the main application frame
                        Window.showWindow = 0;
                        // Window.showWindow = 16;
                        // Window.showWindow = 0;
                        // using session to store user login details
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => SkiiyaBet()));
                        // print('log out');
                        // log out the current user from the system
                        // Login.doLogout();
                        // reload the main application frame
                      });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' > Déconnexion',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.power_settings_new,
                        size: 25.0,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            // SizedBox(height: 2.0),
            if (Selection.user == null) SizedBox(height: 10.0),
            if (Selection.user == null)
              Divider(color: Colors.grey, thickness: 1.0),
            if (Selection.user != null)
              Divider(color: Colors.grey, thickness: 1.0),
            // Divider(color: Colors.grey, thickness: 1.0),
            // SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }

  clearGamesSelected() {
    // clear all games logic goes here and reset every thing
    if (mounted)
      setState(() {
        var resetToDefault = [];
        // set all bet options to false
        for (int i = 0; i < Selection.maxLength; i++) {
          resetToDefault.add(false);
        }
        for (var j = 0; j < BetSlipData.gameIds.length; j++) {
          // get the position of the id in the main array
          int start = Selection.gameOddsArray.indexOf(BetSlipData.gameIds[j]);
          Selection.gameOddsArray.replaceRange(
              (start + 1), (start + (Selection.maxLength + 1)), resetToDefault);
        }
        // clear all betslip arrays so that new values can be added
        BetSlipData.team1s.clear(); // clear all team1
        BetSlipData.team2s.clear(); // clear all Team 2
        // clear all oddTypes
        // BetSlipData.oddTypes
        //     .clear();
        // clear all choices
        BetSlipData.gameChoices.clear();
        BetSlipData.rates.clear(); // clear all rates
        BetSlipData.gameIds.clear(); // clear all id
        loadBetslipMatches();
        // set the default price to 100 Fc
        Price.stake = 0.0;
      });
  }

  removeSingleMatch(String id) {
    // hide the show error panel on The BETSLIP panel
    showBetslipMessagePanel = false;
    // remove match from betslip process
    var resetToDefault = [];
    for (int i = 0; i < Selection.maxLength; i++) {
      resetToDefault.add(false);
    }
    // get the position of the id in the main array
    int start = Selection.gameOddsArray.indexOf(id);
    Selection.gameOddsArray.replaceRange(
        (start + 1), (start + (Selection.maxLength + 1)), resetToDefault);
    int index = BetSlipData.gameIds.indexOf(id);
    // clear index betslip arrays so that new values can be added
    BetSlipData.team1s.removeAt(index); // clear index team1
    BetSlipData.team2s.removeAt(index); // clear index Team 2
    // clear index oddTypes
    // BetSlipData.oddTypes.removeAt(index);
    // clear index choices
    BetSlipData.gameChoices.removeAt(index);
    BetSlipData.rates.removeAt(index); // clear index rates
    BetSlipData.gameIds.removeAt(index); // clear index id

    loadBetslipMatches();
  }

  // keep on loading user blance details every 30s
  loopUserDetails() {
    // keep loading user balance every t seconds
    Timer.periodic(new Duration(seconds: 30), (timer) {
      // load details only if user has logged in
      if (Selection.user != null) {
        Firestore.instance
            .collection('UserBalance')
            .document(Selection.user.uid)
            .get()
            .then((_result) {
          // if the login is successful then go ack to home Page
          if (mounted)
            setState(() {
              Selection.userBalance =
                  double.parse(_result['balance'].toString());
            });
        }).catchError((e) {
          print('e: $e');
        });
      }
    });
  }

  removedTheOldMatch() {
    // LOOP THROUGH THE DATA ARRAY EVERY 1 SECOND TO REMOVE OLD MATCHES ONE BY ONE
    Timer.periodic(new Duration(seconds: 30), (timer) {
      // LET'S DO SOME CALCULATION
      // print(data.length);
      // loop through all displayed games on the screen to check if they are still valid
      for (int j = 0; j < data.length; j++) {
        // This is the timestamp for every single game
        Timestamp realGameTime = Timestamp.fromDate(new DateTime(
          int.parse(data[j]['date']['4']),
          int.parse(data[j]['date']['3']),
          int.parse(data[j]['date']['2']),
          int.parse(data[j]['time']['1']),
          int.parse(data[j]['time']['2']),
        ));
        //To TimeStamp
        // We get the user current date and time
        Timestamp currentUserTime = Timestamp.fromDate(new DateTime.now());
        // Let's calcualate the difference of Seconds
        int diff = realGameTime.seconds - currentUserTime.seconds;
        // print('This match DIFF is: $diff secs.');
        if (mounted)
          setState(() {
            // REMOVE THE GAME IF IT REMAINS ONLY TWO MINUTES AND HALF OR LESS
            if (diff <= 150 || diff < 0) {
              // check if the game has been selected before updating
              if (BetSlipData.gameIds.contains(data[j].documentID)) {
                // delete the game from selected games array
                // TO BE UNCOMMENTED
                // removeSingleMatch(data[j].documentID);
                // print('Removing the selected match');
              }
              // print('Removing a current match from the list');
              // if not remove it from the list
              // Remove the game in the Game Array
              // TO BE UNCOMMENTED
              // data.removeAt(j);
            }
            // else {
            //   // IF THE MATCH IS STILL VALID
            // print('This match will remain actif=> DIFF is: $diff secs.');
            // }
            if (data.length <= 20) {
              // load more games if available remains only 20 or less
              // THIS WILL LOAD MORE GAMES
              // TO BE UNCOMMENTED
              // loadingGames(fieldLoadMore);
            }
          });
        // THIS CONDITION LOADS MORE GAMES IF REMAINING ARE LESS THAN 10
      }
    });
  }
} // 6272
