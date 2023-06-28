const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();
var gplay = require('google-play-scraper');
const express = require("express")
const cors = require('cors');

const app = express()

app.use(cors({ origin: true }));

app.get('/', (req, res) =>{

	gplay.app({appId: 'com.hrs.flutter.glk_controls'})
	.then((value) =>{
		res.send(value);
	});
});

//app.listen(3000, ()=> console.log('server on port 3000'))

exports.expressAPI = functions.https.onRequest(app);
