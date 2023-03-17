import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/modal/veiculoAguardando.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../pesquisaDir/pesquisa.dart';

//Programado por HeroRickyGames

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
        title: Text('GLK Controls - ENTRADA'),
        backgroundColor: Colors.green[700],
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
                          'Pesquisar'
                      ),
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore
                          .instance
                          .collection('Autorizacoes')
                          .where('Status', isNotEqualTo: 'Saida')
                          .orderBy("Status", descending: true)
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
                            borderRadius: BorderRadius.all(Radius.circular(5.0)
                            ),
                          ),
                          child: GridView.count(
                            padding: const EdgeInsets.all(10),
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
                                              onPressed: () async {

                                                if(documents['Status'] == 'Aguardando'){

                                                  if(lacre == 'lacre'){
                                                    String liberadopor = documents['QuemAutorizou'];
                                                    Timestamp horarioCriacao = documents['Horario Criado'];
                                                    String nomeMotorista = documents['nomeMotorista'];
                                                    String Veiculo = documents['Veiculo'];
                                                    String PlacaVeiculo = documents['PlacaVeiculo'];
                                                    String Empresadestino = documents['Empresa'];
                                                    String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                    String Galpao = documents['Galpão'];
                                                    String lacradoStr = documents['lacrenum'];

                                                    String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(horarioCriacao.toDate()).replaceAll('-', '/');

                                                    final ByteData imageData = await rootBundle.load('assets/insertFoto.png');

                                                    final Uint8List uint8List = imageData.buffer.asUint8List();

                                                    final compressedImage = await FlutterImageCompress.compressWithList(
                                                      uint8List,
                                                      quality: 85, // ajuste a qualidade da imagem conforme necessário
                                                    );

                                                    final tempDir = await getTemporaryDirectory();
                                                    final file = File('${tempDir.path}/imagem.jpg');
                                                    await file.writeAsBytes(compressedImage);

                                                    final file2 = File('${tempDir.path}/imagem.jpg');
                                                    await file2.writeAsBytes(compressedImage);

                                                    final file3 = File('${tempDir.path}/imagem.jpg');
                                                    await file3.writeAsBytes(compressedImage);

                                                    final file4 = File('${tempDir.path}/imagem.jpg');
                                                    await file4.writeAsBytes(compressedImage);

                                                    print(' arquivo temporario é : ${file} ');

                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context){
                                                          return veiculoAguardando(lacre, widget.porteiroName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, lacradoStr, documents.id, file, file2, file3, file4);
                                                        }));

                                                  }
                                                  else{
                                                    if(lacre == 'naolacrado'){
                                                      String liberadopor = documents['QuemAutorizou'];
                                                      Timestamp horarioCriacao = documents['Horario Criado'];
                                                      Timestamp DataEntrada = documents['DataEntrada'];
                                                      String nomeMotorista = documents['nomeMotorista'];
                                                      String Veiculo = documents['Veiculo'];
                                                      String PlacaVeiculo = documents['PlacaVeiculo'];
                                                      String Empresadestino = documents['Empresa'];
                                                      String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                      String Galpao = documents['Galpão'];

                                                      String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(horarioCriacao.toDate()).replaceAll('-', '/');
                                                      String formattedDate2 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataEntrada.toDate()).replaceAll('-', '/');

                                                      final ByteData imageData = await rootBundle.load('assets/error-image.png');

                                                      final Uint8List uint8List = imageData.buffer.asUint8List();

                                                      final compressedImage = await FlutterImageCompress.compressWithList(
                                                        uint8List,
                                                        quality: 85, // ajuste a qualidade da imagem conforme necessário
                                                      );

                                                      final tempDir = await getTemporaryDirectory();
                                                      final file = File('${tempDir.path}/imagem.jpg');
                                                      await file.writeAsBytes(compressedImage);

                                                      final file2 = File('${tempDir.path}/imagem.jpg');
                                                      await file2.writeAsBytes(compressedImage);

                                                      final file3 = File('${tempDir.path}/imagem.jpg');
                                                      await file3.writeAsBytes(compressedImage);

                                                      final file4 = File('${tempDir.path}/imagem.jpg');
                                                      await file4.writeAsBytes(compressedImage);

                                                      print(' arquivo temporario é : ${file} ');
                                                      print(formattedDate);

                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context){
                                                            return veiculoAguardando(lacre, widget.porteiroName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, file, file2, file3, file4);
                                                          }));
                                                    }
                                                  }
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
                      'assets/sanca.png',
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
