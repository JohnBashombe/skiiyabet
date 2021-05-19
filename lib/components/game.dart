// import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  String id;
  String type;
  String country;
  String championship;
  String team1;
  String team2;
  bool isPopular;
  String status;
  String admin;
  // bool isStillDisplay;
  List<String> time = [];
  List<String> date = [];
  List<String> timeAdded = [];
  List<String> dateAdded = [];
  List<double> oneTimesTwo;
  List<double> overUnder;
  List<double> bothTeamsToScore;
  List<double> oddEven;
  List<double> half;
  List<double> cleanSheet;
  List<double> drawNoBet;
  List<double> other;
  // add results and score arrays
  List<double> scoresTeam1; // [FirstHalf,SecondHalf,Final Score]
  List<double> scoresTeam2; // [FirstHalf,SecondHalf,Final Score]
  // store true or false and have the same structure as the original odds
  List<bool> resultOneTimesTwo;
  List<bool> resultOverUnder;
  List<bool> resultBothTeamsToScore;
  List<bool> resultOddEven;
  List<bool> resultHalf;
  List<bool> resultCleanSheet;
  List<bool> resultDrawNoBet;
  List<bool> resultOther;

  // static DocumentSnapshot matchDetails;
  Match(
      {this.id,
      this.type,
      this.country,
      this.championship,
      this.team1,
      this.team2,
      this.isPopular,
      this.status,
      this.admin,
      this.time,
      this.date,
      this.timeAdded,
      this.dateAdded,
      this.oneTimesTwo,
      this.overUnder,
      this.bothTeamsToScore,
      this.oddEven,
      this.half,
      this.cleanSheet,
      this.drawNoBet,
      this.other,
      this.scoresTeam1,
      this.scoresTeam2,
      this.resultOneTimesTwo,
      this.resultOverUnder,
      this.resultBothTeamsToScore,
      this.resultOddEven,
      this.resultHalf,
      this.resultDrawNoBet,
      this.resultCleanSheet,
      this.resultOther});
}

// addGameToCollection() {
//     // variables declaration
//     // variables declaration
//     var date = new DateTime.now();
//     String min = date.minute < 10
//         ? '0' + date.minute.toString()
//         : date.minute.toString();
//     String hour =
//         date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString();

//     int indicRef = date.hour;
//     String timeIndicator = '';
//     if (indicRef < 12)
//       timeIndicator = 'AM';
//     else
//       timeIndicator = 'PM';

//     String day =
//         date.day < 10 ? '0' + date.day.toString() : date.day.toString();
//     String month =
//         date.month < 10 ? '0' + date.month.toString() : date.month.toString();
//     String year =
//         date.year < 10 ? '0' + date.year.toString() : date.year.toString();
//     int today = date.weekday;

//     String weekday = '';
//     if (today == 1) weekday = 'Mon';
//     if (today == 2) weekday = 'Tue';
//     if (today == 3) weekday = 'Wed';
//     if (today == 4) weekday = 'Thu';
//     if (today == 5) weekday = 'Fri';
//     if (today == 6) weekday = 'Sat';
//     if (today == 7) weekday = 'Sun';
//     // we will be inserting in games and History at the same time

