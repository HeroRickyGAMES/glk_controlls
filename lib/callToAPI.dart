import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<void> releCancelaEntrada() async {

  //Contasta para o Relê 1
  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=0&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

    print('Status 200');

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> rele1comDelay(int valorDelay) async {
  await Future.delayed(Duration(seconds: valorDelay));
  //Contasta para o Relê 1
  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=0&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> releFechamento02() async {

  //Contasta para o Relê 2
  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=1&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> releFarol02() async {

  //Contasta para o Relê 2
  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=1&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> rele2comDelay(int valorDelay) async {
  await Future.delayed(Duration(seconds: valorDelay));
  //Contasta para o Relê 2
  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=1&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> releFarol03() async {

  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=2&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> rele3comDelay(int valorDelay) async {
  await Future.delayed(Duration(seconds: valorDelay));
  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=2&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> releFarol04() async {

  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=3&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future<void> rele4comDelay(int valorDelay) async {
  await Future.delayed(Duration(seconds: valorDelay));

  var result = await FirebaseFirestore.instance
      .collection("Reles")
      .doc('Rele01')
      .get();

  String urlRele = (result.get('ip'));

  final String urlst = 'http://${urlRele}/relay_set.cgi?relay=3&on=1&';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}