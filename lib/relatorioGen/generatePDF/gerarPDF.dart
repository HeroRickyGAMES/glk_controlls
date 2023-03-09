import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

Future<void> generatePDF(String entradapor, String dataEntrada, String nomeMotorista, String Veiculo, String Placa, String EmpresaDestino, String telefone, String EmpresaOrigin, String Galpao, String SaidaLiberadapor, String lacrado, String dataLiberacao, bool lacrebool) async {

  String lacreString = '';
  var myTheme = pw.ThemeData.withFont(
    base: Font.ttf(await rootBundle.load("assets/fonts/open-sans.ttf")),
  );

  final pdf = pw.Document();

  if(lacrebool == true){
    lacreString = 'Lacrado';
  }
  if(lacrebool == false){
    lacreString = 'Não lacrado';
  }

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
      build: (pw.Context context) =>
          pw.Center(
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Relatório: ' + EmpresaOrigin,
                      style: pw.TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Entrada Liberada: ' + entradapor,
                      style: pw.TextStyle(fontSize: 16)),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Data de Entrada: ' + dataEntrada,
                      style: pw.TextStyle(fontSize: 16)),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Nome do motorista: ' + nomeMotorista,
                      style: pw.TextStyle(fontSize: 16)),
                ),

                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Veiculo: ' + Veiculo,
                      style: pw.TextStyle(fontSize: 16)),
                ),

                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Placa: ' + Placa,
                      style: pw.TextStyle(fontSize: 16)),
                ),
                pw.Container(
                    padding: pw.EdgeInsets.all(15),
                    child: pw.Text('Empresa de destino: ' + EmpresaDestino,
                        style: pw.TextStyle(fontSize: 16)),
                ),

                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Empresa de Origem: ' + EmpresaOrigin,
                      style: pw.TextStyle(fontSize: 16)),
                ),

                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text('Telefone: ' + telefone,
                      style: pw.TextStyle(fontSize: 16)),
                ),

                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child:  pw.Text('Galpão: ' + Galpao,
                      style: pw.TextStyle(fontSize: 16)),
                ),

                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child:  pw.Text('Saída liberada por: ' + SaidaLiberadapor,
                      style: pw.TextStyle(fontSize: 16)),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child:  pw.Text('Data de liberação: ' + dataLiberacao,
                      style: pw.TextStyle(fontSize: 16)),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child:  pw.Text('Lacrado? ' + lacreString,
                      style: pw.TextStyle(fontSize: 16)),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  child:  pw.Text('Numero do lacre: ' + lacrado,
                      style: pw.TextStyle(fontSize: 16)),
                ),
              ]
          )
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
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );

}