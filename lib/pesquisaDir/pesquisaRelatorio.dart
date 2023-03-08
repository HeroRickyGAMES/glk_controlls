import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/relatorioGen/relatorioGenerate.dart';
import 'package:intl/intl.dart';
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
                                              onPressed: (){
                                                if(lacre == 'lacre'){

                                                  String formattedDate = '';
                                                  String formattedDate2 = '';
                                                  String formattedDate3 ='';
                                                  bool dataEntradabool = false;
                                                  bool datacriadobool = false;
                                                  bool datasaidabool = false;

                                                  if(documents['DataEntrada'] == ''){
                                                    dataEntradabool = false;
                                                  }else{
                                                    dataEntradabool = true;
                                                  }

                                                  if(documents['Horario Criado'] == ''){
                                                    datacriadobool = false;
                                                  }else{
                                                    datacriadobool = true;
                                                  }

                                                  if(documents['DataSaida'] == ''){
                                                    datasaidabool = false;
                                                  }else{
                                                    datasaidabool = true;
                                                  }

                                                  if(dataEntradabool == false){
                                                    formattedDate = '';
                                                  }

                                                  if(dataEntradabool == true){

                                                    Timestamp DataEntrada = documents['DataEntrada'];
                                                    formattedDate2 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataEntrada.toDate()).replaceAll('-', '/');
                                                  }

                                                  if(datacriadobool == false){
                                                    formattedDate2 = '';
                                                  }

                                                  if(datacriadobool == true){

                                                    Timestamp horarioCriacao = documents['Horario Criado'];
                                                    formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(horarioCriacao.toDate()).replaceAll('-', '/');
                                                  }

                                                  if(datasaidabool == false){
                                                    formattedDate3 = '';
                                                  }

                                                  if(datasaidabool == true){
                                                    Timestamp DataSaida = documents['DataSaida'];
                                                    formattedDate3 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataSaida.toDate()).replaceAll('-', '/');
                                                  }

                                                  String liberadopor = documents['QuemAutorizou'];
                                                  String nomeMotorista = documents['nomeMotorista'];
                                                  String Veiculo = documents['Veiculo'];
                                                  String PlacaVeiculo = documents['PlacaVeiculo'];
                                                  String Empresadestino = documents['Empresa'];
                                                  String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                  String Galpao = documents['Galpão'];
                                                  String lacradoStr = documents['lacrenum'];
                                                  String RG = documents['RGDoMotorista'];
                                                  String telefone = documents['Telefone'];
                                                  String saidaLiberadaPor = documents['saidaLiberadaPor'];
                                                  String imageURL = documents['uriImage'];

                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return relatorioGenerate(lacre, "", liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, lacradoStr, documents.id, formattedDate2, formattedDate3, RG, telefone, saidaLiberadaPor, imageURL);
                                                      }));

                                                }
                                                else{
                                                  if(lacre == 'naolacrado'){

                                                    String formattedDate = '';
                                                    String formattedDate2 = '';
                                                    String formattedDate3 ='';
                                                    bool dataEntradabool = false;
                                                    bool datacriadobool = false;
                                                    bool datasaidabool = false;

                                                    if(documents['DataEntrada'] == ''){
                                                      dataEntradabool = false;
                                                    }else{
                                                      dataEntradabool = true;
                                                    }

                                                    if(documents['Horario Criado'] == ''){
                                                      datacriadobool = false;
                                                    }else{
                                                      datacriadobool = true;
                                                    }

                                                    if(documents['DataSaida'] == ''){
                                                      datasaidabool = false;
                                                    }else{
                                                      datasaidabool = true;
                                                    }

                                                    if(dataEntradabool == false){
                                                      formattedDate = '';
                                                    }

                                                    if(dataEntradabool == true){

                                                      Timestamp DataEntrada = documents['DataEntrada'];
                                                      formattedDate2 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataEntrada.toDate()).replaceAll('-', '/');
                                                    }

                                                    if(datacriadobool == false){
                                                      formattedDate2 = '';
                                                    }

                                                    if(datacriadobool == true){

                                                      Timestamp horarioCriacao = documents['Horario Criado'];
                                                      formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(horarioCriacao.toDate()).replaceAll('-', '/');
                                                    }

                                                    if(datasaidabool == false){
                                                      formattedDate3 = '';
                                                    }

                                                    if(datasaidabool == true){
                                                      Timestamp DataSaida = documents['DataSaida'];
                                                      formattedDate3 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataSaida.toDate()).replaceAll('-', '/');
                                                    }

                                                    String imageURL = '';

                                                    String liberadopor = documents['QuemAutorizou'];
                                                    String nomeMotorista = documents['nomeMotorista'];
                                                    String Veiculo = documents['Veiculo'];
                                                    String PlacaVeiculo = documents['PlacaVeiculo'];
                                                    String Empresadestino = documents['Empresa'];
                                                    String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                    String Galpao = documents['Galpão'];
                                                    String RG = documents['RGDoMotorista'];
                                                    String telefone = documents['Telefone'];
                                                    String saidaLiberadaPor = documents['saidaLiberadaPor'];


                                                    if(documents['uriImage'] == ''){
                                                      imageURL = 'https://cdn-icons-png.flaticon.com/512/75/75519.png';
                                                    }else{
                                                      imageURL = documents['uriImage'];
                                                    }

                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context){
                                                          return relatorioGenerate(lacre, "", liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, formattedDate2, formattedDate3, RG, telefone, saidaLiberadaPor, imageURL);
                                                        }));
                                                  }
                                                }
                                              },
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