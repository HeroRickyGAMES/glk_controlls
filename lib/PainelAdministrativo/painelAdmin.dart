import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

import '../CadastrarCondominio.dart';
import '../anteLogin.dart';

class painelAdmin extends StatefulWidget {
  const painelAdmin({Key? key}) : super(key: key);

  @override
  State<painelAdmin> createState() => _painelAdminState();
}

class _painelAdminState extends State<painelAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configurações'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

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

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return CadastroCondominio(dropValue, file, file2);
                      }));

                },
                child: Text(
                    'Configuração',
                  style: TextStyle(
                      fontSize: 19,
                  ),
                ),
              ),
            ),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){

              },
              child: Text(
                  'Painel',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return anteLogin();
                        }));
                  },
                  child: Text(
                    'Sair',
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey
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
