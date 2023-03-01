import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/cadastrese.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glk_controls/mainEmpresa.dart';
import 'package:glk_controls/mainPorteiro.dart';
import 'package:glk_controls/setorADM.dart';
import 'firebase_options.dart';
import 'operadorEmpresarial.dart';

//Programado por HeroRickyGames

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}
class _loginState extends State<login> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  toCadastrese(){

    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return registro();
        }));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              'GLK Controls - Login'
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child:
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
            ),
            Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Senha',
                      hintStyle: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                child:
                    ElevatedButton(
                      onPressed: (){
                        if(emailController.text != ''){
                          if(passController.text != ''){

                            FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passController.text
                            ).then((value) {
                              print(value);

                              var db = FirebaseFirestore.instance;
                              var UID = FirebaseAuth.instance.currentUser?.uid;
                              db.collection('Users').doc(UID).get().then((event){
                                print("${event.data()}");

                                event.data()?.forEach((key, value) {

                                  print(key);
                                  print(value);

                                  if(value == 'ADM'){

                                    var db = FirebaseFirestore.instance;
                                    var UID = FirebaseAuth.instance.currentUser?.uid;
                                    db.collection('Users').doc(UID).get().then((event){
                                      print("${event.data()}");

                                      event.data()?.forEach((key, value) {

                                        print(key);
                                        print(value);

                                        if(key == 'nome'){
                                          String ADMName = value;

                                          print('O ADM é ' + ADMName);

                                          var db = FirebaseFirestore.instance;
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
                                    print('Ele é um porteiro');
                                    var db = FirebaseFirestore.instance;
                                    var UID = FirebaseAuth.instance.currentUser?.uid;
                                    db.collection('Users').doc(UID).get().then((event){
                                      print("${event.data()}");

                                      event.data()?.forEach((key, value) async {

                                        print(key);
                                        print(value);

                                        if(key == 'nome'){
                                          String PorteiroNome = value;

                                          print('Porteiro name é' + PorteiroNome);

                                          var UID = FirebaseAuth.instance.currentUser?.uid;
                                          var result = await FirebaseFirestore.instance
                                              .collection("porteiro")
                                              .doc(UID)
                                              .get();

                                          bool cadastro = result.get('cadastrar');
                                          bool entrada = result.get('entrada');
                                          bool saida = result.get('saida');
                                          bool relatorio = result.get('relatorio');
                                          bool painel = result.get('painel');


                                          Navigator.pop(context);
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context){
                                                return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel);
                                              }));

                                        }

                                      });

                                    }
                                    );
                                  }
                                  if(value == 'empresa'){
                                    print('Ele é uma empresa');

                                    db.collection('Users').doc(UID).get().then((event){
                                      print("${event.data()}");

                                      event.data()?.forEach((key, value) {

                                        print(key);
                                        print(value);

                                        if(key == 'nome'){
                                          print('Ele é uma empresa');
                                          String nome = value;
                                          //Passar o codigo para mandar a tela
                                          var db = FirebaseFirestore.instance;
                                          var UID = FirebaseAuth.instance.currentUser?.uid;
                                          db.collection('Users').doc(UID).get().then((event){
                                            print("${event.data()}");

                                            event.data()?.forEach((key, value) {

                                              print(key);
                                              print(value);

                                              if(key == 'estaativo'){
                                                if(value == true){

                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return mainEmpresa(nome);
                                                      }));

                                                }else{

                                                  print('O está ativo está funcionando!');

                                                  AlertDialog alert = AlertDialog(
                                                    title: Text("Sua conta ainda não está ativa!"),
                                                    content: Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: (){
                                                            SystemNavigator.pop();
                                                          },
                                                          child: Text('Ok')
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
                                          var db = FirebaseFirestore.instance;
                                          var UID = FirebaseAuth.instance.currentUser?.uid;
                                          db.collection('Users').doc(UID).get().then((event){
                                            print("${event.data()}");

                                            event.data()?.forEach((key, value) async {

                                              print(key);
                                              print(value);

                                              if(key == 'estaativo'){
                                                if(value == true){

                                                  var result = await FirebaseFirestore.instance
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
                                                    title: Text("Sua conta ainda não está ativa!"),
                                                    content: Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: (){
                                                            SystemNavigator.pop();
                                                          },
                                                          child: Text('Ok')
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


                            }).catchError((onError){

                              print(onError);

                              Fluttertoast.showToast(
                                msg: onError.toString().replaceFirst("[firebase_auth/wrong-password]", ""),
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );


                            });

                          }else{



                          }
                        }else{

                        }

                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                ),
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
                      'assets/icon.png',
                      fit: BoxFit.contain,
                    )
                ),
              ],
            ),
          ],
        ),
    );
  }
}
