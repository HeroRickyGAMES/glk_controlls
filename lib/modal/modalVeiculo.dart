import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:enhanced_url_launcher/enhanced_url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:glk_controls/mainPorteiro.dart';
import 'package:intl/intl.dart';

//Programado Por HeroRickyGames

class modalPorteiro extends StatefulWidget {
  final List<dynamic> EmpresasOpc;
  final dropValue;
  final String nomeUser;
  final String idEmpresa;
  final dropValue2;
  modalPorteiro(this.EmpresasOpc, this.dropValue, this.nomeUser, this.idEmpresa, this.dropValue2);

  @override
  State<modalPorteiro> createState() => _modalPorteiroState();
}
class _modalPorteiroState extends State<modalPorteiro> {
  String? coletaouentrega;
  String? lacreounao = '';
  String? empresaSelecionada;
  String galpaoPrimario = '';

  //fields
  String? nomeMotorista;
  String? RGMotorista;
  String? Veiculo;
  String? telefone = '';
  String motivo = '';
  String DataEntradaEmpresa = '';
  String? VeiculoPlaca;
  String? originEmpresa = '';
  TextEditingController nameMotoristaAllcaps = TextEditingController();
  TextEditingController placaveiculointerface = TextEditingController();
  TextEditingController telefoneinterface = TextEditingController();
  bool lacrebool = false;
  List VeiculoOPC = [
    'Carreta',
    'Caminhão',
    'Caminhonete',
    'Moto',
    'Carro de Passeio'
  ];

  String Status = '';

  bool veiculoInterno = false;

  Future<void> testPing() async {

    ConnectivityUtils.instance
      ..serverToPing =
          "https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/onlineCheck.txt"
      ..verifyResponseCallback =
          (response) => response.contains("estaOnline");

    if(await ConnectivityUtils.instance.isPhoneConnected()){

      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      bool? offlinemode =  prefs.getBool('OfflineMode');

      if(offlinemode == true){
        Status = 'Estacionário';
      }else{
        Status = 'Aguardando Liberação';
      }
    }else{
      Status = 'Estacionário';
    }
  }

