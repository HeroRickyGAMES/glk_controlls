import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<void> getReleAPI1() async {
  await Future.delayed(Duration(seconds: 1));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/?b=1';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  getReleAPI2();

}

Future<void> getReleAPI2() async {
  await Future.delayed(Duration(seconds: 5));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/?b=3';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  getReleAPI3();
}

Future<void> getReleAPI3() async {
  await Future.delayed(Duration(seconds: 5));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/?b=5';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  getReleAPI4();
}

Future<void> getReleAPI4() async {
  await Future.delayed(Duration(seconds: 5));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/?b=7';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}