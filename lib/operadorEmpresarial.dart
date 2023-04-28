import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/anteLogin.dart';
import 'package:glk_controls/listas/meusAgendamentos.dart';
import 'package:glk_controls/modal/modalCadastroVeiculoInterno.dart';
import 'package:glk_controls/modal/modalVeiculoAgendamento.dart';
import 'package:glk_controls/relatorio.dart';
import 'package:glk_controls/listas/liberacoesOperadorEmpresarial.dart';

//Programado por HeroRickyGames

  Map map = Map();
  List listaNome = [];
  Map Galpoes = { };

  Map<String, String> map1 = {};
  Map<String, String> mapNome = {};
class operadorEmpresarial extends StatefulWidget {
  final String name;
  final String empresaName;
  String Email;
  operadorEmpresarial(this.name, this.empresaName, this.Email, {super.key});

  @override
  State<operadorEmpresarial> createState() => _operadorEmpresarialState();
}

class _operadorEmpresarialState extends State<operadorEmpresarial> {

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

                event.data()?.forEach((key, value) async {

                  print(key);
                  print(value);

                  if(key == 'nome'){

                    var resultEmpresa = await FirebaseFirestore.instance
                        .collection("empresa")
                        .get();

                    for (var res in resultEmpresa.docs) {
                      //print('cheguei aqui');
                      for (int i = resultEmpresa.docs.length; i >= 1; i--) {
                        if(i == resultEmpresa.docs.length){
                          print('cheguei aqui');
                          print(res.data()['nome'] == widget.empresaName);
                          print(res.data()['nome']);
                          print(widget.empresaName);
                          if(res.data()['nome'] == widget.empresaName){

                            print('cheguei aqui');

                            Galpoes.addAll(res.data()['galpaes']);
                            String galpaoPrimario = res.data()['galpaoPrimario'];

                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return modalVeiculoAgendamento(widget.name, widget.empresaName,dropValue2, dropValue, Galpoes.keys.toList(), galpaoPrimario);
                                }));

                            print('tentando abrir');

                          }
                        }
                      }
                    }
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

  Widget build(BuildContext context) {
    String idDocumento;

    String holderPlaca = '';

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

        tamanhotexto = 16;
        tamanhotextobtns = 18;
        aspect = 0.8;

      }
    }
    meusAgendamentos(){

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return meusAgendamentosActivity();
          }));

    }

    toRelatorio() async {
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
            return relatorio(widget.name, logoPath);
          }));

    }
    cadastrarVeiculoInterno() async {

      var UID = FirebaseAuth.instance.currentUser?.uid;

      var result = await FirebaseFirestore.instance
          .collection("operadorEmpresarial")
          .doc(UID)
          .get();

      String idEmpresa = result.get('idEmpresa');

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return cadastroVeiculoInterno(idEmpresa);
          }));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GLK Controls - OPERADORES DE EMPRESAS'),
        backgroundColor: Colors.red[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return liberacoesOperadorEmpresarial(widget.name, widget.empresaName);
                      }));
                },
                    child: Text(
                        'Liberações',
                      style: TextStyle(
                          fontSize: tamanhotexto,
                          fontWeight: FontWeight.bold,
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
                  onPressed: openModal,
                  child: Text(
                    'Agendamento',
                    style: TextStyle(
                      fontSize: tamanhotexto,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white24
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: meusAgendamentos,
                  child: Text(
                    'Meus agendamentos',
                    style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(onPressed: toRelatorio,
                  child: Text(
                    'Relatórios',
                    style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: cadastrarVeiculoInterno,
                  child: Text(
                    'Cadastrar veiculo interno',
                    style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
                      Image.asset(
                        'assets/sanca.png',
                        fit: BoxFit.contain,
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child:
                    Text(
                      'Operador: ' + widget.name,
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
