import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

//Programado por HeroRickyGames

class veiculoEntrada extends StatefulWidget {

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
  String DateEntrada = '';
  String verificadoPor = '';
  String DatadeAnalise = '';
  String lacreNum = '';
  bool interno;
  bool LacreSaida;

  veiculoEntrada(
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
      this.DateEntrada,
      this.verificadoPor,
      this.DatadeAnalise,
      this.interno,
      this.lacreNum,
      this.LacreSaida,
      {super.key}
      );
  @override
  State<veiculoEntrada> createState() => _veiculoEntradaState();
}

class _veiculoEntradaState extends State<veiculoEntrada> {
  bool lacrebool = false;
  String lacreSt = '';

  @override
  Widget build(BuildContext context) {
    String lacrereject = '';
    String AutorizoEntrada = 'Autorizo Entrada st';


    if(widget.lacreounao == 'lacre'){
      setState(() {
        AutorizoEntrada = 'Autorizo Saída com lacre';
        lacrereject = 'Autorizo saída ';
      });
    }

    if(widget.lacreounao == 'naolacrado'){
      setState(() {
        AutorizoEntrada = 'Autorizo Entrada sem lacre';
        lacrereject = 'Autorizo saída ';
      });
    }

    if(widget.lacreounao == 'lacre'){

      lacrebool = true;

    }

    if(widget.lacreounao == 'naolacrado'){

      lacrebool = false;

    }

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final textScaleFactor = mediaQueryData.textScaleFactor;
    final dpi = mediaQueryData.devicePixelRatio;

    final textHeight = screenHeight * 0.05;
    final textWidth = screenWidth * 0.8;

    final textSize = (textHeight / dpi / 2) * textScaleFactor;
    final textSizeandroid = (textWidth / dpi / 15) * textScaleFactor;
    final textSizeandroidbtn = (textWidth / dpi / 13) * textScaleFactor;

    if(kIsWeb){
      tamanhotexto = textSize;
      tamanhotextobtns = textSize;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = textSizeandroid;
        tamanhotextobtns = textSizeandroidbtn;
        aspect = 0.8;

      }
    }

    String lacreNameSaida = '';

    if(widget.LacreSaida == true){
      setState(() {
        lacreNameSaida = 'Com Lacre divergente';
      });

    }

    if(widget.LacreSaida == false){
      setState(() {
        lacreNameSaida = 'Sem Lacre';
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
            'GLK Controls - Autorizar Saída',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao} - Portaria - ${widget.liberadopor}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DateEntrada} - Analise na Empresa - ${widget.empresaName}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DatadeAnalise} - Entrada - ${widget.verificadoPor}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Nome: ${widget.nomeMotorista}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Veiculo: ${widget.Veiculo}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Placa: ${widget.PlacaVeiculo}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Empresa de destino: ${widget.Empresadestino}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Empresa de origem: ${widget.EmpresadeOrigin}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Galpão: ${widget.Galpao}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              child:
              CheckboxListTile(
                title: Text(lacrereject),
                value: !widget.LacreSaida,
                onChanged: (value) {
                  setState(() {
                    widget.LacreSaida = !value!;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              child:
              CheckboxListTile(
                title: Text("$lacrereject com lacre"),
                value: widget.LacreSaida,
                onChanged: (value) {
                  setState(() {
                    widget.LacreSaida = value!;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
              widget.LacreSaida ?
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    setState(() {
                      lacreSt = valor;
                    });
                  },
                  keyboardType: TextInputType.number,
                  //enableSuggestions: false,
                  //autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Numero do lacre *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              )
                  :const Text(''),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  //todo subtract

                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  var result = await FirebaseFirestore.instance
                      .collection("operadorEmpresarial")
                      .doc(UID)
                      .get();

                  String idEmpresa = (result.get('idEmpresa'));

                  var resultEmpresa = await FirebaseFirestore.instance
                      .collection("empresa")
                      .doc(idEmpresa)
                      .get();


                  if(widget.interno == false){
                    Map galpoes = (resultEmpresa.get('galpaes'));

                    galpoes[widget.Galpao] = galpoes[widget.Galpao] + 1;

                    FirebaseFirestore.instance.collection('empresa').doc(idEmpresa).update({
                      'galpaes': galpoes
                    }).then((value){
                      if(widget.LacreSaida == false){
                        FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                          'DataSaida': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                          'Status': 'Liberado Saida'
                        });
                        Navigator.pop(context);
                      }
                      if(widget.LacreSaida == true){
                        if(lacreSt == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o numero do lacre!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotexto,
                          );
                        }else{
                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataSaida': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                            'Status': 'Liberado Saida',
                            'lacrenumSaida': lacreSt,
                            'lacreboolsaida': true
                          });
                          Navigator.pop(context);
                        }
                      }
                    });
                  }else{
                    if(widget.LacreSaida == false){
                      FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                        'DataSaida': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                        'Status': 'Liberado Saida'
                      });
                      Navigator.pop(context);
                    }
                    if(widget.LacreSaida == true){
                      if(lacreSt == ''){
                        Fluttertoast.showToast(
                          msg: 'Preencha o numero do lacre!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: tamanhotexto,
                        );
                      }else{
                        FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                          'DataSaida': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                          'Status': 'Liberado Saida',
                          'lacrenumSaida': lacreSt,
                          'lacreboolsaida': true
                        });
                        Navigator.pop(context);
                      }
                    }
                  }
                },
                child: Text(
                  'Prosseguir',
                  style: TextStyle(
                      fontSize: tamanhotexto
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
                        padding: const EdgeInsets.all(16),
                        child:
                        Image.asset(
                          'assets/icon.png',
                          fit: BoxFit.contain,
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child:
                      Column(
                        children: [
                          Text(
                            'Operador: ${widget.empresaName}',
                            style: TextStyle(
                                fontSize: tamanhotexto
                            ),
                          ),
                        ],
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