//     Firestore.instance.collection('Games').add({
//       'admin': 'ntavigwa',
//       'bothTeamsToScore': {'1': 1.33, '2': 1.64},
//       'championship': 'Lazio',
//       'cleanSheet': {
//         '1': 2.30,
//         '2': 1.30,
//         '3': 2.18,
//         '4': 1.43,
//       },
//       'country': 'Italy',
//       'date': {
//         '1': 'Sun',
//         '2': '20',
//         '3': '09',
//         '4': '2020',
//       },
//       'dateAdded': {
//         '1': '$weekday',
//         '2': '$day',
//         '3': '$month',
//         '4': '$year',
//       },
//       'drawNoBet': {
//         '1': 1.59,
//         '2': 1.52,
//       },
//       'half': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//         '9': 1.28,
//         '10': 1.29,
//         '11': 1.20,
//       },
//       'isPopular': true,
//       'oddEven': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//       },
//       'oneTimesTwo': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//         '9': 1.28,
//       },
//       'other': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//       },
//       'overUnder': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//         '9': 1.28,
//         '10': 1.29,
//         '11': 1.20,
//         '12': 1.20,
//       },
//       'searchKey': ['P', 'N'], // Leeds United - Fulham
//       'status': 'pending',
//       'team1': 'Parma',
//       'team2': 'Napoli',
//       'time': {
//         '1': '09',
//         '2': '30',
//         '3': 'AM',
//       },
//       'timeAdded': {
//         '1': '$hour',
//         '2': '$min',
//         '3': '$timeIndicator',
//       },
//       'type': 'football',
//       'sorter': '20' + '09' + '2020' + '09' + '30',
//       'timestamp': DateTime.now(),
//     }).then((value) {
//       print('id is: ${value.documentID}');
//       print('Game Added successfully and adding to history collection');
//       Firestore.instance.collection('GamesHistory').add({
//         'gameID': value.documentID,
//         'admin': 'ntavigwa',
//         'bothTeamsToScore': {'1': 1.33, '2': 1.64},
//         'championship': 'Lazio',
//         'cleanSheet': {
//           '1': 2.30,
//           '2': 1.30,
//           '3': 2.18,
//           '4': 1.43,
//         },
//         'country': 'Italy',
//         'date': {
//           '1': 'Sun',
//           '2': '20',
//           '3': '09',
//           '4': '2020',
//         },
//         'dateAdded': {
//           '1': weekday,
//           '2': '$day',
//           '3': '$month',
//           '4': '$year',
//         },
//         'drawNoBet': {
//           '1': 1.59,
//           '2': 1.52,
//         },
//         'half': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//           '9': 1.28,
//           '10': 1.29,
//           '11': 1.20,
//         },
//         'isPopular': true,
//         'oddEven': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//         },
//         'oneTimesTwo': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//           '9': 1.28,
//         },
//         'other': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//         },
//         'overUnder': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//           '9': 1.28,
//           '10': 1.29,
//           '11': 1.20,
//           '12': 1.20,
//         },
//         'searchKey': ['P', 'N'], // Leeds United - Fulham
//         'status': 'pending',
//         'team1': 'Parma',
//         'team2': 'Napoli',
//         'time': {
//           '1': '09',
//           '2': '30',
//           '3': 'AM',
//         },
//         'timeAdded': {
//           '1': '$hour',
//           '2': '$min',
//           '3': '$timeIndicator',
//         },
//         'type': 'football',
//         'sorter': '20' + '09' + '2020' + '09' + '30',
//         'timestamp': DateTime.now(),
//         'resultBothTeamsToScore': [null, null],
//         'resultOddEven': [null, null, null, null, null, null, null, null],
//         'resultHalf': [
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null
//         ],
//         'resultCleanSheet': [null, null, null, null],
//         'resultDrawNoBet': [null, null],
//         'resultOther': [null, null, null, null, null, null]
//       }).then((value) {
//         print('Game History Added successfully');
//       }).catchError((e) {
//         print('Could not add game : Error : $e');
//       });
//     }).catchError((e) {
//       print('Could not add game : Error : $e');
//     });
//   }

