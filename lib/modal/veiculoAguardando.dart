import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

//Programado por HeroRickyGames

class veiculoAguardando extends StatefulWidget {

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
  File? imageFile;
  File? imageFile2;
  File? imageFile3;

  veiculoAguardando(
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
      this.imageFile,
      this.imageFile2,
      this.imageFile3
      );
  @override
  State<veiculoAguardando> createState() => _veiculoAguardandoState();
}
final FirebaseStorage storage = FirebaseStorage.instance;

bool isTired = false;
bool isTired2 = false;
bool isTired3 = false;

class _veiculoAguardandoState extends State<veiculoAguardando> {
  @override
  Widget build(BuildContext context) {
    File? imageFile = widget.imageFile;
    File? imageFile2 = widget.imageFile2;
    File? imageFile3 = widget.imageFile3;

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
      print(url);
      return url;
    }

    trocandoparaverdadeiro(){
      setState(() {
        isTired = true;
      });
    }
    trocandoparaverdadeiro2(){
      setState(() {
        isTired2 = true;
      });
    }
    trocandoparaverdadeiro3(){
      setState(() {
        isTired3 = true;
      });
    }

    Future<void> _uploadImage() async {
      imageFile = await _getImageFromCamera();
      setState(() {

        imageFile = imageFile;
        widget.imageFile = imageFile;
      });
      trocandoparaverdadeiro();
      print(imageFile);
    }


    Future<String> _uploadImageToFirebase2(File file, String id) async {
      // Crie uma referência única para o arquivo
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);

      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }

    Future<void> _uploadImage2() async {
      imageFile2 = await _getImageFromCamera();
      setState(() {

        imageFile2 = imageFile2;
        widget.imageFile2 = imageFile2;
      });
      trocandoparaverdadeiro2();
      print(imageFile);

    }
    Future<String> _uploadImageToFirebase3(File file, String id) async {
      // Crie uma referência única para o arquivo
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);
      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }

    Future<void> _uploadImage3() async {
      imageFile3 = await _getImageFromCamera();
      setState(() {

        imageFile3 = imageFile3;
        widget.imageFile3 = imageFile3;
      });
      trocandoparaverdadeiro3();
      print(imageFile);
    }


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
          'GLK Controls - Veiculo Aguardando',
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
              height: 300,
              width: 700,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage,
                      child:
                      Image.file(
                        imageFile!,
                        height: 265,
                        width: 200,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage2,
                      child:
                      Image.file(
                        imageFile2!,
                        height: 265,
                        width: 200,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: 700,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage3,
                      child:
                      Image.file(
                        imageFile3!,
                        height: 265,
                        width: 200,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  if(lacrebool == false){

                    Fluttertoast.showToast(
                      msg: 'Atualizando dados... Isso pode demorar um pouco dependendo da',
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Fluttertoast.showToast(
                      msg: 'Sua internet...',
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    if(isTired == false){
                      Fluttertoast.showToast(
                        msg: 'Tire a foto do veiculo!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      if(isTired2 == false){
                        Fluttertoast.showToast(
                          msg: 'Tire a foto do veiculo!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{
                        if(isTired3 == false){
                          Fluttertoast.showToast(
                            msg: 'Tire a foto do veiculo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{
                          final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idDocumento);
                          final imageUrl2 = await _uploadImageToFirebase2(imageFile2!, widget.idDocumento);
                          final imageUrl3 = await _uploadImageToFirebase3(imageFile3!, widget.idDocumento);
                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'LacreouNao': 'naolacrado',
                            'uriImage': imageUrl,
                            'uriImage2': imageUrl2,
                            'uriImage3': imageUrl3,
                          }).then((value){
                            Fluttertoast.showToast(
                              msg: 'Dados atualizados!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          });
                          Navigator.pop(context);
                        }
                      }
                    }
                  }
                  if(lacrebool == true){

		               Fluttertoast.showToast(
                      msg: 'Atualizando dados... Isso pode demorar um pouco dependendo da',
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
		              Fluttertoast.showToast(
                      msg: 'Sua internet...',
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                    if(lacreSt == null){
                      Fluttertoast.showToast(
                        msg: 'Preencha o numero do lacre!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      print(isTired);

                      if(isTired == false){
                        Fluttertoast.showToast(
                          msg: 'Tire a foto do veiculo!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{

                        if(isTired2 == false){
                          Fluttertoast.showToast(
                            msg: 'Tire a foto do veiculo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{
                          if(isTired3 == false){
                            Fluttertoast.showToast(
                              msg: 'Tire a foto do veiculo!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }else{
                            final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idDocumento);
                            final imageUrl2 = await _uploadImageToFirebase2(imageFile2!, widget.idDocumento);
                            final imageUrl3 = await _uploadImageToFirebase3(imageFile3!, widget.idDocumento);

                            FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                              'LacreouNao': 'lacre',
                              'uriImage': imageUrl,
                              'uriImage2': imageUrl2,
                              'uriImage3': imageUrl3,
                            }).then((value) {
                              Fluttertoast.showToast(
                                msg: 'Dados atualizados!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            });
                            Navigator.pop(context);
                          }
                        }
                      }
                    }
                  }
                },
                child: Text(
                  'Atualizar Documento',
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
                    Container(
                      padding: EdgeInsets.all(16),
                      child:
                      Text(
                        'Operador: ' + widget.empresaName,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
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
