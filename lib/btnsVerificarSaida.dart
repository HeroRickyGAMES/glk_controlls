import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/listas/listaSaida.dart';

class btnsVerificarSaida extends StatefulWidget {
  String PorteiroName;
  btnsVerificarSaida(
      this.PorteiroName,
      {Key? key}):
        super(key: key);

  @override
  State<btnsVerificarSaida> createState() => _btnsVerificarSaidaState();
}

class _btnsVerificarSaidaState extends State<btnsVerificarSaida> {

  String Saida = '';
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
        title: Text('Qual entrada está operando?'),
        centerTitle: true,
      ),
      body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: (){

                    Saida = 'Rele02';

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return listaSaida(widget.PorteiroName, Saida);
                        }));
                  },
                  child: Text(
                    'Saida 01',
                    style: TextStyle(
                        fontSize: tamanhotextobtns
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: (){

                    Saida = 'Rele04';

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return listaSaida(widget.PorteiroName, Saida);
                        }));
                  },
                  child: Text(
                    'Saida 02',
                    style: TextStyle(
                        fontSize: tamanhotextobtns
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
