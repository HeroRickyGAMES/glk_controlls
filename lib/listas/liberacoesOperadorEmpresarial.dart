import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/modal/veiculoEntrada.dart';
import 'package:glk_controls/pesquisaDir/pesquisa.dart';
import 'package:intl/intl.dart';



//Programado por HeroRickyGames

Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
class liberacoesOperadorEmpresarial extends StatefulWidget {
  final String name;
  final String empresaName;
  liberacoesOperadorEmpresarial(this.name, this.empresaName);

  @override
  State<liberacoesOperadorEmpresarial> createState() => _liberacoesOperadorEmpresarialState();
}

class _PlateFormatter extends TextInputFormatter {
  static const int _firstGroupLength = 3;
  static const int _secondGroupLength = 4;
  static const String _separator = ' ';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleaned = newValue.text.replaceAll(RegExp('[^a-zA-Z0-9]'), '');
    String plate = '';
    int i = 0;
    while (i < cleaned.length) {
      int remaining = cleaned.length - i;
      if (remaining > _firstGroupLength) {
        plate += cleaned.substring(i, i + _firstGroupLength) + _separator;
        i += _firstGroupLength;
      } else {
        plate += cleaned.substring(i, i + remaining);
        i += remaining;
      }
      if (i == _firstGroupLength && remaining > 0) {
        plate += _separator;
      }
    }
    return TextEditingValue(
      text: plate,
      selection: TextSelection.fromPosition(
        TextPosition(offset: plate.length),
      ),
    );
  }
}

class _liberacoesOperadorEmpresarialState extends State<liberacoesOperadorEmpresarial> {

  Widget build(BuildContext context) {
    String idDocumento;

    String holderPlaca = '';

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextobtns = 34;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

      print(aspect);
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 20;
        tamanhotextobtns = 34;
        aspect = 0.8;

      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GLK Controls - LIBERA????ES'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            ),

            Container(
              padding: EdgeInsets.all(16),
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

                        border: OutlineInputBorder(
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
                                      if(doc["Galp??o"] == holderPlaca){
                                        String oqPesquisar = 'Galp??o';
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return pesquisa(holderPlaca, oqPesquisar);
                                            }));
                                      }else{

                                        Fluttertoast.showToast(
                                          msg: 'Infelizmente n??o achei nada do que voc?? pesquisou, por favor, tente novamente!',
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
                            .where('Empresa', isEqualTo: widget.empresaName)
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
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
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

                                    if(documents['Empresa'] == widget.empresaName){
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
                                        lacrado = 'N??o Lacrado';
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

                                      if(documents['Status'] == 'Aguardando'){
                                        color = Colors.red[400] as Color;
                                        textColor = Colors.white as Color;
                                      }

                                      if(documents['Status'] == 'Rejeitado'){
                                        color = Colors.red[400] as Color;
                                        textColor = Colors.white as Color;
                                      }

                                      if(documents['Status'] == 'Entrada'){
                                        color = Colors.yellow[400] as Color;
                                        textColor = Colors.black as Color;
                                      }

                                      if(documents['Status'] == 'Liberado'){
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
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: color,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                          ),
                                          child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: (){

                                                    if(documents['Status'] == 'Entrada' ){

                                                      String lacre = documents['LacreouNao'];

                                                      if(lacre == 'lacre'){
                                                        String liberadopor = documents['QuemAutorizou'];
                                                        Timestamp horarioCriacao = documents['Horario Criado'];
                                                        String nomeMotorista = documents['nomeMotorista'];
                                                        String Veiculo = documents['Veiculo'];
                                                        String PlacaVeiculo = documents['PlacaVeiculo'];
                                                        String Empresadestino = documents['Empresa'];
                                                        String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                        String Galpao = documents['Galp??o'];
                                                        Timestamp DataEntrada = documents['DataEntrada'];
                                                        String lacradoStr = documents['lacrenum'];

                                                        String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(horarioCriacao.toDate()).replaceAll('-', '/');
                                                        String formattedDate2 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataEntrada.toDate()).replaceAll('-', '/');

                                                        Navigator.push(context,
                                                            MaterialPageRoute(builder: (context){
                                                              return veiculoEntrada(lacre, widget.empresaName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, lacradoStr, documents.id, formattedDate2);
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

                                                          String liberadopor = documents['QuemAutorizou'];
                                                          String nomeMotorista = documents['nomeMotorista'];
                                                          String Veiculo = documents['Veiculo'];
                                                          String PlacaVeiculo = documents['PlacaVeiculo'];
                                                          String Empresadestino = documents['Empresa'];
                                                          String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                          String Galpao = documents['Galp??o'];

                                                          print(formattedDate);

                                                          Navigator.push(context,
                                                              MaterialPageRoute(builder: (context){
                                                                return veiculoEntrada(lacre, widget.empresaName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, formattedDate2);
                                                              }));
                                                        }
                                                      }
                                                    }

                                                    if(documents['Status'] == 'Aguardando'){
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Deseja autorizar entrada?'),
                                                            content: SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <Widget>[
                                                                  Text('Deseja autorizar entrada desse veiculo?'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text('Rejeitar Entrada'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();

                                                                  FirebaseFirestore.instance.collection('Autorizacoes').doc(documents.id).update({
                                                                    'DatadeRejeicao': DateTime.now(),
                                                                    'Status': 'Rejeitado'
                                                                  });
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text('Permitir Entrada'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();

                                                                  FirebaseFirestore.instance.collection('Autorizacoes').doc(documents.id).update({
                                                                    'DataEntrada': DateTime.now(),
                                                                    'Status': 'Entrada'
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }else{

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
                                                padding: EdgeInsets.all(16),
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
                                    }else{
                                      return SizedBox(width: 0, height: 0);
                                    }
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
                    padding: EdgeInsets.all(16),
                    child:
                    Image.asset(
                      'assets/sanca.png',
                      fit: BoxFit.contain,
                    )
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child:
                  Text(
                    'Operador: ' + widget.name,
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