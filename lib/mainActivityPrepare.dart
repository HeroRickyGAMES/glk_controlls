import 'dart:convert';

import 'package:enhanced_url_launcher/enhanced_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glk_controls/mainEmpresa.dart';
import 'package:glk_controls/mainPorteiro.dart';
import 'package:glk_controls/operadorEmpresarial.dart';
import 'package:glk_controls/setorADM.dart';
import 'package:glk_controls/firebase_options.dart';
import 'package:glk_controls/anteLogin.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

//Programado por HeroRickyGames

class mainActivityPrepare extends StatefulWidget {
  String calloff;

  mainActivityPrepare(this.calloff, {Key? key}) : super(key: key);

  @override
  State<mainActivityPrepare> createState() => _mainActivityPrepareState();
}

checkislog(context) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var dbInstance = FirebaseFirestore.instance;

  final info = await PackageInfo.fromPlatform();

  String expressIP = 'https://us-central1-glk-controls.cloudfunctions.net/expressAPI';

  final response = await http.get(Uri.parse(expressIP));

  if (response.statusCode == 200) {

    Map<String, dynamic> data = json.decode(response.body);

    if(int.parse(info.version.replaceAll(".", '')) < int.parse((data['version']).replaceAll(".", ''))){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Nova atualização!',
                style: TextStyle(
                    fontSize: 19
                ),
              ),
              content: Text(
                'O app lançou uma atualização!\nAtualize agora pelo site!\nA versão instalada em seu dispositivo é a ${info.version}\nMas a mais atualizada é a ${data['version']}',
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
              actions: [
                TextButton(onPressed: () async {

                  Uri uri = Uri.parse("https://play.google.com/store/apps/details?id=com.hrs.flutter.glk_controls");
                  if (!await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception('Could not launch $uri');
                  }
                }, child: const Text(
                  'Baixar versão mais atualizada',
                  style: TextStyle(
                      fontSize: 19
                  ),
                )
                ),
              ],
            );
          }
      );
    }else{
      FirebaseAuth.instance
          .idTokenChanges()
          .listen((User? user) async {
        if (user == null) {

          var resulte = await dbInstance
              .collection("Condominio")
              .doc('condominio')
              .get();

          String logoPath = resulte.get('imageURL');

          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return anteLogin(logoPath);
              }));

        } else {
          var UID = FirebaseAuth.instance.currentUser?.uid;

          var db = dbInstance;
          db.collection('Users').doc(UID).get().then((event){

            event.data()?.forEach((key, value) {
              if(value == 'ADM'){

                var db = dbInstance;
                var UID = FirebaseAuth.instance.currentUser?.uid;
                db.collection('Users').doc(UID).get().then((event){

                  event.data()?.forEach((key, value) {
                    if(key == 'nome'){
                      String ADMName = value;
                      var db = dbInstance;
                      var UID = FirebaseAuth.instance.currentUser?.uid;
                      db.collection('Users').doc(UID).get().then((event){

                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return setorADM(ADMName);
                            }));
                      }
                      );
                    }

                  });

                }
                );
                //Passar o codigo para mandar a tela
              }

              if(value == 'porteiro'){

                var db = dbInstance;
                var UID = FirebaseAuth.instance.currentUser?.uid;
                db.collection('Users').doc(UID).get().then((event){

                  event.data()?.forEach((key, value) {


                    if(key == 'nome'){
                      String PorteiroNome = value;


                      var db = dbInstance;
                      var UID = FirebaseAuth.instance.currentUser?.uid;
                      db.collection('Users').doc(UID).get().then((event){

                        event.data()?.forEach((key, value) async {


                          if(key == 'estaativo'){
                            if(value == true){


                              var result = await dbInstance
                                  .collection("porteiro")
                                  .doc(UID)
                                  .get();

                              bool cadastro = result.get('cadastrar');
                              bool entrada = result.get('entrada');
                              bool saida = result.get('saida');
                              bool relatorio = result.get('relatorio');
                              bool painel = result.get('painel');
                              String Email = result.get('email');


                              var resulte = await FirebaseFirestore.instance
                                  .collection("Condominio")
                                  .doc('condominio')
                                  .get();

                              String logoPath = resulte.get('imageURL');
                              bool liberacao = result.get('liberacao');
                              bool listaColaborador = result.get('listaColaborador');
                              bool relatorioColaborador = result.get('relatorioColaborador');

                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel, logoPath, Email, liberacao, listaColaborador, relatorioColaborador);
                                  }));

                            }else{


                              AlertDialog alert = AlertDialog(
                                title: const Text("Sua conta ainda não está ativa!"),
                                content: const Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                                actions: [
                                  TextButton(
                                      onPressed: (){
                                        SystemNavigator.pop();
                                      },
                                      child: const Text('Ok')
                                  ),
                                ],
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          }
                        });
                      }
                      );
                    }
                  });
                }
                );
                //Passar o codigo para mandar a tela
              }

              if(value == 'empresa'){

                db.collection('Users').doc(UID).get().then((event){

                  event.data()?.forEach((key, value) {


                    bool relatorio = false;

                    if(key == 'nome'){
                      String nome = value;
                      //Passar o codigo para mandar a tela
                      var db = dbInstance;
                      var UID = FirebaseAuth.instance.currentUser?.uid;
                      db.collection('Users').doc(UID).get().then((event){

                        event.data()?.forEach((key, value) {


                          if(key == 'estaativo'){
                            if(value == true){

                              var db2 = dbInstance;
                              db2.collection('Users').doc(UID).get().then((event){

                                event.data()?.forEach((key, value) {


                                  if(key == 'nome'){
                                    String nome = value;
                                    //Passar o codigo para mandar a tela
                                    var db = dbInstance;
                                    var UID = FirebaseAuth.instance.currentUser?.uid;
                                    db.collection('Users').doc(UID).get().then((event){

                                      event.data()?.forEach((key, value) {


                                        if(key == 'RelatorioDays'){

                                          String dayHj = '${DateTime.now().day}';

                                          if(value.contains(dayHj)){
                                            relatorio = true;

                                            Navigator.pop(context);
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context){
                                                  return mainEmpresa(nome, relatorio);
                                                }));

                                          }else{
                                            relatorio = false;

                                            Navigator.pop(context);
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context){
                                                  return mainEmpresa(nome, relatorio);
                                                }));
                                          }
                                        }
                                      });

                                    }
                                    );
                                  }
                                });
                              }
                              );

                            }else{

                              AlertDialog alert = AlertDialog(
                                title: const Text("Sua conta ainda não está ativa!"),
                                content: const Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                                actions: [
                                  TextButton(
                                      onPressed: (){
                                        SystemNavigator.pop();
                                      },
                                      child: const Text('Ok')
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          }
                        });
                      }
                      );
                    }
                  });
                }
                );
              }
              if(value == 'operadorEmpresarial'){
                db.collection('Users').doc(UID).get().then((event){
                  event.data()?.forEach((key, value) {
                    if(key == 'nome'){
                      String nome = value;
                      //Passar o codigo para mandar a tela
                      var db = dbInstance;
                      var UID = FirebaseAuth.instance.currentUser?.uid;
                      db.collection('Users').doc(UID).get().then((event){
                        event.data()?.forEach((key, value) async {
                          if(key == 'estaativo'){
                            if(value == true){

                              var result = await dbInstance
                                  .collection("operadorEmpresarial")
                                  .doc(UID)
                                  .get();

                              String empresaName = (result.get('empresa'));
                              String Email = result.get('email');
                              String idEmpresa = result.get('idEmpresa');

                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return operadorEmpresarial(nome, empresaName, Email, idEmpresa);
                                  }));

                            }else{


                              AlertDialog alert = AlertDialog(
                                title: const Text("Sua conta ainda não está ativa!"),
                                content: const Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                                actions: [
                                  TextButton(
                                      onPressed: (){
                                        SystemNavigator.pop();
                                      },
                                      child: const Text('Ok')
                                  ),
                                ],
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }
                          }
                        });
                      }
                      );
                    }
                  });
                }
                );
              }
            });
          }
          );
        }
      });
    }

  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

}

