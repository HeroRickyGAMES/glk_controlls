import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/subModais/ReleConfigOnly.dart';

class releModalConfig extends StatefulWidget {
  String urlPadrao;
  String urlPadrao2;
  String ADMName;
  String LogoPath;
  releModalConfig(this.urlPadrao, this.urlPadrao2, this.ADMName, this.LogoPath, {super.key});

  @override
  State<releModalConfig> createState() => _releModalConfigState();
}

class _releModalConfigState extends State<releModalConfig> {

  @override
  Widget build(BuildContext context) {
    String urlString = widget.urlPadrao;
    TextEditingController urlStringRele = TextEditingController(text: widget.urlPadrao);

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
        centerTitle: true,
        title: Text('Configurações de Relê'),
      ),
      body:
      Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Image.asset(
                  'assets/icon.png',
                  width: 300,
                  height: 300,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                      child: Text(
                          'Entrada',
                        style: TextStyle(
                          fontSize: tamanhotextobtns
                        ),
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Saida',
                        style: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {

                              final dropValue = ValueNotifier('');
                              final dropValue2 = ValueNotifier('');
                              final dropValue3 = ValueNotifier('');
                              final dropValue4 = ValueNotifier('');
                              final dropValue5 = ValueNotifier('');
                              final dropValue6 = ValueNotifier('');
                              final dropValue7 = ValueNotifier('');
                              final dropValue8 = ValueNotifier('');


                              var result = await FirebaseFirestore.instance
                                  .collection("Reles")
                                  .doc('Rele01')
                                  .get();
                              String ipRele = (result.get('ip'));

                              String funcao1 = (result.get('funcao-rele1'));
                              String funcao2 = (result.get('funcao-rele2'));
                              String funcao3 = (result.get('funcao-rele3'));
                              String funcao4 = (result.get('funcao-rele4'));
                              String EntradaouSaida = 'Entrada';
                              String DocRele = 'Rele01';

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return ReleConfigOnly(dropValue, dropValue2, funcao1, dropValue3, dropValue4, dropValue5, dropValue6, dropValue7, dropValue8, funcao2, funcao3, funcao4, EntradaouSaida, ipRele, DocRele);
                                  }));
                            },
                            child: Text(
                                'Entrada 01',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                  'IP: ',
                                style: TextStyle(
                                    fontSize: tamanhotextobtns,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                widget.urlPadrao,
                                style: TextStyle(
                                    fontSize: tamanhotextobtns,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              final dropValue = ValueNotifier('');
                              final dropValue2 = ValueNotifier('');
                              final dropValue3 = ValueNotifier('');
                              final dropValue4 = ValueNotifier('');
                              final dropValue5 = ValueNotifier('');
                              final dropValue6 = ValueNotifier('');
                              final dropValue7 = ValueNotifier('');
                              final dropValue8 = ValueNotifier('');


                              var result = await FirebaseFirestore.instance
                                  .collection("Reles")
                                  .doc('Rele02')
                                  .get();
                              String ipRele = (result.get('ip'));

                              String funcao1 = (result.get('funcao-rele1'));
                              String funcao2 = (result.get('funcao-rele2'));
                              String funcao3 = (result.get('funcao-rele3'));
                              String funcao4 = (result.get('funcao-rele4'));
                              String EntradaouSaida = 'Saida';
                              String DocRele = 'Rele02';

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return ReleConfigOnly(dropValue, dropValue2, funcao1, dropValue3, dropValue4, dropValue5, dropValue6, dropValue7, dropValue8, funcao2, funcao3, funcao4, EntradaouSaida, ipRele, DocRele);
                                  }));
                            },
                            child: Text(
                              'Saida 01',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'IP: ',
                                style: TextStyle(
                                    fontSize: tamanhotextobtns,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                widget.urlPadrao2,
                                style: TextStyle(
                                  fontSize: tamanhotextobtns,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {

                              final dropValue = ValueNotifier('');
                              final dropValue2 = ValueNotifier('');
                              final dropValue3 = ValueNotifier('');
                              final dropValue4 = ValueNotifier('');
                              final dropValue5 = ValueNotifier('');
                              final dropValue6 = ValueNotifier('');
                              final dropValue7 = ValueNotifier('');
                              final dropValue8 = ValueNotifier('');


                              var result = await FirebaseFirestore.instance
                                  .collection("Reles")
                                  .doc('Rele03')
                                  .get();
                              String ipRele = (result.get('ip'));

                              String funcao1 = (result.get('funcao-rele1'));
                              String funcao2 = (result.get('funcao-rele2'));
                              String funcao3 = (result.get('funcao-rele3'));
                              String funcao4 = (result.get('funcao-rele4'));
                              String EntradaouSaida = 'Entrada';
                              String DocRele = 'Rele03';

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return ReleConfigOnly(dropValue, dropValue2, funcao1, dropValue3, dropValue4, dropValue5, dropValue6, dropValue7, dropValue8, funcao2, funcao3, funcao4, EntradaouSaida, ipRele, DocRele);
                                  }));
                            },
                            child: Text(
                              'Entrada 02',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'IP: ',
                                style: TextStyle(
                                    fontSize: tamanhotextobtns,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                widget.urlPadrao,
                                style: TextStyle(
                                  fontSize: tamanhotextobtns,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              final dropValue = ValueNotifier('');
                              final dropValue2 = ValueNotifier('');
                              final dropValue3 = ValueNotifier('');
                              final dropValue4 = ValueNotifier('');
                              final dropValue5 = ValueNotifier('');
                              final dropValue6 = ValueNotifier('');
                              final dropValue7 = ValueNotifier('');
                              final dropValue8 = ValueNotifier('');


                              var result = await FirebaseFirestore.instance
                                  .collection("Reles")
                                  .doc('Rele04')
                                  .get();
                              String ipRele = (result.get('ip'));

                              String funcao1 = (result.get('funcao-rele1'));
                              String funcao2 = (result.get('funcao-rele2'));
                              String funcao3 = (result.get('funcao-rele3'));
                              String funcao4 = (result.get('funcao-rele4'));
                              String EntradaouSaida = 'Saida';
                              String DocRele = 'Rele04';

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return ReleConfigOnly(dropValue, dropValue2, funcao1, dropValue3, dropValue4, dropValue5, dropValue6, dropValue7, dropValue8, funcao2, funcao3, funcao4, EntradaouSaida, ipRele, DocRele);
                                  }));
                            },
                            child: Text(
                              'Saida 02',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'IP: ',
                                style: TextStyle(
                                    fontSize: tamanhotextobtns,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                widget.urlPadrao2,
                                style: TextStyle(
                                  fontSize: tamanhotextobtns,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                      child:
                      Image.network(
                        widget.LogoPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                      child:
                      Column(
                        children: [
                          Text(
                            'ADM : ${widget.ADMName}',
                            style: TextStyle(
                                fontSize: tamanhotextobtns
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
