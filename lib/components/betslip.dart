import 'package:skiiyabet/components/price.dart';

class BetSlipData {
  double stake = Price.stake; // to be sent on server
  static List<String> team1s = [];
  static List<String> team2s = [];
  static List<String> oddTypes = [];
  static List<String> gameChoices = []; // to be sent on server
  static List<double> rates = [];
  // to be sent on server: all calculations will be made from there
  static List<String> gameIds = [];
  // create and stores betslip prices
  // double totalRate;
  // double possibleWinning;
  // double winBonus;
  // double totalPayout;
}
