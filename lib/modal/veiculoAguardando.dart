import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../callToAPI.dart';

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
  File? imageFile4;
  String DataAnaliseEmpresa;

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
      this.imageFile3,
      this.imageFile4,
      this.DataAnaliseEmpresa
      );
  @override
  State<veiculoAguardando> createState() => _veiculoAguardandoState();
}
final FirebaseStorage storage = FirebaseStorage.instance;

bool isTired = false;
bool isTired2 = false;
bool isTired3 = false;
bool isTired4 = false;

class _veiculoAguardandoState extends State<veiculoAguardando> {
  @override
  Widget build(BuildContext context) {
    File? imageFile = widget.imageFile;
    File? imageFile2 = widget.imageFile2;
    File? imageFile3 = widget.imageFile3;
    File? imageFile4 = widget.imageFile4;

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
    trocandoparaverdadeiro4(){
      setState(() {
        isTired4 = true;
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

    Future<String> _uploadImageToFirebase4(File file, String id) async {
      // Crie uma referência única para o arquivo
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);
      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }

    Future<void> _uploadImage4() async {
      imageFile4 = await _getImageFromCamera();
      setState(() {

        imageFile4 = imageFile4;
        widget.imageFile4 = imageFile4;

      });
      trocandoparaverdadeiro4();
      print(imageFile);
    }


    if(widget.lacreounao == 'lacre'){

      lacrebool = true;

    }

    if(widget.lacreounao == 'naolacrado'){

      lacrebool = false;

    }

    callToVerifyReles() async {
      var result = await FirebaseFirestore.instance
          .collection("Reles")
          .doc('Rele01')
          .get();

      print('aqui');
      print(result.get('localAplicacao1'));

      //rele 1
      if(result.get('localAplicacao1') == "Cancela"){
          //Verifica a função dos outros relês

          if(result.get('funcao-rele1').contains('Pulso')){

            print(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));

            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            releCancelaEntrada();
          }

          if(result.get('localAplicacao2') == 'Fechamento'){

            if(result.get('funcao-rele2').contains('Pulso')){

              rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(Duration(seconds: 5));
              releFechamento02();
            }

          }

          if(result.get('localAplicacao2') == 'Farol'){
            if(result.get('funcao-rele2').contains('Pulso')){

              rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(Duration(seconds: 5));
              releFechamento02();
            }
          }

          //Verifica a função dos outros relês

          if(result.get('localAplicacao3') == 'Fechamento'){
            if(result.get('funcao-rele3').contains('Pulso')){

              rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(Duration(seconds: 5));
              releFarol03();
            }
          }

          if(result.get('localAplicacao3') == 'Farol'){

            if(result.get('funcao-rele3').contains('Pulso')){

              rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(Duration(seconds: 5));
              releFarol03();
            }
          }

          //Verifica a função dos outros relês


          if(result.get('localAplicacao4') == 'Fechamento'){
            if(result.get('funcao-rele4').contains('Pulso')){

              rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(Duration(seconds: 5));
              releFarol04();
            }
          }

          if(result.get('localAplicacao4') == 'Farol'){
            if(result.get('funcao-rele4').contains('Pulso')){

              rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(Duration(seconds: 5));
              releFarol04();
            }
          }
      }

      //rele 2

      if(result.get('localAplicacao2') == "Cancela"){
        if(result.get('funcao-rele2').contains('Pulso')){

          rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
        }else{
          await Future.delayed(Duration(seconds: 5));
          releFarol02();
        }

        if(result.get('localAplicacao1') == 'Fechamento'){

          if(result.get('funcao-rele1').contains('Pulso')){

            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releCancelaEntrada();
          }

        }

        if(result.get('localAplicacao1') == 'Farol'){

          if(result.get('funcao-rele1').contains('Pulso')){
            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releCancelaEntrada();
          }
        }

        //Verifica a função dos outros relês

        if(result.get('localAplicacao3') == 'Fechamento'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol03();
          }

        }

        if(result.get('localAplicacao3') == 'Farol'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));

            print(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol03();
          }
        }

        //Verifica a função dos outros relês

        if(result.get('localAplicacao4') == 'Fechamento'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol04();
          }
        }

