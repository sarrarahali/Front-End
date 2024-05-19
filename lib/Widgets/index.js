const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendOrderAcceptedNotification = functions.firestore
  .document('commandes/{orderId}')
  .onUpdate(async (change, context) => {
    const newValue = change.after.data();
    const previousValue = change.before.data();

    // Check if the order was just accepted
    if (previousValue.acceptedByUserId === null && newValue.acceptedByUserId !== null) {
      const userId = newValue.acceptedByUserId;
      const userDoc = await admin.firestore().collection('users').doc(userId).get();
      const fcmToken = userDoc.data().fcmToken;

      if (fcmToken) {
        const payload = {
          notification: {
            title: 'Order Accepted',
            body: `You have accepted the order ${context.params.orderId}.`,
          },
        };

        return admin.messaging().sendToDevice(fcmToken, payload)
          .then(response => {
            console.log('Successfully sent message:', response);
            return null;
          })
          .catch(error => {
            console.error('Error sending message:', error);
          });
      }
    }

    return null;
  });
