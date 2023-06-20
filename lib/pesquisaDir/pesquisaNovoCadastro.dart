import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:glk_controls/modal/modalVeiculo.dart';
import 'package:glk_controls/listas/listaUsuarios.dart';

//Programado por HeroRickyGames

class pesquisaCadastro extends StatefulWidget {

  String operadorName;

  pesquisaCadastro(this.operadorName, {super.key});

  @override
  State<pesquisaCadastro> createState() => _pesquisaCadastroState();
}

class _pesquisaCadastroState extends State<pesquisaCadastro> {

  Map<String, String> map1 = {};
  Map<String, String> mapNome = {};
  String idDocumento = '';
  List listaNome = [];
  List galpao = [ ];

  String? Pesquisa = '';
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

    pesquisarmet() async {

      if(Pesquisa == ''){
        Fluttertoast.showToast(
          msg: 'Preencha a pesquisa para fazer uma pesquisa!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else{

        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context){

              return listaUsuarios(Pesquisa!);
            }));
      }
    }

    novoCadastromt() async {
    //todo novo cadastro

      var result = await FirebaseFirestore.instance
          .collection("empresa")
          .get();
      for (var res in result.docs) {

        setState(() {
          listaNome.add(res.data()['nome']);

          galpao.addAll(res.data()['galpaes']);

          final dropValue = ValueNotifier('');
          final dropValue2 = ValueNotifier('');
          final dropValue3 = ValueNotifier('');

          var db = FirebaseFirestore.instance;
          var UID = FirebaseAuth.instance.currentUser?.uid;
          db.collection('Users').doc(UID).get().then((event){

            event.data()?.forEach((key, value) {


              if(key == 'nome'){
                String PorteiroNomee = value;

                var db = FirebaseFirestore.instance;
                var UID = FirebaseAuth.instance.currentUser?.uid;
                db.collection('Users').doc(UID).get().then((event){

                  event.data()?.forEach((key, value) {


                    if(key == 'nome'){
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return modalPorteiro(listaNome, dropValue, PorteiroNomee, '',dropValue2);
                          }));
                    }
                  });
                }
                );
              }
            });
          }
          );
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Novo cadastro / Pesquisa'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: novoCadastromt,
                    child: Text(
                      'Novo cadastro',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    )
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  onChanged: (valor){
                    Pesquisa = valor.toUpperCase();
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  obscureText: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Pesquisa (Nome apenas letras) / (RG apenas digitos) * ',
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
                      padding: const EdgeInsets.all(16),
                      child:
                      Image.asset(
                        'assets/sanca.png',
                        fit: BoxFit.contain,
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child:
                    Column(
                      children: [
                        Text(
                          'Operador: ' + widget.operadorName,
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        ),
                      ],
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
