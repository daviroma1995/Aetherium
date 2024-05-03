const functions = require("firebase-functions");
const admin = require("firebase-admin");

const { getFirestore } = require("firebase-admin/firestore");


admin.initializeApp();
exports.sendNotification = functions.firestore
  .document("notifications/{docId}")
  .onCreate(async (snap, context) => {
    const data = snap.data();
    const notificationContent = {
      notification: {
        title: data.title,
        body: data.body,
      },
      data: {
        id: JSON.stringify(data.id),
        title: data.title,
        body: data.body,
        senderImage: JSON.stringify(data.senderImage),
        senderId: JSON.stringify(data.senderId),
        type: JSON.stringify(data.type),
        appointmentId: data.appointmentId,
      },
      apns: {
        payload: {
          aps: {
            "alert": {
              title: data.title,
              body: data.body,
            },

            sound: "default",

          },
        },
      },
      topic: data.receiverId,
    };
    await admin.messaging().send(notificationContent);
  });

exports.sendNewNotifications = functions.firestore
  .document("new_notification/{docId}")
  .onCreate(async (snap, context) => {
    const data = snap.data();
    const notificationContents = [];
    console.log("data :::: " + data);
    data.receiverId.forEach((receiverId) => {
      notificationContents.push(
        {
          notification: {
            title: data.title,
            body: data.body,
          },
          data: {
            id: data.id == undefined ? "" : JSON.stringify(data.id),
            title: data.title,
            body: data.body,
            senderId: data.senderid == undefined ? "" :
              JSON.stringify(data.senderId),
            type: data.type == undefined ? "" :
              JSON.stringify(data.type),
            appointmentId: data.appointmentId == undefined ? "" :
              data.appointmentId,
          },
          apns: {
            payload: {
              aps: {
                "alert": {
                  title: data.title,
                  body: data.body,
                },
                "sound": "default",
              },
            },
          },
          topic: receiverId,
        },
      );
    });

    await admin.messaging().sendEach(notificationContents);
  });

exports.createNotification = functions.https.onRequest(async (req, res) => {
  const { title, body, receiverIds } = req.body;
  let receiverId;
  let statusIds = [];
  try {
    if (receiverIds.length == 0) {
      res.json({ "error": "receiver ids list is required" });
      return;
    }
    if (receiverIds.length === 1) {
      receiverId = receiverIds[0];
      try {
        const documentReferences = await admin.firestore()
          .collection("clients")
          .where("isAdmin", "==", receiverId === "admin")
          .get();
        const response = documentReferences.docs;
        response.forEach((res) => {
          statusIds.push(res.id);
        });
      } catch (error) {
        console.error("Error querying Firestore:", error);
        // Handle the error appropriately
      }
    } else {
      statusIds = receiverIds;
    }

    const ref = getFirestore().collection("new_notification").doc();
    await ref.set({
      title: title,
      body: body,
      receiverId: receiverIds,
      createdAt: new Date(),
      desc: body,
      id: ref.id,
      status: statusIds,
      client_id: receiverIds,
    });
    res.json({ "receiverIds": receiverIds, "status": "Success" });
  } catch (ex) {
    console.log(ex);
    res.json({ "status": "Failure" });
  }
});
>>>>>>> a7b79b91bb16a5abae7fea901dc01f535a0ebb5e

exports.createUserwithEmail = functions.https.onRequest(async (req, res) => {
  const { email, password } = req.body;
  try {
    const userData = await admin.auth().createUser({
      email,
      password,
    });
    res.status(200).send(userData);
  } catch (err) {
    const errorCode = err.code;
    if (errorCode == "auth/email-already-in-use") {
      res.status(500).send(err);
    }
    res.status(500).send(err);
  }
});

exports.deleteUser = functions.https.onRequest(async (req, res) => {
  const { uid } = req.body;
  console.log(uid);
  try {
    const user = await admin.auth().deleteUser(uid);
    res.status(200).send(user);
  } catch (ex) {
    console.log("Erro" + ex);
    res.status(500).send(ex);
  }
});

