const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const database = admin.firestore();

exports.timerUpdate = functions.pubsub.schedule("* * * * *")
    .onRun((context) => {
      // UPDATE THE TIMER EVERY 1 MINUTE
      database.doc("timer/timer").update({
        "timestamp": admin.firestore.Timestamp.now(),
      }).catch((e) => console.log("The error is: " + e)
      );
      //   return console.log("Timer update success");
      return null;
    });
