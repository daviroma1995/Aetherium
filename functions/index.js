const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.createUserwithEmail = functions.https.onRequest(async (req, res) =>{
  const {email, password} = req.body;
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
  const {uid} = req.body;
  console.log(uid);
  try {
    const user = await admin.auth().deleteUser(uid);
    res.status(200).send(user);
  } catch (ex) {
    console.log("Erro" + ex);
    res.status(500).send(ex);
  }
});
