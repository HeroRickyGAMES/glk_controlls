import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/callToAPI.dart';
import 'package:uuid/uuid.dart';

//Programado por HeroRickyGames

class SaidaPrestadorSaida extends StatefulWidget {
  String Operador;
  String URLImage;
  String NomeUser;
  String TipoDeVeiculo;
  String Empresa;
  String Telefone;
  bool vagaComum;
  bool vagaMoto;
  bool VagaDiretoria;
  String Marca;
  String Modelo;
  String Cor;
  String placa;
  String PermitidosVeiculos;
  String ID;
  String IDEmpresa;
  String galpao;
  String RG;
  SaidaPrestadorSaida(this.Operador, this.URLImage, this.NomeUser, this.TipoDeVeiculo, this.Empresa, this.Telefone, this.vagaComum, this.vagaMoto, this.VagaDiretoria, this.Marca, this.Modelo, this.Cor, this.placa, this.PermitidosVeiculos, this.ID, this.IDEmpresa, this.galpao, this.RG, {super.key});

  @override
  State<SaidaPrestadorSaida> createState() => _SaidaPrestadorSaidaState();
}

class _SaidaPrestadorSaidaState extends State<SaidaPrestadorSaida> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    double vagasInterno = 0.0;
    int vagasDeDiretoria = 0;
    int vagasMoto = 0;
    String Entrada = '';

    String vaga = '';
    String EntradaST = '';

    if(widget.vagaComum == true){
      vaga = 'Vaga';
    }
    if(widget.vagaMoto == true){
      vaga = 'Moto';
    }
    if(widget.VagaDiretoria == true){
      vaga = 'Diretoria';
    }

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

    nextStep(){
      FirebaseFirestore.instance.collection('empresa').doc(widget.IDEmpresa).update({
        'vagasInterno': vagasInterno,
        'vagasDeDiretoria': vagasDeDiretoria,
        'vagasMoto': vagasMoto
      }).then((value){
        FirebaseFirestore.instance.collection('VeiculosdePrestadores').doc(widget.ID).update({
          'status': '',
          'lastStatus': 'Liberado Saida'
        }).then((value) async {

          var uuid = const Uuid();

          FirebaseFirestore.instance.collection('relatorioModuloPrestador').doc('${DateTime.now().toString()}${uuid.v4()}').set({
            'Nome': widget.NomeUser,
            'RG': widget.RG,
            'Empresa': widget.Empresa.toUpperCase(),
            'Placa': widget.placa,
            'Veiculo': widget.TipoDeVeiculo,
            'Modelo': widget.Modelo,
            'Cor': widget.Cor,
            'Data': '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            'Horario': '${DateTime.now().hour}:${DateTime.now().minute}',
            'Status': EntradaST,
            'DATACODE': '${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}',
            'HORACODE': '${DateTime.now().hour}${DateTime.now().minute}',
            'galpao': widget.galpao.replaceAll('-', ' '),
            'id': '${DateTime.now().toString()}${uuid.v4()}',
          });

          Fluttertoast.showToast(
            msg: 'Saida Realizada com sucesso! Aguarde os reles se acionarem!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );

          Fluttertoast.showToast(
            msg: 'Ligando reles!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );

          var result = await FirebaseFirestore.instance
              .collection("Reles")
              .doc(Entrada)
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
        });
      });
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Saida - Placa: ${widget.placa}'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Dados de Cadastro',
                    style: TextStyle(
                        fontSize: tamanhotextobtns,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                  width: 250,
                  height: 250,
                  padding: const EdgeInsets.all(16),
                  child: Image.network(widget.URLImage)
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Nome: ${widget.NomeUser}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Veiculo permitido: ${widget.PermitidosVeiculos}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Empresa: ${widget.galpao} ${widget.Empresa}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Telefone: ${widget.Telefone}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Permissão: $vaga",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Veiculo Liberado',
                          style: TextStyle(
                              fontSize: tamanhotextobtns,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Marca: ${widget.Marca}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Modelo: ${widget.Modelo}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Cor: ${widget.Cor}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Placa: ${widget.placa}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Tipo de Veiculo: ${widget.TipoDeVeiculo}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Saída liberada',
                      style: TextStyle(
                          fontSize: tamanhotexto,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white60
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                                fontSize: tamanhotexto,
                                color: Colors.black
                            ),
                          )
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green
                          ),
                          onPressed: () async {
                            bool Entrada01 = false;
                            bool Entrada02 = false;

                            Entrada = '';
                            EntradaST = '';

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                                  return AlertDialog(
                                    title: Text('Escolha a Cancela a ser liberada!'),
                                    actions: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: Entrada01,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    Entrada01 = value ?? false;
                                                    Entrada02 = !value! ?? false;
                                                    Entrada = 'Rele02';
                                                    EntradaST = 'Saida 01';
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Cancela 01 Saida Passeio',
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: Entrada02,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    Entrada02 = value ?? false;
                                                    Entrada01 = !value! ?? false;
                                                    Entrada = 'Rele04';
                                                    EntradaST = 'Saida 02';
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Cancela 02 Saida Caminhões',
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(16),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.red
                                                    ),
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      'Cancelar',
                                                      style: TextStyle(
                                                          fontSize: tamanhotextobtns
                                                      ),
                                                    )
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(16),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.green
                                                    ),
                                                    onPressed: () async {
                                                      if(Entrada == ''){
                                                        Fluttertoast.showToast(
                                                          msg: 'Selecione pelo menos uma entrada!',
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor: Colors.black,
                                                          textColor: Colors.white,
                                                          fontSize: tamanhotexto,
                                                        );
                                                      }else{
                                                        if(_isChecked == false){
                                                          Fluttertoast.showToast(
                                                            msg: 'O botão liberar entrada não está checado!',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor: Colors.black,
                                                            textColor: Colors.white,
                                                            fontSize: tamanhotexto,
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

                                                          final EmpresaCollection = FirebaseFirestore.instance.collection('empresa');
                                                          final snapshot6 = await EmpresaCollection.get();
                                                          final EMPRESADOC = snapshot6.docs;
                                                          for (final NOMEDOC in EMPRESADOC) {

                                                            final Vagasinternos = NOMEDOC.get('vagasInterno') + 0.0;
                                                            final VagasDirecao = NOMEDOC.get('vagasDeDiretoria');
                                                            final VagasMoto = NOMEDOC.get('vagasMoto');

                                                            vagasInterno = Vagasinternos;
                                                            vagasDeDiretoria = VagasDirecao;
                                                            vagasMoto = VagasMoto;
                                                          }

                                                          if(widget.vagaComum == true){

                                                            if(widget.TipoDeVeiculo == 'Carro'){
                                                              vagasInterno = vagasInterno + 1.0;
                                                              print(vagasInterno);
                                                            }else{
                                                              if(widget.TipoDeVeiculo == 'Moto'){
                                                                vagasInterno = vagasInterno + 0.5;
                                                              }
                                                            }

                                                          }
                                                          if(widget.vagaMoto == true){
                                                            vagasDeDiretoria = vagasDeDiretoria + 1;
                                                          }
                                                          if(widget.VagaDiretoria == true){
                                                            vagasMoto = vagasMoto + 1;
                                                          }

                                                          nextStep();
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      'Prosseguir',
                                                      style: TextStyle(
                                                          fontSize: tamanhotextobtns
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                });
                              },
                            );
                          },
                          child: Text(
                            'Prosseguir',
                            style: TextStyle(
                              fontSize: tamanhotexto,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
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
                          'Operador: ${widget.Operador}',
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
        ),
      ),
    );
  }
}