checkislogOFFLine(context) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    host: '192.168.35.175:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  var dbInstance = FirebaseFirestore.instance;
  FirebaseAuth.instance
      .idTokenChanges()
      .listen((User? user) async {
    if (user == null) {

      var resulte = await dbInstance
          .collection("Condominio")
          .doc('condominio')
          .get();

      String logoPath = resulte.get('imageURL');

      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return anteLogin(logoPath);
          }));

    } else {

      var UID = FirebaseAuth.instance.currentUser?.uid;

      var db = dbInstance;
      db.collection('Users').doc(UID).get().then((event){

        event.data()?.forEach((key, value) {


          if(value == 'porteiro'){


            var db = dbInstance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){

              event.data()?.forEach((key, value) async {

                var result = await dbInstance
                    .collection("porteiro")
                    .doc(UID)
                    .get();

                bool cadastro = result.get('cadastrar');
                bool entrada = result.get('entrada');
                bool saida = result.get('saida');
                bool relatorio = result.get('relatorio');
                bool painel = result.get('painel');
                bool liberacao = result.get('liberacao');
                String PorteiroNome = result.get('nome');
                String Email = result.get('email');

                bool listaColaborador = result.get('listaColaborador');
                bool relatorioColaborador = result.get('relatorioColaborador');

                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel, '', Email, liberacao, listaColaborador, relatorioColaborador);
                    }));

              });

            }
            );
            //Passar o codigo para mandar a tela
          }

          if(value == 'empresa'){

            db.collection('Users').doc(UID).get().then((event){

              event.data()?.forEach((key, value) {


                bool relatorio = false;

                if(key == 'nome'){
                  String nome = value;
                  //Passar o codigo para mandar a tela
                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){

                    event.data()?.forEach((key, value) {


                      if(key == 'estaativo'){
                        if(value == true){

                          var db2 = dbInstance;
                          db2.collection('Users').doc(UID).get().then((event){

                            event.data()?.forEach((key, value) {


                              if(key == 'nome'){
                                String nome = value;
                                //Passar o codigo para mandar a tela
                                var db = dbInstance;
                                var UID = FirebaseAuth.instance.currentUser?.uid;
                                db.collection('Users').doc(UID).get().then((event){

                                  event.data()?.forEach((key, value) {


                                    if(key == 'RelatorioDays'){

                                      String dayHj = '${DateTime.now().day}';

                                      if(value.contains(dayHj)){
                                        relatorio = true;

                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return mainEmpresa(nome, relatorio);
                                            }));

                                      }else{
                                        relatorio = false;

                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return mainEmpresa(nome, relatorio);
                                            }));

                                      }


                                    }
                                  });

                                }
                                );
                              }

                            });

                          }
                          );

                        }else{

                          AlertDialog alert = AlertDialog(
                            title: const Text("Sua conta ainda não está ativa!"),
                            content: const Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    SystemNavigator.pop();
                                  },
                                  child: const Text('Ok')
                              ),
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }


                      }

                    });

                  }
                  );
                }

              });

            }
            );
          }
          if(value == 'operadorEmpresarial'){

            db.collection('Users').doc(UID).get().then((event){

              event.data()?.forEach((key, value) {


                if(key == 'nome'){
                  String nome = value;
                  //Passar o codigo para mandar a tela
                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){

                    event.data()?.forEach((key, value) async {


                      if(key == 'estaativo'){
                        if(value == true){

                          var result = await dbInstance
                              .collection("operadorEmpresarial")
                              .doc(UID)
                              .get();

                          String empresaName = (result.get('empresa'));
                          String Email = result.get('email');
                          String idEmpresa = result.get('idEmpresa');

                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return operadorEmpresarial(nome, empresaName, Email, idEmpresa);
                              }));

                        }else{


                          AlertDialog alert = AlertDialog(
                            title: const Text("Sua conta ainda não está ativa!"),
                            content: const Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    SystemNavigator.pop();
                                  },
                                  child: const Text('Ok')
                              ),
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                      }
                    });
                  }
                  );
                }
              });
            }
            );
          }
        });
      }
      );
    }
  });
}
class _mainActivityPrepareState extends State<mainActivityPrepare> {

  @override
  Widget build(BuildContext context) {

    if(widget.calloff == 'Ativo'){
      checkislogOFFLine(context);
    }else{
      if(widget.calloff == 'NaoAtivo'){
        checkislog(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preparando login"),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
