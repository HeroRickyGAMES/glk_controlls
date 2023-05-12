import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:glk_controls/callToAPI.dart';

//Programado por HeroRickyGames

class modalSaidaVeiculo extends StatefulWidget {

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
  String DatadeAnalise = '';
  String verificadoPor = '';
  String DateEntrada = '';
  String EmpresaDoc = '';
  String porteiroName = '';
  String DataSaida = '';
  String tagSelecionada = '';
  String Saida = '';
  String numeroLacresaida  = '';
  bool lacresaida;

  modalSaidaVeiculo(
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
      this.DatadeAnalise,
      this.verificadoPor,
      this.DateEntrada,
      this.EmpresaDoc,
      this.porteiroName,
      this.DataSaida,
      this.tagSelecionada,
      this.Saida,
      this.numeroLacresaida,
      this.lacresaida,
      {super.key}
      );
  @override
  State<modalSaidaVeiculo> createState() => _modalSaidaVeiculoState();
}

class _modalSaidaVeiculoState extends State<modalSaidaVeiculo> {

  bool recolheutag = false;
  bool dadosConferido = false;

  @override
  Widget build(BuildContext context) {

    bool lacrebool = false;
    String? lacreSt;

    if(widget.lacreounao == 'lacre'){

      lacrebool = true;

    }

    if(widget.lacreounao == 'naolacrado'){

      lacrebool = false;

    }

    String _textoPredefinido = widget.lacradoStr;
    lacreSt = widget.lacradoStr;

    callToVerifyReles() async {
      var result = await FirebaseFirestore.instance
          .collection("Reles")
          .doc('Rele02')
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

    TextEditingController _textEditingController = TextEditingController(text: _textoPredefinido);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: const Text(
          'GLK Controls - Veiculo Saida',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child:
              Text(
                'Liberação: ' + 'Motorista e Veiculo',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao} - Portaria - ${widget.liberadopor}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DatadeAnalise} - Analise da Empresa - ${widget.Empresadestino}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DateEntrada} - Portaria - ${widget.verificadoPor}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DataSaida} - Solicitação de saída - ${widget.Empresadestino}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Nome: ${widget.nomeMotorista}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ${widget.Veiculo}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Placa: ${widget.PlacaVeiculo}',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ${widget.Empresadestino}',
                style: TextStyle(
                    fontSize: tamanhotextobtns
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ${widget.EmpresadeOrigin}',
                style: TextStyle(
                    fontSize: tamanhotextobtns
                ),
              ),
            ),
            widget.lacresaida? Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Lacre de saida: ${widget.numeroLacresaida}',
                style: TextStyle(
                    fontSize: tamanhotextobtns
                ),
              ),
            ): const Text(''),
            Container(
              child:
              CheckboxListTile(
                title: const Text('Tag recolhida'),
                value: recolheutag,
                onChanged: (value) {
                  setState(() {
                    recolheutag = value!;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              child:
              CheckboxListTile(
                title: const Text('Dados conferidos'),
                value: dadosConferido,
                onChanged: (value) {
                  setState(() {
                    dadosConferido = value!;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {

                  if(recolheutag == false){
                    Fluttertoast.showToast(
                      msg: 'Verifique se a tag já foi recolhida!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: tamanhotexto,
                    );
                  }else{
                    if(dadosConferido == false){
                      Fluttertoast.showToast(
                        msg: 'Verifique todos os dados!!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: tamanhotexto,
                      );
                    }else{

                      if(lacrebool == false){

                        var result = await FirebaseFirestore.instance
                            .collection("Condominio")
                            .doc('condominio')
                            .get();

                        Map tags = (result.get('tags'));

                        tags[widget.tagSelecionada] = 'naoUsado';


                        FirebaseFirestore.instance.collection('Condominio').doc('condominio').update(
                            {
                              'tags': tags
                            });

                        callToVerifyReles();

                        FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                          'DataSaida': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                          'Status': 'Saida',
                          'saidaLiberadaPor': widget.porteiroName
                        }).then((value){
                          Navigator.pop(context);
                        });

                        ConnectivityUtils.instance
                          ..serverToPing =
                              "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt"
                          ..verifyResponseCallback =
                              (response) => response.contains("This is a test!");

                        if(await ConnectivityUtils.instance.isPhoneConnected()){

                        }else{
                          Navigator.pop(context);
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
                            fontSize: tamanhotexto,
                          );
                        }else{
                          var result = await FirebaseFirestore.instance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          Map tags = (result.get('tags'));

                          tags[widget.tagSelecionada] = 'naoUsado';


                          FirebaseFirestore.instance.collection('Condominio').doc('condominio').update(
                              {
                                'tags': tags
                              });
                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataSaida': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                            'Status': 'Saida',
                            'saidaLiberadaPor': widget.porteiroName
                          }).then((value){
                            Navigator.pop(context);
                          });

                          ConnectivityUtils.instance
                            ..serverToPing =
                                "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt"
                            ..verifyResponseCallback =
                                (response) => response.contains("This is a test!");

                          if(await ConnectivityUtils.instance.isPhoneConnected()){
                          }else{
                            Navigator.pop(context);
                          }
                        }
                      }
                    }
                  }
                },
                child: Text(
                  'Prosseguir',
                  style: TextStyle(
                      fontSize: tamanhotextobtns
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
                        'Operador: ${widget.porteiroName}',
                        style: TextStyle(
                            fontSize: tamanhotexto
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