import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/Painel.dart';

//Programado por HeroRickyGames

class setorADM extends StatefulWidget {
  final String ADMName;
  const setorADM(this.ADMName);

  @override
  State<setorADM> createState() => _setorADMState();
}

class _setorADMState extends State<setorADM> {
  @override
  Widget build(BuildContext context) {
    double tamanhotexto = 20;
    double tamanhotextobtns = 16;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextobtns = 34;
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;

      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('SETOR ADIMISTRATIVO'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                Text(
                  'Cadastrar',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                Text(
                  'Entrada',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                Text(
                  'Saída',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                Text(
                  'Relatorio',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {

                  var result = await FirebaseFirestore.instance
                      .collection("Condominio")
                      .doc('condominio')
                      .get();

                  String logoPath = result.get('imageURL');

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return painelADM(widget.ADMName, logoPath);
                      }));

                },
                child:
                Text(
                  'Painel',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
          ),
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
                Text(
                  'ADM : ${widget.ADMName}',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
