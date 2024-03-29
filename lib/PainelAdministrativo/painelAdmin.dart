import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:glk_controls/CadastrarCondominio.dart';
import 'package:glk_controls/Painel.dart';
import 'package:glk_controls/anteLogin.dart';

//Programado por HeroRickyGames

class painelAdmin extends StatefulWidget {
  const painelAdmin({Key? key}) : super(key: key);

  @override
  State<painelAdmin> createState() => _painelAdminState();
}

class _painelAdminState extends State<painelAdmin> {
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
        centerTitle: true,
        title: const Text('Configurações'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                  if(kIsWeb){

                    Fluttertoast.showToast(
                        msg: 'Essa função só é disponivel na versão Mobile do app!',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: tamanhotexto
                    );

                  }else{
                    if(Platform.isAndroid){

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

                      final dropValue = ValueNotifier('');

                      final ByteData imageData = await rootBundle.load('assets/insertFoto.png');

                      final ByteData imageData2 = await rootBundle.load('assets/white.png');

                      final Uint8List uint8List = imageData.buffer.asUint8List();
                      final Uint8List uint8List2 = imageData2.buffer.asUint8List();

                      final compressedImage = await FlutterImageCompress.compressWithList(
                        uint8List,
                        quality: 85, // ajuste a qualidade da imagem conforme necessário
                      );
                      final compressedImage2 = await FlutterImageCompress.compressWithList(
                        uint8List2,
                        quality: 85, // ajuste a qualidade da imagem conforme necessário
                      );

                      final tempDir = await getTemporaryDirectory();

                      final file = File('${tempDir.path}/imagem.jpg');
                      final file2 = File('${tempDir.path}/imagem2.jpg');
                      await file.writeAsBytes(compressedImage);
                      await file2.writeAsBytes(compressedImage2);

                      var result = await FirebaseFirestore.instance
                          .collection("Condominio")
                          .doc('condominio')
                          .get();
                      String empresaName = result.get('Empresa');
                      String endereco = result.get('Endereço');
                      String cep = result.get('cep');
                      String cidade = result.get('cidade');
                      String estado = result.get('estado');
                      String galpao = '${result.get('galpoes')}';
                      String vagas = '${result.get('vagas')}';
                      String tags = '${result.get('tags').length}';
                      String vagasInternas = '${result.get('VagasPrestadores')}';
                      String vagasMoto = '${result.get('VagasMotos')}';
                      String emailADM = '${result.get('emailADM')}';
                      String EstadoSelecionado = '${result.get('estado')}';
                      String entrada01CamIP = '${result.get('ip_camera_entrada01')}';
                      String entrada02CamIP = '${result.get('ip_camera_entrada02')}';
                      String saida01CamIP = '${result.get('ip_camera_saida01')}';
                      String saida02CamIP = '${result.get('ip_camera_saida02')}';

                      Navigator.of(context).pop();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return CadastroCondominio(dropValue, file, file2, empresaName, endereco, cep, cidade, estado, galpao, vagas, tags, vagasInternas, vagasMoto, emailADM, EstadoSelecionado, entrada01CamIP, entrada02CamIP, saida01CamIP, saida02CamIP);
                          }));

                    }
                  }
                },
                child: Text(
                    'Configuração',
                  style: TextStyle(
                      fontSize: tamanhotextobtns ,
                  ),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {

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
                var result = await FirebaseFirestore.instance
                    .collection("Condominio")
                    .doc('condominio')
                    .get();

                String logoPath = result.get('imageURL');

                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return painelADM('ADM GLK', logoPath);
                    }));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey
              ),
              child: Text(
                  'Painel',
                style: TextStyle(
                  fontSize: tamanhotextobtns,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {

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
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey
                  ),
                  child: Text(
                    'Sair',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
