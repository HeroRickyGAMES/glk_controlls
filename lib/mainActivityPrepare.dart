import 'package:flutter/material.dart';
import 'dart:io';
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

  final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

  try {
    final result = await Process.run('ping', ['-c', '1', ip]);
    if (result.exitCode == 0) {

      print('Ping realizado com sucesso para o endereço $ip');
    } else {

      print('Falha no ping para o endereço $ip');
    }
  } catch (e) {
    print('Erro ao executar o comando de ping: $e');
  }

  await FirebaseAuth.instance
      .idTokenChanges()
      .listen((User? user) async {
    if (user == null) {

      var resulte = await dbInstance
          .collection("Condominio")
          .doc('condominio')
          .get();

      String logoPath = resulte.get('imageURL');

      print('User is currently signed out!');
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return anteLogin(logoPath);
          }));

    } else {

      var UID = FirebaseAuth.instance.currentUser?.uid;

      var db = dbInstance;
      db.collection('Users').doc(UID).get().then((event){
        print("${event.data()}");

        event.data()?.forEach((key, value) {

          print(key);
          print(value);

          if(value == 'ADM'){

            var db = dbInstance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) {

                print(key);
                print(value);

                if(key == 'nome'){
                  String ADMName = value;

                  print('O ADM é ' + ADMName);

                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){
                    print("${event.data()}");

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
            print('Ele é um ADM');
            //Passar o codigo para mandar a tela
          }

          if(value == 'porteiro'){

            var db = dbInstance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) {

                print(key);
                print(value);

                if(key == 'nome'){
                  String PorteiroNome = value;

                  print('Porteiro name é' + PorteiroNome);

                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){
                    print("${event.data()}");

                    event.data()?.forEach((key, value) async {

                      print(key);
                      print(value);

                      if(key == 'estaativo'){
                        if(value == true){

                          print('Porteiro name é' + PorteiroNome);

                          var result = await dbInstance
                              .collection("porteiro")
                              .doc(UID)
                              .get();

                          bool cadastro = result.get('cadastrar');
                          bool entrada = result.get('entrada');
                          bool saida = result.get('saida');
                          bool relatorio = result.get('relatorio');
                          bool painel = result.get('painel');


                          var resulte = await dbInstance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          String logoPath = resulte.get('imageURL');

                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel, logoPath);
                              }));

                        }else{

                          print('O está ativo está funcionando!');

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
            print('Ele é um porteiro');
            //Passar o codigo para mandar a tela
          }

          if(value == 'empresa'){
            print('Ele é uma empresa');

            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) {

                print(key);
                print(value);

                bool relatorio = false;

                if(key == 'nome'){
                  print('É uma empresa');
                  String nome = value;
                  //Passar o codigo para mandar a tela
                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){
                    print("${event.data()}");

                    event.data()?.forEach((key, value) {

                      print(key);
                      print(value);

                      if(key == 'estaativo'){
                        if(value == true){

                          var db2 = dbInstance;
                          db2.collection('Users').doc(UID).get().then((event){
                            print("${event.data()}");

                            event.data()?.forEach((key, value) {

                              print(key);
                              print(value);

                              if(key == 'nome'){
                                print('É uma empresa');
                                String nome = value;
                                //Passar o codigo para mandar a tela
                                var db = dbInstance;
                                var UID = FirebaseAuth.instance.currentUser?.uid;
                                db.collection('Users').doc(UID).get().then((event){
                                  print("${event.data()}");

                                  event.data()?.forEach((key, value) {

                                    print(key);
                                    print(value);

                                    if(key == 'RelatorioDays'){

                                      String dayHj = '${DateTime.now().day}';
                                      print('Dia do relatiorio são ${value}');
                                      print('Dia de hoje é ${DateTime.now().day}');

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
                          print('O está ativo está funcionando!');

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
            print('Ele é um Operador Empresarial');

            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) {

                print(key);
                print(value);

                if(key == 'nome'){
                  print('Ele é um Operador Empresarial');
                  String nome = value;
                  //Passar o codigo para mandar a tela
                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){
                    print("${event.data()}");

                    event.data()?.forEach((key, value) async {

                      print(key);
                      print(value);

                      if(key == 'estaativo'){
                        if(value == true){

                          var result = await dbInstance
                              .collection("operadorEmpresarial")
                              .doc(UID)
                              .get();

                          String empresaName = (result.get('empresa'));

                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return operadorEmpresarial(nome, empresaName);
                              }));

                        }else{

                          print('O está ativo está funcionando!');

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
checkislogOFFLine(context) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    host: 'localhost:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  var dbInstance = FirebaseFirestore.instance;

  final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

  try {
    final result = await Process.run('ping', ['-c', '1', ip]);
    if (result.exitCode == 0) {

      print('Ping realizado com sucesso para o endereço $ip');
    } else {

      print('Falha no ping para o endereço $ip');
    }
  } catch (e) {
    print('Erro ao executar o comando de ping: $e');
  }

  await FirebaseAuth.instance
      .idTokenChanges()
      .listen((User? user) async {
    if (user == null) {

      var resulte = await dbInstance
          .collection("Condominio")
          .doc('condominio')
          .get();

      String logoPath = resulte.get('imageURL');

      print('User is currently signed out!');
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return anteLogin(logoPath);
          }));

    } else {

      var UID = FirebaseAuth.instance.currentUser?.uid;

      var db = dbInstance;
      db.collection('Users').doc(UID).get().then((event){
        print("${event.data()}");

        event.data()?.forEach((key, value) {

          print(key);
          print(value);

          if(value == 'porteiro'){

            print('começo!');

            var db = dbInstance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) async {

                print(key);
                print(value);
                print('está passando para lá');
                print("${event.data()}");

                print('está passando para cá');


                print(UID);

                var result = await dbInstance
                    .collection("porteiro")
                    .doc(UID)
                    .get();

                bool cadastro = result.get('cadastrar');
                bool entrada = result.get('entrada');
                bool saida = result.get('saida');
                bool relatorio = result.get('relatorio');
                bool painel = result.get('painel');
                String PorteiroNome = result.get('nome');

                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel, '');
                    }));

              });

            }
            );
            print('Ele é um porteiro');
            //Passar o codigo para mandar a tela
          }

          if(value == 'empresa'){
            print('Ele é uma empresa');

            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) {

                print(key);
                print(value);

                bool relatorio = false;

                if(key == 'nome'){
                  print('É uma empresa');
                  String nome = value;
                  //Passar o codigo para mandar a tela
                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){
                    print("${event.data()}");

                    event.data()?.forEach((key, value) {

                      print(key);
                      print(value);

                      if(key == 'estaativo'){
                        if(value == true){

                          var db2 = dbInstance;
                          db2.collection('Users').doc(UID).get().then((event){
                            print("${event.data()}");

                            event.data()?.forEach((key, value) {

                              print(key);
                              print(value);

                              if(key == 'nome'){
                                print('É uma empresa');
                                String nome = value;
                                //Passar o codigo para mandar a tela
                                var db = dbInstance;
                                var UID = FirebaseAuth.instance.currentUser?.uid;
                                db.collection('Users').doc(UID).get().then((event){
                                  print("${event.data()}");

                                  event.data()?.forEach((key, value) {

                                    print(key);
                                    print(value);

                                    if(key == 'RelatorioDays'){

                                      String dayHj = '${DateTime.now().day}';
                                      print('Dia do relatiorio são ${value}');
                                      print('Dia de hoje é ${DateTime.now().day}');

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
                          print('O está ativo está funcionando!');

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
            print('Ele é um Operador Empresarial');

            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) {

                print(key);
                print(value);

                if(key == 'nome'){
                  print('Ele é um Operador Empresarial');
                  String nome = value;
                  //Passar o codigo para mandar a tela
                  var db = dbInstance;
                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  db.collection('Users').doc(UID).get().then((event){
                    print("${event.data()}");

                    event.data()?.forEach((key, value) async {

                      print(key);
                      print(value);

                      if(key == 'estaativo'){
                        if(value == true){

                          var result = await dbInstance
                              .collection("operadorEmpresarial")
                              .doc(UID)
                              .get();

                          String empresaName = (result.get('empresa'));

                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return operadorEmpresarial(nome, empresaName);
                              }));

                        }else{

                          print('O está ativo está funcionando!');

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

      print(widget.calloff == 'Ativo');
      print(widget.calloff == 'NaoAtivo');
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
      body: Column(
        children: const [
          Center(
              child: CircularProgressIndicator()
          ),
        ],
      ),
    );
  }
}
