import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Selection {
  // store the current logged in user
  static FirebaseUser user;
  // string initialize user status in local storage
  // static String getUserIdFromLocal = '';
  // store the current Signed In user phone
  static String userTelephone = '';
  static String resetPhone = '';
  // store the current Signed In user balance
  static double userBalance = 0.0;

  static int bottomCurrentTab = 0;
  // static int matchClicked;
  static var gameOddsArray = [];
  static int maxLength = 53;

  // max search limit
  static int loadLimit = 20;
  // load games based on a championship but with no limit
  // static int loadSearchLimit = 1;
  //allow if new result can be loded
  // static int loadNewData = 1;
  // counter for the request resend code
  // static int minTimer = 90;
  // time variables
  static bool isPasswordChanged = false;

  // static void getUserDetails(String uid) {
  //   Firestore.instance.collection('users').document(uid).get().then((_result) {
  //     // Selection.getUserIdFromLocal = uid;
  //     Selection.userTelephone = ('0' + _result['telephone'].trim()).trim();
  //     Selection.userBalance = _result['balance'];
  //   });
  // }
  // the bool that display the reset SMS Code link to client
  static bool showResendSMS = false;
  static bool showResendSMSinForgot = true;

  static var reference = [
    '1x2 [ 1 ]',
    '1x2 [ X ]',
    '1x2 [ 2 ]',
    '1x2 : 1 [ 1 ]',
    '1x2 : 1 [ X ]',
    '1x2 : 1 [ 2 ]',
    '1x2 : 2 [ 1 ]',
    '1x2 : 2 [ X ]',
    '1x2 : 2 [ 2 ]',
    'Over [ 0.5 ]',
    'Under [ 0.5 ]',
    'Over [ 1.5 ]',
    'Under [ 1.5 ]',
    'Over [ 2.5 ]',
    'Under [ 2.5 ]',
    'Over [ 3.5 ]',
    'Under [ 3.5 ]',
    'Over [ 4.5 ]',
    'Under [ 4.5 ]',
    'Over [ 5.5 ]',
    'Under [ 5.5 ]',
    'BTS [ Yes ]',
    'BTS [ No ]',
    'FT [ Odd ]',
    'FT [ Even ]',
    'T1-FT [ Odd ]',
    'T1-FT [ Even ]',
    'T2-FT [ Odd ]',
    'T2-FT [ Even ]',
    'M.Goal [ 1st ]',
    'M.Goal [ 2nd ]',
    'M.Goal [ Equal ]',
    'T1-WEH [ Yes ]',
    'T1-WEH [ No ]',
    'T2-WEH [ Yes ]',
    'T2-WEH [ No ]',
    'T1-SBH [ Yes ]',
    'T1-SBH [ No ]',
    'T2-SBH [ Yes ]',
    'T2-SBH [ No ]',
    'T1-CS [ Yes ]',
    'T1-CS [ No ]',
    'T2-CS [ Yes ]',
    'T2-CS [ No ]',
    'FT-DC [ 1X ]',
    'FT-DC [ 2X ]',
    'FT-DC [ 12 ]',
    '1x2-BTS [ 1-Yes ]',
    '1x2-BTS [ 1-No ]',
    '1x2-BTS [ 2-Yes ]',
    '1x2-BTS [ 2-No ]',
    '1x2-BTS [ X-Yes ]',
    '1x2-BTS [ X-No ]',
    'x?x'
  ];

  static Future getPosts(int filter) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn;
    if (filter == 0) {
      // if it is the game windows loading filter all games
      qn = await firestore
          .collection('Games')
          .orderBy('sorter')
          .limit(loadLimit)
          .getDocuments();
    } else if (filter == 1) {
      // print('loading popular bets');
      // other wise filter only trending games
      qn = await firestore
          .collection('Games')
          .where('isPopular', isEqualTo: true)
          .limit(loadLimit)
          .orderBy('sorter')
          .getDocuments();
    } else if (filter == 2) {
      // home matches with high odds
      qn = await firestore
          .collection('Games')
          .orderBy('oneTimesTwo.1', descending: true)
          .limit(loadLimit)
          .getDocuments();
    } else if (filter == 3) {
      // home matches with low odds
      qn = await firestore
          .collection('Games')
          .orderBy('oneTimesTwo.1', descending: false)
          .limit(loadLimit)
          .getDocuments();
      // print(qn.documents.length);
    } else if (filter == 4) {
      // home matches with high odds
      qn = await firestore
          .collection('Games')
          .orderBy('oneTimesTwo.3', descending: true)
          .limit(loadLimit)
          .getDocuments();
      // print(qn.documents.length);
    } else if (filter == 5) {
      // away matches with low odds
      qn = await firestore
          .collection('Games')
          .orderBy('oneTimesTwo.3', descending: false)
          .limit(loadLimit)
          .getDocuments();
      // print(qn.documents.length);
    }
    return qn.documents;
  }

  static Future getCategory(String championship) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn;
    // if it is the game windows loading filter all games
    qn = await firestore
        .collection('Games')
        .where('championship', isEqualTo: championship)
        // .orderBy('timestamp', descending: false)
        // .limit(loadSearchLimit) // we remove the limit based on games champuonship
        .getDocuments();
    // print('championship $query');
    return qn.documents;
  }

  static getCountData() async {
    var firestore = Firestore.instance;
    // This query snapshot load all games available in the system
    QuerySnapshot qn;
    qn = await firestore.collection('Games').getDocuments();
    return qn.documents;
  }
}
