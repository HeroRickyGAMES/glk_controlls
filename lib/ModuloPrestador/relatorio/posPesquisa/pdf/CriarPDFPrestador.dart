// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

List<pw.Widget> listaItens = [];

class generatePDFPrestador extends StatelessWidget {
  Map<String, dynamic> dataDBPusher;
  List IDS;

  generatePDFPrestador(this.dataDBPusher,this.IDS, {super.key});

  @override
  Widget build(BuildContext context) {
    listaItens.clear();
    for (int i = 0; i <= IDS.length -1; i++) {

      listaItens.add(
        pw.Row(
            children: [
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Nome:\n${dataDBPusher[IDS[i]]['Nome']}',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'RG:\n${dataDBPusher[IDS[i]]['RG']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Empresa:\n${dataDBPusher[IDS[i]]['galpao']} ${dataDBPusher[IDS[i]]['Empresa']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Placa:\n${dataDBPusher[IDS[i]]['Placa']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Veiculo:\n${dataDBPusher[IDS[i]]['Veiculo']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Modelo:\n${dataDBPusher[IDS[i]]['Modelo']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Cor:\n${dataDBPusher[IDS[i]]['Cor']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Data:\n${dataDBPusher[IDS[i]]['Data']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Hora:\n${dataDBPusher[IDS[i]]['Horario']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
              pw.Expanded(child:
              pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                          'Status:\n${dataDBPusher[IDS[i]]['Status']},',
                        style: const pw.TextStyle(
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ]
              ),
              ),
            ]
        ),
      );
    }
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Gerar PDF')
        ),
        body: PdfPreview(
          build: (format) => _generatePDFPrestador(format, 'Gerar PDF', dataDBPusher, IDS),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePDFPrestador(PdfPageFormat format, String title, Map<String, dynamic> dataDBPusherr, List IDS) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);


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