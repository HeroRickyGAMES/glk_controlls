import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Programado por HeroRickyGames

class UsuariosCadastrados extends StatefulWidget {
  String ADMName;
  String LogoPath;
  UsuariosCadastrados(this.ADMName, this.LogoPath);

  @override
  State<UsuariosCadastrados> createState() => _UsuariosCadastradosState();
}

class _UsuariosCadastradosState extends State<UsuariosCadastrados> {


  bool interno = true;
  String OperadorTipe = 'Operador Interno';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(interno == true){
      setState(() {
        OperadorTipe = 'Operador Interno';
      });
    }else{
      setState(() {
        OperadorTipe = 'Operador de Empresa';
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final textScaleFactor = mediaQueryData.textScaleFactor;
    final dpi = mediaQueryData.devicePixelRatio;

    final textHeight = screenHeight * 0.05;
    final textWidth = screenWidth * 0.8;

    final textSize = (textHeight / dpi / 2) * textScaleFactor;

    String idDocumento;

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    Map Galpoes = { };
    List GalpoesList = [ ];

    if(kIsWeb){
      tamanhotexto = textSize;
      tamanhotextobtns = textSize;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;
        aspect = 0.8;

      }
    }

    return LayoutBuilder(builder: (context, constrains){
      double wid = 60;
      if(constrains.maxWidth < 600){
        wid = 60;
      }else {
        if(constrains.maxWidth > 600){
          wid = 150;
        }
      }


      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Usuarios Cadastrados'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: CheckboxListTile(
                  title: Text(
                    OperadorTipe,
                    style: TextStyle(
                        fontSize: tamanhotextobtns
                    ),
                  ),
                  value: interno,
                  onChanged: (bool? value) {
                    setState(() {
                      interno = value!;

                      if(interno == true){
                        setState(() {
                          OperadorTipe = 'Operador Interno';
                        });
                      }else{
                        setState(() {
                          OperadorTipe = 'Operador de Empresa';
                        });
                      }

                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Nome",
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Empresa",
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Status",
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "",
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ],
              ),
              if (interno == true) SizedBox(
                height: 700,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('porteiro')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((documents) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: wid,
                                  child: Text(documents['nome'],
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                const Text('SLG Sanca',
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text('Interno',
                                      style: TextStyle(
                                          fontSize: 16
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () async {

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(documents['nome']),
                                                  actions: [
                                                    Center(
                                                      child: Text(
                                                        'Deseja Excluir?',
                                                        style: TextStyle(
                                                            fontSize: tamanhotextobtns
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                            child: Text(
                                                              'Cancelar',
                                                              style: TextStyle(
                                                                  fontSize: tamanhotextobtns
                                                              ),
                                                            )
                                                        ),
                                                        TextButton(onPressed: () async {
                                                          FirebaseFirestore.instance
                                                              .collection('porteiro')
                                                              .doc(documents['id'])
                                                              .delete().then((value){
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                            child: Text(
                                                              'Prosseguir',
                                                              style: TextStyle(
                                                                  fontSize: tamanhotextobtns
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
                                          child: const Row(
                                            children: [
                                              Icon(Icons.delete),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Usuario: ${documents['nome']}'),
                                                    actions: [
                                                      Center(
                                                        child: Text(
                                                          'Informações do Usuario: \n Email: ${documents['email']}',
                                                          style: TextStyle(
                                                              fontSize: tamanhotextobtns
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          TextButton(onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                              child: Text(
                                                                'Cancelar',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotextobtns
                                                                ),
                                                              )
                                                          ),
                                                          TextButton(onPressed: () async {
                                                            Navigator.of(context).pop();
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: const Text('Tem certeza que deseja resetar essa senha?'),
                                                                  actions: [
                                                                    Center(
                                                                      child: Container(
                                                                        padding: const EdgeInsets.all(16),
                                                                        child: Text(
                                                                          'Depois de fazer essa ação, enviaremos um email para a conta cadastrada',
                                                                          style: TextStyle(
                                                                              fontSize: tamanhotextobtns
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        TextButton(onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                            child: Text(
                                                                              'Cancelar',
                                                                              style: TextStyle(
                                                                                  fontSize: tamanhotextobtns
                                                                              ),
                                                                            )
                                                                        ),
                                                                        TextButton(onPressed: () async {
                                                                          try {
                                                                            await FirebaseAuth.instance.sendPasswordResetEmail(email: documents['email']).then((value){
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
                                                                            child: Text(
                                                                              'Resetar Senha',
                                                                              style: TextStyle(
                                                                                  fontSize: tamanhotextobtns
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
                                                              child: Text(
                                                                'Resetar Senha',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotextobtns
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
                                            child: const Row(
                                              children: [
                                                Icon(Icons.remove_red_eye),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ) else SizedBox(
                height: 800,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('operadorEmpresarial')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((documentos) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: wid,
                                  child: Text(documentos['nome'],
                                    style: const TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: wid,
                                  child: Text(documentos['empresa'],
                                    style: const TextStyle(
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text('Empresa',
                                      style: TextStyle(
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(documentos['nome']),
                                                  actions: [
                                                    Center(
                                                      child: Text(
                                                        'Deseja Excluir?',
                                                        style: TextStyle(
                                                            fontSize: tamanhotextobtns
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                            child: Text(
                                                              'Cancelar',
                                                              style: TextStyle(
                                                                  fontSize: tamanhotextobtns
                                                              ),
                                                            )
                                                        ),
                                                        TextButton(onPressed: () async {
                                                          FirebaseFirestore.instance
                                                              .collection('operadorEmpresarial')
                                                              .doc(documentos['id'])
                                                              .delete().then((value){
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                            child: Text(
                                                              'Prosseguir',
                                                              style: TextStyle(
                                                                  fontSize: tamanhotextobtns
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
                                          child: const Row(
                                            children: [
                                              Icon(Icons.delete),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Usuario: ${documentos['nome']}'),
                                                    actions: [
                                                      Center(
                                                        child: Text(
                                                          'Informações do Usuario: \n Email: ${documentos['email']}',
                                                          style: TextStyle(
                                                              fontSize: tamanhotextobtns
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          TextButton(onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                              child: Text(
                                                                'Cancelar',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotextobtns
                                                                ),
                                                              )
                                                          ),
                                                          TextButton(onPressed: () async {
                                                            Navigator.of(context).pop();
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: const Text('Tem certeza que deseja resetar essa senha?'),
                                                                  actions: [
                                                                    Center(
                                                                      child: Container(
                                                                        padding: const EdgeInsets.all(16),
                                                                        child: Text(
                                                                          'Depois de fazer essa ação, enviaremos um email para a conta cadastrada',
                                                                          style: TextStyle(
                                                                              fontSize: tamanhotextobtns
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        TextButton(onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                            child: Text(
                                                                              'Cancelar',
                                                                              style: TextStyle(
                                                                                  fontSize: tamanhotextobtns
                                                                              ),
                                                                            )
                                                                        ),
                                                                        TextButton(onPressed: () async {
                                                                          try {
                                                                            await FirebaseAuth.instance.sendPasswordResetEmail(email: documentos['email']).then((value){
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
                                                                            child: Text(
                                                                              'Resetar Senha',
                                                                              style: TextStyle(
                                                                                  fontSize: tamanhotextobtns
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
                                                              child: Text(
                                                                'Resetar Senha',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotextobtns
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
                                            child: const Row(
                                              children: [
                                                Icon(Icons.remove_red_eye),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
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
      );

    });
  }
}