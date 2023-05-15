import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:glk_controls/callToAPI.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String RG;
  bool semSaida;

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
      this.RG,
      this.semSaida,
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

String Status = "";

class _veiculoAguardandoState extends State<veiculoAguardando> {

  String lacreSt = '';
  bool lacrebool = false;
  String tagSelecionada = '';
  final dropValue = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    String lacrereject = '';
    String AutorizoEntrada = 'Autorizo Entrada st';

    File? imageFile = widget.imageFile;
    File? imageFile2 = widget.imageFile2;
    File? imageFile3 = widget.imageFile3;
    File? imageFile4 = widget.imageFile4;

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final textScaleFactor = mediaQueryData.textScaleFactor;
    final dpi = mediaQueryData.devicePixelRatio;

    final textHeight = screenHeight * 0.05;
    final textWidth = screenWidth * 0.8;

    final textSize = (textHeight / dpi / 2) * textScaleFactor;

    String idDocumento;

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;
    bool lacreSelect = false;
    String lacrefoto = 'Placa 2';

    Map Galpoes = { };
    List GalpoesList = [ ];

    if(kIsWeb){
      tamanhotexto = textSize;
      tamanhotextobtns = textSize;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;
        aspect = 0.8;

      }
    }

    if(widget.lacreounao == 'lacre'){
      lacreSelect = true;
      lacrefoto = 'Lacre *';

      setState(() {
        AutorizoEntrada = 'Autorizo Entrada com lacre divergente';
        lacrereject = 'com lacre divergente';
      });
    }

    if(widget.lacreounao == 'naolacrado'){
      setState(() {
        AutorizoEntrada = 'Autorizo Entrada sem lacre';
        lacrereject = 'sem lacre';
      });
    }



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


      //rele 1
      if(result.get('localAplicacao1') == "Cancela"){
          //Verifica a função dos outros relês

          if(result.get('funcao-rele1').contains('Pulso')){


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

    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

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
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao} - Portaria - ${widget.liberadopor}' ,
                    style: TextStyle(
                        fontSize: textSize
                    ),
                  ),
                ],
              )
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DataAnaliseEmpresa} - Empresa - ${widget.Empresadestino}' ,
                    style: TextStyle(
                        fontSize: textSize
                    ),
                  ),
                ],
              )
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Nome: ${widget.nomeMotorista}',
                style: TextStyle(
                    fontSize: textSize
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'RG: ${widget.RG}',
                style: TextStyle(
                    fontSize: textSize
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ${widget.Veiculo}',
                style: TextStyle(
                    fontSize: textSize
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Placa: ${widget.PlacaVeiculo}',
                style: TextStyle(
                    fontSize: textSize
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ${widget.Empresadestino}',
                style: TextStyle(
                    fontSize: textSize
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ${widget.EmpresadeOrigin}',
                style: TextStyle(
                    fontSize: textSize
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Setor: ${widget.Galpao}',
                style: TextStyle(
                    fontSize: textSize
                ),
              ),
            ),
            RadioListTile(
              title: const Text(
                  "Com lacre divergente"
              ),
              value: "lacre",
              groupValue: widget.lacreounao,
              onChanged: null,
            ),
            RadioListTile(
              title: const Text("Sem Lacre",),
              value: "naolacrado",
              groupValue: widget.lacreounao,
              onChanged: null,
            ),
            lacrebool ?
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  lacreSt = valor;
                  //Mudou mandou para a String
                },
                keyboardType: TextInputType.number,
                //enableSuggestions: false,
                //autocorrect: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Numero do lacre *',
                  hintStyle: TextStyle(
                      fontSize: textSize
                  ),
                ),
              ),
            )
                :const Text(''),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Adicione a foto no icone abaixo',
                  style: TextStyle(
                      fontSize: textSize
                  ),
                ),
              ),
            SizedBox(
              height: 300,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child:
                      ElevatedButton(
                        onPressed: _uploadImage,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent
                        ),
                        child:
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Motorista *',
                                style: TextStyle(
                                  fontSize: textSize,
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child:
                      ElevatedButton(
                        onPressed: _uploadImage2,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent
                        ),
                        child:
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Placa 1*',
                                style: TextStyle(
                                    fontSize: textSize,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child:
                      ElevatedButton(
                        onPressed: _uploadImage3,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent
                        ),
                        child:
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                lacrefoto,
                                style: TextStyle(
                                    fontSize: textSize,
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
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child:
                      ElevatedButton(
                        onPressed: _uploadImage4,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent
                        ),
                        child:
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Placa 3',
                                style: TextStyle(
                                    fontSize: textSize,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
                child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                  return DropdownButton(
                    hint: Text(
                      'Selecione uma TAG.VC - ID *',
                      style: TextStyle(
                          fontSize: textSize
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
                        style: TextStyle(
                            fontSize: textSize
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
                        fontSize: textSize,
                      );
                    }else{
                      if(tagSelecionada == ''){
                        Fluttertoast.showToast(
                          msg: 'Selecione uma tag disponivel!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: textSize,
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

                          final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                          final SharedPreferences prefs = await _prefs;
                          bool? offlinemode =  prefs.getBool('OfflineMode');

                          if(offlinemode == true){

                            FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                              'verificadoPor': widget.empresaName,
                              'LacreouNao': 'naolacrado',
                              'DataDeAnalise': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                              'tag': tagSelecionada,
                              'Status': 'Liberado Saida',
                            });

                            var result = await FirebaseFirestore.instance
                                .collection("Condominio")
                                .doc('condominio')
                                .get();

                            Map tags = (result.get('tags'));

                            tags[tagSelecionada] = 'Usado';


                            FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                              'tags': tags
                            });

                            //Fazer as regras do Rele
                            callToVerifyReles();
                            Navigator.of(context).pop();
                            Navigator.pop(context);

                          }else{
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
                              'DataDeAnalise': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
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
                                fontSize: textSize,
                              );

                              var result = await FirebaseFirestore.instance
                                  .collection("Condominio")
                                  .doc('condominio')
                                  .get();

                              Map tags = (result.get('tags'));

                              tags[tagSelecionada] = 'Usado';


                              FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                'tags': tags
                              });

                              //Fazer as regras do Rele
                              callToVerifyReles();
                              Navigator.of(context).pop();
                              Navigator.pop(context);
                            });
                          }
                        }else{

                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'verificadoPor': widget.empresaName,
                            'LacreouNao': 'naolacrado',
                            'DataDeAnalise': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                            'tag': tagSelecionada,
                            'Status': 'Liberado Saida',
                          });

                          var result = await FirebaseFirestore.instance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          Map tags = (result.get('tags'));

                          tags[tagSelecionada] = 'Usado';


                          FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                            'tags': tags
                          });

                          //Fazer as regras do Rele
                          callToVerifyReles();
                          Navigator.of(context).pop();
                          Navigator.pop(context);

                        }
                      }
                    }
                  }
                  if(lacrebool == true){
                    if(lacreSt == ''){
                      Fluttertoast.showToast(
                        msg: 'Preencha o numero do lacre!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: textSize,
                      );
                    }else{

                      if(isTired == false){
                        Fluttertoast.showToast(
                          msg: 'Tire a foto do motorista!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: textSize,
                        );
                      }else{
                        if(isTired2 == false){
                          Fluttertoast.showToast(
                            msg: 'Tire da placa do veiculo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: textSize,
                          );
                        }else{
                          if(isTired3 == false){
                            Fluttertoast.showToast(
                              msg: 'Tire do lacre!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: textSize,
                            );
                          }else{
                            if(tagSelecionada == ''){
                              Fluttertoast.showToast(
                                msg: 'Selecione uma tag disponivel!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: textSize,
                              );
                            }else{
                              if(widget.semSaida == true){
                                Status = 'Saida"';
                              }else{
                                Status = 'Estacionário';
                              }
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

                                  final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idDocumento);
                                  final imageUrl2 = await _uploadImageToFirebase2(imageFile2!, widget.idDocumento);
                                  final imageUrl3 = await _uploadImageToFirebase3(imageFile3!, widget.idDocumento);

                                  String imageUrl4 = '';

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
                                    'Status': Status,
                                    'DataDeAnalise': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                                    'tag': tagSelecionada,
                                  }).then((value) {

                                    Fluttertoast.showToast(
                                      msg: 'Dados atualizados!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: textSize,
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


                                  FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                    'tags': tags
                                  });

                                } else {
                                  FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                                    'verificadoPor': widget.empresaName,
                                    'LacreouNao': 'lacre',
                                    'Status': Status,
                                    'tag': tagSelecionada,
                                    'DataDeAnalise': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),

                                  });
                                  //Fazer as regras do Rele
                                  callToVerifyReles();
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);

                                }
                              } catch (e) {
                              }
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
                      fontSize: textSize
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
                        'Operador: ${widget.empresaName}',
                        style: TextStyle(
                            fontSize: textSize
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