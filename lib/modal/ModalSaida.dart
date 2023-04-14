import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../callToAPI.dart';

//Programado por HeroRickyGames

class modalSaidaVeiculo extends StatefulWidget {

  String lacreounao = '';
  String empresaName = '';
  String liberadopor = '';
  String horarioCriacao;
  String nomeMotorista = '';
  String Veiculo = '';
  String PlacaVeiculo = '';
  String Empresadestino = '';
  String EmpresadeOrigin = '' ;
  String Galpao = '';
  String lacradoStr = '';
  String idDocumento = '';
  String DatadeAnalise = '';
  String verificadoPor = '';
  String DateEntrada = '';
  String EmpresaDoc = '';
  String porteiroName = '';
  String DataSaida = '';

  modalSaidaVeiculo(
      this.lacreounao,
      this.empresaName,
      this.liberadopor,
      this.horarioCriacao,
      this.nomeMotorista,
      this.Veiculo,
      this.PlacaVeiculo,
      this.Empresadestino,
      this.EmpresadeOrigin,
      this.Galpao,
      this.lacradoStr,
      this.idDocumento,
      this.DatadeAnalise,
      this.verificadoPor,
      this.DateEntrada,
      this.EmpresaDoc,
      this.porteiroName,
      this.DataSaida
      );
  @override
  State<modalSaidaVeiculo> createState() => _modalSaidaVeiculoState();
}

class _modalSaidaVeiculoState extends State<modalSaidaVeiculo> {
  @override
  Widget build(BuildContext context) {

    bool lacrebool = false;
    String? lacreSt;

    if(widget.lacreounao == 'lacre'){

      lacrebool = true;

    }

    if(widget.lacreounao == 'naolacrado'){

      lacrebool = false;

    }

    String _textoPredefinido = widget.lacradoStr;
    lacreSt = widget.lacradoStr;

    TextEditingController _textEditingController = TextEditingController(text: _textoPredefinido);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          'GLK Controls - Veiculo Saida',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child:
              Text(
                'Liberação: ' + 'Motorista e Veiculo',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao}' ,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.liberadopor,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DatadeAnalise}' ,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Analise da Empresa - ' + widget.Empresadestino,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DateEntrada}' ,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.verificadoPor,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DataSaida}' ,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Solicitação de saída - ' + widget.Empresadestino,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Nome: ' + widget.nomeMotorista,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ' + widget.Veiculo,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Placa: ' + widget.PlacaVeiculo,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ' + widget.Empresadestino,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ' + widget.EmpresadeOrigin,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  if(lacrebool == false){
                    FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                      'DataSaida': DateTime.now(),
                      'Status': 'Saida',
                      'saidaLiberadaPor': widget.porteiroName
                    }).then((value){
                      Navigator.pop(context);
                    });
                    final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

                    try {
                      final result = await Process.run('ping', ['-c', '1', ip]);
                      if (result.exitCode == 0) {
                        print('Ping realizado com sucesso para o endereço $ip');
                      } else {
                        Navigator.pop(context);
                        print('Falha no ping para o endereço $ip');
                      }
                    } catch (e) {
                      print('Erro ao executar o comando de ping: $e');
                    }
                  }
                  if(lacrebool == true){
                    if(lacreSt == null){
                      Fluttertoast.showToast(
                        msg: 'Preencha o numero do lacre!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                        'DataSaida': DateTime.now(),
                        'Status': 'Saida',
                        'saidaLiberadaPor': widget.porteiroName
                      }).then((value){
                        Navigator.pop(context);
                      });

                      final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

                      try {
                        final result = await Process.run('ping', ['-c', '1', ip]);
                        if (result.exitCode == 0) {
                          print('Ping realizado com sucesso para o endereço $ip');
                        } else {
                          Navigator.pop(context);
                          print('Falha no ping para o endereço $ip');
                        }
                      } catch (e) {
                        print('Erro ao executar o comando de ping: $e');
                      }
                    }
                  }
                },
                child: Text(
                  'Prosseguir',
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 180,
                        height: 180,
                        padding: EdgeInsets.all(16),
                        child:
                        Image.asset(
                          'assets/sanca.png',
                          fit: BoxFit.contain,
                        )
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child:
                      Text(
                        'Operador: ' + widget.porteiroName,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}