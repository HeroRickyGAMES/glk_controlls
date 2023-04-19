// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class generatePDF extends StatelessWidget {
  String entradapor = '';
  String dataEntrada = '';
  String nomeMotorista = '';
  String Veiculo = '';
  String Placa = '';
  String EmpresaDestino = '';
  String telefone = '';
  String EmpresaOrigin = '';
  String Galpao = '';
  String SaidaLiberadapor = '';
  String lacrado = '';
  String dataLiberacao = '';

  String dataEntradaex = '';
  String dataAnaliseex = '';
  String dataEntradaEmpresaex = '';
  String dataSaidaex = '';
  bool lacrebool = false;
  String id = '';
  generatePDF(this.entradapor, this.dataEntrada, this.nomeMotorista, this.Veiculo, this.Placa, this.EmpresaDestino, this.telefone, this.EmpresaOrigin, this.Galpao, this.SaidaLiberadapor, this.lacrado,this.dataLiberacao, this.lacrebool, id , this.dataEntradaex , this.dataAnaliseex , this.dataEntradaEmpresaex , this.dataSaidaex, {super.key} );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gerar PDF')),
        body: PdfPreview(
          build: (format) => _generatePdf(format, 'Gerar PDF', entradapor, dataEntrada, nomeMotorista, Veiculo, Placa, EmpresaDestino, telefone, EmpresaOrigin, Galpao, SaidaLiberadapor, lacrado, dataLiberacao, lacrebool, id, dataEntradaex , dataAnaliseex , dataEntradaEmpresaex , dataSaidaex),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title, String entradapor, String dataEntrada, String nomeMotorista, String Veiculo, String Placa, String EmpresaDestino, String telefone, String EmpresaOrigin, String Galpao, String SaidaLiberadapor, String lacrado, String dataLiberacao, bool lacrebool, String id, String dataEntradaex, String dataAnaliseex, String dataEntradaEmpresaex, String dataSaidaex) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    String lacreString = '';

    if(lacrebool == true){
      lacreString = 'Lacrado';
    }
    if(lacrebool == false){
      lacreString = 'Não lacrado';
    }

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
                    child: pw.Text('Relatório: ' + EmpresaOrigin,
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text(dataEntradaex,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text(dataAnaliseex,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(15),
                        child: pw.Text(dataEntradaEmpresaex,
                            style: const pw.TextStyle(fontSize: 16)
                        ),
                      ),
                    ]
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text(dataSaidaex,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Nome do motorista: ' + nomeMotorista,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),

                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Veiculo: ' + Veiculo,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),

                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Placa: ' + Placa,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Empresa de destino: ' + EmpresaDestino,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),

                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Empresa de Origem: ' + EmpresaOrigin,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),

                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Telefone: ' + telefone,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),

                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Galpão: ' + Galpao,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Lacrado? ' + lacreString,
                        style: const pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Text('Numero do lacre: ' + lacrado,
                        style: const pw.TextStyle(fontSize: 16)),
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