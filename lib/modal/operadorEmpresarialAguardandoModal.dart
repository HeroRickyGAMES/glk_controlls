import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

//Programado por HeroRickyGames

class operadorEmpresarialAguardando extends StatefulWidget {

  String lacreounao = '';
  String empresaName = '';
  String liberadopor = '';
  String horarioCriacao;
  String nomeMotorista = '';
  String Veiculo = '';
  String PlacaVeiculo = '';
  String Empresadestino = '';
  String EmpresadeOrigin = '' ;
  String Galpao = '';
  String lacradoStr = '';
  String idDocumento = '';
  String DateAnalise = '';
  String verificadoPor = '';
  String urlImage1 = '';
  String urlImage2 = '';
  String urlImage3 = '';
  String urlImage4 = '';
  String motivo = '';
  Map Galpoes;
  String UIDEmpresa;

  operadorEmpresarialAguardando(
      this.lacreounao,
      this.empresaName,
      this.liberadopor,
      this.horarioCriacao,
      this.nomeMotorista,
      this.Veiculo,
      this.PlacaVeiculo,
      this.Empresadestino,
      this.EmpresadeOrigin,
      this.Galpao,
      this.lacradoStr,
      this.idDocumento,
      this.DateAnalise,
      this.verificadoPor,
      this.urlImage1,
      this.urlImage2,
      this.urlImage3,
      this.urlImage4,
      this.Galpoes,
      this.UIDEmpresa,
      this.motivo,
      {super.key}
      );
  @override
  State<operadorEmpresarialAguardando> createState() => _operadorEmpresarialAguardandoState();
}
String AutorizoEntrada = 'Autorizo Entrada st';
class _operadorEmpresarialAguardandoState extends State<operadorEmpresarialAguardando> {
  bool lacrebool = false;
  String? lacreSt;
  bool entradabool = false;
  bool regeitado = false;
  String galpaoSelecionado = '';
  final dropValue = ValueNotifier('');

  bool empresaPikada = false;
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

    if(widget.lacreounao == 'lacre'){
      setState(() {
        AutorizoEntrada = 'Autorizo Entrada com lacre';
      });
    }

    if(widget.lacreounao == 'naolacrado'){
      setState(() {
        AutorizoEntrada = 'Autorizo Entrada sem lacre';
      });
    }

    if(widget.lacreounao == 'lacre'){

      lacrebool = true;

    }

    if(widget.lacreounao == 'naolacrado'){

      lacrebool = false;

    }

    String _textoPredefinido = widget.lacradoStr;
    lacreSt = widget.lacradoStr;

    TextEditingController _textEditingController = TextEditingController(text: _textoPredefinido);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text(
            'GLK Controls - Liberação de Veiculo',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.liberadopor,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Nome: ' + widget.nomeMotorista,
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ' + widget.Veiculo,
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Placa: ' + widget.PlacaVeiculo,
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ' + widget.Empresadestino,
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ' + widget.EmpresadeOrigin,
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Observação: ' + widget.motivo,
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Galpões da Empresa *',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Center(
                    child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                      return DropdownButton(
                        hint: Text(
                          'Selecione um galpão',
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        ),
                        value: (value.isEmpty)? null : value,
                        onChanged: (escolha) async {
                          dropValue.value = escolha.toString();

                          galpaoSelecionado = escolha.toString();


                        },
                        items: widget.Galpoes.keys.map((opcao) => DropdownMenuItem(
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
            Container(
              child:
              CheckboxListTile(
                title: Text(AutorizoEntrada),
                value: entradabool,
                onChanged: (value) {
                  setState(() {
                    entradabool = value!;
                    regeitado = false;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              child:
              CheckboxListTile(
                title: Text('Rejeito a Entrada'),
                value: regeitado,
                onChanged: (value) {
                  setState(() {
                    regeitado = value!;
                    entradabool = false;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {

                  var valorEmpresas = await FirebaseFirestore.instance
                      .collection("empresa")
                      .doc(widget.UIDEmpresa)
                      .get();


                  if(valorEmpresas.get('galpaes')[galpaoSelecionado] == 0){
                    Fluttertoast.showToast(
                      msg: 'Infelizmente não existe mais vagas disponiveis, selecione outro galpão!',
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: tamanhotexto,
                    );
                  }else{

                    if(widget.Galpoes.containsKey(galpaoSelecionado)){


                      widget.Galpoes[galpaoSelecionado] = widget.Galpoes[galpaoSelecionado] - 1;


                      if(lacrebool == false){
                        if(entradabool == true){
                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataEntradaEmpresa': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                            'Galpão': galpaoSelecionado,
                            'Status': 'Liberado Entrada'
                          }).then((value){
                            FirebaseFirestore.instance.collection('empresa').doc(widget.UIDEmpresa).update(
                                {
                                  "galpaes": widget.Galpoes
                                }
                            ).then((value){
                              Navigator.pop(context);
                            });
                          });
                        }
                        if(regeitado == true){

                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataAnaliseEmpresa': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                            'Status': 'Rejeitado'
                          }).then((value){
                            Navigator.pop(context);
                          });

                        }
                      }
                      if(lacrebool == true){
                        if(lacreSt == null){
                          Fluttertoast.showToast(
                            msg: 'Preencha o numero do lacre!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotexto,
                          );
                        }else{
                          if(entradabool == true){
                            FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                              'DataEntradaEmpresa': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                              'Galpão': galpaoSelecionado,
                              'Status': 'Liberado Entrada'
                            }).then((value){

                              FirebaseFirestore.instance.collection('empresa').doc(widget.UIDEmpresa).update(
                                  {
                                    "galpaes": widget.Galpoes
                                  }
                              ).then((value){
                                Navigator.pop(context);
                              });

                            });
                          }
                          if(regeitado == true){
                            FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                              'DataEntradaEmpresa': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                              'Galpão': galpaoSelecionado,
                              'Status': 'Rejeitado'
                            }).then((value){
                              Navigator.pop(context);
                            });
                          }
                        }
                      }
                    }
                  }
                },
                child: Text(
                  'Prosseguir',
                  style: TextStyle(
                      fontSize: tamanhotextobtns
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}