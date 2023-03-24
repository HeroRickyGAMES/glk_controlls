import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<void> getReleAPI5() async {
  await Future.delayed(Duration(seconds: 1));

  var result = await FirebaseFirestore.instance
      .collection("Server")
      .doc('serverValues')
      .get();
  String urlRele = (result.get('URLRele'));

  final String urlst = 'http://${urlRele}/?b=0';

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

  final String urlst = 'http://${urlRele}/?b=2';

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

  final String urlst = 'http://${urlRele}/?b=4';

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

  final String urlst = 'http://${urlRele}/?b=6';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}