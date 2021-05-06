import 'package:firebase/firestore.dart';

class Match {
  // TO AVOID LOADING UNWANTED CONTENT, WE WILL BE:
  // LOADING THE SELECTED MATCH BY TODAY DATE
  // THEN WILL BE LOADING ODDS BY GAME ID INDIVIDUALLY AND BY BOOKMAKER
  // DOING THIS, WE WILL AVOID LOADING TOO MUCH DATA THAT CRUSHES OUR SYSTEM

  // WE SHOULD HAVE TWO COLLECTIONS 1. MATCH DETAILS - 2. MATCH ODDS
  // IN THE MATCH DETAILS, WE HAVE TO ADD THE 3WAY POSSIBILITY SO THAT FETCHING WILL BE MUCH EASIER FOR USERS

  var id; // ID OF CURRENT MATCH
  var league_id; // ID OF THE LIGUE OF THIS MATCH
  var season_id; // ID OF THE SEASON
  var stage_id; // ID OF THE STAGE
  var round_id; // ID OF THE ROUND OF THIS LEAGUE

  var group_id; // ID OF THE GROUP OF THIS MATCH
  var aggregate_id; // THE ID OF AGGREGATE
  var venue_id; // THE VENUE ID
  var referee_id; // THE NAME OF THE REFREE
  var localteam_id; // THE ID OF THE LOCAL TEAM OR HOME TEAM
  var visitorteam_id; // ID OF VISITOR TEAM
  var winner_team_id; // ID OF WINNER

  var scores; // HOLD SCORES
  var time; // HOLD MATCH TIME AND STATUS
  var deleted; // INDICCATES IF A GAME HAS BEEN DELETED
  var localTeam; // LOCAL TEAM DETAILS
  var visitorTeam; // VISITOR TEAM DETAILS

  // THIS STATUS WILL BE USED TO HELP US REMOVE THE MATCHES ON TIME BEFORE THEY EVEN START
  String
      status; // PENDING, STARTED, STOP or END in our MAIN SYSTEM not from API

  // THIS WILL HOLD THE FIRST ODDS TO BE DISPLAYED TO INITIAL USER INTEFACE
  var threeWayOdds; // 1x2

  var searchKey = []; // WILL CONTAIN FIRST LETTERS OF EVERY MATCH

  // CONSTRUCTOR INTITIALIZATION OF MATCHES
  Match(
      {this.id,
      this.league_id,
      this.season_id,
      this.stage_id,
      this.round_id,
      this.group_id,
      this.aggregate_id,
      this.venue_id,
      this.referee_id,
      this.localteam_id,
      this.visitorteam_id,
      this.winner_team_id,
      this.scores,
      this.time,
      this.deleted,
      this.localTeam,
      this.visitorTeam,
      this.status,
      this.threeWayOdds,
      this.searchKey});

  factory Match.fromDatabase(var db) {
    return Match(
      id: db['id'],
      league_id: db['league_id'],
      season_id: db['season_id'],
      stage_id: db['stage_id'],
      round_id: db['round_id'],
      group_id: db['group_id'],
      aggregate_id: db['aggregate_id'],
      venue_id: db['venue_id'],
      referee_id: db['referee_id'],
      localteam_id: db['localteam_id'],
      visitorteam_id: db['visitorteam_id'],
      winner_team_id: db['winner_team_id'],
      scores: db['scores'],
      time: db['time'],
      deleted: db['deleted'],
      localTeam: db['localTeam'],
      visitorTeam: db['visitorTeam'],
      status: db['status'],
      threeWayOdds: db['threeWayOdds'],
      searchKey: db['searchKey'],
    );
  }
}
