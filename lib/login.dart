import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/mainPorteiro.dart';
import 'package:glk_controls/setorADM.dart';
import 'package:glk_controls/operadorEmpresarial.dart';

//Programado por HeroRickyGames

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}
class _loginState extends State<login> {

  bool visivel = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
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
    
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
              'GLK Controls - Login'
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
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
                    Center(
                        child:
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            ),
                          ),
                        ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: visivel,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                                fontSize: tamanhotexto
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                             setState(() {
                               visivel = !visivel;
                             });
                          },
                        )
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child:
                        ElevatedButton(
                          onPressed: (){
                            if(emailController.text != ''){
                              if(passController.text != ''){

                                FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text
                                ).then((value) {

                                  var db = FirebaseFirestore.instance;
                                  var UID = FirebaseAuth.instance.currentUser?.uid;
                                  db.collection('Users').doc(UID).get().then((event){

                                    event.data()?.forEach((key, value) {


                                      if(value == 'ADM'){

                                        var db = FirebaseFirestore.instance;
                                        var UID = FirebaseAuth.instance.currentUser?.uid;
                                        db.collection('Users').doc(UID).get().then((event){

                                          event.data()?.forEach((key, value) {


                                            if(key == 'nome'){
                                              String ADMName = value;


                                              var db = FirebaseFirestore.instance;
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
                                        var db = FirebaseFirestore.instance;
                                        var UID = FirebaseAuth.instance.currentUser?.uid;
                                        db.collection('Users').doc(UID).get().then((event){

                                          event.data()?.forEach((key, value) async {


                                            if(key == 'nome'){
                                              String PorteiroNome = value;


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
                                              String Email = result.get('email');


                                              var resulte = await FirebaseFirestore.instance
                                                  .collection("Condominio")
                                                  .doc('condominio')
                                                  .get();

                                              String logoPath = resulte.get('imageURL');

                                              bool liberacao = result.get('liberacao');

                                              Navigator.pop(context);
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context){
                                                    return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel, logoPath, Email, liberacao);
                                                  }));

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
                                              var db = FirebaseFirestore.instance;
                                              var UID = FirebaseAuth.instance.currentUser?.uid;
                                              db.collection('Users').doc(UID).get().then((event){

                                                event.data()?.forEach((key, value) async {


                                                  if(key == 'estaativo'){
                                                    if(value == true){

                                                      var result = await FirebaseFirestore.instance
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
                                }).catchError((onError){


                                  Fluttertoast.showToast(
                                    msg: onError.toString().replaceFirst("[firebase_auth/wrong-password]", ""),
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: tamanhotexto,
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
                                fontSize: tamanhotexto
                            ),
                          ),
                        ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
