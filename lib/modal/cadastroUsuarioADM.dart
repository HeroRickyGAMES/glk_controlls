import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/Painel.dart';

class cadastroUsuarioModal extends StatefulWidget {
  var dropValue;
  List listaNome;

  String ADMName;
  String LogoPath;
  cadastroUsuarioModal(this.dropValue, this.listaNome, this.ADMName, this.LogoPath, {super.key});

  @override
  State<cadastroUsuarioModal> createState() => _cadastroUsuarioModalState();
}

class _cadastroUsuarioModalState extends State<cadastroUsuarioModal> {

  String nomeComp = '';
  String RG = '';
  String telNum = '';
  String email = '';
  String pass = '';
  String empresaSelecionada = '';
  String empresaID = '';
  String IDSe = '';
  String NamesE = '';
  bool visivel = true;

  casts() async {
    List tst = [];
    List Names = [];

    final usersCollection = FirebaseFirestore.instance.collection('empresa');
    final snapshot = await usersCollection.get();
    final documents = snapshot.docs;

    for (final doc in documents) {
      tst.addAll(documents);

      if(documents.length == tst.length){
        final id = doc.id;
        final name = doc.get('nome');
        Names.add(name);
        IDSe = id;
        NamesE = name;
      }
    }
  }

@override
  void initState() {

  casts();

    // TODO: implement initState
    super.initState();
  }
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
        title: const Text('Cadastro de Operadores de Empresas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
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
                    hintText: 'Nome completo *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotextobtns
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
                    border: OutlineInputBorder(),
                    hintText: 'RG (Sem o dígito) * ',
                    hintStyle: TextStyle(
                        fontSize: tamanhotextobtns
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
                    border: OutlineInputBorder(),
                    hintText: 'Telefone',
                    hintStyle: TextStyle(
                        fontSize: tamanhotextobtns
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
                    border: OutlineInputBorder(),
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
                    border: OutlineInputBorder(),
                    hintText: 'Senha * ',
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
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Empresa do Operador *',
                  style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                    return DropdownButton(
                      hint: Text(
                        'Selecione uma empresa',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue.value = escolha.toString();

                        empresaSelecionada = escolha.toString();
                        empresaID = escolha.toString();

                      },
                      items: widget.listaNome.map((opcao) => DropdownMenuItem(
                        value: opcao,
                        child:
                        Text(
                          opcao,
                          style: TextStyle(
                              fontSize: tamanhotextobtns
                          ),
                        ),
                      ),
                      ).toList(),
                    );
                  })
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () async {

                      if(nomeComp == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o nome completo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotextobtns,
                          );
                      }else{

                        if(RG == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o RG!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotextobtns,
                          );
                        }else{

                          if(email == ''){
                            Fluttertoast.showToast(
                              msg: 'Preencha o email!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: tamanhotextobtns,
                            );
                          }else{
                            if(empresaSelecionada == ''){
                              Fluttertoast.showToast(
                                msg: 'Selecione a empresa que o Operador irá trabalhar!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: tamanhotextobtns,
                              );
                            }else{
                              if(pass == ''){
                                Fluttertoast.showToast(
                                  msg: 'Preencha a senha!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: tamanhotextobtns,
                                );
                              }else{
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

                                List tst = [];
                                List Names = [];

                                final usersCollection = FirebaseFirestore.instance.collection('empresa');
                                final snapshot = await usersCollection.get();
                                final documents = snapshot.docs;

                                for (final doc in documents) {


                                  tst.addAll(documents);
                                  final id = doc.id;
                                  IDSe = id;
                                  empresaSelecionada = empresaSelecionada.replaceAll(IDSe, '');

                                  final name = doc.get('nome');

                                  Names.add(name);



                                  NamesE = name;

                                  empresaID = empresaID.replaceAll(NamesE, '');
                                  empresaSelecionada = empresaSelecionada.replaceAll(IDSe, '');



                                }
                                FirebaseApp app = await Firebase.initializeApp(
                                    name: 'Secondary', options: Firebase.app().options);
                                try {
                                  UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
                                      .createUserWithEmailAndPassword(email: email, password: pass);

                                  Fluttertoast.showToast(
                                    msg: 'Cadastrando Operador Empresarial...',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: tamanhotextobtns,
                                  );
                                  FirebaseFirestore.instance.collection('operadorEmpresarial').doc(userCredential.user?.uid).set(
                                      {
                                        'nome': nomeComp,
                                        'RG': RG,
                                        'Telefone': telNum,
                                        'email': email,
                                        'tipoConta': 'operadorEmpresarial',
                                        'empresa': empresaSelecionada,
                                        'idEmpresa': empresaID,
                                        'estaativo': true,
                                        'id': userCredential.user?.uid
                                      }
                                  );
                                  FirebaseFirestore.instance.collection('Users').doc(userCredential.user?.uid).set(
                                      {
                                        'nome': nomeComp,
                                        'RG': RG,
                                        'Telefone': telNum,
                                        'email': email,
                                        'tipoConta': 'operadorEmpresarial',
                                        'empresa': empresaSelecionada,
                                        'idEmpresa': empresaID,
                                        'estaativo': true,
                                        'id': userCredential.user?.uid
                                      }
                                  ).then((value) {
                                    Fluttertoast.showToast(
                                      msg: 'Operador Empresarial cadastrado com sucesso!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: tamanhotextobtns,
                                    );
                                    widget.listaNome.clear();
                                    Navigator.of(context).pop();
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
                                    fontSize: tamanhotextobtns,
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
                      'Confirmar cadastro',
                      style: TextStyle(
                          fontSize: tamanhotextobtns,
                          fontWeight: FontWeight.bold
                      ),),
                  )
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
                      Text(
                        'ADM : ${widget.ADMName}',
                        style: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                    ),
                    WillPopScope(
                      onWillPop: () async {

                        widget.listaNome.clear();
                        var result = await FirebaseFirestore.instance
                            .collection("Condominio")
                            .doc('condominio')
                            .get();

                        String logoPath = result.get('imageURL');

                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return painelADM(widget.ADMName, logoPath);
                            }));

                        return false;
                      }, child: const Text(''),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
