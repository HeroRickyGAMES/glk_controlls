import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReleConfigOnly extends StatefulWidget {
  var dropValue;
  var dropValue2;

  var dropValue3;
  var dropValue4;
  var dropValue5;
  var dropValue6;
  var dropValue7;
  var dropValue8;

  String ipRele;
  String funcao;
  String funcao2;
  String funcao3;
  String funcao4;
  String EntradaOuSaida;
  String DocRele;

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
      this.EntradaOuSaida,
      this.ipRele,
      this.DocRele,
      {super.key}
      );

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
    'Nada'
  ];

  String rele1fuc1 = '';
  String rele2fuc1 = '';
  String rele3fuc2 = '';
  String rele4fuc2 = '';
  String Local = '';
  String Local2 = '';
  String Local3 = '';
  String Local4 = '';
  String ipRele = '';

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
    
    rele1fuc1 = widget.funcao;
    rele2fuc1 = widget.funcao2;
    rele3fuc2 = widget.funcao3;
    rele4fuc2 = widget.funcao4;
    ipRele = widget.ipRele;

    TextEditingController releIpController = TextEditingController(text: widget.ipRele);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configuração do Relê'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
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
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.EntradaOuSaida,
                      style: TextStyle(
                          fontSize: tamanhotexto,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "IP:",
                          style: TextStyle(
                              fontSize: tamanhotexto,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: releIpController,
                          onChanged: (valor){
                            ipRele = valor;
                            //Mudou mandou para a String
                          },
                          keyboardType: TextInputType.number,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'IP *',
                            hintStyle: TextStyle(
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Rele 01:",
                          style: TextStyle(
                              fontSize: tamanhotexto,
                          ),
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue2, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Local *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
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
                                      fontSize: tamanhotexto
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
                            fontSize: tamanhotexto
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Selecione a função *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
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
                                      fontSize: tamanhotexto
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Rele 02:",
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue3, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Local *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue3.value = escolha.toString();

                                Local2 = escolha.toString();

                              },
                              items: listLocal.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                      Text(
                        "Função: " + rele2fuc1,
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue4, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Selecione a função *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue4.value = escolha.toString();

                                rele2fuc1 = escolha.toString();

                              },
                              items: func.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Rele 03:",
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue5, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Local *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue5.value = escolha.toString();

                                Local3 = escolha.toString();

                              },
                              items: listLocal.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                      Text(
                        "Função: " + rele4fuc2,
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue6, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Selecione a função *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue6.value = escolha.toString();

                                rele4fuc2 = escolha.toString();

                              },
                              items: func.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Rele 04:",
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue8, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Local *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue8.value = escolha.toString();

                                Local4 = escolha.toString();

                              },
                              items: listLocal.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                              ),
                              ).toList(),
                            );
                          })
                      ),
                      Text(
                        "Função: " + rele3fuc2,
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      Center(
                          child: ValueListenableBuilder(valueListenable: widget.dropValue7, builder: (context, String value, _){
                            return DropdownButton(
                              hint: Text(
                                'Selecione a função *',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              value: (value.isEmpty)? null : value,
                              onChanged: (escolha) async {
                                widget.dropValue7.value = escolha.toString();

                                rele3fuc2 = escolha.toString();

                              },
                              items: func.map((opcao) => DropdownMenuItem(
                                value: opcao,
                                child:
                                Text(
                                  opcao,
                                  style: TextStyle(
                                      fontSize: tamanhotexto
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
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red
                    ),
                      child: Text(
                          'Cancelar',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      //todo magica

                      if(ipRele == ''){
                        Fluttertoast.showToast(
                          msg: 'Digite o IP do rele!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: tamanhotexto,
                        );
                      }else{

                        if(rele1fuc1 == ''){
                          Fluttertoast.showToast(
                            msg: 'Selecione a função do Relê 1!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotexto,
                          );
                        }else{
                          if(Local == ""){
                            Fluttertoast.showToast(
                              msg: 'Selecione o local de aplicação do Relê 1!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: tamanhotexto,
                            );
                          }else{
                            if(rele2fuc1 == ''){
                              Fluttertoast.showToast(
                                msg: 'Selecione a função do Relê 2!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: tamanhotexto,
                              );
                            }else{
                              if(Local2  == ''){
                                Fluttertoast.showToast(
                                  msg: 'Selecione o local de aplicação do Relê 2!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: tamanhotexto,
                                );
                              }else{
                                if(rele3fuc2 == ''){
                                  Fluttertoast.showToast(
                                    msg: 'Selecione a função do Relê 3!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: tamanhotexto,
                                  );
                                }else{
                                  if(Local3 == ''){
                                    Fluttertoast.showToast(
                                      msg: 'Selecione o local de aplicação do Relê 3!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: tamanhotexto,
                                    );
                                  }else{
                                    if(rele4fuc2 == ''){
                                      Fluttertoast.showToast(
                                        msg: 'Selecione a função do Relê 4!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: tamanhotexto,
                                      );
                                    }else{
                                      if(Local4 == ''){
                                        Fluttertoast.showToast(
                                          msg: 'Selecione o local de aplicação do Relê 4!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: tamanhotexto,
                                        );
                                      }else{
                                        //todo mandar para o db

                                        FirebaseFirestore.instance.collection('Reles').doc(widget.DocRele).update({
                                          'ip': ipRele,
                                          'funcao-rele1': rele1fuc1,
                                          'funcao-rele2': rele2fuc1,
                                          'funcao-rele3': rele3fuc2,
                                          'funcao-rele4': rele4fuc2,
                                          'localAplicacao1': Local,
                                          'localAplicacao2': Local2,
                                          'localAplicacao3': Local3,
                                          'localAplicacao4': Local4,
                                        }).then((value){

                                          Fluttertoast.showToast(
                                            msg: 'Configuração feita com sucesso!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: tamanhotexto,
                                          );

                                          Navigator.pop(context);
                                        });
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green
                    ),
                    child: Text(
                      'Prosseguir',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
