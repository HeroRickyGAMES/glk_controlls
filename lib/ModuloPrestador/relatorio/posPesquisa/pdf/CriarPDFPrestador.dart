// ignore_for_file: public_member_api_docs

import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class generatePDFPrestador extends StatelessWidget {

  generatePDFPrestador({super.key} );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gerar PDF')),
        body: PdfPreview(
          build: (format) => _generatePDFPrestador(format, 'Gerar PDF'),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePDFPrestador(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    String lacreString = '';

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
              return pw.Column(
                children: [
                  pw.Text('data')
                ],
              );
        },
      ),
    );
    return pdf.save();
  }
}