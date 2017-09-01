const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

// Update Friends feed when user pick a place
exports.updateFriendsFeed = functions.database.ref('/picked_by_id/{uid}/{timestamp}').onWrite(event => {
  const friendsRef = admin.database().ref('/friends_by_id/').child(event.params.uid);
  return friendsRef.once('value').then( snapshot => {
    snapshot.forEach(function(child) {
      const feedsRef = admin.database().ref('/feeds_by_id/');
      return feedsRef.child(child.key).child(event.params.uid).child(event.params.timestamp).set(event.data.val()).then( () => {
        return feedsRef.child(child.key).child(event.params.uid).child('lastActive').set(event.params.timestamp);
      });
    });
  });
});
