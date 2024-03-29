import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/Empresa/prestadorEmpresaMain.dart';
import 'package:glk_controls/anteLogin.dart';
import 'package:glk_controls/listas/meusAgendamentos.dart';
import 'package:glk_controls/modal/meusVeiculos.dart';
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
  String idEmpresa;
  operadorEmpresarial(this.name, this.empresaName, this.Email, this.idEmpresa, {super.key});

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

      setState(() {
        listaNome.add(res.data()['nome']);

        final dropValue = ValueNotifier('');
        final dropValue2 = ValueNotifier('');

        var db = FirebaseFirestore.instance;
        var UID = FirebaseAuth.instance.currentUser?.uid;
        db.collection('Users').doc(UID).get().then((event){

          event.data()?.forEach((key, value) {


            if(key == 'nome'){
              String PorteiroNomee = value;

              var db = FirebaseFirestore.instance;
              var UID = FirebaseAuth.instance.currentUser?.uid;
              db.collection('Users').doc(UID).get().then((event){

                event.data()?.forEach((key, value) async {


                  if(key == 'nome'){

                    var resultEmpresa = await FirebaseFirestore.instance
                        .collection("empresa")
                        .get();

                    for (var res in resultEmpresa.docs) {
                      //print('cheguei aqui');
                      for (int i = resultEmpresa.docs.length; i >= 1; i--) {
                        if(i == resultEmpresa.docs.length){
                          if(res.data()['nome'] == widget.empresaName){


                            Galpoes.addAll(res.data()['galpaes']);
                            String galpaoPrimario = res.data()['galpaoPrimario'];

                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return modalVeiculoAgendamento(widget.name, widget.empresaName,dropValue2, dropValue, Galpoes.keys.toList(), galpaoPrimario);
                                }));


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
  }

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

    meusAgendamentos(){

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return meusAgendamentosActivity(widget.empresaName, widget.empresaName);
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
    meusVeiculos(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return meusVeiculosActivity(widget.empresaName, widget.idEmpresa);
          }));
    }
    acessoInterno(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return PrestadorEmpresaMain(widget.empresaName, widget.idEmpresa, widget.name);
          }));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GLK Controls - OPERADORES DE EMPRESAS'),
        backgroundColor: Colors.red[700],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                    width: 500,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return liberacoesOperadorEmpresarial(widget.name, widget.empresaName, '');
                          }));
                    },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green[700]
                      ),
                        child: Text(
                            'Liberações',
                          style: TextStyle(
                              fontSize: tamanhotextobtns,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                  ),
                  Container(
                    width: 500,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child: ElevatedButton(
                      onPressed: openModal,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey
                      ),
                      child: Text(
                        'Agendamento',
                        style: TextStyle(
                          fontSize: tamanhotextobtns,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child: ElevatedButton(
                      onPressed: meusAgendamentos,
                      child: Text(
                        'Meus agendamentos',
                        style: TextStyle(
                          fontSize: tamanhotextobtns,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child: ElevatedButton(onPressed: toRelatorio,
                      child: Text(
                        'Relatórios',
                        style: TextStyle(
                          fontSize: tamanhotextobtns,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child: ElevatedButton(
                      onPressed: cadastrarVeiculoInterno,
                      child: Text(
                        'Cadastrar veiculo de frota',
                        style: TextStyle(
                          fontSize: tamanhotextobtns,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child: ElevatedButton(
                      onPressed: meusVeiculos,
                      child: Text(
                        'Frota Cadastrada',
                        style: TextStyle(
                          fontSize: tamanhotextobtns,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child: ElevatedButton(
                      onPressed: acessoInterno,
                      child: Text(
                        'Acesso Interno',
                        style: TextStyle(
                          fontSize: tamanhotextobtns,
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
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey
                                  ),
                                  child: const Text(
                                    'Trocar Senha',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                    });

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red
                                  ),
                                  child: const Text(
                                    'Logoff',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
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
                        Column(
                          children: [
                            Text(
                              'Operador: ${widget.name}',
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
        ),
      ),
    );
  }
}
