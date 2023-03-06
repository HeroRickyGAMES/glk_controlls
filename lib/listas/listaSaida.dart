import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pesquisaDir/pesquisa.dart';

//Programado por HeroRickyGames

class listaSaida extends StatefulWidget {
  String porteiroName;
  listaSaida(this.porteiroName, {Key? key}) : super(key: key);

  @override
  State<listaSaida> createState() => _listaSaidaState();
}

class _listaSaidaState extends State<listaSaida> {
  String? idDocumento;

  @override
  Widget build(BuildContext context) {
    String holderPlaca = '';

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.5;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextomin = 16;
      tamanhotextobtns = 34;
      aspect = 1.3;
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 20;
        tamanhotextobtns = 34;
        aspect =  1.3;

      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'GLK Controls - SAIDA',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child:
              Column(
                children: [
                  Text(
                    'Pesquisar Placa:',
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                  TextFormField(
                    onChanged: (valor){

                      String value = valor.replaceAll(' ', '').toUpperCase();;

                      holderPlaca = value.replaceAllMapped(
                        RegExp(r'^([a-zA-Z]{3})([0-9]{4})$'),
                            (Match m) => '${m[1]}-${m[2]}',
                      );
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow
                          )
                      ),
                      hintStyle: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: (){

                        if(holderPlaca == ''){

                          Fluttertoast.showToast(
                            msg: 'Preencha a pesquisa!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotextomin,
                          );

                        }else{


                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return pesquisa(holderPlaca);
                              }));
                        }
                      },
                      child: Text(
                          'Pesquisar'
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore
                          .instance
                          .collection('Autorizacoes')
                          .where('Status', isEqualTo: 'Liberado')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 700,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: GridView.count(
                            padding: const EdgeInsets.all(5),
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                            crossAxisCount: 2,
                            childAspectRatio: aspect,
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
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child:
                                  Column(
                                    children: [
                                      ElevatedButton(
                                          onPressed: (){
                                            showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Deseja liberar a saída?'),
                                                  content: SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text('Deseja liberar a saída desse veiculo?'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Rejeitar Saida'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();

                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                          'Permitir Saida',
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();

                                                        FirebaseFirestore.instance.collection('Autorizacoes').doc(documents.id).update({
                                                          'DataEntrada': DateTime.now(),
                                                          'Status': 'Saida'
                                                        });

                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            documents['PlacaVeiculo'],
                                            style: TextStyle(
                                              fontSize: tamanhotextobtns,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
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
                                    ],
                                  ),
                                ),
                              );
                            }).toList().reversed.toList(),
                          ),
                        );
                      }
                  ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: 180,
                    height: 180,
                    padding: EdgeInsets.all(16),
                    child:
                    Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.contain,
                    )
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child:
                  Text(
                    'Operador: ' + widget.porteiroName,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