        if(result.get('localAplicacao4') == 'Farol'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol04();
          }
        }

      }


      //Rele3

      if(result.get('localAplicacao3') == "Cancela"){
        if(result.get('localAplicacao1') == 'Fechamento'){

          if(result.get('funcao-rele1').contains('Pulso')){

            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releCancelaEntrada();
          }

        }

        if(result.get('localAplicacao1') == 'Farol'){

          if(result.get('funcao-rele1').contains('Pulso')){
            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releCancelaEntrada();
          }
        }

        if(result.get('localAplicacao2') == 'Fechamento'){

          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFechamento02();
          }

        }

        if(result.get('localAplicacao2') == 'Farol'){
          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFechamento02();
          }
        }

        if(result.get('localAplicacao4') == 'Fechamento'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol04();
          }
        }

        if(result.get('localAplicacao4') == 'Farol'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol04();
          }
        }
      }

      //rele 4

      if(result.get('localAplicacao4') == 'Cancela'){
        if(result.get('funcao-rele4').contains('Pulso')){

          rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
        }else{
          await Future.delayed(Duration(seconds: 5));
          releFarol04();
        }

        if(result.get('localAplicacao1') == 'Fechamento'){

          if(result.get('funcao-rele1').contains('Pulso')){

            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releCancelaEntrada();
          }

        }

        if(result.get('localAplicacao1') == 'Farol'){

          if(result.get('funcao-rele1').contains('Pulso')){
            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releCancelaEntrada();
          }
        }

        if(result.get('localAplicacao2') == 'Fechamento'){

          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFechamento02();
          }

        }

        if(result.get('localAplicacao2') == 'Farol'){
          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFechamento02();
          }
        }

        if(result.get('localAplicacao3') == 'Fechamento'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol03();
          }

        }

        if(result.get('localAplicacao3') == 'Farol'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(Duration(seconds: 5));
            releFarol03();
          }
        }
      }
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
                'Liberação: ' + 'Motorista e Veiculo',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao}' ,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.liberadopor,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DataAnaliseEmpresa}' ,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Empresa - ' + widget.Empresadestino,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Motorista *',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                              ),
                            ),
                          ),
                          Image.file(
                            imageFile!,
                            height: 265,
                            width: 200,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage2,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Placa 1*',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Image.file(
                            imageFile2!,
                            height: 265,
                            width: 200,
                          ),
                        ],
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage3,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Placa 2 *',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Image.file(
                            imageFile3!,
                            height: 265,
                            width: 200,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage4,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Placa 3*',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Image.file(
                            imageFile4!,
                            height: 265,
                            width: 200,
                          ),
                        ],
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
                    if(isTired == false){
                      Fluttertoast.showToast(
                        msg: 'Tire a foto do motorista!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      if(isTired2 == false){
                        Fluttertoast.showToast(
                          msg: 'Tire da placa do veiculo!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{
                        if(isTired3 == false){
                          Fluttertoast.showToast(
                            msg: 'Tire da placa do veiculo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{

                          if(isTired4 == false){
                            Fluttertoast.showToast(
                              msg: 'Tire da placa do veiculo!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }else{
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Aguarde!'),
                                  actions: [
                                    Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  ],
                                );
                              },
                            );

                            final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idDocumento);
                            final imageUrl2 = await _uploadImageToFirebase2(imageFile2!, widget.idDocumento);
                            final imageUrl3 = await _uploadImageToFirebase3(imageFile3!, widget.idDocumento);
                            final imageUrl4 = await _uploadImageToFirebase4(imageFile3!, widget.idDocumento);



                            FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                              'verificadoPor': widget.empresaName,
                              'LacreouNao': 'naolacrado',
                              'DataDeAnalise': DateTime.now(),
                              'uriImage': imageUrl,
                              'uriImage2': imageUrl2,
                              'uriImage3': imageUrl3,
                              'uriImage4': imageUrl4,
                              'Status': 'Entrada',
                            }).then((value) async {
                              Fluttertoast.showToast(
                                msg: 'Dados atualizados!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              //Fazer as regras do Rele

                             callToVerifyReles();
                            });
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          }
                        }
                      }
                    }
                  }
                  if(lacrebool == true){
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
                          msg: 'Tire a foto do motorista!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{

                        if(isTired2 == false){
                          Fluttertoast.showToast(
                            msg: 'Tire da placa do veiculo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{
                          if(isTired3 == false){
                            Fluttertoast.showToast(
                              msg: 'Tire da placa do veiculo!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }else{

                            if(isTired4 == false){
                              Fluttertoast.showToast(
                                msg: 'Tire da placa do veiculo!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }else{

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Aguarde!'),
                                    actions: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                },
                              );

                              final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idDocumento);
                              final imageUrl2 = await _uploadImageToFirebase2(imageFile2!, widget.idDocumento);
                              final imageUrl3 = await _uploadImageToFirebase3(imageFile3!, widget.idDocumento);
                              final imageUrl4 = await _uploadImageToFirebase3(imageFile4!, widget.idDocumento);

                              FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                                'verificadoPor': widget.empresaName,
                                'LacreouNao': 'lacre',
                                'uriImage': imageUrl,
                                'uriImage2': imageUrl2,
                                'uriImage3': imageUrl3,
                                'uriImage4': imageUrl4,
                                'Status': 'Entrada',
                                'DataDeAnalise': DateTime.now(),
                              }).then((value) {

                                Fluttertoast.showToast(
                                  msg: 'Dados atualizados!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                //Fazer as regras do Rele
                                callToVerifyReles();
                                Navigator.of(context).pop();
                                Navigator.pop(context);
                              });
                            }
                          }
                        }
                      }
                    }
                  }
                },
                child: Text(
                  'Prosseguir',
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