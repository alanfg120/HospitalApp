var admin = require("firebase-admin");
var serviceAccount = require("./../hospitalapp-5be6d-firebase-adminsdk-teryv-bb6b2ed53a.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

async function FMC(title, body, token) {
  let message = {
    data: {
      click_action: "FLUTTER_NOTIFICATION_CLICK",
    },
    notification: {
      title,
      body,
    },
    android: {
      notification: {
        sound: "default",
      },
    },
    token,
  };
  try {
    await admin.messaging().send(message);
  } catch (err) {
    console.log(err);
  }
}



module.exports = FMC;
