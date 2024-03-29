import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Programado por HeroRickyGames

class pesquisa extends StatefulWidget {
  String pesquisast;
  String oqPesquisar;
  pesquisa(this.pesquisast, this.oqPesquisar);

  @override
  State<pesquisa> createState() => _pesquisaState();
}

class _pesquisaState extends State<pesquisa> {
  @override
  Widget build(BuildContext context) {
    String idDocumento;

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
        title: const Text('GLK Controls - PESQUISAS'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore
                          .instance
                          .collection('Autorizacoes')
                          .where(widget.oqPesquisar, isEqualTo: widget.pesquisast)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 900,
                          width: double.infinity,
                          child: OrientationBuilder(
                            builder: (context, orientation) {
                              return GridView.count(
                                crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: orientation == Orientation.portrait ? 1.0 : 0.7,
                                children:
                                snapshot.data!.docs.map((documents) {
                                  String lacre = '${documents['LacreouNao']}';
                                  String ColetaOuEntrega = '${documents['ColetaOuEntrega']}';
                                  bool lacrebool = false;
                                  bool coletaBool = false;
                                  String lacrado = '';
                                  String ColetaOuEntregast = '';
                                  idDocumento = documents.id;

                                  if(lacre == 'lacre'){
                                    lacrebool = true;
                                    lacrado = 'Lacrado';
                                  }
                                  if(lacre == 'naolacrado'){
                                    lacrebool = false;
                                    lacrado = 'Não Lacrado';
                                  }
                                  if(ColetaOuEntrega == 'coleta'){
                                    coletaBool = true;
                                    ColetaOuEntregast = 'Coleta';
                                  }
                                  if(ColetaOuEntrega == 'entrega'){
                                    coletaBool = false;
                                    ColetaOuEntregast = 'Entrega';
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: Colors.grey[300],
                                      padding: const EdgeInsets.all(16),
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            documents['PlacaVeiculo'],
                                            style:
                                            TextStyle(
                                                fontSize: tamanhotexto,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              'Status: \n' +
                                                  documents['Status'],
                                              style: TextStyle(
                                                  fontSize: tamanhotexto,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: null,
                                              child: Text(
                                                'Mudar algo',
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                }
                                ).toList().reversed.toList(),
                              );
                            },
                          ),
                        );
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}