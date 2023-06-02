import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:glk_controls/ModuloPrestador/geral/CadastroDoColabotador.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/pesquisa.dart';
import 'package:glk_controls/ModuloPrestador/listas/listasDeInternos.dart';
import 'package:glk_controls/anteLogin.dart';
import 'package:path_provider/path_provider.dart';

class PrestadorEmpresaMain extends StatefulWidget {
  String Empresa = '';
  String IDEmpresa = '';
  PrestadorEmpresaMain(this.Empresa, this.IDEmpresa,{Key? key}) : super(key: key);

  @override
  State<PrestadorEmpresaMain> createState() => _PrestadorEmpresaMainState();
}

class _PrestadorEmpresaMainState extends State<PrestadorEmpresaMain> {
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

    criarCadastro() async {

      if(kIsWeb == true){

      }else{
        final ByteData imageData = await rootBundle.load('assets/error-image.png');

        final Uint8List uint8List = imageData.buffer.asUint8List();

        final compressedImage = await FlutterImageCompress.compressWithList(
          uint8List,
          quality: 85, // ajuste a qualidade da imagem conforme necessário
        );

        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/imagem.jpg');
        await file.writeAsBytes(compressedImage);

        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return CadastroDoOperador(widget.Empresa, widget.IDEmpresa, file);
            }));
      }
    }
    pesquisa() async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return pesquisaPrestador(widget.Empresa, widget.IDEmpresa);
          }));
    }

    listaInternos(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return listasdeInternos(widget.Empresa, widget.IDEmpresa);
          }));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Controle dos intenos'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: criarCadastro,
                  child: Text(
                    'Criar cadastro',
                    style: TextStyle(
                      fontSize: tamanhotextobtns,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: pesquisa,
                  child: Text(
                    'Pesquisar Cadastro',
                    style: TextStyle(
                      fontSize: tamanhotextobtns,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: listaInternos,
                  child: Text(
                    'Lista de Internos',
                    style: TextStyle(
                      fontSize: tamanhotextobtns,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut().then((value) async {

                                      var resulte = await FirebaseFirestore.instance
                                          .collection("Condominio")
                                          .doc('condominio')
                                          .get();

                                      String logoPath = resulte.get('imageURL');

                                      Navigator.pop(context);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context){
                                            return anteLogin(logoPath);
                                          }));
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey
                                  ),
                                  child: const Text(
                                    'Sair',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                              'Operador: ${widget.Empresa}',
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
            ],
          ),
        ),
      ),
    );
  }
}
