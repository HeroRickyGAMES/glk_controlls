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
  bool lacrebool = false;
  String id = '';
  generatePDF(this.entradapor, this.dataEntrada, this.nomeMotorista, this.Veiculo, this.Placa, this.EmpresaDestino, this.telefone, this.EmpresaOrigin, this.Galpao, this.SaidaLiberadapor, this.lacrado,this.dataLiberacao, this.lacrebool, id);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Gerar PDF')),
        body: PdfPreview(
          build: (format) => _generatePdf(format, 'Gerar PDF', entradapor, dataEntrada, nomeMotorista, Veiculo, Placa, EmpresaDestino, telefone, EmpresaOrigin, Galpao, SaidaLiberadapor, lacrado, dataLiberacao, lacrebool, id),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title, String entradapor, String dataEntrada, String nomeMotorista, String Veiculo, String Placa, String EmpresaDestino, String telefone, String EmpresaOrigin, String Galpao, String SaidaLiberadapor, String lacrado, String dataLiberacao, bool lacrebool, String id) async {
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
                    padding: pw.EdgeInsets.all(15),
                    child: pw.Text('Relatório: ' + EmpresaOrigin,
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)
                    ),
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
                    child: pw.Text('Galpão: ' + Galpao,
                        style: pw.TextStyle(fontSize: 16)),
                  ),

                  pw.Container(
                    padding: pw.EdgeInsets.all(15),
                    child: pw.Text('Saída liberada por: ' + SaidaLiberadapor,
                        style: pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(15),
                    child: pw.Text('Data de liberação: ' + dataLiberacao,
                        style: pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(15),
                    child: pw.Text('Lacrado? ' + lacreString,
                        style: pw.TextStyle(fontSize: 16)),
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(15),
                    child: pw.Text('Numero do lacre: ' + lacrado,
                        style: pw.TextStyle(fontSize: 16)),
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