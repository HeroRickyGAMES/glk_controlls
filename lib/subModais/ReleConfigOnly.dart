import 'package:flutter/material.dart';

class ReleConfigOnly extends StatefulWidget {
  var dropValue;
  var dropValue2;

  var dropValue3;
  var dropValue4;
  var dropValue5;
  var dropValue6;
  var dropValue7;
  var dropValue8;

  String funcao;
  String funcao2;
  String funcao3;
  String funcao4;
  String EntradaOuSaida;

  ReleConfigOnly(this.dropValue,
      this.dropValue2,
      this.funcao,
      this.dropValue3,
      this.dropValue4,
      this.dropValue5,
      this.dropValue6,
      this.dropValue7,
      this.dropValue8,
      this.funcao2,
      this.funcao3,
      this.funcao4,
      this.EntradaOuSaida);

  @override
  State<ReleConfigOnly> createState() => _ReleConfigOnlyState();
}

class _ReleConfigOnlyState extends State<ReleConfigOnly> {

  List func = [
    'Liga/Desliga',
    'Pulso 1s',
    'Pulso 2s',
    'Pulso 3s',
    'Pulso 4s',
    'Pulso 5s',
    'Pulso 6s',
    'Pulso 7s',
    'Pulso 8s',
    'Pulso 9s',
    'Pulso 10s',
  ];

  List listLocal = [
    'Cancela',
    'Farol',
    'Fechamento',
  ];

  String rele1fuc1 = '';
  String Local = '';

  @override
  Widget build(BuildContext context) {
    rele1fuc1 = widget.funcao;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configuração do Relê'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      widget.EntradaOuSaida,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Text(
                                "IP:",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Text(
                              "x",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Rele 01:",
                          style: TextStyle(
                              fontSize: 18,
                          ),
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue2, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Local *',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue2.value = escolha.toString();

                                Local = escolha.toString();

                              },
                              items: listLocal.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                      Text(
                          "Função: " + rele1fuc1,
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Selecione a função *',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue.value = escolha.toString();

                                rele1fuc1 = escolha.toString();

                              },
                              items: func.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
