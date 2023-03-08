import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//Programado por HeroRickyGames

class pesquisaRelatorio extends StatefulWidget {
  String pesquisaRelatoriost;
  String oqPesquisar;
  pesquisaRelatorio(this.pesquisaRelatoriost, this.oqPesquisar);

  @override
  State<pesquisaRelatorio> createState() => _pesquisaRelatorioState();
}

class _pesquisaRelatorioState extends State<pesquisaRelatorio> {
  @override
  Widget build(BuildContext context) {
    String idDocumento;

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double aspect = 1.0;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextomin = 16;
      aspect = 0.8;
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 20;
        aspect = 1.0;

      }
    }

    gerarRelatorio(){

    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GLK Controls - Pesquisa Relatório'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child:
              Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore
                          .instance
                          .collection('Autorizacoes')
                          .where(widget.oqPesquisar, isEqualTo: widget.pesquisaRelatoriost)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
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
                                      padding: EdgeInsets.all(16),
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Nome do motorista: ' + documents['nomeMotorista'],
                                            style:
                                            TextStyle(
                                                fontSize: tamanhotexto,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            'RG: ' +documents['RGDoMotorista'],
                                            style:
                                            TextStyle(
                                                fontSize: tamanhotexto,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            documents['PlacaVeiculo'],
                                            style:
                                            TextStyle(
                                                fontSize: tamanhotexto,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(16),
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
                                              onPressed: gerarRelatorio(),
                                              child: Text(
                                                'Gerar Relatório',
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