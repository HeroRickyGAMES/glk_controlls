import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/Painel.dart';
import 'package:glk_controls/btnsVerificarEntrada.dart';
import 'package:glk_controls/btnsVerificarSaida.dart';
import 'package:glk_controls/offlineService/mainPorteiroOffline.dart';
import 'package:glk_controls/relatorio.dart';
import 'package:glk_controls/modal/modalVeiculo.dart';
import 'package:glk_controls/anteLogin.dart';

import 'firebase_options.dart';

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
  String Email;

  final String PorteiroNome;
  mainPorteiro(this.PorteiroNome, this.cadastro, this.entrada, this.saida, this.relatorio, this.painel, this.LogoPath, this.Email, {super.key});

  @override
  State<mainPorteiro> createState() => _mainPorteiroState();
}

class _mainPorteiroState extends State<mainPorteiro> {

  Future<void> testPing() async {

    ConnectivityUtils.instance
      ..serverToPing =
          "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt"
      ..verifyResponseCallback =
          (response) => response.contains("This is a test!");

    if(await ConnectivityUtils.instance.isPhoneConnected()){


      print('Conectado!');

    }else{
      Fluttertoast.showToast(
        msg: 'Conectei ao servidor offline do app!',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Fluttertoast.showToast(
        msg: 'Você está offline, então algumas ações no app irão demorar mais do que o normal,',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Fluttertoast.showToast(
        msg: 'Mas assim que a rede for reestabelecida, reinicie o app para usar o servidor online do app!',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print('Desconectado!');
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
          return const AlertDialog(
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
            return const mainPorteiroOff();
          }));
    }

    entradaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return btnsVerificarEntrada(widget.PorteiroNome);
          }));
    }

    saidaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return btnsVerificarSaida(widget.PorteiroNome);
          }));
    }

    relatorioMT() async {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
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
          const Text(
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
                    padding: const EdgeInsets.all(16),
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
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.cadastro? openModal: null,
                      child: const Text(
                          'Novo cadastro',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.entrada? entradaMT : null,
                    child: const Text(
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
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.saida ? saidaMT : null,
                    child: const Text(
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
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.relatorio ? relatorioMT : null,
                    child: const Text(
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
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: painelMT,
                    child: const Text(
                      'Painel',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.yellow[800]
                    ),
                  ),
                ) : const Text(''),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () async {

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Deseja trocar a senha?'),
                                        actions: [
                                          Center(
                                            child: Text(
                                              'Enviaremos um email para esse email de conta logado.\nEmail: ${widget.Email}',
                                              style: TextStyle(
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                                  child: const Text(
                                                    'Cancelar',
                                                    style: TextStyle(
                                                        fontSize: 18
                                                    ),
                                                  )
                                              ),
                                              TextButton(onPressed: () async {
                                                Navigator.of(context).pop();

                                                try {
                                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.Email).then((value){
                                                    Fluttertoast.showToast(
                                                      msg: 'Enviado, verifique o email para resetar a senha!',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.black,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                    print('enviado!');
                                                  });
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                    msg: 'Ocorreu um erro $e!',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                  print('Erro! $e');
                                                }

                                              },
                                                  child: const Text(
                                                    'Resetar Senha',
                                                    style: TextStyle(
                                                        fontSize: 18
                                                    ),
                                                  )
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );

                                },
                                child: const Text(
                                  'Trocar Senha',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut().then((value) async {

                                    var resulte = await FirebaseFirestore.instance
                                        .collection("Condominio")
                                        .doc('condominio')
                                        .get();

                                    String logoPath = resulte.get('imageURL');

                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return anteLogin(logoPath);
                                        }));
                                    print('Usuário desconectado');
                                  });

                                },
                                child: const Text(
                                  'Logoff',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 180,
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        child:
                        Image.network(
                          widget.LogoPath,
                          fit: BoxFit.contain,
                        ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child:
                      Text(
                        'Operador: ' + widget.PorteiroNome,
                        style: const TextStyle(
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