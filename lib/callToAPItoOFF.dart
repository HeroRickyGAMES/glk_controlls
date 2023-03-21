import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<void> getReleAPI5() async {
  await Future.delayed(Duration(seconds: 1));

  final String urlst = 'http://192.168.3.175/?b=0';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  getReleAPI6();

}

Future<void> getReleAPI6() async {
  await Future.delayed(Duration(seconds: 5));

  final String urlst = 'http://192.168.3.175/?b=2';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  getReleAPI7();
}

Future<void> getReleAPI7() async {
  await Future.delayed(Duration(seconds: 5));

  final String urlst = 'http://192.168.3.175/?b=4';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  getReleAPI8();
}

Future<void> getReleAPI8() async {
  await Future.delayed(Duration(seconds: 5));

  final String urlst = 'http://192.168.3.175/?b=6';

  final response = await http.get(Uri.parse(urlst));

  if (response.statusCode == 200) {

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}