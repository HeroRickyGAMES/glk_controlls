import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/listas/listaEntrada.dart';

class btnsVerificarEntrada extends StatefulWidget {
  String PorteiroName;
  btnsVerificarEntrada(
      this.PorteiroName,
      {Key? key}):
      super(key: key);

  @override
  State<btnsVerificarEntrada> createState() => _btnsVerificarEntradaState();
}

class _btnsVerificarEntradaState extends State<btnsVerificarEntrada> {

  String Entrada = '';
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

                            Entrada = 'Rele01';

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return listEntrada(widget.PorteiroName, Entrada);
                                }));
                          },
                          child: Text(
                            'Entrada 01',
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

                            Entrada = 'Rele03';

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return listEntrada(widget.PorteiroName, Entrada);
                                }));
                          },
                          child: Text(
                            'Entrada 02',
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
