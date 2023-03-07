import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class relatorio extends StatefulWidget {

  String operadorName;

  relatorio(this.operadorName);

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

        tamanhotexto = 20;
        tamanhotextobtns = 34;
        aspect = 0.8;

      }
    }

    pesquisarmet(){

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
                      Pesquisa = valor;
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
                      Image.asset(
                        'assets/sanca.png',
                        fit: BoxFit.contain,
                      )
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
