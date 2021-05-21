import 'package:skiiyabet/app/skiiyaBet.dart';
import 'package:skiiyabet/components/bonus.dart';
import 'package:skiiyabet/components/price.dart';
import 'package:skiiyabet/components/selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Method {
  // GET THE POURCENTAGE VALUE OF THE
  static int pourcentageRate = 0;

  static String displayUserBonus() {
    // COUNT THE MATCHES ON THE TICKET
    int counter = 0;
    // WE LOOP THROUGH THE GAMES ODDS ARRAY TO GET SELECTED GAMES
    for (int _i = 0; _i < oddsGameArray.length; _i++) {
      // CHECK GAME AFTER GAME
      if (oddsGameArray[_i].oddID != null &&
          oddsGameArray[_i].oddName != null &&
          oddsGameArray[_i].oddIndex != null &&
          oddsGameArray[_i].oddLabel != null &&
          oddsGameArray[_i].oddValue != null) {
        // INSCREASE THE COUNTER + 1 OR REDUCE IT ACCORDINGLY
        counter++;
      }
    }
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
          'S\'IL VOUS PLAÎT! \nAjoutez $len selection(s) de plus et recevez ${Bonus.bonus1}% en bonus.';
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

  // ADD THE RATES OF ALL SELECTED ODDS
  static double totalRate() {
    double totalRate = 0;
    // WE LOOP THROUGH THE ODDS GAME ARRAY
    for (int i = 0; i < oddsGameArray.length; i++) {
      // CHECK THE CONDITION BEFORE SUMMING UP
      if (oddsGameArray[i].oddValue != null) {
        // WE ADD THE NON NULL RATE TO THE VARIABLE
        totalRate += double.parse(oddsGameArray[i].oddValue);
      }
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
    // WE GET THE AMOUNT TO BE WON AS BONUS
    return possibleWinning() * (pourcentageRate / 100);
  }

  static double totalPayout() {
    // WE GET THE TOTAL PAYOUT FOR THE CURRENT TICKET
    double result = possibleWinning() + bonusAmount();
    if (result >= Price.maxWinning) {
      result = Price.maxWinning;
    }
    return result;
  }

  static String _getTime() {
    // GET CURRENT TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // GET MINUTE IN A CUSTOM FORMAT
    String _minute = _formatOf10(_datetime.minute);
    // GET HOUR IN A CUSTOM FORMAT
    String _hour = _formatOf10(_datetime.hour);
    // GET SECOND IN A CUSTOM FORMAT
    String _second = _formatOf10(_datetime.second);
    // RETURN A STRING IN TIME FORMAT
    return _hour + ':' + _minute + ':' + _second;
  }

  static String _getDate() {
    // GET CURRENT TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    // WE GET THE DAY
    String _day = _formatOf10(_datetime.day);
    // WE GET THE MONTH
    String _month = _formatOf10(_datetime.month);
    // WE GET THE YEAR
    String _year = _datetime.year.toString();
    // RETURN A STRING IN DATE FORMAT
    return _day + '-' + _month + '-' + _year;
  }

  static Future addNewTicket(
      String _transID, double _stake, var _oddsDataArray) {
    // WE GET THE USER ID
    String _uid = Selection.user.uid;

    // GET THE CURRENT TIME HERE
    var _datetime = new DateTime.now().toUtc();
    // print(_date_time);
    int _timestamp = _datetime.toUtc().millisecondsSinceEpoch;

    // WE GET THE CUSTOM DATE HERE
    String _date = _getDate();
    // WE GET THE CUSTOM TIME HERE
    var _time = _getTime();

    // LET US FIRST OF ALL COUNT ALL SELECTED GAMES
    int _numberOfGames = 0;
    // int _numberOfGames = _getTotalTicketLegs(_oddsDataArray);
    // LET US CREATE A RESIDUAL ARRAY THAT WILL HOLD ONLY SELECTED GAMES
    var _selectedGames = [];

    for (int _i = 0; _i < _oddsDataArray.length; _i++) {
      // CHECK GAME AFTER GAME
      if (_oddsDataArray[_i].oddID != null &&
          _oddsDataArray[_i].oddName != null &&
          _oddsDataArray[_i].oddIndex != null &&
          _oddsDataArray[_i].oddLabel != null &&
          _oddsDataArray[_i].oddValue != null) {
        // INCREASE THE GAME COUNTER OF MATCHES
        _numberOfGames++;
        // ADD THE CURRENT GAME INTO THE RESIDUAL ARRAY
        // WE WILL ADD ONLY SELECTED GAMES IN THIS ARRAY
        _selectedGames.add(_oddsDataArray[_i]);
      }
    }

    // ARRAYS CONTAINING DATA OF GAMES ON THE TICKET
    var _gameIDs = []; // GAME IDS
    var _oddIDs = []; // ODD IDS
    var _oddNames = []; // ODD NAMES
    var _oddIndexes = []; // ODDS INDEXES
    var _oddLabels = []; // ODDS LABELS
    var _oddValues = []; // CONTAINS DATA VALUES
    var _oddTotals = []; // CONTAINS GAME OPTIONS TOTALS
    var _oddHandicaps = []; // CONTAINS GAME OPTIONS HANDICAPS
    var _localTeams = []; // LOCAL TEAM NAMES
    var _visitorTeams = []; // VISITOR TEAM NAMES
    var _teamLeagues = []; // LEAGUES OR CHAMPIONSHIPS
    var _teamCountries = []; // COUNTRIES OF EACH GAME
    var _dataTimes = []; // TIMES OF ALL GAMES
    var _teamScores = []; // SCORES OF ALL TEAMS
    var _teamResults = []; // RESULTS OF ALL TEAMS

    // LET US ADD VALUES TO ALL ARRAYS
    for (int _j = 0; _j < _selectedGames.length; _j++) {
      // ARRAYS CONTAINING DATA OF GAMES ON THE TICKET
      _gameIDs.add(_selectedGames[_j].gameID); // GAME IDS ON THE TICKET
      _oddIDs.add(_selectedGames[_j].oddID); // ODD IDS
      _oddNames.add(_selectedGames[_j].oddName); // ODD NAMES
      _oddIndexes.add(_selectedGames[_j].oddIndex); // ODDS INDEXES
      _oddLabels.add(_selectedGames[_j].oddLabel); // ODDS LABELS
      _oddValues.add(_selectedGames[_j].oddValue); // CONTAINS DATA VALUES
      _oddTotals.add(_selectedGames[_j].total); // CONTAINS GAME OPTIONS TOTALS
      // CONTAINS GAME OPTIONS HANDICAPS
      _oddHandicaps.add(_selectedGames[_j].handicap);
      _localTeams.add(_selectedGames[_j].localTeam); // LOCAL TEAM NAMES
      _visitorTeams.add(_selectedGames[_j].visitorTeam); // VISITOR TEAM NAMES
      // LEAGUES OR CHAMPIONSHIPS
      _teamLeagues.add(_selectedGames[_j].championship);
      _teamCountries.add(_selectedGames[_j].country); // COUNTRIES OF EACH GAME
      _dataTimes.add(_selectedGames[_j].dataTime); // TIMES OF ALL GAMES
      _teamScores.add(null); // SCORES OF ALL TEAMS
      _teamResults.add(null); // RESULTS OF ALL TEAMS
    }

    // print(_gameIDs);
    // print(_oddIDs);
    // print(_oddNames);
    // print(_oddIndexes);
    // print(_oddLabels);
    // print(_oddValues);
    // print(_oddTotals);
    // print(_oddHandicaps);
    // print(_localTeams);
    // print(_visitorTeams);
    // print(_teamLeagues);
    // print(_teamCountries);
    // print(_dataTimes);
    // print(_teamScores);
    // print(_teamResults);

    // print('THE LENGTH IS: $_numberOfGames');
    // print('SELECTED GAMES ARE: ${_selectedGames.length}');

    // TO BE CONTINUED

    return Firestore.instance.collection('betslip').add(
      {
        'uid': _uid,
        'status': 'pending',
        'trans_id': _transID,
        'rewards': {
          'currency': Price.currency_symbol,
          'number_of_games': _numberOfGames,
          'stake': _stake,
          'odds': totalRate(),
          'bonus': bonusAmount(),
          'winning': possibleWinning(),
          'payout': totalPayout(),
        },
        'time': { 
          'date_time': '$_datetime',
          'time': '$_time',
          'date': '$_date',
          'timestamp': _timestamp,
          'timezone': 'UTC'
        },
        'matches': {
          'gameIDs': _gameIDs, // GAME IDS
          'oddIDs': _oddIDs, // ODD IDS
          'oddNames': _oddNames, // ODD NAMES
          'oddIndexes': _oddIndexes, // ODDS INDEXES
          'oddLabels': _oddLabels, // ODDS LABELS
          'oddValues': _oddValues, // CONTAINS DATA VALUES
          'oddTotals': _oddTotals, // CONTAINS GAME OPTIONS TOTALS
          'oddHandicaps': _oddHandicaps, // CONTAINS GAME OPTIONS HANDICAPS
          'localTeams': _localTeams, // LOCAL TEAM NAMES
          'visitorTeams': _visitorTeams, // VISITOR TEAM NAMES
          'teamLeagues': _teamLeagues, // LEAGUES OR CHAMPIONSHIPS
          'teamCountries': _teamCountries, // COUNTRIES OF EACH GAME
          'dataTimes': _dataTimes, // TIMES OF ALL GAMES
          'teamScores': _teamScores, // SCORES OF ALL TEAMS
          'teamResults': _teamResults, // RESULTS OF ALL TEAMS
        },
      },
    );
  }

  static Future updateUserBalance(String _transID) {
    // WE GET THE USER ID FIRST
    String _uid = Selection.user.uid;
    // print('Transaction ID in balance Update');
    // print(_transID);
    // print('==================================');
    // WE UPDATE THE BALANCE NEGATIVELY WITH THE STAKE VALUE
    // THEN WE CONTINUE WITH THE PROCESS
    return Firestore.instance
        .collection('UserBalance')
        .document(_uid)
        .updateData(
      {
        'balance': FieldValue.increment(-Price.stake),
        'transaction_id': '$_transID',
      },
    );
  }

  static String _formatOf10(int _newVal) {
    // WE CREATE AN EMPTY VALUE
    String _val = _newVal.toString();
    // IF THE VALUE IS LESS THAN 10 ADD A ZERO BEFORE
    // OTHERWISE DO NOT ADD ANYTHING BEFORE THE VALUE
    if (_newVal < 10) _val = '0' + _newVal.toString();
    // RETURN THE MODIFIED VALUE
    return _val;
  }

  static Future addNewTransaction(String _type, double _amount, String _actionSign) {
    // WE GET THE USER ID
    String _uid = Selection.user.uid;
    // print('Transaction details');
    // print(_type);
    // print(_amount);
    // print('-----------------------------------');
    // GET THE CURRENT DATE TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // STORE THE TIMESTAMP
    int _timestamp = _datetime.toUtc().millisecondsSinceEpoch;

    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    String _date = _getDate();
    // WE GET THE CUSTOM TIME HERE
    var _time = _getTime();

    // ADDING THE RECORDS TO THE COLLECTION OF TRANSACTIONS
    return Firestore.instance.collection('Transactions').add({
      'uid': _uid,
      'amount': _amount,
      'type': _type,
      'action_sign': _actionSign,
      'currency': Price.currency_symbol,
      'time': {
        'time': '$_time',
        'date': '$_date',  
        'date_time': '$_datetime',
        'timestamp': _timestamp,
        'timezone': 'UTC'
      },
    });
  }
}
