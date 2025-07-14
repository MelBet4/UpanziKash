const functions = require("firebase-functions");
const admin = require("firebase-admin");
const {OpenAIApi, Configuration} = require("openai");

admin.initializeApp();
const openaiApiKey = functions.config().openai.key;

exports.generateTip = functions.https.onRequest(async (req, res) => {
  if (req.method !== "POST") return res.status(405).send("Only POST allowed");
  try {
    const openai = new OpenAIApi(new Configuration({apiKey: openaiApiKey}));
    const prompt =
      "Give a short, practical financial or agricultural tip for " +
      "smallholder farmers in Africa.";
    const completion = await openai.createChatCompletion({
      model: "gpt-3.5-turbo",
      messages: [{role: "user", content: prompt}],
      max_tokens: 60,
    });
    const tip = completion.data.choices[0].message.content.trim();
    await admin.firestore().collection("tips").add({
      tip,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    res.status(200).send({tip});
  } catch (e) {
    res.status(500).send("Error generating tip");
  }
});
