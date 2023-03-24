import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../listas/listaUsuarios.dart';
import '../modal/modalVeiculo.dart';
import '../modal/modalVeiculoPesquisafill.dart';

class pesquisaCadastro extends StatefulWidget {

  String operadorName;

  pesquisaCadastro(this.operadorName);

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
        final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Motoristas').snapshots();
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return listaUsuarios();
            }));
      }
    }

    novoCadastromt() async {
    //todo novo cadastro

      var result = await FirebaseFirestore.instance
          .collection("empresa")
          .get();
      for (var res in result.docs) {
        print(res.data()['nome']);

        setState(() {
          listaNome.add(res.data()['nome']);

          galpao.addAll(res.data()['galpaes']);

          print('dentro da array: ${galpao}' );
          final dropValue = ValueNotifier('');
          final dropValue2 = ValueNotifier('');
          final dropValue3 = ValueNotifier('');

          var db = FirebaseFirestore.instance;
          var UID = FirebaseAuth.instance.currentUser?.uid;
          db.collection('Users').doc(UID).get().then((event){
            print("${event.data()}");

            event.data()?.forEach((key, value) {

              print(key);
              print(value);

              if(key == 'nome'){
                String PorteiroNomee = value;

                var db = FirebaseFirestore.instance;
                var UID = FirebaseAuth.instance.currentUser?.uid;
                db.collection('Users').doc(UID).get().then((event){
                  print("${event.data()}");

                  event.data()?.forEach((key, value) {

                    print(key);
                    print(value);

                    if(key == 'nome'){

                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return modalPorteiro(listaNome, dropValue, PorteiroNomee, '',dropValue2, galpao, dropValue3);

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
      print(listaNome);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Novo cadastro / Pesquisa'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
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
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  onChanged: (valor){
                    Pesquisa = valor.toUpperCase();
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
