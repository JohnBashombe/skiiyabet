import 'package:skiiyabet/database/betslip.dart';
import 'package:skiiyabet/database/bonus.dart';
// import 'package:skiiyabet/database/game.dart';
import 'package:skiiyabet/database/price.dart';
import 'package:skiiyabet/database/selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Method {
  static int pourcentageRate = 0;
  static String transactionID;

  static showUserBettingStake() {
    return Container(
      // padding: EdgeInsets.all(10.0),
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(
            top: BorderSide(color: Colors.lightGreen[400], width: 2.0),
            bottom: BorderSide(color: Colors.lightGreen[400], width: 2.0),
            left: BorderSide(color: Colors.lightGreen[400], width: 2.0),
            right: BorderSide(color: Colors.lightGreen[400], width: 2.0),
          )),
      child: Text(
        // Price.stake.toString(),
        Price.getCommaValue(Price.stake),
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  static String displayUserBonus() {
    int counter = BetSlipData.gameIds.length;
    // print('This is counter: $counter');
    // print('This is bonus rate: $pourcentageRate');
    // int counter = 20;
    pourcentageRate = 0;
    String bonus = '';
    if (counter == 0) {
      bonus =
          'S\'IL VOUS PLAÎT! \nAjoutez au moins un match sur le ticket pour voir le bonus à gagner.';
    } else if ((counter > 0) && (counter <= 3)) {
      int len = 4 - counter;
      // pourcentageRate = Bonus.bonus1;
      bonus =
          'S\'IL VOUS PLAÎT! \nAjoutez $len selection(s) de plus et recevez plutôt ${Bonus.bonus1}% en bonus.';
    } else if (counter == 4) {
      int len = 5 - counter;
      pourcentageRate = Bonus.bonus1;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus1}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus2}% de bonus';
    } else if (counter == 5) {
      int len = 6 - counter;
      pourcentageRate = Bonus.bonus2;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus2}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus3}% de bonus';
    } else if (counter == 6) {
      int len = 7 - counter;
      pourcentageRate = Bonus.bonus3;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus3}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus4}% de bonus';
    } else if (counter == 7) {
      int len = 8 - counter;
      pourcentageRate = Bonus.bonus4;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus4}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus5}% de bonus';
    } else if (counter == 8) {
      int len = 9 - counter;
      pourcentageRate = Bonus.bonus5;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus5}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus6}% de bonus';
    } else if (counter == 9) {
      int len = 10 - counter;
      pourcentageRate = Bonus.bonus6;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus6}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus7}% de bonus';
    } else if (counter == 10) {
      int len = 11 - counter;
      pourcentageRate = Bonus.bonus7;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus7}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus8}% de bonus';
    } else if (counter == 11) {
      int len = 12 - counter;
      pourcentageRate = Bonus.bonus8;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus8}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus9}% de bonus';
    } else if (counter == 12) {
      int len = 13 - counter;
      pourcentageRate = Bonus.bonus9;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus9}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus10}% de bonus';
    } else if (counter == 13) {
      int len = 14 - counter;
      pourcentageRate = Bonus.bonus10;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus10}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus11}% de bonus';
    } else if (counter == 14) {
      int len = 15 - counter;
      pourcentageRate = Bonus.bonus11;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus11}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus12}% de bonus';
    } else if (counter == 15) {
      int len = 16 - counter;
      pourcentageRate = Bonus.bonus12;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus12}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus13}% de bonus';
    } else if (counter == 16) {
      int len = 17 - counter;
      pourcentageRate = Bonus.bonus13;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus13}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus14}% de bonus';
    } else if (counter == 17) {
      int len = 18 - counter;
      pourcentageRate = Bonus.bonus14;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus14}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus15}% de bonus';
    } else if (counter == 18) {
      int len = 19 - counter;
      pourcentageRate = Bonus.bonus15;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus15}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus16}% de bonus';
    } else if (counter == 19) {
      int len = 20 - counter;
      pourcentageRate = Bonus.bonus16;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus16}% en bonus.\nAjoutez $len de plus et recevez plutôt ${Bonus.bonus17}% de bonus';
    } else if (counter >= 20) {
      pourcentageRate = Bonus.bonus17;
      bonus =
          'FÉLICITATIONS! \n$counter selections valent ${Bonus.bonus17}% en bonus.';
    }
    return bonus;
  }

  static double totalRate() {
    double totalRate = 0;
    for (int i = 0; i < BetSlipData.gameIds.length; i++) {
      totalRate += BetSlipData.rates[i];
    }
    return totalRate;
  }

  static double possibleWinning() {
    // print(totalRate());
    // print(Price.stake);
    double result = 0.0;
    result = (totalRate().toDouble() * Price.stake.floor()).round().toDouble();
    if (result >= Price.maxWinning) {
      result = Price.maxWinning;
    }
    // print(result);
    return result;
  }

  static double bonusAmount() {
    return possibleWinning() * (pourcentageRate / 100);
  }

  static double totalPayout() {
    double result = possibleWinning() + bonusAmount();
    if (result >= Price.maxWinning) {
      result = Price.maxWinning;
    }
    return result;
  }

  static Future addBetslipToRecords() {
    // variables declaration
    var date = new DateTime.now();
    String min = date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString();
    String hour =
        date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString();

    int indicRef = date.hour;
    String timeIndicator = '';
    if (indicRef < 12)
      timeIndicator = 'AM';
    else
      timeIndicator = 'PM';

    String day =
        date.day < 10 ? '0' + date.day.toString() : date.day.toString();
    String month =
        date.month < 10 ? '0' + date.month.toString() : date.month.toString();
    String year =
        date.year < 10 ? '0' + date.year.toString() : date.year.toString();
    int today = date.weekday;
    String weekday = '';

    if (today == 1) weekday = 'Lun';
    if (today == 2) weekday = 'Mar';
    if (today == 3) weekday = 'Mer';
    if (today == 4) weekday = 'Jeu';
    if (today == 5) weekday = 'Ven';
    if (today == 6) weekday = 'Sam';
    if (today == 7) weekday = 'Dim';
    // this variable array hold the amount of games are in ids and contains results
    var betResults = [];
    var betScoreTeam1 = [];
    var betScoreTeam2 = [];
    // set defaults values of results to null then results will be added later
    for (int i = 0; i < BetSlipData.gameIds.length; i++) {
      betResults.add(null);
      betScoreTeam1.add(null);
      betScoreTeam2.add(null);
    }
    // print(BetSlipData.gameIds);
    // print(BetSlipData.team1s);
    // print(BetSlipData.team2s);
    // print(BetSlipData.rates);
    // print(BetSlipData.oddTypes);
    // print(BetSlipData.gameChoices);
    // print('the user id is: $id');
    // return null;
    return Firestore.instance.collection('BetSlip').add(
      {
        'uid': Selection.user.uid,
        'gameIDs': BetSlipData.gameIds,
        'gameChoices': BetSlipData.gameChoices,
        // maybe we should add championship array and type so that in my bets there will be no need of loading games ever again
        // 'gameTeam1s': BetSlipData.team1s,
        // 'gameTeam2s': BetSlipData.team2s,
        // 'gameChampionships': BetSlipData.championships,
        // 'gameTypes': BetSlipData.gameTypes,
        'gameRates': BetSlipData.rates,
        'gameScoreTeam1': betScoreTeam1,
        'gameScoreTeam2': betScoreTeam2,
        'gameResults': betResults,
        'stake': Price.stake,
        'totalRate': totalRate(),
        'bonusAmount': bonusAmount(),
        'possibleWinning': possibleWinning(),
        'totalPayout': totalPayout(),
        'time': [hour.toString(), min.toString(), timeIndicator.toString()],
        'date': [
          weekday.toString(),
          day.toString(),
          month.toString(),
          year.toString()
        ],
        'status': 'pending', // pending or completed
        'result': 'pending', // won or lost
        'transactionID': transactionID, // save the transaction associated to it
        'sorter': day.toString() +
            month.toString() +
            year.toString() +
            hour.toString() +
            min.toString(),
        'timeAdded': new DateTime.now(),
      },
    );
  }

  static Future updateUserBalance() {
    // update the user balance before placing the games
    return Firestore.instance
        .collection('UserBalance')
        .document(Selection.user.uid)
        .updateData({'balance': FieldValue.increment(-Price.stake)});
    // .updateData({'balance': FieldValue.increment(0)});
    //     .then((value) {
    //   print('user balance updated successfully with minus $amount');
    // }).catchError((e) {
    //   print('error while updating balance : $e');
    // });
    // return null;
  }

  static Future addTransactionRecords(String type, String uid, double amount) {
    // variables declaration
    var date = new DateTime.now();
    String min = date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString();
    String hour =
        date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString();

    int indicRef = date.hour;
    String timeIndicator = '';
    if (indicRef < 12)
      timeIndicator = 'AM';
    else
      timeIndicator = 'PM';

    String day =
        date.day < 10 ? '0' + date.day.toString() : date.day.toString();
    String month =
        date.month < 10 ? '0' + date.month.toString() : date.month.toString();
    String year =
        date.year < 10 ? '0' + date.year.toString() : date.year.toString();
    int today = date.weekday;

    String weekday = '';
    if (today == 1) weekday = 'Lun';
    if (today == 2) weekday = 'Mar';
    if (today == 3) weekday = 'Mer';
    if (today == 4) weekday = 'Jeu';
    if (today == 5) weekday = 'Ven';
    if (today == 6) weekday = 'Sam';
    if (today == 7) weekday = 'Dim';
    // inserting that transaction into the transaction history
    return Firestore.instance.collection('Transactions').add({
      'uid': uid,
      'amount': amount,
      'type': type,
      'time': [hour, min, timeIndicator],
      'date': [weekday, day, month, year],
      'sorter': day.toString() +
          month.toString() +
          year.toString() +
          hour.toString() +
          min.toString(),
    }).then((value) {
      // save the transaction ID for it to be used in the betslip
      transactionID = value.documentID;
    });
    // print('user transaction added successfully');
    // print('the user id is: $id');
    // return null;
  }
}