List<Match> matches = [
  Match(
      type: 'football',
      country: 'England',
      championship: 'Premier League',
      team1: 'Liverpool',
      team2: 'Burnley',
      isPopular: true,
      status: 'pending',
      admin: '1',
      time: [
        '05',
        '00',
        'PM'
      ],
      date: [
        'sat',
        '22',
        '09',
        '2020'
      ],
      timeAdded: [
        '08',
        '30',
        'PM'
      ],
      dateAdded: [
        'sat',
        '20',
        '09',
        '2020'
      ],
      oneTimesTwo: [
        3.50,
        2.69,
        1.43,
        1.24,
        4.36,
        10.00,
        1.24,
        3.69,
        5.20
      ],
      overUnder: [
        1.05,
        1.03,
        1.20,
        1.20,
        1.30,
        1.30,
        1.40,
        1.54,
        1.54,
        4.59,
        1.06,
        3.54
      ],
      bothTeamsToScore: [
        2.09,
        1.71
      ],
      oddEven: [
        1.87,
        1.89,
        1.24,
        1.71,
        1.36,
        1.45,
        1.65,
        1.98
      ],
      half: [
        3.12,
        2.00,
        3.50,
        3.29,
        1.18,
        4.27,
        1.23,
        2.00,
        4.50,
        1.86,
        3.00
      ],
      cleanSheet: [
        7.00,
        1.06,
        1.76,
        1.80
      ],
      drawNoBet: [
        5.00,
        1.07
      ],
      other: [
        15.00,
        12.00,
        3.40,
        2.00,
        5.00,
        8.00
      ],
      scoresTeam1: [
        null,
        null,
        null
      ],
      scoresTeam2: [
        null,
        null,
        null
      ],
      resultOneTimesTwo: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultOverUnder: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultBothTeamsToScore: [
        null,
        null
      ],
      resultOddEven: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultHalf: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultCleanSheet: [
        null,
        null,
        null,
        null
      ],
      resultDrawNoBet: [
        null,
        null
      ],
      resultOther: [
        null,
        null,
        null,
        null,
        null,
        null
      ]),
  Match(
      type: 'football',
      country: 'England',
      championship: 'Premier League',
      team1: 'Man City',
      team2: 'Man United',
      isPopular: true,
      status: 'pending',
      admin: '1',
      time: [
        '22',
        '30',
        'PM'
      ],
      date: [
        'sun',
        '15',
        '12',
        '2020'
      ],
      timeAdded: [
        '08',
        '30',
        'PM'
      ],
      dateAdded: [
        'sat',
        '20',
        '09',
        '2020'
      ],
      oneTimesTwo: [
        3.50,
        2.69,
        1.43,
        1.24,
        4.36,
        10.00,
        1.24,
        3.69,
        5.20
      ],
      overUnder: [
        1.05,
        1.03,
        1.20,
        1.20,
        1.30,
        1.30,
        1.40,
        1.54,
        1.54,
        4.59,
        1.06,
        3.54
      ],
      bothTeamsToScore: [
        2.09,
        1.71
      ],
      oddEven: [
        1.87,
        1.89,
        1.24,
        1.71,
        1.36,
        1.45,
        1.65,
        1.98
      ],
      half: [
        3.12,
        2.00,
        3.50,
        3.29,
        1.18,
        4.27,
        1.23,
        2.00,
        4.50,
        1.86,
        3.00
      ],
      cleanSheet: [
        7.00,
        1.06,
        1.76,
        1.80
      ],
      drawNoBet: [
        5.00,
        1.07
      ],
      other: [
        15.00,
        12.00,
        3.40,
        2.00,
        5.00,
        8.00
      ],
      scoresTeam1: [
        null,
        null,
        null
      ],
      scoresTeam2: [
        null,
        null,
        null
      ],
      resultOneTimesTwo: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultOverUnder: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultBothTeamsToScore: [
        null,
        null
      ],
      resultOddEven: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultHalf: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultCleanSheet: [
        null,
        null,
        null,
        null
      ],
      resultDrawNoBet: [
        null,
        null
      ],
      resultOther: [
        null,
        null,
        null,
        null,
        null,
        null
      ]),
  Match(
      type: 'football',
      country: 'Spain',
      championship: 'La Liga',
      team1: 'Barcelona',
      team2: 'Real Valladolid',
      isPopular: false,
      status: 'pending',
      admin: '1',
      time: [
        '03',
        '30',
        'PM'
      ],
      date: [
        'sat',
        '25',
        '09',
        '2020'
      ],
      timeAdded: [
        '08',
        '30',
        'PM'
      ],
      dateAdded: [
        'sat',
        '20',
        '09',
        '2020'
      ],
      oneTimesTwo: [
        3.50,
        2.69,
        1.43,
        1.24,
        4.36,
        10.00,
        1.24,
        3.69,
        5.20
      ],
      overUnder: [
        1.05,
        1.03,
        1.20,
        1.20,
        1.30,
        1.30,
        1.40,
        1.54,
        1.54,
        4.59,
        1.06,
        3.54
      ],
      bothTeamsToScore: [
        2.09,
        1.71
      ],
      oddEven: [
        1.87,
        1.89,
        1.24,
        1.71,
        1.36,
        1.45,
        1.65,
        1.98
      ],
      half: [
        3.12,
        2.00,
        3.50,
        3.29,
        1.18,
        4.27,
        1.23,
        2.00,
        4.50,
        1.86,
        3.00
      ],
      cleanSheet: [
        7.00,
        1.06,
        1.76,
        1.80
      ],
      drawNoBet: [
        5.00,
        1.07
      ],
      other: [
        15.00,
        12.00,
        3.40,
        2.00,
        5.00,
        8.00
      ],
      scoresTeam1: [
        null,
        null,
        null
      ],
      scoresTeam2: [
        null,
        null,
        null
      ],
      resultOneTimesTwo: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultOverUnder: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultBothTeamsToScore: [
        null,
        null
      ],
      resultOddEven: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultHalf: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultCleanSheet: [
        null,
        null,
        null,
        null
      ],
      resultDrawNoBet: [
        null,
        null
      ],
      resultOther: [
        null,
        null,
        null,
        null,
        null,
        null
      ]),
  Match(
      type: 'football',
      country: 'Italy',
      championship: 'Serie A',
      team1: 'Liverpool',
      team2: 'Lazio',
      isPopular: false,
      status: 'pending',
      admin: '1',
      time: [
        '20',
        '45',
        'PM'
      ],
      date: [
        'Tue',
        '08',
        '11',
        '2020'
      ],
      timeAdded: [
        '08',
        '30',
        'PM'
      ],
      dateAdded: [
        'sat',
        '20',
        '09',
        '2020'
      ],
      oneTimesTwo: [
        3.50,
        2.69,
        1.43,
        1.24,
        4.36,
        10.00,
        1.24,
        3.69,
        5.20
      ],
      overUnder: [
        1.05,
        1.03,
        1.20,
        1.20,
        1.30,
        1.30,
        1.40,
        1.54,
        1.54,
        4.59,
        1.06,
        3.54
      ],
      bothTeamsToScore: [
        2.09,
        1.71
      ],
      oddEven: [
        1.87,
        1.89,
        1.24,
        1.71,
        1.36,
        1.45,
        1.65,
        1.98
      ],
      half: [
        3.12,
        2.00,
        3.50,
        3.29,
        1.18,
        4.27,
        1.23,
        2.00,
        4.50,
        1.86,
        3.00
      ],
      cleanSheet: [
        7.00,
        1.06,
        1.76,
        1.80
      ],
      drawNoBet: [
        5.00,
        1.07
      ],
      other: [
        15.00,
        12.00,
        3.40,
        2.00,
        5.00,
        8.00
      ],
      scoresTeam1: [
        null,
        null,
        null
      ],
      scoresTeam2: [
        null,
        null,
        null
      ],
      resultOneTimesTwo: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultOverUnder: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultBothTeamsToScore: [
        null,
        null
      ],
      resultOddEven: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultHalf: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultCleanSheet: [
        null,
        null,
        null,
        null
      ],
      resultDrawNoBet: [
        null,
        null
      ],
      resultOther: [
        null,
        null,
        null,
        null,
        null,
        null
      ]),
  Match(
      type: 'football',
      country: 'Germany',
      championship: 'Bundesliga',
      team1: 'Bayern',
      team2: 'Lazio',
      isPopular: true,
      status: 'pending',
      admin: '1',
      time: [
        '21',
        '15',
        'PM'
      ],
      date: [
        'Sun',
        '05',
        '10',
        '2020'
      ],
      timeAdded: [
        '08',
        '30',
        'PM'
      ],
      dateAdded: [
        'sat',
        '20',
        '09',
        '2020'
      ],
      oneTimesTwo: [
        3.50,
        2.69,
        1.43,
        1.24,
        4.36,
        10.00,
        1.24,
        3.69,
        5.20
      ],
      overUnder: [
        1.05,
        1.03,
        1.20,
        1.20,
        1.30,
        1.30,
        1.40,
        1.54,
        1.54,
        4.59,
        1.06,
        3.54
      ],
      bothTeamsToScore: [
        2.09,
        1.71
      ],
      oddEven: [
        1.87,
        1.89,
        1.24,
        1.71,
        1.36,
        1.45,
        1.65,
        1.98
      ],
      half: [
        3.12,
        2.00,
        3.50,
        3.29,
        1.18,
        4.27,
        1.23,
        2.00,
        4.50,
        1.86,
        3.00
      ],
      cleanSheet: [
        7.00,
        1.06,
        1.76,
        1.80
      ],
      drawNoBet: [
        5.00,
        1.07
      ],
      other: [
        15.00,
        12.00,
        3.40,
        2.00,
        5.00,
        8.00
      ],
      scoresTeam1: [
        null,
        null,
        null
      ],
      scoresTeam2: [
        null,
        null,
        null
      ],
      resultOneTimesTwo: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultOverUnder: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultBothTeamsToScore: [
        null,
        null
      ],
      resultOddEven: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultHalf: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultCleanSheet: [
        null,
        null,
        null,
        null
      ],
      resultDrawNoBet: [
        null,
        null
      ],
      resultOther: [
        null,
        null,
        null,
        null,
        null,
        null
      ]),
  Match(
      type: 'football',
      country: 'Spain',
      championship: 'La Liga',
      team1: 'Real Madrid',
      team2: 'Villareal',
      isPopular: false,
      status: 'pending',
      admin: '1',
      time: [
        '18',
        '00',
        'PM'
      ],
      date: [
        'Fri',
        '18',
        '11',
        '2020'
      ],
      timeAdded: [
        '08',
        '30',
        'PM'
      ],
      dateAdded: [
        'sat',
        '20',
        '09',
        '2020'
      ],
      oneTimesTwo: [
        3.50,
        2.69,
        1.43,
        1.24,
        4.36,
        10.00,
        1.24,
        3.69,
        5.20
      ],
      overUnder: [
        1.05,
        1.03,
        1.20,
        1.20,
        1.30,
        1.30,
        1.40,
        1.54,
        1.54,
        4.59,
        1.06,
        3.54
      ],
      bothTeamsToScore: [
        2.09,
        1.71
      ],
      oddEven: [
        1.87,
        1.89,
        1.24,
        1.71,
        1.36,
        1.45,
        1.65,
        1.98
      ],
      half: [
        3.12,
        2.00,
        3.50,
        3.29,
        1.18,
        4.27,
        1.23,
        2.00,
        4.50,
        1.86,
        3.00
      ],
      cleanSheet: [
        7.00,
        1.06,
        1.76,
        1.80
      ],
      drawNoBet: [
        5.00,
        1.07
      ],
      other: [
        15.00,
        12.00,
        3.40,
        2.00,
        5.00,
        8.00
      ],
      scoresTeam1: [
        null,
        null,
        null
      ],
      scoresTeam2: [
        null,
        null,
        null
      ],
      resultOneTimesTwo: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultOverUnder: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultBothTeamsToScore: [
        null,
        null
      ],
      resultOddEven: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultHalf: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null
      ],
      resultCleanSheet: [
        null,
        null,
        null,
        null
      ],
      resultDrawNoBet: [
        null,
        null
      ],
      resultOther: [
        null,
        null,
        null,
        null,
        null,
        null
      ]),
];
