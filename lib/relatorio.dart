import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/pesquisaDir/pesquisaRelatorio.dart';

class relatorio extends StatefulWidget {

  String operadorName;
  String LogoPath;

  relatorio(this.operadorName, this.LogoPath);

  @override
  State<relatorio> createState() => _relatorioState();
}

class _relatorioState extends State<relatorio> {

  String Pesquisa = '';
  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final textScaleFactor = mediaQueryData.textScaleFactor;
    final dpi = mediaQueryData.devicePixelRatio;

    final textHeight = screenHeight * 0.05;
    final textWidth = screenWidth * 0.8;

    final textSize = (textHeight / dpi / 2) * textScaleFactor;

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    Map Galpoes = { };
    List GalpoesList = [ ];

    if(kIsWeb){
      tamanhotexto = textSize;
      tamanhotextobtns = textSize;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;
        aspect = 0.8;

      }
    }

    pesquisarmet() async {
    List nome = [];
    List Placa = [];
    List Empresa = [];
    List rg = [];

    Pesquisa.toUpperCase();

      if(Pesquisa == ''){

        Fluttertoast.showToast(
          msg: 'Preencha algum parametro na pesquisa!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

      }else{

        final veiculosDeEmpresasCollection = FirebaseFirestore.instance.collection('Autorizacoes');
        final snapshot = await veiculosDeEmpresasCollection.get();
        final veiculosDeEmpresas = snapshot.docs;
        for (final docveiculosDeEmpresas in veiculosDeEmpresas) {
          final id = docveiculosDeEmpresas.id;

          nome.add(docveiculosDeEmpresas.get('nomeMotorista'));
          Placa.add(docveiculosDeEmpresas.get('PlacaVeiculo'));
          Empresa.add(docveiculosDeEmpresas.get('Empresa'));
          rg.add(docveiculosDeEmpresas.get('RGDoMotorista'));

        }
        
        if(nome.contains(Pesquisa)){
          String oqPesquisar = 'nomeMotorista';
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return pesquisaRelatorio(Pesquisa, oqPesquisar);
              }));
        }else{
            if(Placa.contains(Pesquisa)){
              String oqPesquisar = 'PlacaVeiculo';
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return pesquisaRelatorio(Pesquisa, oqPesquisar);
                  }));
            }else{
              if(Empresa.contains(Pesquisa)){
                String oqPesquisar = 'Empresa';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return pesquisaRelatorio(Pesquisa, oqPesquisar);
                    }));
              }else{
                if(rg.contains(Pesquisa)){
                  String oqPesquisar = 'RGDoMotorista';
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return pesquisaRelatorio(Pesquisa, oqPesquisar);
                      }));
                }else{
                  Fluttertoast.showToast(
                    msg: 'Infelizmente não achei nada do que você pesquisou, por favor, tente novamente!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              }
            }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Relatorios'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onChanged: (valor){
                      Pesquisa = valor.toUpperCase();
                      //Mudou mandou para a String
                    },
                    keyboardType: TextInputType.name,
                    enableSuggestions: false,
                    obscureText: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Pesquisa',
                      hintStyle: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ElevatedButton(onPressed: pesquisarmet,
                  child: Text(
                      'Pesquisar',
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 180,
                      height: 180,
                      padding: const EdgeInsets.all(16),
                      child:
                      Image.network(
                        widget.LogoPath,
                        fit: BoxFit.contain,
                      ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child:
                    Text(
                      'Operador: ${widget.operadorName}',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
