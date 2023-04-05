import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../subModais/ReleConfigOnly.dart';

class releModalConfig extends StatefulWidget {
  String urlPadrao;
  String urlPadrao2;
  releModalConfig(this.urlPadrao, this.urlPadrao2);

  @override
  State<releModalConfig> createState() => _releModalConfigState();
}

class _releModalConfigState extends State<releModalConfig> {



  @override
  Widget build(BuildContext context) {
    String urlString = widget.urlPadrao;
    TextEditingController urlStringRele = TextEditingController(text: widget.urlPadrao);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configurações de Relê'),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
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
                padding: EdgeInsets.all(16),
                  child: Text(
                      'Entrada',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Saida',
                    style: TextStyle(
                        fontSize: 18
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
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
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
                              fontSize: 18
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                              'IP: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            widget.urlPadrao,
                            style: TextStyle(
                                fontSize: 18,
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
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: (){

                        },
                        child: Text(
                          'Saida 01',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'IP: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            widget.urlPadrao2,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
