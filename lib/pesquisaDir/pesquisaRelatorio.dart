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
  pesquisaRelatorio(this.pesquisaRelatoriost, this.oqPesquisar, {super.key});

  @override
  State<pesquisaRelatorio> createState() => _pesquisaRelatorioState();
}

class _pesquisaRelatorioState extends State<pesquisaRelatorio> {
  @override
  Widget build(BuildContext context) {

    double tamanhotexto = 20;
    double tamanhotextobtns = 16;
    double aspect = 1.5;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextobtns = 34;
      aspect = 1.3;
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;
        aspect =  1.3;

      }
    }

    DateTime dataAtual = DateTime.now();
    DateTime dataDe30DiasAtras = dataAtual.subtract(const Duration(days: 30));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GLK Controls - Pesquisa Relatório'),
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
                          .where('Status', isEqualTo: 'Liberado Entrada')
                      //.orderBy("Status", descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SingleChildScrollView(
                          child: Container(
                            height: 900,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            ),
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
                                    String idDocumento = documents.id;

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
                                                onPressed: (){
                                                  if(lacre == 'lacre'){

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
                                                    String id = documents['idDoc'];
                                                    String imageURL2 = documents['uriImage2'];
                                                    String imageURL3 = documents['uriImage3'];
                                                    String imageURL4 = documents['uriImage4'];
                                                    String empresaDoc = documents['Empresa'];

                                                    String horarioCriacao = documents['Horario Criado'];
                                                    String DataEntrada = documents['DataEntradaEmpresa'];
                                                    String DataSaidaPortariast = documents['DataSaida'];
                                                    String verificadoPor = documents['verificadoPor'];

                                                    String DatadeAnalise = documents['DataDeAnalise'];

                                                    String formattedDate = horarioCriacao;
                                                    String formattedDate2 = DataEntrada;
                                                    String formattedDate3 = DatadeAnalise;
                                                    String DataSaidaPortaria =DataSaidaPortariast;


                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context){
                                                          return relatorioGenerate(lacre, "", liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, lacradoStr, documents.id, formattedDate2, formattedDate3, RG, telefone, saidaLiberadaPor, imageURL, id, imageURL2, imageURL3, imageURL4, formattedDate3, verificadoPor, formattedDate2, empresaDoc, DataSaidaPortaria);
                                                        }));

                                                  }
                                                  else{
                                                    if(lacre == 'naolacrado'){
                                                      String imageURL = '';
                                                      String imageURL2 = '';
                                                      String imageURL3 = '';
                                                      String imageURL4 = '';

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
                                                      String id = documents['idDoc'];

                                                      String horarioCriacao = documents['Horario Criado'];
                                                      String DataEntrada = documents['DataEntradaEmpresa'];
                                                      String DataSaidaPortariast = documents['DataSaida'];
                                                      String verificadoPor = documents['verificadoPor'];

                                                      String DatadeAnalise = documents['DataDeAnalise'];

                                                      String formattedDate = horarioCriacao;
                                                      String formattedDate2 = DataEntrada;
                                                      String formattedDate3 = DatadeAnalise;
                                                      String DataSaidaPortaria =DataSaidaPortariast;


                                                      String empresaDoc = documents['Empresa'];

                                                      if(documents['uriImage'] == ''){
                                                        imageURL = 'https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/assets/error-image.png';
                                                      }else{
                                                        imageURL = documents['uriImage'];

                                                        if(documents['uriImage2'] == ''){
                                                          imageURL2 = 'https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/assets/error-image.png';
                                                        }else{
                                                          imageURL2 = documents['uriImage2'];
                                                          if(documents['uriImage3'] == ''){
                                                            imageURL3 = 'https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/assets/error-image.png';
                                                          }else{
                                                            imageURL3 = documents['uriImage3'];
                                                            if(documents['uriImage4'] == ''){
                                                              imageURL4 = 'https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/assets/error-image.png';
                                                            }else{
                                                              imageURL4 = documents['uriImage4'];
                                                            }
                                                          }
                                                        }
                                                      }

                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context){
                                                            return relatorioGenerate(lacre, "", liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, formattedDate2, formattedDate3, RG, telefone, saidaLiberadaPor, imageURL, id, imageURL2, imageURL3, imageURL4, formattedDate3, verificadoPor, formattedDate2, empresaDoc, DataSaidaPortaria);
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