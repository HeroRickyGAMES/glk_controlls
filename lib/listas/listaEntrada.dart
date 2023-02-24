import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pesquisaDir/pesquisa.dart';

class listEntrada extends StatefulWidget {
  String porteiroName;
  listEntrada(this.porteiroName, {Key? key}) : super(key: key);

  @override
  State<listEntrada> createState() => _listEntradaState();
}

class _listEntradaState extends State<listEntrada> {
  String? idDocumento;

  @override
  Widget build(BuildContext context) {
    String holderPlaca = '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GLK Controls - ENTRADA'),
        backgroundColor: Colors.green[700],
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
                      fontSize: 20
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
                              color: Colors.green
                          )
                      ),
                      hintStyle: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: (){

                        if(holderPlaca == ''){

                          Fluttertoast.showToast(
                            msg: '´Preencha a pesquisa!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
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

                                if(documents['Status'] != 'Autorizado a entrar na empresa'){
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
                            }).toList(),
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
                        fontSize: 20
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
