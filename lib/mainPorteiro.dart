import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/Painel.dart';
import 'package:glk_controls/callToAPI.dart';
import 'package:glk_controls/listas/listaEntrada.dart';
import 'package:glk_controls/offlineService/mainPorteiroOffline.dart';
import 'package:glk_controls/relatorio.dart';
import 'anteLogin.dart';
import 'listas/listaSaida.dart';
import 'modal/modalVeiculo.dart';


//Programado por HeroRickyGames

Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
String idDocumento = '';
List listaNome = [];
String pass = '';

class mainPorteiro extends StatefulWidget {
  final String LogoPath;
  bool cadastro;
  bool entrada;
  bool saida;
  bool relatorio;
  bool painel;

  final String PorteiroNome;
  mainPorteiro(this.PorteiroNome, this.cadastro, this.entrada, this.saida, this.relatorio, this.painel, this.LogoPath);

  @override
  State<mainPorteiro> createState() => _mainPorteiroState();
}

class _mainPorteiroState extends State<mainPorteiro> {

  Future<void> testPing() async {
    final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

    try {
      final result = await Process.run('ping', ['-c', '1', ip]);
      if (result.exitCode == 0) {
        print('Ping realizado com sucesso para o endereço $ip');
      } else {
        Fluttertoast.showToast(
          msg: 'Você está offline, então algumas ações no app irão demorar mais do que o normal,',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Fluttertoast.showToast(
          msg: 'Mas não se preocupe, assim que sua conexão for restaurada tudo voltará ao normal!',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        print('Falha no ping para o endereço $ip');
      }
    } catch (e) {
      print('Erro ao executar o comando de ping: $e');
    }
  }

  @override
  void initState() {

    testPing();

    // TODO: implement initState com outras verificações de conexão
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    openModal() async {
  //todo novo cadastro

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aguarde!'),
            actions: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        },
      );

      var result = await FirebaseFirestore.instance
          .collection("empresa")
          .get();
      for (var res in result.docs) {
        print(res.data()['nome']);

        setState(() {
          listaNome.add(res.data()['nome']);

          final dropValue = ValueNotifier('');
          final dropValue2 = ValueNotifier('');

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
      print(listaNome);
    }

    openModalOffline() async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return mainPorteiroOff();
          }));
    }

    entradaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return listEntrada(widget.PorteiroNome);
          }));
    }

    saidaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return listaSaida(widget.PorteiroNome);
          }));
    }

    relatorioMT() async {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aguarde!'),
            actions: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        },
      );

      var result = await FirebaseFirestore.instance
          .collection("Condominio")
          .doc('condominio')
          .get();

      String logoPath = result.get('imageURL');
      Navigator.of(context).pop();

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return relatorio(widget.PorteiroNome, logoPath);
          }));
    }

    painelMT() async {

      var result = await FirebaseFirestore.instance
          .collection("Condominio")
          .doc('condominio')
          .get();

      String logoPath = result.get('imageURL');

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return painelADM(widget.PorteiroNome, logoPath);

          }));

    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Colors.red[900],
        title: Container(
          child:
          Text(
              'GLK Controls - OPERADORES'
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: 180,
                    height: 180,
                    padding: EdgeInsets.all(16),
                    child:
                    Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.contain,
                    )
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.cadastro? openModal: null,
                      child: Text(
                          'Novo cadastro',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.entrada? entradaMT : null,
                    child: Text(
                      'Verificar Entrada',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green[700]
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.saida ? saidaMT : null,
                    child: Text(
                      'Verificar Saída',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.yellow[800]
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.relatorio ? relatorioMT : null,
                    child: Text(
                      'Relatorio',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.yellow[800]
                    ),
                  ),
                ),
                widget.painel ?
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: painelMT,
                    child: Text(
                      'Painel',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.yellow[800]
                    ),
                  ),
                ) : Text(''),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().then((value){
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return anteLogin();
                                }));
                            print('Usuário desconectado');
                          });

                        },
                        child: Text(
                          'Logoff',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 180,
                        height: 180,
                        padding: EdgeInsets.all(16),
                        child:
                        Image.network(
                          widget.LogoPath,
                          fit: BoxFit.contain,
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child:
                      Text(
                        'Operador: ' + widget.PorteiroNome,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}