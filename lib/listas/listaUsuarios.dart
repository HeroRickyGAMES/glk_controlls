import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/modal/modalVeiculoPesquisafill.dart';

class listaUsuarios extends StatefulWidget {

  String NomeMotorista = '';

  listaUsuarios(this.NomeMotorista);

  @override
  _listaUsuariosState createState() => _listaUsuariosState();
}

class _listaUsuariosState extends State<listaUsuarios> {

  List listaNome = [];
  List galpao = [ ];

  String PesquisaNome = '';
  String PesquisaRGMotorista = '';

  bool verificaSeSoTemLetras(String input) {
    return input.replaceAll(" ", "").split("").every((char) => char.contains(RegExp(r'[a-zA-Z]')));
  }

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

    String input = widget.NomeMotorista;
    if (verificaSeSoTemLetras(input)) {
      PesquisaNome = widget.NomeMotorista;
    } else {
      PesquisaRGMotorista = widget.NomeMotorista;
    }


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista com os Motoristas'),
      ),
      body: PesquisaNome != '' ? StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Motoristas')
            .where('nomeMotorista', isEqualTo: widget.NomeMotorista)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((documents) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 3.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: Text( 'Nome do Motorista: '+ documents['nomeMotorista'],
                              style: TextStyle(
                                fontSize: tamanhotexto
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: Text( 'RG do motorista: '+ documents['RGDoMotorista'],
                              style: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            )
                        ),
                      ),
                      ElevatedButton(onPressed: () async {

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

                                        String autofillName = documents['nomeMotorista'];

                                        String autofillRG = documents['RGDoMotorista'];

                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return modalVeiculofill(listaNome, dropValue, PorteiroNomee, '',dropValue2, galpao, dropValue3, autofillName, autofillRG);

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

                      }, child: Text(
                          'Selecionar esse motorista',
                        style: TextStyle(
                            fontSize: tamanhotextobtns,
                            color: Colors.white
                        ),
                      )
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ): PesquisaRGMotorista != "" ? StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Motoristas')
            .where('RGDoMotorista', isEqualTo: widget.NomeMotorista)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((documents) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 3.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: Text( 'Nome do Motorista: '+ documents['nomeMotorista'],
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: Text( 'RG do motorista: '+ documents['RGDoMotorista'],
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            )
                        ),
                      ),
                      ElevatedButton(onPressed: () async {
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

                                        String autofillName = documents['nomeMotorista'];

                                        String autofillRG = documents['RGDoMotorista'];

                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return modalVeiculofill(listaNome, dropValue, PorteiroNomee, '',dropValue2, galpao, dropValue3, autofillName, autofillRG);

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

                      }, child: Text(
                        'Selecionar esse motorista',
                        style: TextStyle(
                            fontSize: tamanhotextobtns,
                            color: Colors.white
                        ),
                      )
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ): const Text(''),
    );
  }
}