import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../callToAPI.dart';

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
              const Text(
                'Liberação: ' + 'Motorista e Veiculo',
                style: TextStyle(
                    fontSize: 16
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
                    'Data: ${widget.DatadeAnalise}' ,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Analise da Empresa - ' + widget.Empresadestino,
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
                    'Data: ${widget.DateEntrada}' ,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.verificadoPor,
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
                    'Data: ${widget.DataSaida}' ,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Solicitação de saída - ' + widget.Empresadestino,
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
                    fontSize: 18
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ' + widget.EmpresadeOrigin,
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
            ),
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
                      fontSize: 16.0,
                    );
                  }else{
                    if(dadosConferido == false){
                      Fluttertoast.showToast(
                        msg: 'Verifique todos os dados!!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{

                      if(lacrebool == false){

                        var result = await FirebaseFirestore.instance
                            .collection("Condominio")
                            .doc('condominio')
                            .get();

                        Map tags = (result.get('tags'));

                        tags[widget.tagSelecionada] = 'naoUsado';

                        print(tags[widget.tagSelecionada]);

                        FirebaseFirestore.instance.collection('Condominio').doc('condominio').update(
                            {
                              'tags': tags
                            });

                        callToVerifyReles();

                        FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                          'DataSaida': DateTime.now(),
                          'Status': 'Saida',
                          'saidaLiberadaPor': widget.porteiroName
                        }).then((value){
                          Navigator.pop(context);
                        });
                        final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

                        try {
                          final result = await Process.run('ping', ['-c', '1', ip]);
                          if (result.exitCode == 0) {
                            print('Ping realizado com sucesso para o endereço $ip');
                          } else {
                            Navigator.pop(context);
                            print('Falha no ping para o endereço $ip');
                          }
                        } catch (e) {
                          print('Erro ao executar o comando de ping: $e');
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
                          var result = await FirebaseFirestore.instance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          Map tags = (result.get('tags'));

                          tags[widget.tagSelecionada] = 'naoUsado';

                          print(tags[widget.tagSelecionada]);

                          FirebaseFirestore.instance.collection('Condominio').doc('condominio').update(
                              {
                                'tags': tags
                              });
                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataSaida': DateTime.now(),
                            'Status': 'Saida',
                            'saidaLiberadaPor': widget.porteiroName
                          }).then((value){
                            Navigator.pop(context);
                          });
                          final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

                          try {
                            final result = await Process.run('ping', ['-c', '1', ip]);
                            if (result.exitCode == 0) {
                              print('Ping realizado com sucesso para o endereço $ip');
                            } else {
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
                },
                child: const Text(
                  'Prosseguir',
                  style: TextStyle(
                      fontSize: 18
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
                        'Operador: ' + widget.porteiroName,
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