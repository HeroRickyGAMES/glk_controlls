import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class operadorInterno extends StatefulWidget {
  const operadorInterno({Key? key}) : super(key: key);

  @override
  State<operadorInterno> createState() => _operadorInternoState();
}

class _operadorInternoState extends State<operadorInterno> {
  String nomeComp = '';
  String RG = '';
  String telNum = '';
  String email = '';
  String pass = '';
  bool painelbool = false;
  bool relatoriosbool = false;
  bool entradabool = false;
  bool cadastrarbool = false;
  bool saidabool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Cadastro de Operadores Internos'
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.only(top: 60),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    nomeComp = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome Completo *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    RG = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'RG *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    telNum = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Telefone *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    email = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    pass = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.visiblePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Senha *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                        'Permissões',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text('Cadastrar'),
                    value: cadastrarbool,
                    onChanged: (value) {
                      setState(() {
                        cadastrarbool = value!;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text('Saida'),
                    value: saidabool,
                    onChanged: (value) {
                      setState(() {
                        saidabool = value!;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text('Entrada'),
                    value: entradabool,
                    onChanged: (value) {
                      setState(() {
                        entradabool = value!;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text('Relatórios'),
                    value: relatoriosbool,
                    onChanged: (value) {
                      setState(() {
                        relatoriosbool = value!;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text('Painel'),
                    value: painelbool,
                    onChanged: (value) {
                      setState(() {
                        painelbool = value!;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {

                    if(nomeComp == ''){
                      Fluttertoast.showToast(
                        msg: 'Preencha o nome completo!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 20,
                      );
                    }else{
                      if(RG == ''){
                        Fluttertoast.showToast(
                          msg: 'Preencha o RG!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 20,
                        );
                      }else{
                        if(telNum == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o número de telefone!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 20,
                          );
                        }else{
                          if(email == ''){
                            Fluttertoast.showToast(
                              msg: 'Preencha o Email!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 20,
                            );
                          }else{
                            if(pass == ''){
                              Fluttertoast.showToast(
                                msg: 'Preencha a senha!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 20,
                              );
                            }else{

                              //todo

                              FirebaseApp app = await Firebase.initializeApp(
                                  name: 'Secondary', options: Firebase.app().options);
                              try {
                                UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
                                    .createUserWithEmailAndPassword(email: email, password: pass);

                                Fluttertoast.showToast(
                                  msg: 'Cadastrando operador interno...',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 20,
                                );
                                FirebaseFirestore.instance.collection('porteiro').doc(userCredential.user?.uid).set(
                                    {
                                      'nome': nomeComp,
                                      'RG': RG,
                                      'Telefone': telNum,
                                      'email': email,
                                      'painel': painelbool,
                                      'relatorio': relatoriosbool,
                                      'entrada': entradabool,
                                      'cadastrar': cadastrarbool,
                                      'saida': saidabool,
                                      'tipoConta': 'porteiro',
                                      'estaativo': true,
                                      'id': userCredential.user?.uid,
                                    }
                                );
                                FirebaseFirestore.instance.collection('Users').doc(userCredential.user?.uid).set(
                                    {
                                      'nome': nomeComp,
                                      'RG': RG,
                                      'Telefone': telNum,
                                      'email': email,
                                      'painel': painelbool,
                                      'relatorio': relatoriosbool,
                                      'entrada': entradabool,
                                      'cadastrar': cadastrarbool,
                                      'saida': saidabool,
                                      'tipoConta': 'porteiro',
                                      'estaativo': true,
                                      'id': userCredential.user?.uid
                                    }
                                ).then((value) {
                                  Fluttertoast.showToast(
                                    msg: 'operador interno cadastrada com sucesso!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 20,
                                  );
                                  Navigator.pop(context);
                                });

                              }
                              on FirebaseAuthException catch (e) {
                                Fluttertoast.showToast(
                                  msg: e.message.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 20,
                                );
                              }
                              await app.delete();

                            }
                          }
                        }
                      }
                    }

                  },
                  child: Text(
                    'Cadastrar usuario',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
