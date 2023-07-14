import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Programado por HeroRickyGames

class operadorInterno extends StatefulWidget {
  String ADMName;
  String LogoPath;
  operadorInterno(this.ADMName, this.LogoPath);

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
  bool liberacao = false;
  bool relatoriosbool = false;
  bool entradabool = false;
  bool cadastrarbool = false;
  bool saidabool = false;
  bool visivel = true;
  bool relatorioColaborador = true;
  bool listaColaborador = true;

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
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    nomeComp = valor.trim();
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Nome Completo *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    RG = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'RG *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    telNum = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Telefone',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    email = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Email *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    pass = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.visiblePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: visivel,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Senha *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
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
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        'Permissões',
                      style: TextStyle(
                        fontSize: tamanhotexto,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('Cadastrar'),
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
                    title: const Text('Saida'),
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
                    title: const Text('Entrada'),
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
                    title: const Text('Relatórios'),
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
                    title: const Text('Painel'),
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
                  CheckboxListTile(
                    title: const Text('Liberação Manual'),
                    value: liberacao,
                    onChanged: (value) {
                      setState(() {
                        liberacao = value!;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: const Text('Lista de colaboradores'),
                    value: listaColaborador,
                    onChanged: (value) {
                      setState(() {
                        listaColaborador = value!;
                      });
                    },
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: const Text('Relatorio de colaboradores'),
                    value: relatorioColaborador,
                    onChanged: (value) {
                      setState(() {
                        relatorioColaborador = value!;
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
                        fontSize: tamanhotexto,
                      );
                    }else{
                      if(RG == ''){
                        Fluttertoast.showToast(
                          msg: 'Preencha o RG!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: tamanhotexto,
                        );
                      }else{

                        if(email == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o Email!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotexto,
                          );
                        }else{
                          if(pass == ''){
                            Fluttertoast.showToast(
                              msg: 'Preencha a senha!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: tamanhotexto,
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
                                fontSize: tamanhotexto,
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
                                    'liberacao': liberacao,
                                    'listaColaborador': listaColaborador,
                                    'relatorioColaborador': relatorioColaborador,
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
                                    'liberacao': liberacao,
                                    'id': userCredential.user?.uid,
                                    'listaColaborador': listaColaborador,
                                    'relatorioColaborador': relatorioColaborador,
                                  }
                              ).then((value) {
                                Fluttertoast.showToast(
                                  msg: 'operador interno cadastrada com sucesso!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: tamanhotexto,
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
                                fontSize: tamanhotexto,
                              );
                            }
                            await app.delete();

                          }
                        }
                      }
                    }
                  },
                  child: Text(
                    'Cadastrar usuario',
                    style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                      child:
                      Image.network(
                        widget.LogoPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                      child:
                      Column(
                        children: [
                          Text(
                            'ADM : ${widget.ADMName}',
                            style: TextStyle(
                                fontSize: tamanhotexto
                            ),
                          ),
                        ],
                      ),
                    ),
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
