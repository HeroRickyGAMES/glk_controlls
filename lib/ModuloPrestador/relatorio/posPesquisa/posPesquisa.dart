import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/ModuloPrestador/relatorio/posPesquisa/pdf/CriarPDFPrestador.dart';

class PosPesquisaRelatorio extends StatefulWidget {
  String Pesquisa;
  String OquePesquisar;
  PosPesquisaRelatorio(this.Pesquisa, this.OquePesquisar, {super.key});

  @override
  State<PosPesquisaRelatorio> createState() => _PosPesquisaRelatorioState();
}

class _PosPesquisaRelatorioState extends State<PosPesquisaRelatorio> {
  bool pesquisaData = false;
  bool pesquisaHora = false;
  bool horaEData = false;

  Map<String, dynamic> dataDBPusher = {};
  List DBPusherIDS = [];

  String PesquisaDATA = '';
  String PesquisaHORA = '';
  @override
  Widget build(BuildContext context) {

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final textScaleFactor = mediaQueryData.textScaleFactor;
    final dpi = mediaQueryData.devicePixelRatio;

    final textHeight = screenHeight * 0.05;
    final textWidth = screenWidth * 0.8;

    final textSize = (textHeight / dpi / 2) * textScaleFactor;
    final textSizeandroid = (textWidth / dpi / 15) * textScaleFactor;
    final textSizeandroidbtn = (textWidth / dpi / 13) * textScaleFactor;

    if(kIsWeb){
      tamanhotexto = textSize;
      tamanhotextobtns = textSize;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = textSizeandroid;
        tamanhotextobtns = textSizeandroidbtn;
        aspect = 0.8;

      }
    }
    dalay() async {
      var RGCollections;
      pesquisaData == true ?
      RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador').where('DATACODE', isEqualTo: PesquisaDATA)
          : pesquisaHora == true ?
      RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador')
          .where('HORACODE', isEqualTo: PesquisaHORA) :
      horaEData == true ? RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador')
          .where('DATACODE', isEqualTo: pesquisaData)
          .where('HORACODE', isEqualTo: PesquisaHORA) :
      RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador');

      final snapshot7 = await RGCollections.get();
      final RGDOC = snapshot7.docs;

      for (final RGDOCU in RGDOC) {

        dataDBPusher[RGDOCU.id] = RGDOCU.data();

        DBPusherIDS.add(RGDOCU.id);


      }
      await Future.delayed(const Duration(seconds: 1));

    }

    dalay();
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado da pesquisa ${widget.Pesquisa}'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Filtro da Pesquisa:',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DBPusherIDS.clear();
                      var RGCollections;

                      pesquisaData == true ?
                      RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador').where('DATACODE', isEqualTo: PesquisaDATA)
                          : pesquisaHora == true ?
                      RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador')
                          .where('HORACODE', isEqualTo: PesquisaHORA) :
                      horaEData == true ? RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador')
                          .where('DATACODE', isEqualTo: pesquisaData)
                          .where('HORACODE', isEqualTo: PesquisaHORA) :
                      RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador');

                      final snapshot7 = await RGCollections.get();
                      final RGDOC = snapshot7.docs;

                      for (final RGDOCU in RGDOC) {

                        dataDBPusher[RGDOCU.id] = RGDOCU.data();
                        DBPusherIDS.add(RGDOCU.id);

                      }


                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return generatePDFPrestador(dataDBPusher, DBPusherIDS);
                          }));
                    },
                    child: const Icon(
                        Icons.document_scanner_rounded,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState(() {
                    PesquisaDATA = valor.replaceAll('/', '');


                    if(PesquisaHORA != ''){
                      horaEData = true;
                      pesquisaHora = false;
                      pesquisaData = false;
                    }else{
                      if(PesquisaDATA == ''){
                        pesquisaData = false;
                        horaEData = false;
                      }
                    }

                  });
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Data (dia/mes/ano)',
                  hintStyle: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState((){
                    PesquisaHORA = valor.replaceAll(':', '');
                    if(PesquisaDATA != ''){
                      horaEData = true;
                      pesquisaHora = false;
                      pesquisaData = false;
                    }

                    if(valor == ''){
                      pesquisaHora = false;
                      horaEData = false;
                    }else{
                      horaEData = false;
                      pesquisaHora = true;
                      pesquisaData = false;
                    }

                  });
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Hora (hora:minuto)',
                  hintStyle: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                stream:
                pesquisaData == true ?
                FirebaseFirestore.instance
                    .collection('relatorioModuloPrestador')
                    .where(widget.OquePesquisar, isEqualTo: widget.Pesquisa)
                    .where('DATACODE', isEqualTo: PesquisaDATA)
                    .snapshots():
                pesquisaHora == true ?
                FirebaseFirestore.instance
                    .collection('relatorioModuloPrestador')
                    .where(widget.OquePesquisar, isEqualTo: widget.Pesquisa)
                    .where('HORACODE', isEqualTo: PesquisaHORA)
                    .snapshots() :
                horaEData == true ?
                FirebaseFirestore.instance
                    .collection('relatorioModuloPrestador')
                    .where(widget.OquePesquisar, isEqualTo: widget.Pesquisa)
                    .where('DATACODE', isEqualTo: pesquisaData)
                    .where('HORACODE', isEqualTo: PesquisaHORA)
                    .snapshots()
                    :
                FirebaseFirestore.instance
                    .collection('relatorioModuloPrestador')
                    .where(widget.OquePesquisar, isEqualTo: widget.Pesquisa)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: ListView(
                        children: snapshot.data!.docs.map((documents) {

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['Nome']}-',
                                          style: const TextStyle(
                                              fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['RG']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['galpao']} ${documents['Empresa']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['Placa']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['Modelo']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['Cor']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['Data']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['Horario']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: Text(
                                          '${documents['Status']}-',
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
