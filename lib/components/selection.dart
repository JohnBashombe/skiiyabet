import 'package:firebase_auth/firebase_auth.dart';

class Selection {
  // store the current logged in user
  static FirebaseUser user;
  // store the current Signed In user phone
  static String userTelephone = '';
  // STORE THE RESET PHONE NUMBER IN USE
  static String resetPhone = '';
  // store the current Signed In user balance
  static double userBalance = 0.0;
  // BOTTOM NAVIGATION TAB HANDLER
  static int bottomCurrentTab = 0;
  // max search limit
  static int loadLimit = 20;
  // THE MINIMUM MATCHES ON THE USER LIST
  static int minimumMatchesCount = 20;
  // USE TO SHOW IF WE HAVE A PASSWORD CHANGE EVENT TO SHOW A CONTAINER MESSAGE
  static bool isPasswordChanged = false;
  // the bool that display the reset SMS Code link to client
  static bool showResendSMS = false;
  // WILL SHOW ONLY IF WE HAVE A PENDING REQUEST
  static bool showResendSMSinForgot = true;
  // CHECK IF THE USER IS BLOCKED
  static bool isUserBlocked = false;
  // WILL ALLOW THE USER TO RESET THE PASSWORD OR WAIT FOR FEW MINUTES
  static bool allowSMSReset = true;
  // THIS STORE THE LOCAL TIME OFFLINE TO KEEP TRACK OF GAME EXPIRATION TIME
  static  DateTime offlineTracker;
}
