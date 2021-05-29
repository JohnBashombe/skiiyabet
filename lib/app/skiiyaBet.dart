import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:skiiyabet/account/login.dart';
import 'package:skiiyabet/app/entities/oddSelection.dart';
import 'package:skiiyabet/components/bonus.dart';
import 'package:skiiyabet/encryption/encryption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skiiyabet/Responsive/responsive_widget.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:skiiyabet/mywindow.dart';
import 'package:skiiyabet/methods/methods.dart';
import 'package:skiiyabet/account/forgot.dart';
import 'package:skiiyabet/account/resetUpdate.dart';
import 'package:skiiyabet/account/update.dart';
import 'package:skiiyabet/help/help.dart';
import 'package:skiiyabet/windows/bet/bets.dart';
import 'package:skiiyabet/windows/bet/history.dart';
import 'package:skiiyabet/windows/transaction/deposit.dart';
import 'package:skiiyabet/windows/support/support.dart';
import 'package:skiiyabet/windows/transaction/transaction.dart';
import 'package:skiiyabet/windows/transaction/withdraw.dart';
import 'package:skiiyabet/app/entities/match.dart';
import 'package:http/http.dart' as http;
import 'entities/fetching.dart';

// THE SELECTED INDEX
int _selectedIndex = 0;
// display the betslip error message
int displayInputErrorMessage = -1;
// variable from search panel
// store loaded results
var _queryResults = [];
// store filtered results
var _queryDisplay = [];
// check weither input is empty or not to display no data found
bool _isQueryEmpty = true;
// FIREBASE AUTHENTICATION INITIALIZATION
FirebaseAuth _auth = FirebaseAuth.instance;
// FTECH MATCH INSTAMCE
FetchMatch _fetchMatch = new FetchMatch();

// Store all fetched matches and ready-to-use
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
// IT STORE THE ODDS OF THE CLICKED GAME THAT WE NEDD FOR MORE PROBABILITIES
var moreLoadedMatchOdds;

// THIS CHECK WEITHER WE HAVE INTERNET NETWORK OR NOT
bool isNoInternetNetwork = false;
// bool isNoInternetNetworkOrOtherError = false;

// GET THE LEAGUE INDEX THAT WILL BE USED TO FETCH THE RIGHT COUNTRY
int leagueIndex;

// THIS WILL SHOW A LOADING BUTTON
bool _buyingATicketLoader = false;

// SCROOL CONTROLLER
ScrollController _scrollController;

class SkiiyaBet extends StatefulWidget {
  @override
  _SkiiyaBetState createState() => _SkiiyaBetState();
}

