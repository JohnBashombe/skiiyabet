class Price {
  static double minimumBetPrice = 100;
  static double stake = 0; // minimum betting stake
  static double maxStake = 1000000; // maximum betting stake
  static double maxWinning = 15000000; // maximum winning amount
  // static double balance = 50000;
  static double jackpotMinimumBet = 100;
  static double jackpotWinningAmount = 10000000;
  static double minimumWithdraw = 2500;
  static double maximumWithdraw = 1000000;
  static double maximumDailyWithdraw = 2000000;
  static double minimumDeposit = 1500;
  static double maximumDeposit = 2500000;
  // that's the maximum games a user can place
  static double maxGames = 10;

  static String getCommaValue(double thisRate) {
    int rate = thisRate.floor();
    String data = rate.toString();
    String output = '';
    var array = data.split('');
    int counter = 0;

    // print(data.split(''));
    int len = data.length;
    if (len > 3) {
      for (var i = (array.length - 1); i >= 0; i--) {
        if (counter == 3) {
          output += 'x' + array[i];
          counter = 1;
        } else {
          output += array[i];
          counter++;
        }
      }
      array = [];
      array = output.split('');

      output = '';
      for (var i = (array.length - 1); i >= 0; i--) {
        if (array[i].toString().compareTo('x') == 0) {
          output += ',';
        } else {
          output += array[i];
        }
      }
    } else {
      output = data;
    }

    return output;
  }

  static String getWinningValues(double thisRate) {
    // convert it to string with 2 decimals values to take it back to double
    // get the decimal part of the nuber if exist
    double decimal = thisRate - thisRate.floor();
    int rate = thisRate.floor();
    String data = rate.toString();
    String output = '';
    var array = data.split('');
    int counter = 0;

    int len = data.length;
    if (len > 3) {
      for (var i = (array.length - 1); i >= 0; i--) {
        // detect 3 items then add a comma
        if (counter == 3) {
          output += 'x' + array[i];
          counter = 1;
        } else {
          // other wise do not add anything
          output += array[i];
          counter++;
        }
      }
      array = [];
      array = output.split('');
      output = '';
      // add the inverse of that array to get the right position
      for (var i = (array.length - 1); i >= 0; i--) {
        if (array[i].toString().compareTo('x') == 0) {
          output += ',';
        } else {
          output += array[i];
        }
      }
    } else {
      output = data;
    }
    String myDecimal = decimal
        .toString()
        .replaceFirst(new RegExp(r'0'), '') // remove the first 0 of the double
        .replaceFirst(new RegExp(r'.'), ''); // remove the dot of the double
    return (output + '.' + getDecimal(myDecimal));
  }

  static String getDecimal(String data) {
    String result = '';
    // put data string into the array
    var array = data.split('');
    if (data.length > 0) {
      for (var i = 0; i < array.length; i++) {
        result += array[i];
        if (i == 1)
          break; // break if two elements have been added to the string
      }
    } else {
      result = '00'; // default decimal values
    }
    // if the result has only one number at the deciaml part
    // then we add another zero for the design
    if (result.length == 1) {
      result += '0';
    }
    return result;
  }
}
