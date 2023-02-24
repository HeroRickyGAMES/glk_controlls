import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class pesquisa extends StatefulWidget {
  String pesquisast;
  pesquisa(this.pesquisast);

  @override
  State<pesquisa> createState() => _pesquisaState();
}

class _pesquisaState extends State<pesquisa> {
  @override
  Widget build(BuildContext context) {
    String idDocumento;

    String holderPlaca = '';

    bool estaPesquisando = false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GLK Controls - EMPRESAS'),
        backgroundColor: Colors.red[700],
      ),
      body: Column(
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
                        child: GridView.count(
                          padding: const EdgeInsets.all(5),
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                          childAspectRatio: 0.57,
                          children:
                          snapshot.data!.docs.map((documents) {
                            String lacre = '${documents['LacreouNao']}';
                            String ColetaOuEntrega = '${documents['ColetaOuEntrega']}';
                            bool lacrebool = false;
                            bool coletaBool = false;
                            String lacrado = '';
                            String ColetaOuEntregast = '';
                            idDocumento = documents.id;

                            if(documents['PlacaVeiculo'] == widget.pesquisast){
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
                                    children: [
                                      Text(
                                        documents['PlacaVeiculo'],
                                        style:
                                        TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        child: Image
                                            .network(
                                          documents['uriImage'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          'Status: \n' +
                                              documents['Status'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: (){

                                          },
                                          child: Text(
                                            'Editar',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }else{
                              return Text('');
                            }
                          }
                          ).toList(),
                        ),
                      );
                    }
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}