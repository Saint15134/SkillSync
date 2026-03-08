import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

export const onNotificationCreated = functions.firestore
  .document('Notification/{id}')
  .onCreate(async (snap, context) => {
    try {
      const data = snap.data();
      if (!data) return;

      const userRef = data.user_id as admin.firestore.DocumentReference | undefined;
      const type = data.type as string | undefined;
      const referenceId = data.referenceId as string | undefined;

      if (!userRef) return;

      const userSnap = await userRef.get();
      if (!userSnap.exists) return;
      const userData = userSnap.data();
      const token = userData?.fcmToken as string | undefined;
      if (!token) return;

      const title = type === 'match' ? 'New Match! 🎉' : 'New Comment';
      const message: admin.messaging.Message = {
        token,
        notification: {
          title,
          body: 'Tap to view details',
        },
        data: {
          type: type ?? 'generic',
          referenceId: referenceId ?? '',
        },
      };

      await admin.messaging().send(message);
    } catch (e) {
      console.error('onNotificationCreated error', e);
    }
  });
