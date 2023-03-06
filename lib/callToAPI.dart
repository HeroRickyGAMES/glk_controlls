import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

final String url = 'https://k1gjf.localtonet.com/api/tst';

Future<void> getReleAPI1() async {

  Fluttertoast.showToast(
      msg: "Ligando ou desligando...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0
  );

  final response = await http.get(Uri.parse(url));

  Fluttertoast.showToast(
      msg: 'O status foi ' + response.statusCode.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: "Ligando o relê!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0
    );

    print(response.body);
  } else {
    // Houve um erro ao receber os dados
    print('Erro ao receber os dados: ${response.statusCode}');

    Fluttertoast.showToast(
        msg: "Ocorreu um erro comum ao executar, tente novamente por favor!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}