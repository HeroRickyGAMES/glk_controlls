import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

Future<void> generatePDF() async {

  var myTheme = pw.ThemeData.withFont(
    base: Font.ttf(await rootBundle.load("assets/fonts/open-sans.ttf")),
  );

  final pdf = pw.Document();

  print('gerando pdf');
  Fluttertoast.showToast(
    msg: 'Gerando PDF...',
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  pdf.addPage(
    pw.Page(
      theme: myTheme,
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'
        ),
      ),
    ),
  );
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  final file = File( appDocDirectory.path + '/' + 'example.pdf');
  await file.writeAsBytes(await pdf.save());


  final file2 = File('/sdcard/Download/meu_arquivo.pdf');
  await file2.writeAsBytes(await pdf.save());

  Fluttertoast.showToast(
    msg: 'O PDF foi gerado! Veja em ${file2.uri}',
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );

}