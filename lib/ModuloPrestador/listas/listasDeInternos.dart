import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/geral/Modals/recuperarInfos.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class listasdeInternos extends StatefulWidget {
  String NomeEmpresa;
  String EmpresaID;
  listasdeInternos(this.NomeEmpresa, this.EmpresaID, {Key? key}) : super(key: key);
  @override
  State<listasdeInternos> createState() => _listasdeInternosState();
}

class _listasdeInternosState extends State<listasdeInternos> {

  String EmpresaIs = '';

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
        title: const Text('Lista de cadastros'),
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
            Container(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                stream: widget.EmpresaID != '' ? FirebaseFirestore.instance
                    .collection('Prestadores')
                    .where('EmpresaID', isEqualTo: widget.EmpresaID)
                    .snapshots() :
                FirebaseFirestore.instance
                    .collection('Prestadores')
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
                      height: 700,
                      width: 700,
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
                                        width: 700,
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
                                        width: 700,
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
                                        width: 700,
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
                                        width: 700,
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
                                  Expanded(
                                    child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: TextButton(onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Atenção!',
                                                  style: TextStyle(
                                                      fontSize: tamanhotextobtns
                                                  ),
                                                ),
                                                actions: [
                                                  Center(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Tem certeza que deseja deletar esse interno?\nOs dados não poderão ser recuperados pós deletação!',
                                                          style: TextStyle(
                                                              fontSize: tamanhotexto
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: TextButton(onPressed: (){
                                                                Navigator.of(context).pop();
                                                              }, child: Text(
                                                                'Cancelar',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotexto
                                                                ),
                                                              ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: TextButton(onPressed: (){
                                                                FirebaseFirestore.instance.collection('Prestadores').doc(documents['id']).delete().whenComplete((){
                                                                  Navigator.of(context).pop();
                                                                  Fluttertoast.showToast(
                                                                    msg: 'O interno selecionado foi deletado!',
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.black,
                                                                    textColor: Colors.white,
                                                                    fontSize: tamanhotexto,
                                                                  );
                                                                });
                                                              }, child: Text(
                                                                'Prosseguir',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotexto
                                                                ),
                                                              ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        }, child: const Icon(Icons.delete),
                                        )
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
