import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/mainEmpresa.dart';
import 'package:glk_controls/mainPorteiro.dart';
import 'package:image_picker/image_picker.dart';

//Programado por HeroRickyGames

class relatorioGenerate extends StatefulWidget {

  String lacreounao = '';
  String empresaName = '';
  String liberadopor = '';
  String horarioCriacao;
  String nomeMotorista = '';
  String Veiculo = '';
  String PlacaVeiculo = '';
  String Empresadestino = '';
  String EmpresadeOrigin = '' ;
  String Galpao = '';
  String lacradoStr = '';
  String idDocumento = '';
  String dataEntrada = '';
  String dataSaida = '';

  relatorioGenerate(
      this.lacreounao,
      this.empresaName,
      this.liberadopor,
      this.horarioCriacao,
      this.nomeMotorista,
      this.Veiculo,
      this.PlacaVeiculo,
      this.Empresadestino,
      this.EmpresadeOrigin,
      this.Galpao,
      this.lacradoStr,
      this.idDocumento,
      this.dataEntrada,
      this.dataSaida
      );
  @override
  State<relatorioGenerate> createState() => _relatorioGenerateState();
}

File? imageFile;

final FirebaseStorage storage = FirebaseStorage.instance;

class _relatorioGenerateState extends State<relatorioGenerate> {
  bool lacrebool = false;
  String? lacreSt;

  Future<File?> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    return File(pickedFile!.path);
  }
  Future<String> _uploadImageToFirebase(File file, String id) async {
    // Crie uma referência única para o arquivo
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final reference = storage.ref().child('images/$id/$fileName');

    // Faça upload da imagem para o Cloud Storage
    await reference.putFile(file);

    // Recupere a URL do download da imagem para salvar no banco de dados
    final url = await reference.getDownloadURL();
    return url;
  }

  Future<void> _uploadImage() async {
    imageFile = await _getImageFromCamera();
    if (imageFile != null) {
      setState(() {
        imageFile = imageFile;


      });

      print(imageFile);

      // Salve a URL do download da imagem no banco de dados
    }
  }

  @override
  Widget build(BuildContext context) {


    if(widget.lacreounao == 'lacre'){

      lacrebool = true;

    }

    if(widget.lacreounao == 'naolacrado'){

      lacrebool = false;

    }

    String _textoPredefinido = widget.lacradoStr;
    lacreSt = widget.lacradoStr;

    TextEditingController _textEditingController = TextEditingController(text: _textoPredefinido);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          'GLK Controls - Relatório',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child:
              Text(
                'Entrada Liberada: ' + widget.liberadopor,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Data: ${widget.horarioCriacao}' ,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Nome: ' + widget.nomeMotorista,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ' + widget.Veiculo,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Placa: ' + widget.PlacaVeiculo,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ' + widget.Empresadestino,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ' + widget.EmpresadeOrigin,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Galpão: ' + widget.Galpao,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            RadioListTile(
              title: Text(
                  "Com Lacre"
              ),
              value: "lacre",
              groupValue: widget.lacreounao,
              onChanged: (value){
                setState(() {
                  widget.lacreounao = value.toString();

                  if(value == 'lacre'){
                    lacrebool = true;
                  }
                });
              },
            ),
            RadioListTile(
              title: Text("Sem Lacre",),
              value: "naolacrado",
              groupValue: widget.lacreounao,
              onChanged: (value){
                setState(() {
                  widget.lacreounao = value.toString();

                  if(value == 'naolacrado'){
                    lacrebool = false;
                  }
                });
              },
            ),
            lacrebool ?
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: _textEditingController,
                onChanged: (valor){
                  lacreSt = valor;
                  //Mudou mandou para a String
                },
                keyboardType: TextInputType.number,
                //enableSuggestions: false,
                //autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Numero do lacre *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            )
                :Text(''),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Adicione a foto no icone abaixo',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child:
              ElevatedButton(
                onPressed: _uploadImage,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {

                },
                child: Text(
                  'Gerar/Imprimir',
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
              ),
            ),
            Column(
              children: [
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
