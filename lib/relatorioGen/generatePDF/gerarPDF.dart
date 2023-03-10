import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:html' as html;
import 'dart:typed_data';

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
  if(kIsWeb){

    Future<Uint8List> pdfDataFuture = pdf.save();
    Uint8List pdfData = await pdfDataFuture;

    savePdfToTempDirectory(pdfData, 'meu_arquivo.pdf');

  }else{
    if(Platform.isAndroid){

      //Verificação no Android
      Directory appDocDirectory = await getApplicationDocumentsDirectory();


      final file = File( appDocDirectory.path + '/' + 'meu_arquivo.pdf');
      await file.writeAsBytes(await pdf.save());


      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      var deviceData = <String, dynamic>{};

      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);


      print(deviceData['version.release']);

      if(deviceData['version.release'] == '13'){
        print('gerando pdf');
        Fluttertoast.showToast(
          msg: 'Gerando PDF...',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

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
      }else{
        _requestStoragePermission(file, pdf);
      }
    }
  }
}

Future<void> _requestStoragePermission(var file, pdf) async {
  var status = await Permission.storage.request();
  if (status.isGranted) {
    print('gerando pdf');
    Fluttertoast.showToast(
      msg: 'Gerando PDF...',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

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

  } else {
    Fluttertoast.showToast(
      msg: 'Eu preciso da permissão ao armazenamento para salvar essa informação!',
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Fluttertoast.showToast(
      msg: 'Por favor, abra as configurações e tente permitir por lá!',
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

//Não tocar, não modificar!
Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'systemFeatures': build.systemFeatures,
    'displaySizeInches':
    ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
    'displayWidthPixels': build.displayMetrics.widthPx,
    'displayWidthInches': build.displayMetrics.widthInches,
    'displayHeightPixels': build.displayMetrics.heightPx,
    'displayHeightInches': build.displayMetrics.heightInches,
    'displayXDpi': build.displayMetrics.xDpi,
    'displayYDpi': build.displayMetrics.yDpi,
    'serialNumber': build.serialNumber,
  };
}
Future<void> savePdfToTempDirectory(Uint8List pdfData, String fileName) async {

  print('gerando pdf');
  Fluttertoast.showToast(
    msg: 'Gerando PDF...',
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  final url = html.Url.createObjectUrlFromBlob(html.Blob([pdfData]));
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..download = fileName;
  html.document.body?.children.add(anchor);
  anchor.click();
  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(url);

  Fluttertoast.showToast(
    msg: 'PDF gerado, iniciando o Download em alguns instantes!',
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );

}