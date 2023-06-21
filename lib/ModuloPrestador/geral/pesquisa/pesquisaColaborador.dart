import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/geral/Modals/editarInfosAdM.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

//Programado por HeroRickyGames

class pesquisaColaborador extends StatefulWidget {

  String EmpresaNome = '';
  String EmpresaID = '';

  pesquisaColaborador(this.EmpresaNome, this.EmpresaID, {Key? key}) : super(key: key);

  @override
  State<pesquisaColaborador> createState() => _pesquisaColaboradorState();
}

class _pesquisaColaboradorState extends State<pesquisaColaborador> {

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
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = textSizeandroid;
        tamanhotextobtns = textSizeandroidbtn;
        aspect = 0.8;

      }
    }
    Future<File> convertImageUrlToFile(String imageUrl) async {
      final response = await http.get(Uri.parse(imageUrl));
      final bytes = response.bodyBytes;

      // Obtenha o diretório de armazenamento local
      final appDirectory = await getApplicationDocumentsDirectory();
      final filePath = '${appDirectory.path}/image.jpg';

      // Crie o arquivo local e escreva os bytes da imagem nele
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      return file;
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Colaboradores'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      RGouNome = valor.toUpperCase();

                      if(valor == ''){
                        setState(() {
                          oqPesquisar = 'RG';
                        });
                        RGouNome = '';
                      }else{
                        List pesquisaRG = [];

                        final RGCollections = FirebaseFirestore.instance.collection('Prestadores').where('RG', isEqualTo: RGouNome);
                        final snapshot5 = await RGCollections.get();
                        final RGDOC = snapshot5.docs;
                        for (final VEICULODOC in RGDOC) {

                          final RG = VEICULODOC.get('RG');

                          pesquisaRG.add('$RG');
                        }

                        List NomeRG = [];

                        final NomeCollections = FirebaseFirestore.instance.collection('Prestadores').where('nome', isEqualTo: RGouNome);
                        final snapshot6 = await NomeCollections.get();
                        final NOMEDOC = snapshot6.docs;
                        for (final NOMEDOC in NOMEDOC) {

                          final NOME = NOMEDOC.get('nome');

                          NomeRG.add('$NOME');
                        }

                        List EmpresaList = [];

                        final EmpresaCollections = FirebaseFirestore.instance.collection('Prestadores').where('Empresa', isEqualTo: RGouNome);
                        final snapshot8 = await EmpresaCollections.get();
                        final EMPRESAS = snapshot8.docs;
                        for (final EMPRESA in EMPRESAS) {

                          final Empresa = EMPRESA.get('Empresa');

                          EmpresaList.add('$Empresa');
                        }

                        if(pesquisaRG.contains(RGouNome)){
                          setState(() {
                            oqPesquisar = 'RG';
                          });
                        }else{
                          if(NomeRG.contains(RGouNome)){
                            setState(() {
                              oqPesquisar = 'nome';
                            });
                          }else{
                            if(EmpresaList.contains(RGouNome)){
                              setState(() {
                                oqPesquisar = 'Empresa';
                              });
                            }else{

                            }
                          }
                        }
                      }

                    });
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Digite RG, Nome, Placa, Empresa ou Galpão',
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

                        final RGCollections = FirebaseFirestore.instance.collection('Prestadores').where('RG', isEqualTo: RGouNome);
                        final snapshot5 = await RGCollections.get();
                        final RGDOC = snapshot5.docs;
                        for (final VEICULODOC in RGDOC) {

                          final RG = VEICULODOC.get('RG');

                          pesquisaRG.add('$RG');
                        }

                        List NomeRG = [];

                        final NomeCollections = FirebaseFirestore.instance.collection('Prestadores').where('nome', isEqualTo: RGouNome);
                        final snapshot6 = await NomeCollections.get();
                        final NOMEDOC = snapshot6.docs;
                        for (final NOMEDOC in NOMEDOC) {

                          final NOME = NOMEDOC.get('nome');

                          NomeRG.add('$NOME');
                        }

                        List EmpresaList = [];

                        final EmpresaCollections = FirebaseFirestore.instance.collection('Prestadores').where('Empresa', isEqualTo: RGouNome);
                        final snapshot8 = await EmpresaCollections.get();
                        final EMPRESAS = snapshot8.docs;
                        for (final EMPRESA in EMPRESAS) {

                          final Empresa = EMPRESA.get('Empresa');

                          EmpresaList.add('$Empresa');
                        }

                        if(pesquisaRG.contains(RGouNome)){
                          setState(() {
                            oqPesquisar = 'RG';
                          });
                        }else{
                          if(NomeRG.contains(RGouNome)){
                            setState(() {
                              oqPesquisar = 'nome';
                            });
                          }else{
                              if(EmpresaList.contains(RGouNome)){
                                setState(() {
                                  oqPesquisar = 'Empresa';
                                });
                              }else{
                                Fluttertoast.showToast(
                                  msg: 'Não encontrei nada!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: tamanhotexto,
                                );
                              }
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

                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context){
                                                return editarInfosADM(documents['Empresa'], documents['EmpresaID'], documents['nome'], documents['RG'], documents['Telefone'], documents['id'], true, true, documents['carro'], documents['moto'], documents['carroEmoto'], documents['vagaComum'], documents['vagaMoto'], documents['VagaDiretoria'], true, documents['Liberado'], false, true, false, widget.EmpresaNome, documents['urlImage']);
                                              }));

                                        },
                                          child: const Icon(Icons.edit),
                                        )
                                    ),
                                  ),
                                  documents['Liberado'] == true ?
                                      Icon(
                                      Icons.done,
                                      color: Colors.green,
                                      ):
                                  Icon(
                                    Icons.block_flipped,
                                    color: Colors.red,
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
                                                          'Tem certeza que deseja cancelar esse veiculo?\nOs dados não poderão ser recuperados pós deletação!',
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
                                                                  Fluttertoast.showToast(
                                                                    msg: 'O veiculo selecionado foi deletado!',
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
                          'Operador: ${widget.EmpresaNome}',
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
      ),
    );
  }
}
