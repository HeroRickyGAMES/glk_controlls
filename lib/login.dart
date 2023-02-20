import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/cadastrese.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glk_controls/mainEmpresa.dart';
import 'package:glk_controls/mainPorteiro.dart';
import 'firebase_options.dart';

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
          title: Text(
              'GLK Controls - Login'
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
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
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
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

                                if(value == 'porteiro'){
                                  print('Ele é um porteiro');
                                  //Passar o codigo para mandar a tela
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context){
                                        return mainPorteiro();
                                      }));
                                }

                                if(value == 'empresa'){
                                  print('Ele é uma empresa');
                                  var UID = FirebaseAuth.instance.currentUser?.uid;

                                  var db = FirebaseFirestore.instance;
                                  db.collection('Users').doc(UID).get().then((event){
                                    print("${event.data()}");

                                    event.data()?.forEach((key, value) {

                                      print(key);
                                      print(value);

                                      if(key == 'nome'){
                                        print('Ele é uma empresa');
                                        String nome = value;
                                        //Passar o codigo para mandar a tela
                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return mainEmpresa(nome);
                                            }));
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
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Text(
                        'Ainda não tem uma conta?',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      TextButton(
                          onPressed: toCadastrese,
                          child: Text(
                            'Cadastre-se Agora!',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
