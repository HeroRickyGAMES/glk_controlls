import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/geral/Modals/recuperarInfos.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

//Programado por HeroRickyGames

class pesquisaCriarVeiculo extends StatefulWidget {
  String NomeEmpresa;
  String EmpresaID;
  pesquisaCriarVeiculo(this.NomeEmpresa, this.EmpresaID, {Key? key}) : super(key: key);
  @override
  State<pesquisaCriarVeiculo> createState() => _pesquisaCriarVeiculoState();
}

class _pesquisaCriarVeiculoState extends State<pesquisaCriarVeiculo> {

  String EmpresaIs = '';
  String RGouNome = '';
  String oqPesquisar = 'RG';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de veiculo'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: 500,
              child: Image.asset(
                'assets/icon.png',
                width: 200,
                height: 200,
              ),
            ),
            Text(
              'Digite RG ou Nome:',
              style: TextStyle(
                  fontSize: tamanhotexto
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState(() async {
                    RGouNome = valor.trim().toUpperCase();

                    if(RGouNome == ''){
                      setState(() {
                        oqPesquisar = 'RG';
                      });
                      RGouNome = '';
                    }

                    List pesquisaRG = [];



                    final RGCollections = FirebaseFirestore.instance.collection('Prestadores');
                    final snapshot5 = await RGCollections.get();
                    final RGDOC = snapshot5.docs;
                    for (final VEICULODOC in RGDOC) {

                      final RG = VEICULODOC.get('RG');

                      pesquisaRG.add('$RG');
                    }
                    List pesquisaNome = [];

                    final NomeCollections = FirebaseFirestore.instance.collection('Prestadores');
                    final snapshot6 = await NomeCollections.get();
                    final NOMEDOC = snapshot6.docs;
                    for (final NOMEDOC in NOMEDOC) {

                      final nome = NOMEDOC.get('nome');

                      pesquisaNome.add('$nome');
                    }

                    if(pesquisaRG.contains(RGouNome)){
                      //TODO PESQUISA RG

                      setState(() {
                        oqPesquisar = 'RG';
                      });
                    }else{
                      if(pesquisaNome.contains(RGouNome)){
                        //TODO PESQUISA nome

                        setState(() {
                          oqPesquisar = 'nome';
                        });

                      }
                    }

                  });
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Digite RG ou Nome ',
                  hintStyle: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white60
                    ), child: Text(
                      'Cancelar',
                      style: TextStyle(
                          fontSize: tamanhotextobtns,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(onPressed: () async {
                    if(RGouNome == ''){
                      setState(() {
                        oqPesquisar = 'RG';
                      });
                      RGouNome = '';
                      Fluttertoast.showToast(
                        msg: 'O campo de pesquisa está vazio!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: tamanhotexto,
                      );
                    }else{
                      List pesquisaRG = [];

                      final RGCollections = FirebaseFirestore.instance.collection('Prestadores');
                      final snapshot5 = await RGCollections.get();
                      final RGDOC = snapshot5.docs;
                      for (final VEICULODOC in RGDOC) {

                        final RG = VEICULODOC.get('RG');

                        pesquisaRG.add('$RG');
                      }
                      List pesquisaNome = [];

                      final NomeCollections = FirebaseFirestore.instance.collection('Prestadores');
                      final snapshot6 = await NomeCollections.get();
                      final NOMEDOC = snapshot6.docs;
                      for (final NOMEDOC in NOMEDOC) {

                        final nome = NOMEDOC.get('nome');

                        pesquisaNome.add('$nome');
                      }

                      if(pesquisaRG.contains(RGouNome)){
                        //TODO PESQUISA RG

                        setState(() {
                          oqPesquisar = 'RG';
                        });

                        Fluttertoast.showToast(
                          msg: 'Os resultados devem aparecer logo a baixo!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: tamanhotexto,
                        );
                      }else{
                        if(pesquisaNome.contains(RGouNome)){
                          //TODO PESQUISA nome

                          setState(() {
                            oqPesquisar = 'nome';
                          });
                          Fluttertoast.showToast(
                            msg: 'Os resultados devem aparecer logo a baixo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotexto,
                          );

                        }else{
                          Fluttertoast.showToast(
                            msg: 'Nenhum resultado foi encontrado!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotexto,
                          );
                        }
                      }

                    }
                  },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green
                    ), child: Text(
                      'Pesquisar',
                      style: TextStyle(
                        fontSize: tamanhotextobtns,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Prestadores')
                    .where(oqPesquisar, isEqualTo: RGouNome)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    height: 700,
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
                                        '${documents['nome']}-',
                                        style: TextStyle(
                                            fontSize: tamanhotexto,
                                            fontWeight: FontWeight.bold
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
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
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
                                        '${documents['Empresa']}-',
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextButton(onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text('Aguarde!'),
                                              actions: [
                                                Center(
                                                  child: CircularProgressIndicator(),
                                                )
                                              ],
                                            );
                                          },
                                        );

                                        if(kIsWeb){
                                          if(widget.EmpresaID == ''){
                                            Navigator.of(context).pop();
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context){
                                                  return RecuperarInfos(documents['Empresa'], documents['EmpresaID'], '', documents['nome'], documents['RG'], documents['Telefone'], documents['id'], true, true, documents['carro'], documents['moto'], documents['carroEmoto'], documents['vagaComum'], documents['vagaMoto'], documents['VagaDiretoria'], true, documents['Liberado'], false, true, false, widget.NomeEmpresa, false, '', documents['urlImage']);
                                                }));
                                          }else{
                                            Navigator.of(context).pop();
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context){
                                                  return RecuperarInfos(documents['Empresa'], documents['EmpresaID'], '', documents['nome'], documents['RG'], documents['Telefone'], documents['id'], true, true, documents['carro'], documents['moto'], documents['carroEmoto'], documents['vagaComum'], documents['vagaMoto'], documents['VagaDiretoria'], true, documents['Liberado'], false, true, false, widget.NomeEmpresa, true, '', documents['urlImage']);
                                                }));
                                          }

                                        }else{
                                          final http.Response responseData = await http.get(Uri.parse(documents['urlImage']));
                                          Uint8List uint8list = responseData.bodyBytes;
                                          var buffer = uint8list.buffer;
                                          ByteData byteData = ByteData.view(buffer);
                                          var tempDir = await getTemporaryDirectory();
                                          File convertedFile = await File('${tempDir.path}/${documents['urlImage'].replaceAll('-', '').replaceAll('%', '').replaceAll('/', '').replaceAll('=', '').replaceAll('https', '').replaceAll(':', '').replaceAll('firebasestorage.googleapis.com', '').replaceAll('bglkcontrols.appspot.comoimages', '')}').writeAsBytes(
                                              buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

                                          if(widget.EmpresaID == ''){
                                            Navigator.of(context).pop();
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context){
                                                  return RecuperarInfos(documents['Empresa'], documents['EmpresaID'], convertedFile, documents['nome'], documents['RG'], documents['Telefone'], documents['id'], true, true, documents['carro'], documents['moto'], documents['carroEmoto'], documents['vagaComum'], documents['vagaMoto'], documents['VagaDiretoria'], true, documents['Liberado'], false, true, false, widget.NomeEmpresa, false, '', documents['urlImage']);
                                                }));
                                          }else{
                                            Navigator.of(context).pop();
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context){
                                                  return RecuperarInfos(documents['Empresa'], documents['EmpresaID'], convertedFile, documents['nome'], documents['RG'], documents['Telefone'], documents['id'], true, true, documents['carro'], documents['moto'], documents['carroEmoto'], documents['vagaComum'], documents['vagaMoto'], documents['VagaDiretoria'], true, documents['Liberado'], false, true, false, widget.NomeEmpresa, true, '', documents['urlImage']);
                                                }));
                                          }
                                        }
                                      },
                                        child: const Icon(Icons.edit),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
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
                  Column(
                    children: [
                      Text(
                        'Operador: ${widget.NomeEmpresa}',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                    ],
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
