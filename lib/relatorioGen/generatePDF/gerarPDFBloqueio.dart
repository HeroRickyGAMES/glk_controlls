// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

//Programado por HeroRickyGames

class generatePDF2 extends StatelessWidget {

  String Placa;
  String tipoVeiculo;
  String Motivo;
  String Data;

  generatePDF2(this.Placa, this.Motivo, this.tipoVeiculo, this.Data, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gerar PDF')),
        body: PdfPreview(
          build: (format) => _generatePDF2(format, 'Gerar PDF', Placa, tipoVeiculo, Motivo, Data),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePDF2(PdfPageFormat format, String titulo, String Placa, String tipoVeiculo, String Motivo, String Data) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Center(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Relatório',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text("Placa: " + Placa,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Tipo de Veiculo: ' + Motivo,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text( 'Data do bloqueio: ' + Data,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text( 'Data geração do PDF: ${ DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/')}',
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(15),
                        child: pw.Text('Motivo: ' + tipoVeiculo,
                            style: const pw.TextStyle(fontSize: 16)
                        ),
                      ),
                    ]
                  ),
                ]
            ),
          );
        },
      ),
    );
    return pdf.save();
  }
}