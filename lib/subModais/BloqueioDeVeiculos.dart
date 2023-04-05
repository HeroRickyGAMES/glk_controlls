import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../relatorioGen/generatePDF/gerarPDFBloqueio.dart';

class bloqueioDePlacas extends StatefulWidget {
  @override
  _bloqueioDePlacasState createState() => _bloqueioDePlacasState();
}

class _bloqueioDePlacasState extends State<bloqueioDePlacas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bloqueio de Placas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Image.asset(
              'assets/icon.png',
              width: 300,
              height: 300,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Placa',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Veiculo',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Data',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('VeiculosBloqueados')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((documents) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                documents['placa'],
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            Text(
                              documents['tipoVeiculo'],
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat('dd-MM-yyyy HH:mm:ss').format(documents['dataDoBloqueio'].toDate()).replaceAll('-', '/'),
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                                TextButton(
                                  onPressed: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          icon:  Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Icon(Icons.zoom_out_sharp),
                                            ],
                                          ),
                                          title: Column(
                                            children: [
                                              Text('Bloqueio'),
                                              Container(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text('Veiculo:'  + documents['tipoVeiculo']),
                                                    Text('Data do Bloqueio:'  + DateFormat('dd-MM-yyyy HH:mm:ss').format(documents['dataDoBloqueio'].toDate()).replaceAll('-', '/'),),
                                                    Container(
                                                        padding: EdgeInsets.all(16),
                                                        child: Text('Motivo: \n'  + documents['Motivo']
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Row(

                                              mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                              children: [
                                                ElevatedButton(onPressed: (){

                                                  Navigator.of(context).pop();

                                                }, child: Text(
                                                    'Voltar',
                                                  style: TextStyle(
                                                      fontSize: 18
                                                  ),
                                                ),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.red
                                                  ),
                                                ),
                                                ElevatedButton(onPressed: (){

                                                  Navigator.of(context).pop();

                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return generatePDF2(documents['placa'], documents['tipoVeiculo'], documents['Motivo'], DateFormat('dd-MM-yyyy HH:mm:ss').format(documents['dataDoBloqueio'].toDate()).replaceAll('-', '/'));
                                                      }));

                                                }, child: Text(
                                                    'Imprimir',
                                                  style: TextStyle(
                                                      fontSize: 18
                                                  ),
                                                ),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.blue
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child:
                                  Icon(Icons.zoom_out_sharp),
                                ),
                                TextButton(
                                  onPressed: (){

                                  },
                                  child: Icon(Icons.delete),
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
        ],
      ),
    );
  }
}