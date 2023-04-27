import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glk_controls/callToAPI.dart';
import 'package:intl/intl.dart';

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
  List tagList;
  String DataAnaliseEmpresa;
  String Entrada;

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
      this.DataAnaliseEmpresa,
      this.tagList,
      this.Entrada,
      {super.key}
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
    String? tagSelecionada = '';

    final dropValue = ValueNotifier('');

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
          .doc(widget.Entrada)
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
              await Future.delayed(const Duration(seconds: 5));
              releFechamento02();
            }

          }

          if(result.get('localAplicacao2') == 'Farol'){
            if(result.get('funcao-rele2').contains('Pulso')){

              rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(const Duration(seconds: 5));
              releFechamento02();
            }
          }

          //Verifica a função dos outros relês

          if(result.get('localAplicacao3') == 'Fechamento'){
            if(result.get('funcao-rele3').contains('Pulso')){

              rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(const Duration(seconds: 5));
              releFarol03();
            }
          }

          if(result.get('localAplicacao3') == 'Farol'){

            if(result.get('funcao-rele3').contains('Pulso')){

              rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(const Duration(seconds: 5));
              releFarol03();
            }
          }

          //Verifica a função dos outros relês


          if(result.get('localAplicacao4') == 'Fechamento'){
            if(result.get('funcao-rele4').contains('Pulso')){

              rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(const Duration(seconds: 5));
              releFarol04();
            }
          }

          if(result.get('localAplicacao4') == 'Farol'){
            if(result.get('funcao-rele4').contains('Pulso')){

              rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
            }else{
              await Future.delayed(const Duration(seconds: 5));
              releFarol04();
            }
          }
      }

      //rele 2

      if(result.get('localAplicacao2') == "Cancela"){
        if(result.get('funcao-rele2').contains('Pulso')){

          rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
        }else{
          await Future.delayed(const Duration(seconds: 5));
          releFarol02();
        }

        if(result.get('localAplicacao1') == 'Fechamento'){

          if(result.get('funcao-rele1').contains('Pulso')){

            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releCancelaEntrada();
          }

        }

        if(result.get('localAplicacao1') == 'Farol'){

          if(result.get('funcao-rele1').contains('Pulso')){
            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releCancelaEntrada();
          }
        }

        //Verifica a função dos outros relês

        if(result.get('localAplicacao3') == 'Fechamento'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFarol03();
          }

        }

        if(result.get('localAplicacao3') == 'Farol'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));

            print(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFarol03();
          }
        }

        //Verifica a função dos outros relês

        if(result.get('localAplicacao4') == 'Fechamento'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFarol04();
          }
        }

        if(result.get('localAplicacao4') == 'Farol'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
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
            await Future.delayed(const Duration(seconds: 5));
            releCancelaEntrada();
          }

        }

        if(result.get('localAplicacao1') == 'Farol'){

          if(result.get('funcao-rele1').contains('Pulso')){
            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releCancelaEntrada();
          }
        }

        if(result.get('localAplicacao2') == 'Fechamento'){

          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFechamento02();
          }

        }

        if(result.get('localAplicacao2') == 'Farol'){
          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFechamento02();
          }
        }

        if(result.get('localAplicacao4') == 'Fechamento'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFarol04();
          }
        }

        if(result.get('localAplicacao4') == 'Farol'){
          if(result.get('funcao-rele4').contains('Pulso')){

            rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFarol04();
          }
        }
      }

      //rele 4

      if(result.get('localAplicacao4') == 'Cancela'){
        if(result.get('funcao-rele4').contains('Pulso')){

          rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
        }else{
          await Future.delayed(const Duration(seconds: 5));
          releFarol04();
        }

        if(result.get('localAplicacao1') == 'Fechamento'){

          if(result.get('funcao-rele1').contains('Pulso')){

            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releCancelaEntrada();
          }

        }

        if(result.get('localAplicacao1') == 'Farol'){

          if(result.get('funcao-rele1').contains('Pulso')){
            rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releCancelaEntrada();
          }
        }

        if(result.get('localAplicacao2') == 'Fechamento'){

          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFechamento02();
          }

        }

        if(result.get('localAplicacao2') == 'Farol'){
          if(result.get('funcao-rele2').contains('Pulso')){

            rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFechamento02();
          }
        }

        if(result.get('localAplicacao3') == 'Fechamento'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
            releFarol03();
          }

        }

        if(result.get('localAplicacao3') == 'Farol'){

          if(result.get('funcao-rele3').contains('Pulso')){

            rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
          }else{
            await Future.delayed(const Duration(seconds: 5));
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
        title: const Text(
          'GLK Controls - Liberação de Veiculos',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao}' ,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.liberadopor,
                    style: const TextStyle(
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
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Empresa - ' + widget.Empresadestino,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Nome: ' + widget.nomeMotorista,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ' + widget.Veiculo,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Placa: ' + widget.PlacaVeiculo,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ' + widget.Empresadestino,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ' + widget.EmpresadeOrigin,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Setor: ' + widget.Galpao,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            RadioListTile(
              title: const Text(
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
              title: const Text("Sem Lacre",),
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
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _textEditingController,
                onChanged: (valor){
                  lacreSt = valor;
                  //Mudou mandou para a String
                },
                keyboardType: TextInputType.number,
                //enableSuggestions: false,
                //autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Numero do lacre *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            )
                :const Text(''),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: const Text(
                  'Adicione a foto no icone abaixo',
                  style: TextStyle(
                      fontSize: 16
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
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: const Text(
                              'Motorista *',
                              style: TextStyle(
                                fontSize: 16,
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
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage2,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: const Text(
                              'Placa 1*',
                              style: TextStyle(
                                  fontSize: 16,
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
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage3,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: const Text(
                              'Placa 2 ',
                              style: TextStyle(
                                  fontSize: 16,
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
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage4,
                      child:
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: const Text(
                              'Placa 3',
                              style: TextStyle(
                                  fontSize: 16,
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
            Center(
                child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                  return DropdownButton(
                    hint: const Text(
                      'Selecione uma TAG.VC - ID *',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    value: (value.isEmpty)? null : value,
                    onChanged: (escolha) async {
                     dropValue.value = escolha.toString();

                      tagSelecionada = escolha.toString();

                    },
                    items: widget.tagList.map((opcao) => DropdownMenuItem(
                      value: opcao,
                      child:
                      Text(
                        opcao,
                        style: const TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ),
                    ).toList(),
                  );
                })
            ),
            Container(
              padding: const EdgeInsets.all(16),
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
                      if(tagSelecionada == ''){
                        Fluttertoast.showToast(
                          msg: 'Selecione uma tag disponivel!',
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

                        final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar


                        ConnectivityUtils.instance
                          ..serverToPing =
                              "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt"
                          ..verifyResponseCallback =
                              (response) => response.contains("This is a test!");

                        if(await ConnectivityUtils.instance.isPhoneConnected()){




                          final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idDocumento);
                          final imageUrl2 = await _uploadImageToFirebase2(imageFile2!, widget.idDocumento);
                          String imageUrl3 = '';
                          String imageUrl4 = '';


                          if(imageFile3 != ''){
                            imageUrl3 = await _uploadImageToFirebase3(imageFile3!, widget.idDocumento);

                          }

                          if(imageFile4 != ''){
                            imageUrl4 = await _uploadImageToFirebase4(imageFile4!, widget.idDocumento);
                          }

                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'verificadoPor': widget.empresaName,
                            'lacrenum': lacreSt,
                            'LacreouNao': 'naolacrado',
                            'DataDeAnalise': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                            'uriImage': imageUrl,
                            'uriImage2': imageUrl2,
                            'uriImage3': imageUrl3,
                            'uriImage4': imageUrl4,
                            'Status': 'Estacionário',
                            'tag': tagSelecionada
                          }).then((value) async {
                            Fluttertoast.showToast(
                              msg: 'Dados atualizados!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );

                            var result = await FirebaseFirestore.instance
                                .collection("Condominio")
                                .doc('condominio')
                                .get();

                            Map tags = (result.get('tags'));

                            tags[tagSelecionada] = 'Usado';

                            print(tags[tagSelecionada]);

                            FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                              'tags': tags
                            });

                            //Fazer as regras do Rele
                            callToVerifyReles();
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          });

                          print('Conectado!');

                        }else{

                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'verificadoPor': widget.empresaName,
                            'LacreouNao': 'naolacrado',
                            'DataDeAnalise': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                            'tag': tagSelecionada,
                            'Status': 'Estacionário',
                          });

                          var result = await FirebaseFirestore.instance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          Map tags = (result.get('tags'));

                          tags[tagSelecionada] = 'Usado';

                          print(tags[tagSelecionada]);

                          FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                            'tags': tags
                          });

                          //Fazer as regras do Rele
                          callToVerifyReles();
                          Navigator.of(context).pop();
                          Navigator.pop(context);

                          print('Desconectado!');
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
                          if(tagSelecionada == ''){
                            Fluttertoast.showToast(
                              msg: 'Selecione uma tag disponivel!',
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
                            final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

                            try {
                              final result = await Process.run('ping', ['-c', '1', ip]);
                              if (result.exitCode == 0) {
                                print('Ping realizado com sucesso para o endereço $ip');

                                final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idDocumento);
                                final imageUrl2 = await _uploadImageToFirebase2(imageFile2!, widget.idDocumento);
                                String imageUrl3 = '';
                                String imageUrl4 = '';


                                if(imageFile3 != ''){
                                  imageUrl3 = await _uploadImageToFirebase3(imageFile3!, widget.idDocumento);

                                }

                                if(imageFile4 != ''){
                                  imageUrl4 = await _uploadImageToFirebase4(imageFile4!, widget.idDocumento);
                                }

                                FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                                  'verificadoPor': widget.empresaName,
                                  'LacreouNao': 'lacre',
                                  'uriImage': imageUrl,
                                  'uriImage2': imageUrl2,
                                  'uriImage3': imageUrl3,
                                  'uriImage4': imageUrl4,
                                  'Status': 'Estacionário',
                                  'DataDeAnalise': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                                  'tag': tagSelecionada,
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


                                var result = await FirebaseFirestore.instance
                                    .collection("Condominio")
                                    .doc('condominio')
                                    .get();

                                Map tags = (result.get('tags'));

                                tags[tagSelecionada] = 'Usado';

                                print(tags[tagSelecionada]);

                                FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                  'tags': tags
                                });

                              } else {
                                FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                                  'verificadoPor': widget.empresaName,
                                  'LacreouNao': 'lacre',
                                  'Status': 'Estacionário',
                                  'tag': tagSelecionada,
                                  'DataDeAnalise': DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),

                                });
                                //Fazer as regras do Rele
                                callToVerifyReles();
                                Navigator.of(context).pop();
                                Navigator.pop(context);

                                print('Falha no ping para o endereço $ip');
                              }
                            } catch (e) {
                              print('Erro ao executar o comando de ping: $e');
                            }
                          }
                        }
                      }
                    }
                  }
                },
                child: const Text(
                  'Prosseguir',
                  style: TextStyle(
                      fontSize: 16
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
                      Text(
                        'Operador: ' + widget.empresaName,
                        style: const TextStyle(
                            fontSize: 16
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