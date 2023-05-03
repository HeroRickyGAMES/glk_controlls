import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/Painel.dart';
import 'package:glk_controls/btnsVerificarEntrada.dart';
import 'package:glk_controls/btnsVerificarSaida.dart';
import 'package:glk_controls/callToAPI.dart';
import 'package:glk_controls/offlineService/mainPorteiroOffline.dart';
import 'package:glk_controls/relatorio.dart';
import 'package:glk_controls/modal/modalVeiculo.dart';
import 'package:glk_controls/anteLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

//Programado por HeroRickyGames

Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
String idDocumento = '';
List listaNome = [];
String pass = '';

class mainPorteiro extends StatefulWidget {
  final String LogoPath;
  bool cadastro;
  bool entrada;
  bool saida;
  bool relatorio;
  bool painel;
  String Email;

  final String PorteiroNome;
  mainPorteiro(this.PorteiroNome, this.cadastro, this.entrada, this.saida, this.relatorio, this.painel, this.LogoPath, this.Email, {super.key});

  @override
  State<mainPorteiro> createState() => _mainPorteiroState();
}

class _mainPorteiroState extends State<mainPorteiro> {

  Future<void> testPing() async {

    ConnectivityUtils.instance
      ..serverToPing =
          "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt"
      ..verifyResponseCallback =
          (response) => response.contains("This is a test!");

    if(await ConnectivityUtils.instance.isPhoneConnected()){


      print('Conectado!');

    }else{
      Fluttertoast.showToast(
        msg: 'Conectei ao servidor offline do app!',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
      Fluttertoast.showToast(
        msg: 'Você está offline, então algumas ações no app irão demorar mais do que o normal,',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
      Fluttertoast.showToast(
        msg: 'Mas assim que a rede for reestabelecida, reinicie o app para usar o servidor online do app!',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );

      print('Desconectado!');
    }
  }

  @override
  void initState() {

    testPing();

    // TODO: implement initState com outras verificações de conexão
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    openModal() async {
  //todo novo cadastro

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
          .collection("empresa")
          .get();
      for (var res in result.docs) {
        print(res.data()['nome']);

        setState(() {
          listaNome.add(res.data()['nome']);

          final dropValue = ValueNotifier('');
          final dropValue2 = ValueNotifier('');

          var db = FirebaseFirestore.instance;
          var UID = FirebaseAuth.instance.currentUser?.uid;
          db.collection('Users').doc(UID).get().then((event){
            print("${event.data()}");

            event.data()?.forEach((key, value) {

              print(key);
              print(value);

              if(key == 'nome'){
                String PorteiroNomee = value;

                var db = FirebaseFirestore.instance;
                var UID = FirebaseAuth.instance.currentUser?.uid;
                db.collection('Users').doc(UID).get().then((event){
                  print("${event.data()}");

                  event.data()?.forEach((key, value) {

                    print(key);
                    print(value);

                    if(key == 'nome'){

                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return modalPorteiro(listaNome, dropValue, PorteiroNomee, '',dropValue2);
                          }));
                    }
                  });
                }
                );
              }
            });
          }
          );
        });
      }
      print(listaNome);
    }

