import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Programado por HeroRickyGames

class empresaCadastrada extends StatefulWidget {
  String ADMName;
  String LogoPath;

  @override
  empresaCadastrada(this.ADMName, this.LogoPath, {super.key});
  _empresaCadastradaState createState() => _empresaCadastradaState();
}

class _empresaCadastradaState extends State<empresaCadastrada> {
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
        title: const Text('Empresas cadastradas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Image.asset(
                      'assets/icon.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                        child: const Text(
                        'Empresas',
                          style: TextStyle(
                          ),
                       ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Vagas',
                        style: TextStyle(
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        '',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 500,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('empresa')
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
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)
                              ),
                            ),
                            width: double.infinity,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          documents['nome'],
                                        style: TextStyle(
                                          fontSize: tamanhotexto
                                        ),
                                      ),
                                      Text(
                                        documents['vagas'],
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      ),
                                      ElevatedButton(onPressed: () async {

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
                                                              fontSize: tamanhotexto
                                                          ),
                                                        )
                                                    ),
                                                    TextButton(onPressed: () async {
                                                      var result = await FirebaseFirestore.instance
                                                          .collection("Condominio")
                                                          .doc('condominio')
                                                          .get();

                                                      List galpoesUsados = result.get('galpoesUsados');
                                                      int galpoesRestantes = result.get('galpoes');
                                                      Map galpoes = documents['galpaes'];


                                                      int vagasDisp = result.get('vagas');

                                                      int galpoesRestantesResult = galpoesRestantes + galpoes.length;

                                                      galpoesUsados.remove(galpoes[0]);

                                                      int number = galpoesUsados.length;

                                                      for (int i = number; i >= 1; i--) {

                                                        if(i == galpoesUsados.length){

                                                          int resultadoVagas = vagasDisp + int.parse(documents['vagas']);


                                                          FirebaseFirestore.instance
                                                              .collection('empresa')
                                                              .doc(documents['id'])
                                                              .delete().then((value){
                                                            FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                                              'galpoesUsados': galpoesUsados,
                                                              'vagas': resultadoVagas,
                                                              'galpoes': galpoesRestantesResult
                                                            }).then((value){
                                                              Navigator.of(context).pop();
                                                            });
                                                          });
                                                        }
                                                      }
                                                    },
                                                        child: Text(
                                                            'Prosseguir',
                                                          style: TextStyle(
                                                              fontSize: tamanhotexto
                                                          ),
                                                        )
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );

                                      }, child: const Icon(Icons.delete),)
                                    ],
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}