  @override
  void initState() {    // TODO: implement initState com outras verificações de rede
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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

    MandarMT() async {
      Fluttertoast.showToast(
        msg: 'Enviando informações para o servidor...',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: tamanhotexto,
      );

      if(veiculoInterno == true){

        //registre todos os valores no db
        var UID = FirebaseAuth.instance.currentUser?.uid;

        var dateTime= DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/');

        var uuid = const Uuid();

        String idd = "${DateTime.now().toString()}${uuid.v4()}";
        FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
          'nomeMotorista': nomeMotorista,
          'RGDoMotorista': RGMotorista,
          'Veiculo': Veiculo,
          'PlacaVeiculo': VeiculoPlaca,
          'Telefone': telefone,
          'EmpresadeOrigin': originEmpresa,
          'Empresa': empresaSelecionada,
          'ColetaOuEntrega': coletaouentrega,
          'saidaLiberadaPor': '',
          'DataAnaliseEmpresa': '',
          'uriImage': '',
          'uriImage2': '',
          'uriImage3': '',
          'uriImage4': '',
          'LacreouNao': lacreounao,
          'QuemAutorizou': widget.nomeUser,
          'Status': Status,
          'idDoc': idd,
          'DataEntrada': '',
          'DataSaida': '',
          'Lacre': '',
          'lacrenum': '',
          'Horario Criado': dateTime,
          'verificadoPor': '',
          'DataDeAnalise': '',
          'DataEntradaEmpresa': dateTime,
          'DateSaidaPortaria': '',
          'liberouSaida': '',
          'Galpão': '',
          'tag': '',
          'motivo': motivo,
          'interno': veiculoInterno,
          'agendamento': false,
          'lacrenumSaida': '',
          'lacreboolsaida': false,
          'EntradaInt': int.parse(DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/').replaceAll('/', '').replaceAll(":", "").replaceAll(" ", "")),
          'semSaida': false
        }).then((value) {

          Fluttertoast.showToast(
            msg: 'Enviado com sucesso!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );
          widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

          var db = FirebaseFirestore.instance;
          var UID = FirebaseAuth.instance.currentUser?.uid;
          db.collection('Users').doc(UID).get().then((event){

            event.data()?.forEach((key, value) async {


              if(key == 'nome'){
                String PorteiroNome = value;


                var UID = FirebaseAuth.instance.currentUser?.uid;
                var result = await FirebaseFirestore.instance
                    .collection("porteiro")
                    .doc(UID)
                    .get();

                bool cadastro = result.get('cadastrar');
                bool entrada = result.get('entrada');
                bool saida = result.get('saida');
                bool relatorio = result.get('relatorio');
                bool painel = result.get('painel');
                String Email = result.get('email');

                FirebaseFirestore.instance.collection('Motoristas').doc().set({
                  'nomeMotorista': nomeMotorista,
                  'RGDoMotorista': RGMotorista,
                });

                var resulte = await FirebaseFirestore.instance
                    .collection("Condominio")
                    .doc('condominio')
                    .get();

                String logoPath = resulte.get('imageURL');

                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath, Email);
                    }));
              }
            });
          }
          );
        }).catchError((onerror){
        }).whenComplete((){

        });
      }else{

        var dateTime= DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/');

        var uuid = const Uuid();

        String idd = "${DateTime.now().toString()}${uuid.v4()}";
        FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
          'nomeMotorista': nomeMotorista,
          'RGDoMotorista': RGMotorista,
          'Veiculo': Veiculo,
          'PlacaVeiculo': VeiculoPlaca,
          'Telefone': telefone,
          'EmpresadeOrigin': originEmpresa,
          'Empresa': empresaSelecionada,
          'ColetaOuEntrega': coletaouentrega,
          'saidaLiberadaPor': '',
          'DataAnaliseEmpresa': '',
          'uriImage': '',
          'uriImage2': '',
          'uriImage3': '',
          'uriImage4': '',
          'LacreouNao': lacreounao,
          'QuemAutorizou': widget.nomeUser,
          'Status': Status,
          'idDoc': idd,
          'DataEntrada': '',
          'DataSaida': '',
          'Lacre': '',
          'lacrenum': '',
          'Horario Criado': dateTime,
          'verificadoPor': '',
          'DataDeAnalise': '',
          'DataEntradaEmpresa': '',
          'DateSaidaPortaria': '',
          'liberouSaida': '',
          'Galpão': '',
          'motivo': motivo,
          'tag': '',
          'galpaoPrimario': galpaoPrimario,
          'interno': veiculoInterno,
          'agendamento': false,
          'lacrenumSaida': '',
          'lacreboolsaida': false,
          'EntradaInt': int.parse(DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/').replaceAll('/', '').replaceAll(":", "").replaceAll(" ", "")),
          'semSaida': false
        }).then((value) {

          Fluttertoast.showToast(
            msg: 'Enviado com sucesso!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );
          widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

          var db = FirebaseFirestore.instance;
          var UID = FirebaseAuth.instance.currentUser?.uid;
          db.collection('Users').doc(UID).get().then((event){

            event.data()?.forEach((key, value) async {


              if(key == 'nome'){
                String PorteiroNome = value;


                var UID = FirebaseAuth.instance.currentUser?.uid;
                var result = await FirebaseFirestore.instance
                    .collection("porteiro")
                    .doc(UID)
                    .get();

                bool cadastro = result.get('cadastrar');
                bool entrada = result.get('entrada');
                bool saida = result.get('saida');
                bool relatorio = result.get('relatorio');
                bool painel = result.get('painel');
                String Email = result.get('email');

                FirebaseFirestore.instance.collection('Motoristas').doc().set({
                  'nomeMotorista': nomeMotorista,
                  'RGDoMotorista': RGMotorista,
                });

                var resulte = await FirebaseFirestore.instance
                    .collection("Condominio")
                    .doc('condominio')
                    .get();

                String logoPath = resulte.get('imageURL');

                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath, Email);
                    }));
              }
            });
          }
          );
        }).catchError((onerror){
        }).whenComplete((){

        });
      }

      ConnectivityUtils.instance
        ..serverToPing =
            "https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/onlineCheck.txt"
        ..verifyResponseCallback =
            (response) => response.contains("estaOnline");

      if(await ConnectivityUtils.instance.isPhoneConnected()){

      }else{
        widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
        Navigator.of(context).pop();
        Navigator.pop(context);

      }
    }

    restomanda() async {

      if(VeiculoPlaca!.contains(" ")){
        //Ele vai verificar se o usuario está bloqueado ou não.

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
        List Visitantes = [];

        final VisitantesBloqueadosCollection = FirebaseFirestore.instance.collection('VisitantesBloqueados');
        final snapshot = await VisitantesBloqueadosCollection.get();
        final documentsvist = snapshot.docs;
        for (final docvisit in documentsvist) {
          final id = docvisit.id;
          final name = docvisit.get('rg');

          Visitantes.add(name);

        }

        List VeiculosBLk = [];

        final VeiculosBloqueadosCollection = FirebaseFirestore.instance.collection('VisitantesBloqueados');
        final snapshot2 = await VeiculosBloqueadosCollection.get();
        final VeiculosBLKK = snapshot2.docs;
        for (final docVeiculoBlock in VeiculosBLKK) {
          final id = docVeiculoBlock.id;
          final name = docVeiculoBlock.get('nome');

          VeiculosBLk.add(name);

        }

        if(Visitantes.contains(RGMotorista)){
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: 'Este visitante está bloqueado!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );
        }else{
          if(VeiculosBLk.contains(VeiculoPlaca)){
            Navigator.of(context).pop();
            Fluttertoast.showToast(
              msg: 'Este visitante está bloqueado!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: tamanhotexto,
            );
          }else{

            if(veiculoInterno == true){
              Status = 'Estacionário';
            }

            final usersCollection = FirebaseFirestore.instance.collection('empresa');
            final snapshot = await usersCollection.get();
            final documents = snapshot.docs;
            for (final doc in documents) {

              if(doc.get('nome') == empresaSelecionada){
                galpaoPrimario = doc.get('galpaoPrimario');
                Map galpaesEmpresa = doc.get('galpaes');

                String idEmpresa = doc.get('id');


                List veiculosDeEmpresa = [];
                List idEmpresaList = [];

                final veiculosDeEmpresasCollection = FirebaseFirestore.instance.collection('veiculosDeEmpresa');
                final snapshot3 = await veiculosDeEmpresasCollection.get();
                final veiculosDeEmpresas = snapshot3.docs;
                for (final docveiculosDeEmpresas in veiculosDeEmpresas) {
                  final id = docveiculosDeEmpresas.id;
                  final name = docveiculosDeEmpresas.get('Placa');
                  final idList = docveiculosDeEmpresas.get('idEmpresa');

                  veiculosDeEmpresa.add(name);
                  idEmpresaList.add(idList);

                }

                if(veiculosDeEmpresa.contains(VeiculoPlaca)){

                  if(idEmpresaList.contains(idEmpresa)){

                    if(galpaesEmpresa.values.first == 0){
                      Fluttertoast.showToast(
                        msg: 'Não há mais vagas disponiveis!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: tamanhotexto,
                      );
                    }else{
                      ConnectivityUtils.instance
                        ..serverToPing =
                            "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt"
                        ..verifyResponseCallback =
                            (response) => response.contains("This is a test!");

                      //todo subtract
                      galpaesEmpresa[galpaesEmpresa.keys.first] = galpaesEmpresa[galpaesEmpresa.keys.first] - 1;


                      FirebaseFirestore.instance.collection('empresa').doc(idEmpresa).update({
                        'galpaes': galpaesEmpresa
                      });

                      if(await ConnectivityUtils.instance.isPhoneConnected()){
      veiculoInterno == true;
      Status = 'Estacionário';
      MandarMT();


      }else{
      veiculoInterno == true;
      Status = 'Liberado Saida';
      MandarMT();
      }
      }
      }
      }else{
      ConnectivityUtils.instance
      ..serverToPing =
      "https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/onlineCheck.txt"
      ..verifyResponseCallback =
      (response) => response.contains("estaOnline");

      if(await ConnectivityUtils.instance.isPhoneConnected()){

      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      bool? offlinemode =  prefs.getBool('OfflineMode');

          if(offlinemode == true){
          Status = 'Liberado Entrada';
          MandarMT();
          }else{
          MandarMT();
          }
          }else{
          Status = 'Liberado Entrada';
          MandarMT();
          }
          }
          }
          }
          }
          }
          }else{
          Fluttertoast.showToast(
          msg: 'A placa está escrita errada!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: tamanhotexto,
          );
          }
    }

    uploadInfos() async {
      if(nomeMotorista == null){
        Fluttertoast.showToast(
          msg: 'Preencha o nome do motorista!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: tamanhotexto,
        );
      }else{
        if(RGMotorista == null){
          Fluttertoast.showToast(
            msg: 'Preencha o RG do motorista',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );
        }else{
          if(Veiculo == null){
            Fluttertoast.showToast(
              msg: 'Preencha tipo de veiculo!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: tamanhotexto,
            );
          }else{
            if(VeiculoPlaca == null){
              Fluttertoast.showToast(
                msg: 'Preencha a placa do veiculo!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: tamanhotexto,
              );
            }else{
                if(empresaSelecionada == null){
                  Fluttertoast.showToast(
                    msg: 'Selecione uma empresa!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: tamanhotexto,
                  );
                }else{
                  if(coletaouentrega == null){
                    Fluttertoast.showToast(
                      msg: 'Selecione se é coleta ou entrega!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: tamanhotexto,
                    );
                  }else{

                    if(VeiculoPlaca!.length != 8){
                      Fluttertoast.showToast(
                        msg: 'A placa está escrita errada, faltam caracteres!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: tamanhotexto,
                      );
                    }else{

                      if(lacreounao == ""){
                        Fluttertoast.showToast(
                          msg: 'Preencha se está com lacre ou sem',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: tamanhotexto,
                        );
                      }else{

                        if(VeiculoPlaca!.length != 8){
                          Fluttertoast.showToast(
                            msg: 'A placa está escrita errada, faltam caracteres!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: tamanhotexto,
                          );
                        }else{
                          if(telefone!.length != 15){

                            Fluttertoast.showToast(
                              msg: 'O telefone está escrito errado, faltam caracteres!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: tamanhotexto,
                            );

                          }else{
                            List RGMotoristas = [];

                            final RGMotoristasCollection = FirebaseFirestore.instance.collection('Autorizacoes');
                            final snapshot5 = await RGMotoristasCollection.get();
                            final RGMOTORISTADOC = snapshot5.docs;
                            for (final RGMOTORISTADOC in RGMOTORISTADOC) {
                              final id = RGMOTORISTADOC.id;
                              final name = RGMOTORISTADOC.get('RGDoMotorista');
                              final status = RGMOTORISTADOC.get('Status');

                              RGMotoristas.add("RG $name status $status");

                            }

                            if(RGMotoristas.contains("RG ${RGMotorista} status Saída")){
                              restomanda();
                            }else{
                              if(RGMotoristas.contains("RG ${RGMotorista} status Aguardando Liberação") || RGMotoristas.contains("RG ${RGMotorista} status Aguardando Liberação") || RGMotoristas.contains("RG ${RGMotorista} status Liberado Entrada") || RGMotoristas.contains("RG ${RGMotorista} status Liberado Saida")){
                                Fluttertoast.showToast(
                                  msg: 'Esse RG já existe na base de dados!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: tamanhotexto,
                                );
                              }else{
                                restomanda();
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    testPing();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastro Motorista'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/icon.png',
                width: 100,
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: nameMotoristaAllcaps,
                  onChanged: (valor){
                    nomeMotorista = valor.toUpperCase();
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Nome completo do motorista *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    RGMotorista = valor;
                    nameMotoristaAllcaps.text = nomeMotorista!;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'RG do motorista * ',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Veiculo *',
                  style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue2, builder: (context, String value, _){
                    return DropdownButton(
                      hint: Text(
                        'Selecione um veiculo *',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue2.value = escolha.toString();

                        Veiculo = escolha.toString();

                      },
                      items: VeiculoOPC.map((opcao) => DropdownMenuItem(
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
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: placaveiculointerface,
                  onChanged: (valor){

                    String valorpuro = valor.toUpperCase();
                    if(valorpuro.length == 7){
                      VeiculoPlaca = valorpuro.replaceAllMapped(
                        RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                            (Match m) => '${m[1]} ${m[2]}',
                      );
                      placaveiculointerface.text = VeiculoPlaca!;
                    }

                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Placa do Veiculo * ',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: telefoneinterface,
                  onChanged: (valor){

                    String valorpuro = valor.toUpperCase();

                    if(valorpuro.length == 11){

                      telefone = valorpuro.replaceAllMapped(
                          RegExp(r'^([0-9]{2})([0-9]{5})([0-9]{4})$'),
                              (Match m) => '(${m[1]}) ${m[2]}-${m[3]}'
                      );

                      telefoneinterface.text = telefone!;
                    }

                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Telefone',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    originEmpresa = valor;
                    telefoneinterface.text = telefone!;
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Empresa de Origem',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    motivo = valor;
                    //Mudou mandou para a String

                    if(telefone!.length < 15){
                      Fluttertoast.showToast(
                        msg: 'O telefone está escrito errado, faltam caracteres!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: tamanhotexto,
                      );
                    }

                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Observação',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Center(
                child: CheckboxListTile(
                  title: Text(
                      'Veiculo Interno',
                    style: TextStyle(
                        fontSize: tamanhotexto,

                    ),
                  ),
                  value: veiculoInterno,
                  onChanged: (value) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Liberação de veiculo Interno;'),
                          content: const Text('Confirma essa liberação?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red
                                  ),
                                    child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      veiculoInterno = value!;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green
                                  ),
                                  child: const Text('Prosseguir'),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Empresa destino *',
                  style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                    return DropdownButton(
                      hint: Text(
                        'Selecione uma empresa',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue.value = escolha.toString();

                        empresaSelecionada = escolha.toString();

                      },
                      items: widget.EmpresasOpc.map((opcao) => DropdownMenuItem(
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
              Container(
                padding: const EdgeInsets.all(16),
                child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                                "Coleta",
                              style: TextStyle(
                                fontSize: tamanhotexto
                              ),
                            ),
                            value: "coleta",
                            groupValue: coletaouentrega,
                            onChanged: (value){
                              setState(() {
                                coletaouentrega = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                                "Entrega",
                              style: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            ),
                            value: "entrega",
                            groupValue: coletaouentrega,
                            onChanged: (value){
                              setState(() {
                                coletaouentrega = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                                "Com Lacre",
                              style: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            ),
                            value: "lacre",
                            groupValue: lacreounao,
                            onChanged: (value){
                              setState(() {
                                lacreounao = value.toString();

                                if(value == 'lacre'){
                                  lacrebool = true;
                                }

                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              "Sem Lacre",
                              style: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            ),
                            value: "naolacrado",
                            groupValue: lacreounao,
                            onChanged: (value){
                              setState(() {
                                lacreounao = value.toString();
                                if(value == 'naolacrado'){
                                  lacrebool = false;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Uri uri = Uri.parse("https://glkcontrols.com.br/controls/sanca/clgcarmeladutra/entrada/#/");
                    if (!await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                    )) {
                    throw Exception('Could not launch $uri');
                    }
                  },
                  child:
                  const Text(
                    'Abrir Painel de Entrada',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              ElevatedButton(
              onPressed: uploadInfos,
              child:
              const Text(
                  'Prosseguir',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              )
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
                      ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child:
                    Text(
                      'Operador: ${widget.nomeUser}',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ],
              ),
              WillPopScope(
                onWillPop: () async {


                  ConnectivityUtils.instance
                    ..serverToPing =
                        "https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/onlineCheck.txt"
                    ..verifyResponseCallback =
                        (response) => response.contains("estaOnline");

                  if(await ConnectivityUtils.instance.isPhoneConnected()){

                    widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

                    var UID = FirebaseAuth.instance.currentUser?.uid;
                    var result = await FirebaseFirestore.instance
                        .collection("porteiro")
                        .doc(UID)
                        .get();

                    bool cadastro = result.get('cadastrar');
                    bool entrada = result.get('entrada');
                    bool saida = result.get('saida');
                    bool relatorio = result.get('relatorio');
                    bool painel = result.get('painel');
                    String Email = result.get('email');
                    var resulte = await FirebaseFirestore.instance
                        .collection("Condominio")
                        .doc('condominio')
                        .get();

                    String logoPath = resulte.get('imageURL');

                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath, Email);
                        }));
                    // retorna false para impedir que a navegação volte à tela anterior


                  }else{

                    widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
                    Navigator.pop(context);

                  }

                  return false;
                }, child: const Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