    openModalOffline() async {
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return const mainPorteiroOff();
          }));
    }

    entradaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return btnsVerificarEntrada(widget.PorteiroNome);
          }));
    }

    saidaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return btnsVerificarSaida(widget.PorteiroNome);
          }));
    }

    relatorioMT() async {

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
            return relatorio(widget.PorteiroNome, logoPath);
          }));
    }

    painelMT() async {

      var result = await FirebaseFirestore.instance
          .collection("Condominio")
          .doc('condominio')
          .get();

      String logoPath = result.get('imageURL');

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return painelADM(widget.PorteiroNome, logoPath);

          }));

    }

    double tamanhotexto = 20;
    double tamanhotextobtns = 16;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextobtns = 34;
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;

      }
    }
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Colors.red[900],
        title: Container(
          child:
          const Text(
              'GLK Controls - OPERADORES'
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      'assets/icon.png',
                      fit: BoxFit.contain,
                    )
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.cadastro? openModal: null,
                      child: Text(
                          'Novo cadastro',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.entrada? entradaMT : null,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green[700]
                    ),
                    child: Text(
                      'Verificar Entrada',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.saida ? saidaMT : null,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.yellow[800]
                    ),
                    child: Text(
                      'Verificar Saída',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.relatorio ? relatorioMT : null,
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.yellow[800]
                    ),
                    child: Text(
                      'Relatorio',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ),
                widget.painel ?
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: painelMT,
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.yellow[800]
                    ),
                    child: Text(
                      'Painel',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ) : const Text(''),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Deseja colocar-se no modo offline?"),
                            actions: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(onPressed: (){

                                    Navigator.of(context).pop();

                                  }, child: const Text('Cancelar'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red[800]
                                    ),
                                  ),
                                  ElevatedButton(onPressed: () async {

                                    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                                    final SharedPreferences prefs = await _prefs;

                                    bool? offlinemode =  prefs.getBool('OfflineMode');

                                    if(offlinemode == true){
                                      await prefs.setBool('OfflineMode', false);
                                    }else{
                                      await prefs.setBool('OfflineMode', true);
                                    }

                                    Fluttertoast.showToast(
                                      msg: 'Reinicie o app para que as auterações entrem em vigor!',
                                      toastLength: Toast.LENGTH_LONG,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: tamanhotexto,
                                    );
                                    Navigator.of(context).pop();
                                  }, child: const Text('Prosseguir'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green[800]
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[800]
                    ),
                    child: Text(
                      'Ativar/Desativar modo Offline',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () async {

                      String Entrada = "";
                      final dropValue = ValueNotifier('');
                      List ListEntrada =  ["Entrada 01", 'Entrada 02', 'Saida 01', 'Saida 02'];
                      String Senha = '';

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                           return AlertDialog(
                              title: const Text("Liberação Manual.\nSelecione a Entrada/Saida"),
                              actions: [
                                Container(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: TextFormField(
                                    onChanged: (valor){
                                      Senha = valor;
                                      //Mudou mandou para a String
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: 'Senha',

                                      hintStyle: TextStyle(
                                          fontSize: tamanhotexto
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                    child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                                      return DropdownButton(
                                        hint: Text(
                                          'Selecione uma entrada *',
                                          style: TextStyle(
                                              fontSize: tamanhotexto
                                          ),
                                        ),
                                        value: (value.isEmpty)? null : value,
                                        onChanged: (escolha) async {
                                          dropValue.value = escolha.toString();

                                          setState(() {
                                            if(escolha.toString() == "Entrada 01"){
                                              Entrada = 'Rele01';
                                            }

                                            if(escolha.toString() == "Entrada 02"){
                                              Entrada = 'Rele03';
                                            }

                                            if(escolha.toString() == "Saida 01"){
                                              Entrada = 'Rele02';
                                            }

                                            if(escolha.toString() == "Saida 02"){
                                              Entrada = 'Rele04';
                                            }

                                          });
                                        },
                                        items: ListEntrada.map((opcao) => DropdownMenuItem(
                                          value: opcao,
                                          child:
                                          Text(
                                            opcao,
                                            style: TextStyle(
                                                fontSize: tamanhotexto
                                            ),
                                          ),
                                        ),
                                        ).toList(),
                                      );
                                    })
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red[800]
                                      ),
                                      child: const Text("Cancelar"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {

                                        if(Senha == ""){
                                          Fluttertoast.showToast(
                                            msg: 'Preencha a senha!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: tamanhotexto,
                                          );
                                        }else{
                                          if(Senha == "glk@12345678\$"){

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
                                            Navigator.of(context).pop();

                                          }else{
                                            Fluttertoast.showToast(
                                              msg: 'Senha invalida',
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: tamanhotexto,
                                            );
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green[800]
                                      ),
                                      child: const Text("Prosseguir"),
                                    ),
                                  ],
                                ),
                              ],
                            );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[800]
                    ),
                    child: Text(
                      'Liberação de pânico',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () async {

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Deseja trocar a senha?'),
                                        actions: [
                                          Center(
                                            child: Text(
                                              'Enviaremos um email para esse email de conta logado.\nEmail: ${widget.Email}',
                                              style: TextStyle(
                                                  fontSize: tamanhotextobtns
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                                  child: Text(
                                                    'Cancelar',
                                                    style: TextStyle(
                                                        fontSize: tamanhotextobtns
                                                    ),
                                                  )
                                              ),
                                              TextButton(onPressed: () async {
                                                Navigator.of(context).pop();

                                                try {
                                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.Email).then((value){
                                                    Fluttertoast.showToast(
                                                      msg: 'Enviado, verifique o email para resetar a senha!',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.black,
                                                      textColor: Colors.white,
                                                      fontSize: tamanhotexto,
                                                    );
                                                    print('enviado!');
                                                  });
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                    msg: 'Ocorreu um erro $e!',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: tamanhotexto,
                                                  );
                                                  print('Erro! $e');
                                                }

                                              },
                                                  child: Text(
                                                    'Resetar Senha',
                                                    style: TextStyle(
                                                        fontSize: tamanhotextobtns
                                                    ),
                                                  )
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );

                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey
                                ),
                                child: const Text(
                                  'Trocar Senha',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut().then((value) async {

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
                                    print('Usuário desconectado');
                                  });

                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red
                                ),
                                child: const Text(
                                  'Logoff',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 180,
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        child:
                        Image.network(
                          widget.LogoPath,
                          fit: BoxFit.contain,
                        ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child:
                      Text(
                        'Operador: ${widget.PorteiroNome}',
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