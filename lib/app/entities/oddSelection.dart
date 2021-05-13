class OddsArray {
  var gameID; // ID OF CURRENT MATCH
  var oddName; // NAME OF CURRENT ODD
  var oddID; // ID OF ODD CONCERNED
  var oddIndex; // ID OF THE INDEX
  var oddValue; // VALUE OF ODD
  var oddLabel; // VALUE OF THE LABEL

  // CONSTRUCTOR INTITIALIZATION OF SELECTIONS
  OddsArray(
      {this.gameID, this.oddName, this.oddID, this.oddIndex, this.oddLabel, this.oddValue});

  factory OddsArray.fromDatabase(var db) {
    return OddsArray(
      // WE SHOULD ADD ALL DETAILS NEEDED FOR A BETSLIP TICKET HERE
      // WE ONLY ADD THE GAME ID SINCE OTHER DATA WILL BE CHANGING
      gameID: db.id,
      oddID: null,
      oddName: null,
      oddIndex: null,
      oddLabel: null,
      oddValue: null,
    );
  }
}
