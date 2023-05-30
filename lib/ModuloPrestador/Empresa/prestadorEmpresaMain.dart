import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/anteLogin.dart';

class PrestadorEmpresaMain extends StatefulWidget {
  String Empresa = '';
  String IDEmpresa = '';
  PrestadorEmpresaMain(this.Empresa, this.IDEmpresa,{Key? key}) : super(key: key);

  @override
  State<PrestadorEmpresaMain> createState() => _PrestadorEmpresaMainState();
}

class _PrestadorEmpresaMainState extends State<PrestadorEmpresaMain> {
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
        backgroundColor: Colors.blue,
        title: const Text('Controle dos intenos'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(

                  ),
                  child: Text(
                    'Criar cadastro',
                    style: TextStyle(
                      fontSize: tamanhotextobtns,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(

                  ),
                  child: Text(
                    'Pesquisar Cadastro',
                    style: TextStyle(
                      fontSize: tamanhotextobtns,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(

                  ),
                  child: Text(
                    'Lista de Internos',
                    style: TextStyle(
                      fontSize: tamanhotextobtns,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut().then((value) async {

                                      var resulte = await FirebaseFirestore.instance
                                          .collection("Condominio")
                                          .doc('condominio')
                                          .get();

                                      String logoPath = resulte.get('imageURL');

                                      Navigator.pop(context);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context){
                                            return anteLogin(logoPath);
                                          }));
                                    });

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red
                                  ),
                                  child: const Text(
                                    'Sair',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Container(
                        padding: const EdgeInsets.all(16),
                        child:
                        Column(
                          children: [
                            Text(
                              'Operador: ${widget.Empresa}',
                              style: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