class _SkiiyaBetState extends State<SkiiyaBet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      // resizeToAvoidBottomPadding: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              elevation: 0,
              excludeHeaderSemantics: true,
              automaticallyImplyLeading: false,
              title: _appTitle(context),
              actions: [
                Container(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: new EdgeInsets.only(right: 10.0),
                        width:
                            (MediaQuery.of(context).size.width - 60.0) * 0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // display this phone number and amount if the user has logged in
                            (Selection.user != null)
                                ? _displayUserData(context)
                                // APP BAR DISPLAY BUTTON
                                : _displayLoginButton(),

                            SizedBox(width: 5.0),
                            // display the counter in the app bar with A CLICKING ACTION
                            // DISPLAY THE MATCHES COUNTER ON A BETSLIP
                            counterWidget(context),
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
              // IT ENABLES US TO CLOSE THE INPUT WIDGET ON BODY CLICKED
              FocusScope.of(context).requestFocus(new FocusNode());
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
                        color: Colors.white,
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
                        color: Colors.white,
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
                                      size: 18.0,
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
              // backgroundColor: Colors.white70,
              height: 50.0,
              color: Colors.lightGreen[400],
              buttonBackgroundColor: Colors.white70,
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
                Icon(FontAwesomeIcons.home,
                    size: Selection.bottomCurrentTab == 0 ? 30.0 : 20.0,
                    color: Selection.bottomCurrentTab == 0
                        ? Colors.black
                        : Colors.white),
                Icon(FontAwesomeIcons.search,
                    size: Selection.bottomCurrentTab == 1 ? 30.0 : 20.0,
                    color: Selection.bottomCurrentTab == 1
                        ? Colors.black
                        : Colors.white),
                Icon(FontAwesomeIcons.moneyCheck,
                    size: Selection.bottomCurrentTab == 2 ? 30.0 : 20.0,
                    color: Selection.bottomCurrentTab == 2
                        ? Colors.black
                        : Colors.white),
                Icon(FontAwesomeIcons.moneyBill,
                    size: Selection.bottomCurrentTab == 3 ? 30.0 : 20.0,
                    color: Selection.bottomCurrentTab == 3
                        ? Colors.black
                        : Colors.white),
                Icon(FontAwesomeIcons.listAlt,
                    size: Selection.bottomCurrentTab == 4 ? 30.0 : 20.0,
                    color: Selection.bottomCurrentTab == 4
                        ? Colors.black
                        : Colors.white),
                Icon(FontAwesomeIcons.user,
                    size: Selection.bottomCurrentTab == 5 ? 30.0 : 20.0,
                    color: Selection.bottomCurrentTab == 5
                        ? Colors.black
                        : Colors.white),
              ],
            )
          : null,
    );
  }

  Column _displayUserData(BuildContext context) {
    return Column(
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
          Price.getWinningValues(Selection.userBalance) + ' Fc',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 13.0 : 14.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  List<IconData> _sideMenuList = [
    FontAwesomeIcons.search,
    FontAwesomeIcons.home,
    FontAwesomeIcons.moneyCheck,
    FontAwesomeIcons.moneyBill,
    FontAwesomeIcons.exchangeAlt,
    FontAwesomeIcons.listAlt,
    FontAwesomeIcons.history,
    FontAwesomeIcons.phoneAlt,
  ];

  List<String> _sideMenuToolTip = [
    'Recherchez Ici',
    'Accueil',
    // 'Matches Populaires',
    'Dépôt d\'argent',
    'Retrait d\'argent',
    'Mes Transactions',
    'Mes Paris',
    'Mon Historique',
    'Nos Contacts',
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
                // _indexChampionSelection = -1;
                Window.selectedMenu = index;
                // print(Window.selectedMenu);
                if (Window.selectedMenu == 0) {
                  // matchMoreOdds = new DocumentSnapshot();
                  Window.showWindow = 4; // call search panel
                } else if (Window.selectedMenu == 1) {
                  Window.showWindow = 0; // HOME PAGE
                  Window.showJackpotIndex = 0; // SHOW TOP MENU AT INDEX 0
                  // call home panel
                  // set all loading to all popular matches to be found
                  // clear list games before adding more
                  // data.clear();
                  // set the field type to filter
                  // fieldLoadMore = 0;
                  // load all games bases on their timestamp
                  // filter games by most popular ones
                  // loadingGames(fieldLoadMore);
                  // loadingGames(1);
                } else if (Window.selectedMenu == 2) {
                  Window.showWindow = 8; // call deposit panel
                } else if (Window.selectedMenu == 3) {
                  Window.showWindow = 9; // call withdraw panel
                } else if (Window.selectedMenu == 4) {
                  Window.showWindow = 10; // call transactions panel
                } else if (Window.selectedMenu == 5) {
                  Window.showWindow = 11; // call My Active Bets panel
                } else if (Window.selectedMenu == 6) {
                  Window.showWindow = 12; // call Bets History panel
                } else if (Window.selectedMenu == 7) {
                  Window.showWindow = 13; // call contact Us panel
                }
              });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: Window.selectedMenu == index
                    ? BorderSide(color: Colors.lightGreen[400], width: 5.0)
                    : BorderSide.none,
              ),
            ),
            child: IconButton(
              tooltip: _sideMenuToolTip[index],
              icon: Icon(_sideMenuList[index],
                  color: Window.selectedMenu == index
                      ? Colors.lightGreen[400]
                      : Colors.grey,
                  size: Window.selectedMenu == index ? 22.0 : 20.0),
              onPressed: null,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(
            color: Colors.grey,
            thickness: 0.3,
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
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          ),
          child: Column(
            children: [
              if (!ResponsiveWidget.isSmallScreen(context))
                Container(
                  // color: Colors.white,
                  height: ResponsiveWidget.isSmallScreen(context) ? 50.0 : 59.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:
                            (MediaQuery.of(context).size.width - 60.0) * 0.70,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: ResponsiveWidget.isSmallScreen(context)
                                  ? EdgeInsets.symmetric(horizontal: 10.0)
                                  : EdgeInsets.symmetric(horizontal: 5.0),
                              child: _appTitle(context),
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
                        width:
                            (MediaQuery.of(context).size.width - 60.0) * 0.30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // scrollDirection: Axis.horizontal,
                          children: [
                            // isUserLoggedIn
                            (Selection.user != null)
                                ? _displayUserData(context)
                                : _displayLoginButton(),
                            // if (ResponsiveWidget.isMediumScreen(context) ||
                            //     ResponsiveWidget.isSmallScreen(context))
                            SizedBox(width: 5.0),
                            // display the counter in the app bar with NO ACTION
                            // DISPLAY THE MATCH COUNTER WIDGET HERE
                            counterWidget(context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              if (ResponsiveWidget.isSmallScreen(context))
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: 40.2, // SO THAT WE WILL HAVE A PERFECT TOUCHDOWN
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
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

  Row _appTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          'Skiiya'.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 17.0 : 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 3.0),
        Text(
          'Bet'.toUpperCase(),
          style: TextStyle(
              color: Colors.lightGreen,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 17.0 : 15.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  MouseRegion _displayLoginButton() {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: 'Connectez-vous ici svp!',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 35.0,
                  // padding: new EdgeInsets.symmetric(
                  //     horizontal: 5.0),
                  child: RawMaterialButton(
                    fillColor: Colors.lightGreen[400],
                    // focusColor: Colors.lightGreen[100],
                    padding: new EdgeInsets.symmetric(horizontal: 10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.signInAlt,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Mon Compte',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    // icon: FontAwesomeIcons.signInAlt,
                    // icon: Icons.login,
                    // buttonColor: Colors.lightGreen[400],
                    // color: Colors.white,
                    // title: ' Mon Compte',
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
          ),
        ));
  }

  GestureDetector counterWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted)
          setState(() {
            if (ResponsiveWidget.isMediumScreen(context) ||
                ResponsiveWidget.isSmallScreen(context)) {
              Window.showWindow = 20;
              // print('small screen');
              // print('display custom betslip panel');
            }
            // else {
            //   print('large screen and no special betslip panel to display');
            // }
          });
      },
      child: Tooltip(
        message: 'Nombre de matches sur le billet de pari',
        // decoration: BoxDecoration(color: Colors.grey.shade300),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: [
              Container(
                height: 40.0,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.grey, width: 1.5))),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 45.0,
                    width: 35.0,
                    child: Icon(Icons.sports_soccer_outlined,
                        size: 25.0, color: Colors.black),
                  ),
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: Container(
                      width: 20.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange[600],
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Text(
                          // COUNT THE NUMBER OF MATCHES REMAINING IN BETSLIP
                          countTicketLegs().toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
          padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          // margin: new EdgeInsets.symmetric(
          //     // SHOW NO MARGIN ON BIG SCREEN
          //     vertical: ResponsiveWidget.isSmallScreen(context) ? 5.0 : 0.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(18.0),
            border: Border(
                // SHOW ONLY ON SMALL SCREENS
                // left: ResponsiveWidget.isSmallScreen(context)
                //     ? (Window.showJackpotIndex == index
                //         ? BorderSide(
                //             color: Colors.lightGreen[400],
                //             width: 3.0,
                //           )
                //         : BorderSide.none)
                //     : BorderSide.none,
                // DO NOT DISPLAY ON SMALL SCREEN
                bottom: Window.showJackpotIndex == index
                    ? BorderSide(
                        color: Colors.lightGreen[400],
                        width: 3.0,
                      )
                    : BorderSide.none),
          ),
          child: Text(
            _topMenu[index],
            style: TextStyle(
              color:
                  Window.showJackpotIndex == index ? Colors.black : Colors.grey,
              fontSize: Window.showJackpotIndex == index ? 16.0 : 13.0,
              fontWeight: Window.showJackpotIndex == index
                  ? FontWeight.bold
                  : FontWeight.w300,
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
              ? EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 10.0)
              : EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
          decoration: BoxDecoration(color: Colors.white),
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
                          // HEIGHT OF LEAGUES ON MOBILE
                          height: 40.0,
                          // margin: new EdgeInsets.only(
                          //     left: 15.0, bottom: 15.0, top: 5.0),
                          margin: EdgeInsets.only(
                              left: 10.0, bottom: 15.0, top: 5.0),
                          // padding: new EdgeInsets.symmetric(horizontal: 8.0),
                          child: _leagues.length > 0
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _leagues.length,
                                  itemBuilder: (context, index) {
                                    return _topChampionshipMobile(
                                        _leagues[index]);
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
                        padding: EdgeInsets.all(0.0),
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(8.0),
                        ),
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

  _topChampionshipMobile(var _thisLeague) {
    // WE GET THE CURRENT CHAMPIONSHIP NAME
    String _league = _thisLeague['name'];
    int _leagueID = _thisLeague['id'];
    // WE GET THE CURRENT COUNTRY ID
    int _countryId = _thisLeague['country_id'];

    // THIS WILL STORE THE CURRENT COUNTRY NAME
    // RETURN THE COUNTRY BASED ON THE LEAGUE
    var _country = _league_return_country(_countryId);

    // THIS IS A CLICKABLE WIDGET HERE
    return GestureDetector(
      onTap: () {
        // we will now check if a championship has been adde so it won't be added again
        if (mounted)
          setState(() {
            setState(() {
              // WE INITIALIZE AND SET THE NEW VALUES AND RESPONSE
              _league_action_click(_leagueID);
            });
          });
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 2.0),
                  bottom: BorderSide(color: Colors.grey.shade300, width: 2.0),
                  left: BorderSide(color: Colors.grey.shade300, width: 2.0),
                  right: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _league.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                    SizedBox(width: 4.0),
                    // Icon(Icons.more_horiz, color: Colors.lightGreen, size: 12.0),
                    Text(
                      _country.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                    // if (selectedMobileTopItem
                    //         .toString()
                    //         .compareTo('championship') ==
                    //     0)
                    //   Row(
                    //     children: [
                    //       SizedBox(
                    //         width: 3.0,
                    //       ),
                    //       Center(
                    //         child: Icon(
                    //           Icons.check,
                    //           color: Colors.lightBlue[400],
                    //           size: 15.0,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
                // IntrinsicHeight(
                //     child: new Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     Text('Foo'),
                //     VerticalDivider(),
                //     Text('Bar'),
                //     VerticalDivider(),
                //     Text('Baz'),
                //   ],
                // )),
                // SizedBox(width: 5.0),
                VerticalDivider(),
                // SizedBox(width: 5.0),
                // Divider(),
                // INITIAL PHASE
                // if (_currentPick == 0)
                if (_currentLeagueID != _leagueID)
                  Icon(
                    // SHOW A DIFFERENT ICON IF A CHAMPIONSHIP IS SELECTED
                    Icons.arrow_forward_ios,
                    // SHOW A DIFFERENT COLOR WHEN A CHAMPIONSHIP IS SELECTED
                    color: Colors.grey,
                    size: 20.0,
                  ),
                // CHECK THE SELECTION CHOICE
                if (_currentPick == 1)
                  // IF REQUEST IS LOADING
                  // WE WANT TO LOAD ONLY A SPECIFIC LEAGUE
                  if (_currentLeagueID == _leagueID)
                    SpinKitCircle(color: Colors.lightBlue, size: 18.0),

                // IF WE HAVE GAMES HERE
                // WE WANT TO LOAD ONLY A SPECIFIC LEAGUE
                // SHOW A SUCCESS ICON
                if (_currentPick == 2)
                  if (_currentLeagueID == _leagueID)
                    Icon(
                      // SHOW A DIFFERENT ICON IF A CHAMPIONSHIP IS SELECTED
                      Icons.verified,
                      // SHOW A DIFFERENT COLOR WHEN A CHAMPIONSHIP IS SELECTED
                      color: Colors.green,
                      size: 18.0,
                    ),

                // WE WANT TO LOAD ONLY A SPECIFIC LEAGUE
                // IF WE HAVE NO GAMES
                if (_currentPick == 3)
                  if (_currentLeagueID == _leagueID)
                    Icon(
                      // SHOW A DIFFERENT ICON IF A CHAMPIONSHIP IS SELECTED
                      FontAwesomeIcons.timesCircle,
                      // SHOW A DIFFERENT COLOR WHEN A CHAMPIONSHIP IS SELECTED
                      color: Colors.red,
                      size: 18.0,
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
    'Tous les Matches ',
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
              // IF NOT ZERO MEANS WE HAVE A CERTAIN LEAGUE DATA TO HOME THEN LOAD NORMAL MATCHES
              if (_currentPick == 2) {
                // A CHAMPIONSHIP HAS BEEN LOADED AND DISPLAYED
                // SO LOAD NEW DATA MATCHES HERE
                loadMatchMethod();
                // print('A league data is display');
                // LOAD MAIN MATCHES HERE
              }
              // else {
              //   // CHAMPIONSHIPS LOADED BUT EITHER EMPTY OR STILL LOADING
              //   print('CHAMPIONSHIPS LOADED BUT EITHER EMPTY OR STILL LOADING');
              // }
              // WE CHANGE THE WINDOWS VIEW IF NOT AT HOME PAGE
              switchToMoreMatchOddsWindow = false;
              // SET THE SELECTED CHAMPIONSHIPS TO NONE
              _currentPick = 0;
              // SET THE CURRENT ID TO NULL TOO
              _currentLeagueID = -1;
            });
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
                      : Colors.black87,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.underline,
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
        color: Colors.white,
        // border: Border(
        //   top: BorderSide(color: Colors.grey, width: 0.4),
        //   left: BorderSide(color: Colors.grey, width: 0.4),
        //   right: BorderSide(color: Colors.grey, width: 0.4),
        // ),
      ),
      child: Container(
        height: 25.0,
        padding: EdgeInsets.only(bottom: 10.0, right: 10.0),
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
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 13.0),
          ),
          // Icon(Icons.format_line_spacing, color: Colors.grey, size: 20.0),
        ],
      ),
    );
  }

  loadMatchMethod() {
    // HOLD MATCHES BEFORE UPDATING THE MAIN ARRAY
    var _newMatches = [];
    // WE FIRST LOAD ALL THE GAMES HERE
    _fetchMatch.fetchMatchDetails(Selection.loadLimit).then((_getData) {
      // print(value);
      // WE SET THE VALUE TO THE MATCHES ARRAY
      // LOOPS
      if (_matches.length > 0) {
        for (int i = 0; i < _getData.length; i++) {
          // VALIDATE A NEW MATCH
          bool _isNotPresent = true;
          // MATCHES LOOPING
          for (int j = 0; j < _matches.length; j++) {
            // WE COMPARE LOADED MATCHES WITH CURRENT MATCHES
            if (_getData[i].id == _matches[j].id) {
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
      } else {
        // IF WE HAVE NO GAMES THEN ADD ALL GAMES AUTOMATICALLY HERE
        _newMatches = _getData;
      }
      // LET US INSERT DATA INTO THE SELECTION ARRAY
      for (int i = 0; i < _newMatches.length; i++) {
        // print(_matches[i].id);
        // ADD THE MATCHES TO THE MAIN ARRAY TOO
        _matches.add(_newMatches[i]);
        // WE ADD ONLY THE ID OF THE GAME TO THE ARRAY COLLECTION
        oddsGameArray.add(OddsArray.fromDatabase(_newMatches[i]));
      }
    });
  }

  // RETURN THE NUMBER OF SELCTED MATCHES ON THE BETSLIP
  static int countTicketLegs() {
    int _thisCounter = 0;
    // WE LOOP THROUGH THE GAMES ODDS ARRAY TO GET SELECTED GAMES
    for (int _i = 0; _i < oddsGameArray.length; _i++) {
      // CHECK GAME AFTER GAME
      if (oddsGameArray[_i].oddID != null &&
          oddsGameArray[_i].oddName != null &&
          oddsGameArray[_i].oddIndex != null &&
          oddsGameArray[_i].oddLabel != null &&
          oddsGameArray[_i].oddValue != null) {
        // INSCREASE THE COUNTER + 1 OR REDUCE IT ACCORDINGLY
        _thisCounter++;
      }
    }
    return _thisCounter;
  }

  @override
  void initState() {
    // THIS LOADS ALL MACTHES
    loadMatchMethod();
    // LET US LOAD LEAGUES HERE
    _fetchMatch.fetchLeagues().then((value) {
      if (mounted)
        setState(() {
          // WE SET THE VALUE TO THE MATCHES ARRAY
          // print(value['league']['data'][0]);
          if (value.length > 0) {
            _leagues = value[0]['data'];
            // print(value[0]['data'][0]);
          }
        });
    });

    // LET US LOAD LEAGUES HERE
    _fetchMatch.fetchCountries().then((value) {
      // WE SET THE VALUE TO THE MATCHES ARRAY
      if (mounted)
        setState(() {
          _countries = value;
        });
    });
    // this match check weither matches are still available or have expired
    // checkMatchValidity();
    // New methods loading...
    // removedTheOldMatch();
    // placed here because this widget execute only once
    // this method helps us to detect if a certain user was already logged in
    if (mounted)
      setState(() {
        // reload from existing session and set new values
        // logged the user in if existed before
        reLoginUser(); // uncomment after coding
        // keep loading user balance
        loopUserBalanceRecord();
      });
    // this loadingGames method load only once at first lunch
    // loadingGames(fieldLoadMore);
    // loadSideData();
    super.initState();
    // _data = Selection.getPosts(0);
    // print('Chargement code executed');
    // _itemCount = Selection.getCountData();
    // _countCountries = Selection.getCountCountryData();
    //listen to body scrolling and execute itself
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            // add and load 15 more games on every bottom list reach
            // load more data + condition to filter games already loaded
            Selection.loadLimit = Selection.loadLimit + 15;
            // if (mounted)
            loadMatchMethod();
          });
        }
      });
  }

  Widget games() {
    // SHOW THE GAME HOME PANEL INITIALLY
    if (!switchToMoreMatchOddsWindow) {
      return homePage();
    } else {
      // THEN SHOW THE GAME DETAILS ON GAME CLICK
      return singleGame();
    }
  }

  Expanded homePage() {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),
          left: BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      margin: EdgeInsets.only(left: 10.0, top: 0.0),
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
                                  // loadingGames(fieldLoadMore);
                                  // load championship content
                                  // loadSideData();
                                  // hide the error message
                                  isNoInternetNetwork = false;
                                  // isNoInternetNetworkOrOtherError = false;
                                  // load user details too
                                  // print('User phone: ${Selection.userTelephone}');
                                  // if (Selection.userTelephone.compareTo('') !=
                                  //     0) {
                                  //   // if the phone is not empty, then reloggin the user
                                  //   // reLoginUser();
                                  // }
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
  }

  String _getCountry(int _leagueIndex) {
    String country = '...';
    // LET US GET THE CORRECT COUNTRY HERE
    // ONLY IF WE HAVE DATA IN THE ARRAY
    if (_countries.length > 0)
      for (int j = 0; j < _countries.length; j++) {
        if (_leagues[_leagueIndex]['country_id'] == _countries[j]['id']) {
          country = _countries[j]['name'];
          // print('the country name is ${_countries[j]['name']}');
          // WE BREAK THE LOOP FOR BETTER PROCESSING
          break;
        }
      }
    return country;
  }

  String _getLeague(var _thisMatch) {
    String championship = '...';
// ONLY IF WE HAVE DATA IN THE ARRAY
    if (_leagues.length > 0)
      for (int j = 0; j < _leagues.length; j++) {
        if (_leagues[j]['id'] == _thisMatch.league_id) {
          championship = _leagues[j]['name'];
          // getLeagueIndex(j);
          leagueIndex = j;
          // print('the ligue is ${_leagues[_lpLg]['name']}');
          // WE BREAK THE LOOP FOR BETTER PROCESSING
          break;
        }
      }
    return championship;
  }

  Widget singleMatch(var _thisMatch, int index) {
    // we assign the context at position Index to the document snapshot document
    // DocumentSnapshot match = _thisData[index];
    //snapshot.data[index]
    // match = data[index];
    // print(match);
    var id = _thisMatch.id;
    // var team1 = match['team1'];
    var _localTeam = _thisMatch.localTeam['data']['name'];
    var _visitorTeam = _thisMatch.visitorTeam['data']['name'];
    // var team2 = match['team2'];
    // GET THE TIME OF THE MATCH
    var time = _thisMatch.time['starting_at']['time'];
    // GET THE DATE OF THE GAME
    var date = _thisMatch.time['starting_at']['date'];
    // var championship = match['championship'];
    // var country = match['country'];
    // // load time details
    var championship = _getLeague(_thisMatch);
    // int _leagueIndex = leagueIndex;
    // THIS IS A STORING VARIBALE IN MATCH INSTANCE
    var country = _getCountry(leagueIndex);
    // WE ADD A DASH FOR A BETTER DISPLAY OF THE COUNTRY
    var _countryDisplay = ' - ' + _getCountry(leagueIndex);
    // LET US LOAD CHAMPIONSHIPS

    // THIS STORE THE DATA FOR THREE WAY ODDS
    var _threeWayData =
        _thisMatch.threeWayOdds['bookmaker']['data'][0]['odds']['data'];

    var _dataTime = _thisMatch.time;

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
                      if (mounted)
                        setState(() {
                          // STORE THE ODDS OF THE MATCH IN THE ARRAY
                          moreLoadedMatchOdds = value;
                        });
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
                      setState(() {
                        // STORE THE ODDS OF THE MATCH IN THE ARRAY
                        moreLoadedMatchOdds = value;
                      });
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
                                _localTeam.toString() +
                                    ' - ' +
                                    _visitorTeam.toString(),
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
                          championship.toString() + _countryDisplay.toString(),
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
                  _thisMatch.threeWayOdds['bookmaker']['data'][0]['odds']
                      ['data'],
                  _thisMatch.threeWayOdds['id'], // CONTAINS THE ID OF THE ODD
                  _thisMatch
                      .threeWayOdds['name'], // CONTAINS THE NAME OF THE ODD
                  _i, // CONTAINS THE INDEX OF THE ODD
                  championship,
                  country,
                  _localTeam,
                  _visitorTeam,
                  _dataTime),
          ],
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey, thickness: 0.4),
      ],
    );
  }

  unselectOddsButton(int _gameOddIndex) {
    // THIS BUTTON UNSELECT THE CURRENT GAME INDEX AND UPDATE COLORS
    oddsGameArray[_gameOddIndex].oddID = null;
    oddsGameArray[_gameOddIndex].oddName = null;
    oddsGameArray[_gameOddIndex].oddIndex = null;
    oddsGameArray[_gameOddIndex].oddLabel = null;
    oddsGameArray[_gameOddIndex].oddValue = null;
    oddsGameArray[_gameOddIndex].total = null;
    oddsGameArray[_gameOddIndex].handicap = null;
    // CHANGE THE COLORS TO DEFAULTS COLORS
    _buttonColor = Colors.grey.shade200;
    _labelColor = Colors.black87;
  }

  selectOddsButton(
      int _gameOddIndex,
      int _oddId,
      String _oddName,
      int _oddIndex,
      String _label,
      String _value,
      String _championship,
      String _country,
      String _localTeam,
      String _visitorTeam,
      var _total,
      var _handicap,
      var _dataTime) {
    // WE SET THE VALUES OF THE GAME INTO THE ARRAY
    // WE UPDATE THE VALUES AND THE COLORS
    oddsGameArray[_gameOddIndex].oddID = _oddId;
    oddsGameArray[_gameOddIndex].oddName = _oddName;
    oddsGameArray[_gameOddIndex].oddIndex = _oddIndex;
    oddsGameArray[_gameOddIndex].oddLabel = _label;
    oddsGameArray[_gameOddIndex].oddValue = _value;
    oddsGameArray[_gameOddIndex].total = _total;
    oddsGameArray[_gameOddIndex].handicap = _handicap;
    oddsGameArray[_gameOddIndex].localTeam = _localTeam;
    oddsGameArray[_gameOddIndex].visitorTeam = _visitorTeam;
    oddsGameArray[_gameOddIndex].championship = _championship;
    oddsGameArray[_gameOddIndex].country = _country;
    oddsGameArray[_gameOddIndex].dataTime = _dataTime;
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
      int _gameIndex,
      var _match,
      int _oddId,
      String _oddName,
      int _oddIndex,
      String _championship,
      String _country,
      String _localTeam,
      String _visitorTeam,
      var _dataTime) {
    // GET THE RIGHT DATA WITH THE RIGHT INDEX
    var _threeWayData = _match[_oddIndex];
    // GET THE LENGTH OF THE THREE WAY ODDS DATA
    int _dataLength = _match.length;
    // CONTAINS THE LABEL OF THE BUTTON
    var _label = _threeWayData['label'];
    // CONTAINS THE VALUE OF THE BUTTON
    var _value = _threeWayData['value'];
    // CONTAINS THE TOTAL OF AN ODD
    var _total = _threeWayData['total'];
    // CONTAINS THE HANDICAP VALUE IF N0T NULL
    var _handicap = _threeWayData['handicap'];

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
                  selectOddsButton(
                      _gameOddIndex,
                      _oddId,
                      _oddName,
                      _oddIndex,
                      _label,
                      _value,
                      _championship,
                      _country,
                      _localTeam,
                      _visitorTeam,
                      _total,
                      _handicap,
                      _dataTime);
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

  oddDataAndOddId(var oddData, int _oddId, String _championship,
      String _country, String _localTeam, String _visitorTeam, var _dataTime) {
    // oddData = moreLoadedMatchOdds['odds'][0]
    // print(moreLoadedMatchOdds['odds'][3]['id']);
    // print(_localTeam);
    // print(_visitorTeam);
    // print(_championship);
    // print(_country);
    // print('----------------');
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
                  // LOOP THROUGH ODDS INDEX
                  for (int j = 0; j < oddArray.length; j++)
                    allOddsWidget(
                        oddArray,
                        _oddId,
                        oddData['name'],
                        j,
                        _championship,
                        _country,
                        _localTeam,
                        _visitorTeam,
                        _dataTime),
                ],
              ),
            // IF ODDS VALUES ARE GREATER THAN 3
            if (oddArray.length > 3)
              for (int j = 0; j < oddArray.length - 1; j = j + 2)
                Row(
                  children: [
                    // LOOP THROUGH ODDS INDEXES
                    allOddsWidget(
                        oddArray,
                        _oddId,
                        oddData['name'],
                        j,
                        _championship,
                        _country,
                        _localTeam,
                        _visitorTeam,
                        _dataTime),
                    allOddsWidget(
                        oddArray,
                        _oddId,
                        oddData['name'],
                        (j + 1),
                        _championship,
                        _country,
                        _localTeam,
                        _visitorTeam,
                        _dataTime),
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

  allOddsWidget(
      var data,
      int _oddId,
      String _oddName,
      int _oddIndex,
      String _championship,
      String _country,
      String _localTeam,
      String _visitorTeam,
      var _dataTime) {
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

    var _total = data[_oddIndex]['total'];

    // ONLY FOR DISPLAY
    var _thisTotalDisplay = '';
    // GET THE TOTAL ATTRIBUTE BEFORE UPDATING
    if (data[_oddIndex]['total'] != null) {
      _thisTotalDisplay = ' ' + data[_oddIndex]['total'];
    }

    var _handicap = data[_oddIndex]['handicap'];

    // ONLY FOR DISPLAY
    var _thisHandicapDisplay = '';
    // GET THE HANDICAP ATTRIBUTE BEFORE UPDATING
    if (data[_oddIndex]['handicap'] != null) {
      _thisHandicapDisplay = ' (' + data[_oddIndex]['handicap'] + ')';
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
                  selectOddsButton(
                      _gameOddIndex,
                      _oddId,
                      _oddName,
                      _oddIndex,
                      _label,
                      _value,
                      _championship,
                      _country,
                      _localTeam,
                      _visitorTeam,
                      _total,
                      _handicap,
                      _dataTime);
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
                _label.toString() +
                    // TOTAL VALUES
                    _thisTotalDisplay.toString() +
                    // HANDICAP NO NULL VALUE
                    _thisHandicapDisplay.toString(),
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

  Widget betSlip(BuildContext _context) {
    return Container(
      // padding: new EdgeInsets.only(top: 0.0),
      margin: ResponsiveWidget.isBigScreen(context)
          ? null // ADD MARGIN TO BIG SCREEN
          : EdgeInsets.only(left: 10.0), // ADD LEFT MARGIN TO TABLET AND PHONES
      // 992px - UP
      width: ResponsiveWidget.isBigScreen(context) ? 300.0 : double.infinity,
      height: ResponsiveWidget.isSmallScreen(context)
          ? MediaQuery.of(context).size.height - 176.0 // 767.98px and LOW
          : MediaQuery.of(context).size.height - 80.0, // 767.98px and UP
      // Phones
      // SO THAT THE HEIGHT WILL BE IDENTICALS
      decoration: BoxDecoration(
        color: Colors.white70,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 20.0,
            padding: EdgeInsets.only(bottom: 5.0, right: 10.0),
            // margin: EdgeInsets.only( bottom: 10.0),
            child: Text(
              'Mon billet de pari',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0),
            ),
          ),
          // SizedBox(height: 10.0),
          Expanded(
            child: Container(
              margin: ResponsiveWidget.isBigScreen(context)
                  ? EdgeInsets.only(right: 10.0) // ONLY ON BIG SCREEN
                  : null, // NULL ON SMALL SCREEN
              // padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border(
                          top: BorderSide(color: Colors.grey.shade300),
                          bottom: BorderSide(color: Colors.grey.shade300),
                          left: BorderSide(color: Colors.grey.shade300),
                          right: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Method.displayUserBonus(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.0),
                        Tooltip(
                          message:
                              'Cliquer ici pour voir tous les details sur le bonus',
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                // DISPLAY THE DIALOG BOX FOR BONUS DETAILS
                                // print('Bonus more details');
                                show_dialog_bonus();
                              },
                              child: Text(
                                'Apprendre plus...',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SHOW A MATCH TEMPLATE ON THE BETSLIP FOR A BETTER VIEW
                  Container(
                    margin: new EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        SizedBox(height: 5.0),
                        // SHOW THIS ONLY IF WE HAVE NO DATA AT ALL ON THE TICKET
                        if (countTicketLegs() == 0)
                          Divider(
                            color: Colors.grey,
                            thickness: 0.3,
                            height: 0.0,
                          ),
                      ],
                    ),
                  ),
                  // CHECK IF WE HAVE NO DATA ON THE TICKET TO DISPLAAY THIS MESSAGE
                  if (countTicketLegs() == 0)
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text(
                        'Ton billet de pari est vide'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  // DISPLAY THE DIVIDER ONLY IF WE HAVE NO SELECTION
                  if (countTicketLegs() == 0)
                    Container(
                      margin: new EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          // SizedBox(height: 8.0),
                          Divider(
                            color: Colors.grey,
                            thickness: 0.3,
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                  // DISPLAY MATCHES SELECTED RIGHT HERE
                  // if (countTicketLegs() > 0) SizedBox(height: 5.0),
                  if (countTicketLegs() > 0) loadBetslipMatches(),
                  // slipMatches(null, 1),
                  // slipMatches(null, 2),

                  Container(
                    padding: (ResponsiveWidget.isLargeScreen(context) ||
                            ResponsiveWidget.customScreen(context))
                        ? EdgeInsets.all(10.0)
                        : EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 3.0),
                        if (countTicketLegs() > 0)
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                unselect_all_at_once();
                                // hide the show error panel on the BETSLIP panel
                                // showBetslipMessagePanel = false;
                                // clear all games logic goes here
                                // clearGamesSelected();
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Tout Supprimer',
                                  style: TextStyle(
                                    color: Colors.orange[600],
                                    fontWeight: FontWeight.bold,
                                    // fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // Text('Stake:',
                        //     style: TextStyle(fontWeight: FontWeight.bold)),
                        // SizedBox(height: 5.0),
                        SizedBox(height: 5.0),
                        Text(
                          'Montant Minimum: ' +
                              Price.currency_symbol +
                              ' ' +
                              Price.minimumBetPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        // Method.showUserBettingStake(),
                        // SizedBox(height: 3.0),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 15.0),
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                    color: displayInputErrorMessage != -1
                                        ? Colors.red.shade300
                                        : Colors.grey.shade300,
                                    width: 1.0),
                                bottom: BorderSide(
                                    color: displayInputErrorMessage != -1
                                        ? Colors.red.shade300
                                        : Colors.grey.shade300,
                                    width: 1.0),
                                left: BorderSide(
                                    color: displayInputErrorMessage != -1
                                        ? Colors.red.shade300
                                        : Colors.grey.shade300,
                                    width: 1.0),
                                right: BorderSide(
                                    color: displayInputErrorMessage != -1
                                        ? Colors.red.shade300
                                        : Colors.grey.shade300,
                                    width: 1.0),
                              )),
                          child: TextFormField(
                            initialValue: Price.stake.toString(),
                            cursorColor: displayInputErrorMessage != -1
                                ? Colors.red
                                : Colors.lightBlue,
                            // cursorWidth: 3.0,
                            cursorHeight: 5.0,
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
                                  // showBetslipMessagePanel = false;
                                  if (value.isEmpty) {
                                    Price.stake = 0;
                                    // DISPLAY NONE
                                    displayInputErrorMessage = -1;
                                  } else {
                                    Price.stake = double.parse(value);
                                    if (Price.stake < Price.minimumBetPrice) {
                                      // DISPLAY MINIMUM ERROR
                                      displayInputErrorMessage = 1;
                                    } else if (Price.stake > Price.maxStake) {
                                      // DISPLAY MAXIMUM ERROR
                                      displayInputErrorMessage = 2;
                                    } else {
                                      // DISPLAY NONE
                                      displayInputErrorMessage = -1;
                                    }
                                  }
                                });
                            },
                          ),
                        ),
                        // DISPLAY THE MINIMUM STAKE ERROR
                        if (displayInputErrorMessage == 1)
                          displayInputError('Montant minimum:',
                              Price.getCommaValue(Price.minimumBetPrice)),
                        // DISPLAY THE MAXIMUM STAKE EXCEED ERROR
                        if (displayInputErrorMessage == 2)
                          displayInputError('Montant maximum:',
                              Price.getCommaValue(Price.maxStake)),
                        SizedBox(height: 15.0),
                        // Divider(color: Colors.grey, thickness: 0.4),
                        // SizedBox(height: 10.0),
                        // SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Somme de points',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                )),
                            Text(
                              Method.totalRate().toStringAsFixed(2).toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Gain Total',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                )),
                            Text(
                              // possibleWinning().toStringAsFixed(2),
                              Price.currency_symbol +
                                  ' ' +
                                  Price.getWinningValues(
                                      Method.possibleWinning()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                Method.pourcentageRate.toString() +
                                    '% Gain Bonus',
                                // Text(pourcentageRate.toString() + '% win Bonus',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                )),
                            Text(
                              Price.currency_symbol +
                                  ' ' +
                                  Price.getWinningValues(Method.bonusAmount()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Divider(color: Colors.grey, thickness: 0.4),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Paiement Total'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text(
                              Price.currency_symbol +
                                  ' ' +
                                  Price.getWinningValues(Method.totalPayout()),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Divider(color: Colors.grey, thickness: 0.3),
                        SizedBox(height: 10.0),
                        Container(
                          width: double.infinity,
                          child: _buyingATicketLoader
                              ? RawMaterialButton(
                                  mouseCursor: SystemMouseCursors.wait,
                                  padding:
                                      new EdgeInsets.symmetric(vertical: 15.0),
                                  onPressed: null,
                                  disabledElevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  fillColor: Colors.lightGreen[300],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Placement...',
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
                                        // DOING THE PROCESSES OF ADDING A TICKET IN THE DATABASE
                                        if (countTicketLegs() <= 0) {
                                          // WE CANNOT ADD AN EMPTY TICKET IN THE DATABASE
                                          // A TICKET MUST CONTAINS AT LEAST 1 GAME
                                          // SHOW THIS MESSAGE IF THE CONDITION IS NOT RESPECTED
                                          show_dialog_panel(
                                              context,
                                              'Billet de pari vide!'
                                                  .toUpperCase(),
                                              'Selectionnez au moins un match d\'abord',
                                              'assets/images/fail.png');
                                        }
                                        // check if the user provided a balance amount
                                        else if (Price.stake <
                                            Price.minimumBetPrice) {
                                          // A BET CAN ONLY BE ACCEPTED IF THE STAKE IS GREATER OR EQUAL TO
                                          // THE MINIMUM BET PRICE OF THE SYSTEM
                                          // SHOW THIS MESSAGE DOWN HERE
                                          show_dialog_panel(
                                              context,
                                              'Solde requis!'.toUpperCase(),
                                              'Le montant minimum est de ${Price.currency_symbol} ${Price.minimumBetPrice}',
                                              'assets/images/fail.png');
                                        }
                                        // check if the maximum games is respected
                                        else if (countTicketLegs() >
                                            Price.maxGames) {
                                          // WE CANNOT PLACE MORE THAN THE MAXIMUM GAMES ON A BETSLIP
                                          // A USER IS NOT ALLOWED TO PLACE MORE THAN THE MAX GAMES REQUIRED
                                          // SHOW THIS MESSAGE DOWN HERE
                                          show_dialog_panel(
                                              context,
                                              'limite Dépassée!'.toUpperCase(),
                                              'La Limite de matches pour un billet de pari est de ${Price.maxGames} matches',
                                              'assets/images/fail.png');
                                        } else if (Selection.user == null) {
                                          // SHOW THE LOGIN MESSAGE DIALOG BOX
                                          // LOGIN IS REQUIRED BEFORE PLACING A BET
                                          show_dialog_panel(
                                              context,
                                              'Connexion requise!'
                                                  .toUpperCase(),
                                              'Connecter d\'abord votre compte avant de placer un pari',
                                              'assets/images/fail.png');
                                        }
                                        // WE CHECK IF THE BALANCE IS GREATER OR EQUAL THAN THE MINIMUM PRICE
                                        // WE ALSO CHECK IF IT IS GREATER OR EQUAL TO THE TICKET STAKE
                                        else if ((Selection.userBalance >=
                                                Price.minimumBetPrice) &&
                                            (Selection.userBalance >=
                                                Price.stake)) {
                                          // SHOW THE LOADING BUTTON
                                          if (mounted)
                                            setState(() {
                                              _buyingATicketLoader = true;
                                            });
                                          // WE CHECK IF MATCHES SELECTED ARE STILL NOT STARTED
                                          // O MEANS NO GAMES ON THE LIST HAS STARTED ALREADY
                                          // CHECKING MATCH AVAILABILITY
                                          // print('Checking match availability');
                                          _check_match_availability()
                                              .then((_isOk) {
                                            if (_isOk) {
                                              // print(
                                              //     'CONTINUE WITH ADDING TO BETSLIP');
                                              // print('value from async $_isOk');
                                              // print('Checking finished');
                                              if (mounted)
                                                setState(() {
                                                  _do_the_buying_ticket_process();
                                                });
                                            } else {
                                              // HIDE THE LOADING BUTTON
                                              if (mounted)
                                                setState(() {
                                                  _buyingATicketLoader = false;
                                                });
                                              show_dialog_panel(
                                                  context,
                                                  'Désolé!'.toUpperCase(),
                                                  'Certains matches ont déjà commencé.\nRetirez-les pour placer le pari',
                                                  'assets/images/fail.png');
                                              // print('Could not place the bet');
                                            }
                                          }).catchError((e) {
                                            // print('The validity error is: $e');
                                            print('Error: $e');
                                          });
                                        } else {
                                          // IF THE USER DOES NOT HAVE ENOUGH MONEY INTO HIS SKIIYA BET ACCOUNT
                                          // A BET CAN ONLY BE ACCEPTED FOR USERS WITH MONEY
                                          // MONEY AT LEAST GREATER OR EQUAL TO THE MINIMUM BET PRICE
                                          show_dialog_panel(
                                              context,
                                              'solde insuffisant!'
                                                  .toUpperCase(),
                                              'Désolez! Votre solde est insuffisant.',
                                              'assets/images/fail.png');
                                        }
                                      });
                                  },
                                  fillColor: Colors.lightGreen[400],
                                  disabledElevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Text(
                                    'Pariez maintenant'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  // THIS WILL ALLOW US TO CLEARLY SEE THE END OF THE LIST VIEW
                  SizedBox(height: 200.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text displayInputError(String message, String value) {
    return Text(
      message + ' ' + value.toString() + ' ' + Price.currency_symbol,
      // 'Montant Min est: ${Price.getCommaValue(Price.minimumBetPrice)} Fc',
      style: TextStyle(
        color: Colors.red.shade300,
        fontSize: 12.0,
        // fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future show_dialog_bonus() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: new EdgeInsets.only(
                      top: 100.0, bottom: 16.0, left: 16.0, right: 16.0),
                  margin: new EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(17.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('DETAILS DU BONUS',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20.0),
                      Text(
                        'SKiiYa BET te permet de gagner beaucoup plus encore avec notre système incroyable de bonus.',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Vous pouvez gagner jusqu\'à 100% de bonus sur un billet de pari de 20 Matches et plus',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 25.0),
                      Expanded(
                        child: ListView(
                          children: [
                            _displayBonusDataTable(4, '', Bonus.bonus1),
                            _displayBonusDataTable(5, '', Bonus.bonus2),
                            _displayBonusDataTable(6, '', Bonus.bonus3),
                            _displayBonusDataTable(7, '', Bonus.bonus4),
                            _displayBonusDataTable(8, '', Bonus.bonus5),
                            _displayBonusDataTable(9, '', Bonus.bonus6),
                            _displayBonusDataTable(10, '', Bonus.bonus7),
                            _displayBonusDataTable(11, '', Bonus.bonus8),
                            _displayBonusDataTable(12, '', Bonus.bonus9),
                            _displayBonusDataTable(13, '', Bonus.bonus10),
                            _displayBonusDataTable(14, '', Bonus.bonus11),
                            _displayBonusDataTable(15, '', Bonus.bonus12),
                            _displayBonusDataTable(16, '', Bonus.bonus13),
                            _displayBonusDataTable(17, '', Bonus.bonus14),
                            _displayBonusDataTable(18, '', Bonus.bonus15),
                            _displayBonusDataTable(19, '', Bonus.bonus16),
                            _displayBonusDataTable(20, '+', Bonus.bonus17),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RawMaterialButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          // fillColor: Colors.grey.shade300,
                          hoverColor: Colors.grey.shade100,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: Text(
                              'ok and close'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 16.0,
                  right: 16.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    child: Image.asset(
                      'assets/images/info.png',
                      color: Colors.lightBlue,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future show_dialog_panel(
      BuildContext context, String title, String description, String imgUrl) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: new EdgeInsets.only(
                      top: 100.0, bottom: 16.0, left: 16.0, right: 16.0),
                  margin: new EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(17.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0))
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(title,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700)),
                      SizedBox(height: 20.0),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 25.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RawMaterialButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          // fillColor: Colors.grey.shade300,
                          hoverColor: Colors.grey.shade100,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: Text(
                              'ok and close'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 16.0,
                  right: 16.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60.0,
                    child: Image.asset(
                      imgUrl,
                      // color: Colors.lightGreen[400],
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  loadBetslipMatches() {
    // THIS WILL HOLD ONLY SELECTED GAMES
    var _oddSimplified = [];
    // WE LOOP THROUGH THE ARRAY AND ADD ONLY SELECTED GAMES
    for (var _game in oddsGameArray) {
      // CHECKING FOR SELECTED GAMES
      if (_game.oddID != null &&
          _game.oddName != null &&
          _game.oddIndex != null &&
          _game.oddLabel != null &&
          _game.oddValue != null) {
        // ADDING THE GAME TO THIS TEMPORARILY ARRAY
        _oddSimplified.add(_game);
      }
      // print(_game.gameID);
      // print(' - - - - - - - - up');
    }

    return Column(
      children: _oddSimplified.asMap().entries.map(
        (MapEntry map) {
          // LOAD THE CURRENT GAME TO THE VIEW OF THE USER
          return slipMatches(map.value);
        },
      ).toList(),
    );
  }

  int _hoveredIndex = -1;

  Widget slipMatches(var _matchTicket) {
    // WE SET THE GAME ID HERE
    int _id = _matchTicket.gameID;
    //  oddsGameArray[_gameOddIndex].total = _total;
    // oddsGameArray[_gameOddIndex].handicap = _handicap;
    // oddsGameArray[_gameOddIndex].localTeam = _localTeam;
    // oddsGameArray[_gameOddIndex].visitorTeam = _visitorTeam;
    // oddsGameArray[_gameOddIndex].championship = _championship;
    // oddsGameArray[_gameOddIndex].country = _country;
    var _total = '';
    // SET THE TOTAL IF NOT NULL
    if (_matchTicket.total != null)
      _total = ' ' + _matchTicket.total.toString().toLowerCase();

    var _handicap = '';
    // SET THE HANDICAP IF NOT NULL
    if (_matchTicket.handicap != null)
      _handicap = ' ' + _matchTicket.handicap.toString().toLowerCase();

    // THIS WILL CHECK WEITHER A MATCH HAS STARTED OR NOT
    bool _hasExpired = _matchTicket.hasExpired;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 55.0,
          margin: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: _hasExpired ? 0.0 : 3.0,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: _hasExpired ? Colors.red.shade300 : Colors.grey.shade300,
                width: _hasExpired ? 2.0 : 1.0,
              ),
              bottom: BorderSide(
                color: _hasExpired ? Colors.red.shade300 : Colors.grey.shade300,
                width: _hasExpired ? 2.0 : 1.0,
              ),
              // left: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(
                color: _hasExpired ? Colors.red.shade300 : Colors.grey.shade300,
                width: _hasExpired ? 2.0 : 1.0,
              ),
              left: BorderSide(
                color: _hasExpired ? Colors.red.shade300 : Colors.transparent,
                width: _hasExpired ? 2.0 : 1.0,
              ),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: double.infinity,
                      color: _hoveredIndex == _id
                          ? _hasExpired
                              ? Colors.red.shade300
                              : Colors.grey.shade300
                          : _hasExpired
                              ? Colors.red.shade200
                              : Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onHover: (e) {
                            if (mounted)
                              setState(() {
                                _hoveredIndex = _id;
                                // print(_hoveredIndex);
                              });
                            // Color _colors = Colors.grey;
                          },
                          onExit: (e) {
                            if (mounted)
                              setState(() {
                                _hoveredIndex = -1;
                                // print(_hoveredIndex);
                              });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.0),
                            child: GestureDetector(
                              onTap: () {
                                // ON TAP, REMOVE THE MATCH FROM THE TICKET
                                setState(() {
                                  // WE NEED TO GET THE INDEX OF THIS GAME IN THE ODDS ARRAY
                                  // WE LOOP THROUGH ALL ODDS TO GET THE RIGHT GAME INDEX
                                  for (int _j = 0;
                                      _j < oddsGameArray.length;
                                      _j++) {
                                    // ADDING THE CONDITION HERE
                                    if (oddsGameArray[_j].gameID == _id) {
                                      // print('We have found the game to remove here');
                                      // REMOVING THE MATCH FROM THE TICKET
                                      unselectOddsButton(_j);
                                    }
                                  }
                                  // print('Removing this match from the ticket');
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.times,
                                size: 18.0,
                                color: _hoveredIndex == _id
                                    ? _hasExpired
                                        ? Colors.white
                                        : Colors.redAccent
                                    : _hasExpired
                                        ? Colors.white60
                                        : Colors.black54,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ResponsiveWidget.isExtraSmallScreen(context)
                                ? 140.0
                                : 180.0,
                            // width: ,
                            child: Text(
                              _matchTicket.localTeam +
                                  ' vs ' +
                                  _matchTicket.visitorTeam,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: _hasExpired
                                    ? Colors.red.shade300
                                    : Colors.grey,
                                // fontWeight: FontWeight.bold,
                                // letterSpacing: 1.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Container(
                            width: ResponsiveWidget.isExtraSmallScreen(context)
                                ? 140.0
                                : 180.0,
                            // width: ,
                            child: Text(
                              _matchTicket.oddName.toString() +
                                  ' (' +
                                  _matchTicket.oddLabel
                                      .toString()
                                      .toLowerCase() +
                                  _total +
                                  _handicap +
                                  ')',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: _hasExpired
                                    ? Colors.red.shade300
                                    : Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),

                          // SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
                child: Text(
                  _matchTicket.oddValue.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: _hasExpired ? Colors.red.shade300 : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        _hasExpired
            ? Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3.0),
                child: Text(
                  'Ce match a déjà commencé',
                  style: TextStyle(
                      color: Colors.red.shade300,
                      fontSize: 11.0,
                      fontWeight: FontWeight.normal),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget singleGame() {
    // var _oddData = moreLoadedMatchOdds['odds'];
    var _localTeam = moreOddsMatch.localTeam['data']['name'];
    var _visitorTeam = moreOddsMatch.visitorTeam['data']['name'];
    var _championship = _getLeague(moreOddsMatch);
    var _country = _getCountry(leagueIndex);
    var _dataTime = moreOddsMatch.time;
    // print(_localTeam);
    // print(_visitorTeam);
    // print(_championship);
    // print(_country);
    // print('----------------');

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
          margin: EdgeInsets.only(left: 10.0),
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
                matchIntro(_championship, _country),
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
                        oddDataAndOddId(
                            moreLoadedMatchOdds['odds'][_i],
                            moreLoadedMatchOdds['odds'][_i]['id'],
                            _championship,
                            _country,
                            _localTeam,
                            _visitorTeam,
                            _dataTime),
                    // ELSE DISPLAY A LOADING SCREEN
                    if (moreLoadedMatchOdds == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: SpinKitCircle(
                          color: Colors.lightBlue,
                          size: 25.0,
                        ),
                      )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  matchIntro(String _championship, String _country) {
    // moreOddsMatch
    var team1 = moreOddsMatch.localTeam['data']['name'];
    var team2 = moreOddsMatch.visitorTeam['data']['name'];
    // var team2 = match['team2'];
    // GET THE TIME OF THE MATCH
    var time = moreOddsMatch.time['starting_at']['time'];
    // GET THE DATE OF THE GAME
    var date = moreOddsMatch.time['starting_at']['date'];

    var championship = _championship;
    var country = _country;
    // int _leagueIndex;
    // LET US LOAD CHAMPIONSHIPS
    // ONLY IF WE HAVE DATA IN THE ARRAY
    // if (_leagues.length > 0)
    //   for (int j = 0; j < _leagues.length; j++) {
    //     if (_leagues[j]['id'] == moreOddsMatch.league_id) {
    //       championship = _leagues[j]['name'];
    //       _leagueIndex = j;
    //       // print('the ligue is ${_leagues[_lpLg]['name']}');
    //       // WE BREAK THE LOOP FOR BETTER PROCESSING
    //       break;
    //     }
    //   }

    // LET US GET THE CORRECT COUNTRY HERE
    // ONLY IF WE HAVE DATA IN THE ARRAY
    // if (_countries.length > 0)
    //   for (int j = 0; j < _countries.length; j++) {
    //     if (_leagues[_leagueIndex]['country_id'] == _countries[j]['id']) {
    //       country = ' - ' + _countries[j]['name'];
    //       // print('the country name is ${_countries[j]['name']}');
    //       // WE BREAK THE LOOP FOR BETTER PROCESSING
    //       break;
    //     }
    //   }

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
          championship + ' - ' + country,
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

  Widget tournament() {
    return Expanded(
      child: Container(
        width: 180.0,
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: _leagues.length > 0
            ? ListView.builder(
                itemCount: _leagues.length,
                itemBuilder: (context, index) {
                  // LOAD THE LEAGUES AND DISPLAY THEM
                  return championship(_leagues[index]);
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

  // SHOW THE CURRENT PICK ACTION
  int _currentPick = 0;
  // CONTAINS THE CURRENT SELECTED LEAGUE
  int _currentLeagueID = -1;

  String _league_return_country(int _countryId) {
    // RETURN THE COUNTRY BASED ON THE LEAGUE
    var _country = '';
    // LET US GET THE CORRECT COUNTRY HERE
    // ONLY IF WE HAVE DATA IN THE ARRAY
    // WE LOOP THROUGH COUNTRIES TO GET THE RIGHT COUNTRY NAME WITH THE COUNTRY ID
    if (_countries.length > 0)
      for (int j = 0; j < _countries.length; j++) {
        if (_countryId == _countries[j]['id']) {
          _country = _countries[j]['name'];
          // print('the country name is ${_countries[j]['name']}');
          // WE BREAK THE LOOP FOR BETTER PROCESSING
          break;
        }
      }
    return _country;
  }

  _league_action_click(int _leagueID) {
    // WE SET THE PRESENT LEAGUE TO THIS
    _currentLeagueID = _leagueID;
    // WE SET THE STATE TO LOADING STATE
    _currentPick = 1;
    // THIS SET THE LIMIT OF LOADING MATCHES PER LEAGUE
    int _loadChampsLimit = 50;
    // START FETCHING MATCHES PER LEAGUE
    // HOLD MATCHES NOT ADDED ALREADY
    var _newMatches = [];
    // START FETCHNING MATCHES HERE
    _fetchMatch
        .fetchMatchDetailsByLeague(_loadChampsLimit, _leagueID)
        .then((_getData) {
      // print(_getData);
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
      // CHANGE THE DISPLAY HERE
      // setState(() {
      if (_getData.length > 0) {
        if (mounted)
          setState(() {
            _matches = _getData; // SET THE NEW VALUES
            _currentPick = 2; // SUCCESS MESSAGE
          });

        for (int i = 0; i < _newMatches.length; i++) {
          // print(_matches[i].id);
          // WE ADD ONLY THE ID OF THE GAME TO THE ARRAY COLLECTION
          oddsGameArray.add(OddsArray.fromDatabase(_newMatches[i]));
        }
        // print('WE found data');
      } else {
        // print('No data found');
        if (mounted)
          setState(() {
            _currentPick = 3; // NO DATA FOUND DISPLAY
          });
      }
    });
    // print(_currentPick);
  }

  championship(var _thisLeague) {
    // WE GET THE CURRENT CHAMPIONSHIP NAME
    String _league = _thisLeague['name'];
    int _leagueID = _thisLeague['id'];
    // WE GET THE CURRENT COUNTRY ID
    int _countryId = _thisLeague['country_id'];

    // THIS WILL STORE THE CURRENT COUNTRY NAME
    // RETURN THE COUNTRY BASED ON THE LEAGUE
    var _country = _league_return_country(_countryId);

    // WE RETURN A CLICKABLE WIDGET
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // we will now check if a championship has been adde so it won't be added again
          if (mounted)
            setState(() {
              // WE INITIALIZE AND SET THE NEW VALUES AND RESPONSE
              _league_action_click(_leagueID);
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
                          // DISPLAY THE LEAGUE
                          _league.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Text(
                        // DISPLAY THE COUNTRY
                        _country.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // INITIAL PHASE
                  // if (_currentPick == 0)
                  if (_currentLeagueID != _leagueID)
                    Icon(
                      // SHOW A DIFFERENT ICON IF A CHAMPIONSHIP IS SELECTED
                      Icons.arrow_forward_ios,
                      // SHOW A DIFFERENT COLOR WHEN A CHAMPIONSHIP IS SELECTED
                      color: Colors.grey,
                      size: 20.0,
                    ),
                  // CHECK THE SELECTION CHOICE
                  if (_currentPick == 1)
                    // IF REQUEST IS LOADING
                    // WE WANT TO LOAD ONLY A SPECIFIC LEAGUE
                    if (_currentLeagueID == _leagueID)
                      SpinKitCircle(color: Colors.lightBlue, size: 18.0),

                  // IF WE HAVE GAMES HERE
                  // WE WANT TO LOAD ONLY A SPECIFIC LEAGUE
                  // SHOW A SUCCESS ICON
                  if (_currentPick == 2)
                    if (_currentLeagueID == _leagueID)
                      Icon(
                        // SHOW A DIFFERENT ICON IF A CHAMPIONSHIP IS SELECTED
                        Icons.verified,
                        // SHOW A DIFFERENT COLOR WHEN A CHAMPIONSHIP IS SELECTED
                        color: Colors.green,
                        size: 18.0,
                      ),

                  // WE WANT TO LOAD ONLY A SPECIFIC LEAGUE
                  // IF WE HAVE NO GAMES
                  if (_currentPick == 3)
                    if (_currentLeagueID == _leagueID)
                      Icon(
                        // SHOW A DIFFERENT ICON IF A CHAMPIONSHIP IS SELECTED
                        FontAwesomeIcons.timesCircle,
                        // SHOW A DIFFERENT COLOR WHEN A CHAMPIONSHIP IS SELECTED
                        color: Colors.red,
                        size: 18.0,
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
                        hintText: 'Tapez un Match',
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
                        // print('Erreur: $e');
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Résultats'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
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
                                'Mes Résultats'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  // fontStyle: FontStyle.italic,
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

  thisResult(var result) {
    return GestureDetector(
      onTap: () {
        if (mounted)
          setState(() {
            // CONTAINS THE CONVERTED MATCH TEMPORARILY
            var _searchedMatch = [];
            // WE CONVERT THE GAME INTO A GAME MATCH INSTANCE
            _searchedMatch.add(Match.fromDatabase(result));
            // CHECK IF IS LOADED IN THE MAIN ODDS ARRAY
            bool _isLoaded = false;
            // print(oddsGameArray.length);
            // FILTER TO SEE IF THE GAME EXISTS ALREADY IN THE ODDS ARRAY
            for (int i = 0; i < oddsGameArray.length; i++) {
              // print(oddsGameArray[i].gameID);
              if (oddsGameArray[i].gameID == result['id']) {
                // print('Matching');
                // DO NOT ADD THE GAME
                _isLoaded = true;
                // print('${oddsGameArray[i].gameID} and ${result['id']}');
              }
            }

            // WE ADD THIS GAME IF IT IS NOT YET LOADED
            if (!_isLoaded) {
              // WE ADD THE MATCH IF NOT YET ADDED
              oddsGameArray.add(result);
              // print('Game added to odds array');
            }

            // WE ASSIGN THE UNIQUE VALUE TO THE VARIABLE OF MATCH ODDS
            moreOddsMatch = _searchedMatch.first;
            // LOAD ALL RELATED ODDS TO THIS MATCH
            _fetchMatch
                .fetchAllGameOdds(moreOddsMatch.id.toString())
                .then((value) {
              if (mounted)
                setState(() {
                  // STORE THE ODDS OF THE MATCH IN THE ARRAY
                  moreLoadedMatchOdds = value;
                });
            });
            // matchMoreOdds = _searchedMatch.first;
            // print(matchMoreOdds.data);
            // print(result.documentID);
            // print(moreOddsMatch.id);
            // CLEAR ALL DATA ARRAYS
            _queryDisplay.clear();
            _queryResults.clear();

            _isQueryEmpty = true;
            // // go to match detail page
            Window.showWindow = 0;
            // WE SWITCH THE WINDOW TO GAMES DETAILS
            switchToMoreMatchOddsWindow = true;
            // go to home page content
            Window.selectedMenu = 1;
            // select the home bottom as the current tab
            // Selection.bottomCurrentTab = 0;
            // set the jackpot index to football selection
            Window.showJackpotIndex = 0;
            // } catch (e) {
            //   // print('the stupid error is $e');
            // }
          });
      },
      child: Column(
        children: [
          SizedBox(height: 5.0),
          Row(
            children: [
              Icon(Icons.arrow_forward_ios, size: 18.0, color: Colors.grey),
              SizedBox(width: 3.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['localTeam']['data']['name'].toString() +
                          ' vs ' +
                          result['visitorTeam']['data']['name'].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      result['time']['starting_at']['date_time'].toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Divider(color: Colors.grey, thickness: 0.4),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }

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
        search.substring(0, 1).toLowerCase() + search.substring(1);

    // print(search.toLowerCase());

    // EXECUTE IF WE HAVE NO DATA FETCHED FROM THE DATABASE
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
      // print('the full search string is $capitalizedValue');
      // WE SET THE DISPLAY ARRAY TO EMPTY
      // print(_queryResults.length);
      _queryDisplay = [];
      // WE LOOP THROUGH THE RESULTS AND COMPLETE MATCHING
      _queryResults.forEach((element) {
        // WE SET THE STATE FOR AN INSTANT UPDATE
        // print(element['localTeam']['data']['name']);
        // print(element['visitorTeam']['data']['name']);
        if ((element['localTeam']['data']['name']
                .toString()
                .toLowerCase()
                .startsWith(capitalizedValue.toLowerCase())) ||
            (element['visitorTeam']['data']['name']
                .toString()
                .toLowerCase()
                .startsWith(capitalizedValue.toLowerCase()))) {
          if (mounted)
            setState(() {
              _queryDisplay.add(element);
              // print(element);
            });
        }
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

  sentRequest(String request) {
    // SENDING THE REQUEST TO THE DATABASE
    Firestore.instance
        .collection('football') // COLLECTION
        .where('searchKey', arrayContains: request) // QUERY REQUEST
        .where('status', isEqualTo: 'NS') // ONLY NOT STARTED MATCHES
        // FILTER BY STARTING TIME
        .orderBy('time.starting_at.date_time', descending: false)
        .getDocuments()
        .then((_qn) {
      if (mounted)
        // add all results to the first array
        for (var j = 0; j < _qn.documents.length; j++) {
          setState(() {
            // we add all fetched values to the query results array
            // WE FILL THE QUERY RESULTS
            _queryResults.add(_qn.documents[j]);
            // WE FILL THE DISPLAY RESULTS SO THAT ALL FETCHED DATA WILL BE SEEN
            _queryDisplay.add(_qn.documents[j]);
          });
        }
      // print(_qn.documents.length);
      // return null;
    });
    // return qn.documents;
  }

  // sesssion management
  reLoginUser() async {
    // INITIALIZE THE SESSION
    var session = FlutterSession();
    // GET ALL VVALUES FROM LOCAL STORAGE
    String _phone1 = await session.get('_ph_1_');
    String _phone2 = await session.get('_ph_2_');
    String _pass1 = await session.get('_p1_');
    String _pass2 = await session.get('_p2_');
    // RELOGGIN THE USER IF NO USER IS FOUND
    if (Selection.user == null) {
      if (_phone1 != null &&
          _phone2 != null &&
          _pass1 != null &&
          _pass2 != null) {
        // LOGIN THE USER
        doSessionUserLogin((_phone1 + _phone2), (_pass1 + _pass2));
      }
    }
  }

  doSessionUserLogin(String _telephone, String _passCode) async {
    checkInternet();
    String congoCode = '243';
    // print('The telephone is: $telephone');
    // print('The passcode is: $passCode');
    String _phone = Encryption.decryptAESCryptoJS(
      _telephone,
      '_skiiya_sarl_session_login_',
    );
    // FORMAT THE EMAIL
    String _email = congoCode + _phone + '@gmail.com';
    // GET THE PASSWORD FROM LOCAL STORAGE
    String _password = Encryption.decryptAESCryptoJS(
      _passCode, // PASS ENCRYPT
      _phone, // USER PHONE
    );
    // print('login has been reached and phone is $phone');
    // print('login has been reached and email is $email');
    // print('login has been reached and code is $code');
    await _auth
        .signInWithEmailAndPassword(
      email: _email,
      password: _password,
    )
        .then((result) {
      // SET THE USER VALUE
      Selection.user = result.user;
      // get the right user balance and the right user phone number
      Firestore.instance
          .collection('UserInfo')
          .document(result.user.uid)
          .get()
          .then((_result) {
        // GET THE BLOCKING STATUS
        if (_result['isBlocked'] == true) {
          // logout the user if he is being blocked in the system
          Login.doLogout(); // LOG OUT
        } else {
          Firestore.instance
              .collection('UserBalance')
              .document(result.user.uid)
              .get()
              .then((_resultBalance) {
            if (mounted)
              setState(() {
                // print('the ID is $id');
                Selection.userTelephone = '0' + _phone;
                Selection.userBalance = _resultBalance['balance'];
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
                  'Failed to get document because the client is offline. (unavailable)') ==
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
                        'Historique',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
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
                        'Transactions',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
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
                      'Nos Contacts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
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
                        'Modifiez Mot de Passe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
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
                        'Connexion / Inscription',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
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
                        'Déconnexion',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
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

  _displayBonusDataTable(int matchNumber, String substring, int bonus) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$matchNumber$substring',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          Text(
            ' Matches =',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14.0),
          ),
          Text(
            ' $bonus%',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          Text(
            ' Bonus',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  // WE CHECK THE VALIDITY OF EVERY SINGLE MATCH ON THE TICKET
  Future _check_match_availability() async {
    // IF ZERO, MEANS NO GAME ON THE TICKET HAS STARTED
    // ELSE DIFFERENT FROM ZERO MEANS AT LEAST ONE GAME ON THE TICKET HAS STARTED
    int _notStarted = 0;
    // WE GET THE INDEX OF THE GAME THAT HAS STARTED ALREADY
    // int _gameIndex;

    for (int _i = 0; _i < oddsGameArray.length; _i++) {
      // WE CAN ONLY FETCH VALUES OF SELECTED MATCHES WITH NON NULL VALUES HERE
      if (oddsGameArray[_i].oddID != null &&
          oddsGameArray[_i].oddName != null &&
          oddsGameArray[_i].oddIndex != null &&
          oddsGameArray[_i].oddLabel != null &&
          oddsGameArray[_i].oddValue != null) {
        // LET UD GET THE GAME ID
        String _gameId = oddsGameArray[_i].gameID.toString();
        // IF A MATCH IS SELECTED THEN CHECK FOR ITS VALIDITY
        await Firestore.instance
            .collection('football')
            .document(_gameId) // WE GET THE CURRENT GAME
            .get()
            .then((_gameFetch) {
          // CHECK IF THE STATUS IS STILL NOT STARTED (NS)
          // AND IF THE GAME STILL EXISTS - IF NOT DELETED YET
          // IF THE STATUS IS NOT NS OR THE GAME DOES NOT EXISTS,
          // DENIED THE ADDITION OF THE GAME TO THE TICKET
          if ((_gameFetch['status'].toString().compareTo('NS') != 0) ||
              (!_gameFetch.exists)) {
            // ONLY UPDATE THIS VARIABLE IF THE GAME HAS STARTED OR DOES NOT EXIST ANYMORE
            // WE CHECK IF SELECTED GAMES HAVE NOT YET STARTED
            // KEEP INCREASING THE VALUES SO WE WILL KNOW HAOW MANY HAVE STARTED ALREADY
            // AND HOW MANY ARE STILL PENDING
            _notStarted++;
            // _gameIndex = _i;
            // WE SET THE GAME INDEX TO THIS CURRENT INDEX
            // print(
            //     'This game ${oddsGameArray[_i].gameID} has started already or not found');
            // IF A GAME HAS ALREADY STARTED,
            // WE UPDATE THE STATE OF EXPIRATION IN THE ARRAY
            if (mounted)
              setState(() {
                // WE SET IT TO TRUE TO DISPLAY THE ERROR MESSAGE
                // THE ERROR WILL BE DISPLAYED ON THE BETSLIP LIST
                oddsGameArray[_i].hasExpired = true;
                // WE RELOAD THE BETSLIP BOX TO UPDATE THE RESULTS RIGHT HERE
                loadBetslipMatches();
              });
          }
          //  else {
          //   print('GAME ID: ${oddsGameArray[_i].gameID} PENDING / AVAILABLE');
          // }
        });
      }
    }

    // print('THE ACCESS VALUE: $_notStarted');
    if (_notStarted != 0) {
      // RETURN FALSE
      return false;
    } else {
      // RETURN TRUE
      return true;
    }
  }

  // THIS METHOD LOADS THE USER BALANCE AND MORE DETAILS
  void _load_user_data_info() {
    // FETCH CURRENT DATA FROM THE DATABASE IN THE COLLECTION
    Firestore.instance
        .collection('UserBalance')
        .document(Selection.user.uid)
        .get()
        .then((_result) {
      if (mounted)
        setState(() {
          // STORE AND UPDATE THE BALANCE OF THE USER
          // AFTER PLACING A BET, DARE UPDATE THE USER BALANCE ON SCREEN
          Selection.userBalance = _result['balance'];
        });
    });
  }

  // THIS IS WHERE THE PROCESSES ARE ADDED
  void _do_the_buying_ticket_process() {
    // WE START BY ADDING THE TRANSACTION
    double _stake = Price.stake;
    // TO THE TRANSACTION COLLECTION HERE
    Method.addNewTransaction('Billet de pari', _stake, '-').then((_trans) {
      // LET US GET THE TRANSACTION ID HERE
      String _transID = _trans.documentID.toString();
      // print('--------STAKE--------TRANS ID---------------');
      // print(_stake);
      // print(_transID);
      // print('-------------------------------');
      // IF SUCCESSFULL, WE UPDATE THE USER BALANCE WITH
      // THE TRANSACTION ID FOR TRACKING PROCESS
      Method.updateUserBalance(_transID).then((value) {
        // WE HAVE UPDATED SUCCESSFULLY THE USER BALANCE
        Method.addNewTicket(_transID, _stake, oddsGameArray).then((value) {
          // IF THE TICKET IS ADDED
          // SUCCESSFULLY UPDATE THE VALUE THE USER BALANCE ONSCREEN
          _load_user_data_info();
          // SHOW A SUCCESSFULL MESSAGE TO THE USER HERE
          if (mounted)
            setState(() {
              // UNSELECT ALL GAMES AT ONCE
              unselect_all_at_once();
              // HIDE THE LOADING BUTTON
              hideLoadingButton();
              Price.stake = 200;
            });
          // SHOW A DIALOG BOX
          show_dialog_panel(
              context,
              'Félicitations!'.toUpperCase(),
              'Votre billet de pari a été placé avec succès',
              'assets/images/ok.png');
          // print('Ticket successfully baught');
          // print(value);
          // SHOW THE DIALOG BOX FOR ERROR
        }).catchError((e) {
          hideLoadingButton();
          // print('bet adding error: $e');
          show_dialog_panel(context, 'Désolé!'.toUpperCase(),
              'Une erreur est survenue', 'assets/images/fail.png');
        });
      }).catchError((e) {
        hideLoadingButton();
        // print('user update balance error: $e');
        show_dialog_panel(context, 'Désolé!'.toUpperCase(),
            'Une erreur est survenue', 'assets/images/fail.png');
      });
    }).catchError((e) {
      // HIDE LOADING BUTTON
      hideLoadingButton();
      // PRINT THE ERROR MESSAGE
      // print('adding transaction record error: $e');
      // SHOW THE DIALOG BOX
      show_dialog_panel(context, 'Désolé!'.toUpperCase(),
          'Une erreur est survenue', 'assets/images/fail.png');
    });
  }

  hideLoadingButton() {
    // HIDE THE LOADING BUTTON
    if (mounted)
      setState(() {
        _buyingATicketLoader = false;
      });
  }

  void unselect_all_at_once() {
    if (mounted)
      setState(() {
        // WE LOOP THROUGH ALL ODDS TO GET THE RIGHT GAME INDEX
        for (int _j = 0; _j < oddsGameArray.length; _j++) {
          // print('We have found the game to remove here');
          // REMOVING ALL MATCHES FROM THE TICKET
          unselectOddsButton(_j);
        }
      });
  }

  // keep on loading user blance details every 45s
  loopUserBalanceRecord() {
    String _uid = Selection.user.uid;
    // keep loading user balance every t seconds
    if (Selection.user != null)
      Timer.periodic(new Duration(seconds: 45), (timer) {
        // load details only if user has logged in
        Firestore.instance
            .collection('UserBalance')
            .document(_uid)
            .get()
            .then((_result) {
          // UPDATE THE BALANCE ON SUCCESSFULL LOADING
          if (mounted)
            setState(() {
              // UPDATE THE USER BALANCE HERE
              Selection.userBalance =
                  double.parse(_result['balance'].toString());
            });
        }).catchError((e) {
          // print('e: $e');
        });
      });
  }

  // removedTheOldMatch() {
  //   // LOOP THROUGH THE DATA ARRAY EVERY 1 SECOND TO REMOVE OLD MATCHES ONE BY ONE
  //   Timer.periodic(new Duration(seconds: 30), (timer) {
  //     // LET'S DO SOME CALCULATION
  //     // print(data.length);
  //     // loop through all displayed games on the screen to check if they are still valid
  //     for (int j = 0; j < data.length; j++) {
  //       // This is the timestamp for every single game
  //       Timestamp realGameTime = Timestamp.fromDate(new DateTime(
  //         int.parse(data[j]['date']['4']),
  //         int.parse(data[j]['date']['3']),
  //         int.parse(data[j]['date']['2']),
  //         int.parse(data[j]['time']['1']),
  //         int.parse(data[j]['time']['2']),
  //       ));
  //       //To TimeStamp
  //       // We get the user current date and time
  //       Timestamp currentUserTime = Timestamp.fromDate(new DateTime.now());
  //       // Let's calcualate the difference of Seconds
  //       int diff = realGameTime.seconds - currentUserTime.seconds;
  //       // print('This match DIFF is: $diff secs.');
  //       if (mounted)
  //         setState(() {
  //           // REMOVE THE GAME IF IT REMAINS ONLY TWO MINUTES AND HALF OR LESS
  //           if (diff <= 150 || diff < 0) {
  //             // check if the game has been selected before updating
  //             if (BetSlipData.gameIds.contains(data[j].documentID)) {
  //               // delete the game from selected games array
  //               // TO BE UNCOMMENTED
  //               // removeSingleMatch(data[j].documentID);
  //               // print('Removing the selected match');
  //             }
  //             // print('Removing a current match from the list');
  //             // if not remove it from the list
  //             // Remove the game in the Game Array
  //             // TO BE UNCOMMENTED
  //             // data.removeAt(j);
  //           }
  //           // else {
  //           //   // IF THE MATCH IS STILL VALID
  //           // print('This match will remain actif=> DIFF is: $diff secs.');
  //           // }
  //           if (data.length <= 20) {
  //             // load more games if available remains only 20 or less
  //             // THIS WILL LOAD MORE GAMES
  //             // TO BE UNCOMMENTED
  //             // loadingGames(fieldLoadMore);
  //           }
  //         });
  //       // THIS CONDITION LOADS MORE GAMES IF REMAINING ARE LESS THAN 10
  //     }
  //   });
  // }
}

// 6272
// was 6700 lines of fresh codes --- still
