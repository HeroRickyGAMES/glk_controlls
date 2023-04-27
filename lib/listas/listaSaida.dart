import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/modal/ModalSaida.dart';
import 'package:glk_controls/pesquisaDir/pesquisa.dart';

import 'package:intl/intl.dart';

//Programado por HeroRickyGames

class listaSaida extends StatefulWidget {
  String porteiroName;
  String Saida;
  listaSaida(this.porteiroName, this.Saida, {Key? key}) : super(key: key);

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

        tamanhotexto = 16;
        tamanhotextobtns = 18;
        aspect =  1.3;

      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 180,
                    height: 180,
                    padding: const EdgeInsets.all(16),
                    child:
                    Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.contain,
                    )
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Pesquisar Placa:',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                    TextFormField(
                      onChanged: (valor){

                        String value = valor.replaceAll(' ', '').toUpperCase();

                        holderPlaca = value.replaceAllMapped(
                          RegExp(r'^([a-zA-Z]{3})([0-9]{4})$'),
                              (Match m) => '${m[1]}-${m[2]}',
                        );
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(

                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green
                            )
                        ),
                        hintStyle: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
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


                            FirebaseFirestore.instance
                                .collection('Autorizacoes')
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {

                                if(doc["nomeMotorista"] == holderPlaca ){

                                  String oqPesquisar = 'nomeMotorista';
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context){
                                        return pesquisa(holderPlaca, oqPesquisar);
                                      }));

                                }else{

                                  if(doc["PlacaVeiculo"] == holderPlaca ){

                                    String oqPesquisar = 'PlacaVeiculo';
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return pesquisa(holderPlaca, oqPesquisar);
                                        }));
                                  }else{
                                    if(doc["Empresa"] == holderPlaca){
                                      String oqPesquisar = 'Empresa';
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context){
                                            return pesquisa(holderPlaca, oqPesquisar);
                                          }));
                                    }else{
                                      if(doc["Galpão"] == holderPlaca){
                                        String oqPesquisar = 'Galpão';
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return pesquisa(holderPlaca, oqPesquisar);
                                            }));
                                      }else{

                                        Fluttertoast.showToast(
                                          msg: 'Infelizmente não achei nada do que você pesquisou, por favor, tente novamente!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    }
                                  }
                                }

                              });
                            });
                          }
                        },
                        child: Text(
                          'Pesquisar',
                          style: TextStyle(
                              fontSize: tamanhotexto,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore
                            .instance
                            .collection('Autorizacoes')
                            .where('Status', isEqualTo: 'Liberado Saida')
                        //.orderBy("Status", descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            height: 700,
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

                                    Color color = Colors.white as Color;
                                    Color textColor = Colors.white as Color;

                                    if(documents['Status'] == 'Aguardando Liberação'){
                                      color = Colors.red[400] as Color;
                                      textColor = Colors.white as Color;
                                    }
                                    if(documents['Status'] == 'Liberado Entrada'){
                                      color = Colors.grey as Color;
                                      textColor = Colors.white as Color;
                                    }

                                    if(documents['Status'] == 'Rejeitado'){
                                      color = Colors.red[400] as Color;
                                      textColor = Colors.white as Color;
                                    }

                                    if(documents['Status'] == 'Estacionário'){
                                      color = Colors.yellow[400] as Color;
                                      textColor = Colors.black as Color;
                                    }

                                    if(documents['Status'] == 'Liberado Saida'){
                                      color = Colors.yellow[400] as Color;
                                      textColor = Colors.black as Color;
                                    }

                                    if(documents['Status'] == 'Saida'){
                                      color = Colors.green[400] as Color;
                                      textColor = Colors.white as Color;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: color,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                        ),
                                        child:
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () async {

                                                  if(documents['PlacaVeiculo'].contains('(AG)')){

                                                    if(int.parse(DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/').replaceAll('/', '').replaceAll(' ', '').replaceAll(':', '')) >= int.parse(documents['DataSaida'].replaceAll('/', '').replaceAll(' ', '').replaceAll(':', ''))){
                                                      String lacreounao = documents['LacreouNao'];
                                                      String empresaName = documents['EmpresadeOrigin'];
                                                      String liberadopor = documents['QuemAutorizou'];
                                                      String horarioCriacaost = documents['Horario Criado'];
                                                      String nomeMotorista = documents['nomeMotorista'];
                                                      String Veiculo = documents['Veiculo'];
                                                      String PlacaVeiculo = documents['PlacaVeiculo'];
                                                      String Empresadestino = documents['Empresa'];
                                                      String Galpao = documents['Galpão'];
                                                      String lacradoStr = documents['lacrenum'];
                                                      String tagSelecionada = documents['tag'];


                                                      String idDocumento = documents.id;
                                                      String DatadeAnalisest = documents['DataDeAnalise'];
                                                      String DateEntradast = documents['DataEntradaEmpresa'];
                                                      String DataSaidast = documents['DataSaida'];

                                                      String verificadoPor = documents['verificadoPor'];

                                                      String horarioCriacao = horarioCriacaost;
                                                      String DatadeAnalise = DatadeAnalisest;
                                                      String DateEntrada = DateEntradast;
                                                      String DataSaida = DataSaidast;

                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context){
                                                            return modalSaidaVeiculo(lacreounao, empresaName, liberadopor, horarioCriacao, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, empresaName, Galpao, lacradoStr, idDocumento, DatadeAnalise, verificadoPor, DateEntrada, empresaName, widget.porteiroName, DataSaida, tagSelecionada, widget.Saida);
                                                          }));
                                                    }
                                                  }else{

                                                    String lacreounao = documents['LacreouNao'];
                                                    String empresaName = documents['EmpresadeOrigin'];
                                                    String liberadopor = documents['QuemAutorizou'];
                                                    String horarioCriacaost = documents['Horario Criado'];
                                                    String nomeMotorista = documents['nomeMotorista'];
                                                    String Veiculo = documents['Veiculo'];
                                                    String PlacaVeiculo = documents['PlacaVeiculo'];
                                                    String Empresadestino = documents['Empresa'];
                                                    String Galpao = documents['Galpão'];
                                                    String lacradoStr = documents['lacrenum'];
                                                    String tagSelecionada = documents['tag'];


                                                    String idDocumento = documents.id;
                                                    String DatadeAnalisest = documents['DataDeAnalise'];
                                                    String DateEntradast = documents['DataEntradaEmpresa'];
                                                    String DataSaidast = documents['DataSaida'];

                                                    String verificadoPor = documents['verificadoPor'];

                                                    String horarioCriacao = horarioCriacaost;
                                                    String DatadeAnalise = DatadeAnalisest;
                                                    String DateEntrada = DateEntradast;
                                                    String DataSaida = DataSaidast;

                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context){
                                                          return modalSaidaVeiculo(lacreounao, empresaName, liberadopor, horarioCriacao, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, empresaName, Galpao, lacradoStr, idDocumento, DatadeAnalise, verificadoPor, DateEntrada, empresaName, widget.porteiroName, DataSaida, tagSelecionada, widget.Saida);
                                                        }));
                                                  }
                                                },
                                                child: Text(
                                                  documents['PlacaVeiculo'],
                                                  style: TextStyle(
                                                      fontSize: tamanhotextobtns,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                )
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                'Status: \n' +
                                                    documents['Status'],
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor
                                                ),
                                              ),
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
              ),
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
