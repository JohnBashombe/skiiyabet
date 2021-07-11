import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skiiyabet/app/entities/match.dart';

class FetchMatch {
  Future fetchMatchDetails(int _limit) async {
    // Match Instance
    var matches = [];
    // SELECT MATCH DETAILS AND PENDING MATCH ONLY
    await Firestore.instance
        .collection('football') 
        .where('status', isEqualTo: 'NS')
        .orderBy('time.starting_at.date_time', descending: false)
        .limit(_limit)
        .getDocuments()
        .then((_matchResult) {
      // LOOP THROUGH THE DATA TO ADD MATCH INSTANCES
      for (int _data = 0; _data < _matchResult.documents.length; _data++) {
        // CONVERTING FETCHED DATA AND STORE THEM IN THE ARRAY
        matches.add(Match.fromDatabase(_matchResult.documents[_data]));
      }
    });
    return matches;
  }

  Future fetchMatchDetailsByLeague(int limit, int leagueID) async {
    // ignore: deprecated_member_use
    var matches = List<Match>(); // Match Instance
    // SELECT MATCH DETAILS AND PENDING MATCH ONLY
    await Firestore.instance
        .collection('football')
        .where('league_id', isEqualTo: leagueID)
        .where('status', isEqualTo: 'NS')
        .orderBy('time.starting_at.date_time', descending: false)
        .limit(limit)
        .getDocuments()
        .then((value) {
      // LOOP THROUGH THE DATA TO ADD MATCH INSTANCES
      for (int _data = 0; _data < value.documents.length; _data++) {
        // CONVERT THE RESULT INTO MATCH OBJECT HERE
        matches.add(Match.fromDatabase(value.documents[_data]));
      }
    });
    return matches;
  }

  // LOAD COUNTRIES INDIVIDUALLY
  Future fetchCountries() async {
    // Countries Instance
    var country = [];
    // SELECT ALL COUNTRIES
    await Firestore.instance
        .collection('countries')
        .getDocuments()
        .then((value) {
      country.addAll(value.documents);
    }).catchError((e) {
      // print('Country error $e');
    });
    return country;
  }

  // FETCH CHAMPIONSHIPS
  Future fetchLeagues() async {
    // League Instance
    var leagues = [];
    // SELECT MATCH DETAILS AND PENDING MATCH ONLY
    await Firestore.instance.collection('leagues').getDocuments().then((value) {
      leagues.addAll(value.documents);
    }).catchError((e) {
      // print('league error : ${e.toString()}');
    });
    // Return only the first items given that we have only one item
    return leagues;
  }

  // FETCH GAME FULL ODDS
  Future fetchAllGameOdds(String id) async {
    // League Instance
    DocumentSnapshot odds;
    // SELECT MATCH DETAILS AND PENDING MATCH ONLY
    await Firestore.instance
        .collection('odds')
        .document(id)
        .get()
        .then((value) {
      // Printing all data fetched
      // print(value);
      // SET THE FETCHED VALUE TO THE VARIABLE
      odds = value;
    }).catchError((e) {
      // print('odds error : ${e.toString()}');
    });
    // Return only the first items given that we have only one item
    return odds;
  }
}
