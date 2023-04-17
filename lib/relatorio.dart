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

  String? Pesquisa;
  @override
  Widget build(BuildContext context) {

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextobtns = 34;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

      print(aspect);
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;
        aspect = 0.8;

      }
    }

    pesquisarmet() async {


      if(Pesquisa == null){

        Fluttertoast.showToast(
          msg: 'Preencha algum parametro na pesquisa!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

      }else{

        FirebaseFirestore.instance
            .collection('Autorizacoes')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {

            if(doc["nomeMotorista"] == Pesquisa ){

              String oqPesquisar = 'nomeMotorista';
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return pesquisaRelatorio(Pesquisa!, oqPesquisar);
                  }));

            }else{

              if(doc["PlacaVeiculo"] == Pesquisa ){

                String oqPesquisar = 'PlacaVeiculo';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return pesquisaRelatorio(Pesquisa!, oqPesquisar);
                    }));
              }else{
                if(doc["Empresa"] == Pesquisa){
                  String oqPesquisar = 'Empresa';
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return pesquisaRelatorio(Pesquisa!, oqPesquisar);
                      }));
                }else{
                  if(doc["Galpão"] == Pesquisa){
                    String oqPesquisar = 'Galpão';
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return pesquisaRelatorio(Pesquisa!, oqPesquisar);
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

          });
        });

      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Relatorios'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    onChanged: (valor){
                      Pesquisa = valor.toUpperCase();
                      //Mudou mandou para a String
                    },
                    keyboardType: TextInputType.name,
                    enableSuggestions: false,
                    obscureText: false,
                    autocorrect: false,
                    decoration: InputDecoration(
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
                      padding: EdgeInsets.all(16),
                      child:
                      Image.network(
                        widget.LogoPath,
                        fit: BoxFit.contain,
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child:
                    Text(
                      'Operador: ' + widget.operadorName,
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
