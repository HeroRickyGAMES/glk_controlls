import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/cadastrese.dart';
import 'package:glk_controls/mainEmpresa.dart';
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
  toCadastrese(){

    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return const registro();
        }));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
              'GLK Controls - Login'
          ),
        ),
        body: Column(
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
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontSize: 16
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Senha',
                        hintStyle: TextStyle(
                            fontSize: 16
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
                        print('Botão favorito pressionado!');
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

                                          print('O ADM é $ADMName');

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

                                          print('Porteiro name é$PorteiroNome');

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

                                          Navigator.pop(context);
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context){
                                                return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel, logoPath, Email);
                                              }));

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
                                                  String Email = result.get('email');
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return operadorEmpresarial(nome, empresaName, Email);
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
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16
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
    );
  }
}
