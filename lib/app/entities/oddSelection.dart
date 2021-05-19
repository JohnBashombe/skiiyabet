class OddsArray {
  var gameID; // ID OF CURRENT MATCH
  var oddName; // NAME OF CURRENT ODD
  var oddID; // ID OF ODD CONCERNED
  var oddIndex; // ID OF THE INDEX
  var oddValue; // VALUE OF ODD
  var oddLabel; // VALUE OF THE LABEL
  var total; // STORE THE TOTAL VALUE IF NOT NULL
  var handicap; // STORE THE HANDICAP VALUE IF NOT NULL
  var localTeam; // STORE THE NAME OF THE LOCAL TEAM
  var visitorTeam; // STORE THE NAME OF THE VISITOR TEAM
  var championship; // STORE THE CHAMPIONSHIP OF THE GAME
  var country; // STORE THE COUNTRY OF THE GAME
  bool hasExpired; // INDICATES WEITHER THIS GAME HAS EXPIRED OF NOT
  var dataTime; // GET THE TIME PROPERTY OF THE GAME

  // CONSTRUCTOR INTITIALIZATION OF SELECTIONS
  OddsArray({
    this.gameID,
    this.oddName,
    this.oddID,
    this.oddIndex,
    this.oddLabel,
    this.oddValue,
    this.total,
    this.handicap,
    this.localTeam,
    this.visitorTeam,
    this.championship,
    this.country,
    this.hasExpired,
    this.dataTime,
  });

  factory OddsArray.fromDatabase(var db) {
    // WE SHOULD ADD ALL DETAILS NEEDED FOR A BETSLIP TICKET HERE
    // WE ONLY ADD THE GAME ID SINCE OTHER DATA WILL BE CHANGING
    return OddsArray(
      gameID: db.id,
      oddID: null,
      oddName: null,
      oddIndex: null,
      oddLabel: null,
      oddValue: null,
      total: null,
      handicap: null,
      localTeam: null,
      visitorTeam: null,
      championship: null,
      country: null,
      hasExpired: false,
      dataTime: null,
    );
  }
}
