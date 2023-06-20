import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

//Programado por HeroRickyGames

Future<void> getReleAPI5() async {
  await Future.delayed(Duration(seconds: 1));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=0&on=0&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  getReleAPI6();

}

Future<void> getReleAPI6() async {
  await Future.delayed(Duration(seconds: 5));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=1&on=0&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  getReleAPI7();
}

Future<void> getReleAPI7() async {
  await Future.delayed(Duration(seconds: 5));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=2&on=0&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  getReleAPI8();
}

Future<void> getReleAPI8() async {
  await Future.delayed(Duration(seconds: 5));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=3&on=0&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
      msg: 'Todos os relês foram desligados com sucesso!',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}