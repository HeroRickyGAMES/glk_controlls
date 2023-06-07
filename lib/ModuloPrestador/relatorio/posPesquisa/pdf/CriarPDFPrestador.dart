// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class generatePDFPrestador extends StatelessWidget {
  Map<String, dynamic> dataDBPusher;
  List IDS;

  generatePDFPrestador(this.dataDBPusher,this.IDS, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gerar PDF')),
        body: PdfPreview(
          build: (format) => _generatePDFPrestador(format, 'Gerar PDF', dataDBPusher, IDS),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePDFPrestador(PdfPageFormat format, String title, Map<String, dynamic> dataDBPusherr, List IDS) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    List<pw.Widget> listaItens = [];

    for (int i = 0; i <= IDS.length -1; i++) {

      print(dataDBPusherr.length);

      listaItens.add(
        pw.Row(
            children: [
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Nome: ${dataDBPusherr[IDS[i]]['Nome']}'),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('RG: ${dataDBPusherr[IDS[i]]['RG']},'),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Empresa: ${dataDBPusherr[IDS[i]]['galpao']} ${dataDBPusherr[IDS[i]]['Empresa']},'),
                    ),
                  ]
                ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Placa: ${dataDBPusherr[IDS[i]]['Placa']},'),
                    ),
                  ]
                ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Veiculo: ${dataDBPusherr[IDS[i]]['Veiculo']},'),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Modelo: ${dataDBPusherr[IDS[i]]['Modelo']},'),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Cor: ${dataDBPusherr[IDS[i]]['Cor']},'),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Data: ${dataDBPusherr[IDS[i]]['Data']},'),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Hora: ${dataDBPusherr[IDS[i]]['Horario']},'),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Status: ${dataDBPusherr[IDS[i]]['Status']},'),
                    ),
                  ]
              ),
              ),
            ]
        ),
      );
    }


    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.ListView(children: listaItens),
            ]
          );
        },
      ),
    );
    return pdf.save();
  }
}