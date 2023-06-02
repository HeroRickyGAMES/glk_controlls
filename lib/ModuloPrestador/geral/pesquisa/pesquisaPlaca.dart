import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PesquisaPlaca extends StatefulWidget {
  String Porteiro;
  PesquisaPlaca(this.Porteiro, {Key? key}) : super(key: key);

  @override
  State<PesquisaPlaca> createState() => _PesquisaPlacaState();
}

class _PesquisaPlacaState extends State<PesquisaPlaca> {
  TextEditingController placaveiculointerface = TextEditingController();
  String oqPesquisar = '';
  String Placa = '';
  
  @override
  Widget build(BuildContext context) {


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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liberação: Entrada de veiculo'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: 500,
                child: Image.asset(
                  'assets/icon.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Text(
                'Digite a placa:',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: placaveiculointerface,
                  onChanged: (valor){
                    setState(() async {
                      Placa = valor;
                      String valorpuro = valor.toUpperCase();
                      if(valorpuro.length == 7){
                        Placa = valorpuro.replaceAllMapped(
                          RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                              (Match m) => '${m[1]} ${m[2]}',
                        );
                        placaveiculointerface.text = Placa;
                      }
                    });
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Digite RG ou Nome ',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green[700]
                  ),
                  onPressed: (){
                    if(Placa == ''){
                      Fluttertoast.showToast(
                        msg: 'Preencha a placa!',
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      //todo pesquisa
                    }
                  },
                  child: Text(
                      'Pesquisar',
                    style: TextStyle(
                      fontSize: tamanhotextobtns
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
