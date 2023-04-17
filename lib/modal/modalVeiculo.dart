import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:glk_controls/mainPorteiro.dart';
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
  String? lacreounao;
  String? empresaSelecionada;

  //fields
  String? nomeMotorista;
  String? RGMotorista;
  String? Veiculo;
  String? telefone = '';
  String DataEntradaEmpresa = '';
  String? VeiculoPlaca;
  String? originEmpresa;
  String? lacreSt;
  bool lacrebool = false;
  TextEditingController nameMotoristaAllcaps = TextEditingController();
  TextEditingController placaveiculointerface = TextEditingController();
  TextEditingController telefoneinterface = TextEditingController();

  List VeiculoOPC = [
    'Caminhão',
    'Caminhonete',
    'Carro de passeio',
    'Moto',
  ];
  String Status = '';

  bool veiculoInterno = false;

  Future<void> testPing() async {
    final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

    try {
      final result = await Process.run('ping', ['-c', '1', ip]);
      if (result.exitCode == 0) {
        print('Ping realizado com sucesso para o endereço $ip');
        Status = 'Aguardando';
      } else {
        print('Falha no ping para o endereço $ip');
        Status = 'Em Verificação';
      }
    } catch (e) {
      print('Erro ao executar o comando de ping: $e');
    }
  }

  @override
  void initState() {
    testPing();
    // TODO: implement initState com outras verificações de rede
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MandarMT() async {
      Fluttertoast.showToast(
        msg: 'Enviando informações para o servidor...',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print(lacreounao);
      if(veiculoInterno == true){
        if(lacreounao == 'lacre'){

          //registre todos os valores no db
          var UID = FirebaseAuth.instance.currentUser?.uid;

          var dateTime= new DateTime.now();

          var uuid = Uuid();

          String idd = "${DateTime.now().toString()}" + uuid.v4();
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
            'Lacre': lacreSt,
            'lacrenum': lacreSt,
            'Horario Criado': dateTime,
            'verificadoPor': '',
            'DataDeAnalise': '',
            'DataEntradaEmpresa': DateTime.now(),
            'DateSaidaPortaria': '',
            'liberouSaida': '',
            'Galpão': '',
            'tag': '',
            'interno': veiculoInterno
          }).then((value) {

            Fluttertoast.showToast(
              msg: 'Enviado com sucesso!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

            var db = FirebaseFirestore.instance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) async {

                print(key);
                print(value);

                if(key == 'nome'){
                  String PorteiroNome = value;

                  print('Porteiro name é' + PorteiroNome);

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
                        return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath);
                      }));
                }
              });
            }
            );
          }).catchError((onerror){
            print('error $onerror');
          }).whenComplete((){
            print('Feito com sucesso!');

          });
        }
        if(lacreounao == 'naolacrado'){

          //registre todos os valores no db
          var UID = FirebaseAuth.instance.currentUser?.uid;

          var dateTime= new DateTime.now();

          var uuid = Uuid();

          String idd = "${DateTime.now().toString()}" + uuid.v4();
          FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
            'nomeMotorista': nomeMotorista,
            'RGDoMotorista': RGMotorista,
            'Veiculo': Veiculo,
            'idDoc': idd,
            'DataEntrada': '',
            'DataSaida': '',
            'PlacaVeiculo': VeiculoPlaca,
            'Telefone': telefone,
            'EmpresadeOrigin': originEmpresa,
            'Empresa': empresaSelecionada,
            'ColetaOuEntrega': coletaouentrega,
            'LacreouNao': lacreounao,
            'QuemAutorizou': widget.nomeUser,
            'Status': Status,
            'Horario Criado': dateTime,
            'saidaLiberadaPor': '',
            'DataAnaliseEmpresa': '',
            'uriImage': '',
            'uriImage2': '',
            'uriImage3': '',
            'uriImage4': '',
            'lacrenum': '',
            'verificadoPor': '',
            'DataDeAnalise': '',
            'DataEntradaEmpresa': DateTime.now(),
            'DateSaidaPortaria': '',
            'liberouSaida': '',
            'Galpão': '',
            'tag': '',
            'interno': veiculoInterno
          }).then((value) {
            Fluttertoast.showToast(
              msg: 'Enviado com sucesso!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

            var db = FirebaseFirestore.instance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) async {

                print(key);
                print(value);

                if(key == 'nome'){
                  String PorteiroNome = value;

                  print('Porteiro name é' + PorteiroNome);

                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  var result = await FirebaseFirestore.instance
                      .collection("porteiro")
                      .doc(UID)
                      .get();

                  print('cheguei aqui!');

                  bool cadastro = result.get('cadastrar');
                  bool entrada = result.get('entrada');
                  bool saida = result.get('saida');
                  bool relatorio = result.get('relatorio');
                  bool painel = result.get('painel');

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
                        return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath);
                      }));
                }
              });
            }
            );
          }).catchError((onerror){
            print('error $onerror');
          }).whenComplete((){
            print('Feito com sucesso!');
          });
        }

      }else{
        if(lacreounao == 'lacre'){

          //registre todos os valores no db
          var UID = FirebaseAuth.instance.currentUser?.uid;

          var dateTime= new DateTime.now();

          var uuid = Uuid();

          String idd = "${DateTime.now().toString()}" + uuid.v4();
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
            'Lacre': lacreSt,
            'lacrenum': lacreSt,
            'Horario Criado': dateTime,
            'verificadoPor': '',
            'DataDeAnalise': '',
            'DataEntradaEmpresa': '',
            'DateSaidaPortaria': '',
            'liberouSaida': '',
            'Galpão': '',
            'tag': '',
            'interno': veiculoInterno
          }).then((value) {

            Fluttertoast.showToast(
              msg: 'Enviado com sucesso!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

            var db = FirebaseFirestore.instance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) async {

                print(key);
                print(value);

                if(key == 'nome'){
                  String PorteiroNome = value;

                  print('Porteiro name é' + PorteiroNome);

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
                        return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath);
                      }));
                }
              });
            }
            );
          }).catchError((onerror){
            print('error $onerror');
          }).whenComplete((){
            print('Feito com sucesso!');

          });
        }
        if(lacreounao == 'naolacrado'){

          //registre todos os valores no db
          var UID = FirebaseAuth.instance.currentUser?.uid;

          var dateTime= new DateTime.now();

          var uuid = Uuid();

          String idd = "${DateTime.now().toString()}" + uuid.v4();
          FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
            'nomeMotorista': nomeMotorista,
            'RGDoMotorista': RGMotorista,
            'Veiculo': Veiculo,
            'idDoc': idd,
            'DataEntrada': '',
            'DataSaida': '',
            'PlacaVeiculo': VeiculoPlaca,
            'Telefone': telefone,
            'EmpresadeOrigin': originEmpresa,
            'Empresa': empresaSelecionada,
            'ColetaOuEntrega': coletaouentrega,
            'LacreouNao': lacreounao,
            'QuemAutorizou': widget.nomeUser,
            'Status': Status,
            'Horario Criado': dateTime,
            'saidaLiberadaPor': '',
            'DataAnaliseEmpresa': '',
            'uriImage': '',
            'uriImage2': '',
            'uriImage3': '',
            'uriImage4': '',
            'lacrenum': '',
            'verificadoPor': '',
            'DataDeAnalise': '',
            'DataEntradaEmpresa': '',
            'DateSaidaPortaria': '',
            'liberouSaida': '',
            'Galpão': '',
            'tag': '',
            'interno': veiculoInterno
          }).then((value) {
            Fluttertoast.showToast(
              msg: 'Enviado com sucesso!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

            var db = FirebaseFirestore.instance;
            var UID = FirebaseAuth.instance.currentUser?.uid;
            db.collection('Users').doc(UID).get().then((event){
              print("${event.data()}");

              event.data()?.forEach((key, value) async {

                print(key);
                print(value);

                if(key == 'nome'){
                  String PorteiroNome = value;

                  print('Porteiro name é' + PorteiroNome);

                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  var result = await FirebaseFirestore.instance
                      .collection("porteiro")
                      .doc(UID)
                      .get();

                  print('cheguei aqui!');

                  bool cadastro = result.get('cadastrar');
                  bool entrada = result.get('entrada');
                  bool saida = result.get('saida');
                  bool relatorio = result.get('relatorio');
                  bool painel = result.get('painel');

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
                        return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath);
                      }));
                }
              });
            }
            );
          }).catchError((onerror){
            print('error $onerror');
          }).whenComplete((){
            print('Feito com sucesso!');
          });
        }

      }

      final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

      try {
        final result = await Process.run('ping', ['-c', '1', ip]);
        if (result.exitCode == 0) {
          print('Ping realizado com sucesso para o endereço $ip');
        } else {
          widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
          Navigator.of(context).pop();
          Navigator.pop(context);
          print('Falha no ping para o endereço $ip');
        }
      } catch (e) {
        print('Erro ao executar o comando de ping: $e');
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
          fontSize: 16.0,
        );
      }else{
        if(RGMotorista == null){
          Fluttertoast.showToast(
            msg: 'Preencha o RG do motorista',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else{
          if(Veiculo == null){
            Fluttertoast.showToast(
              msg: 'Preencha tipo de veiculo!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }else{
            if(VeiculoPlaca == null){
              Fluttertoast.showToast(
                msg: 'Preencha a placa do veiculo!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }else{
                if(empresaSelecionada == null){
                  Fluttertoast.showToast(
                    msg: 'Selecione uma empresa!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }else{
                  if(coletaouentrega == null){
                    Fluttertoast.showToast(
                      msg: 'Selecione se é coleta ou entrega!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }else{
                    if(lacreounao == null){
                      Fluttertoast.showToast(
                        msg: 'Selecione se é com lacre ou sem!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      //Ele vai verificar se o usuario está bloqueado ou não.
                      print("chegou aqui");

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

                      var result = await FirebaseFirestore.instance
                          .collection("VeiculosBloqueados")
                          .get();

                      for (var res in result.docs) {

                        for (int i = result.docs.length; i >= 1; i--) {

                          if(i == result.docs.length){

                            print(res.data()['placa']);

                            if(res.data()['placa'] == VeiculoPlaca){

                              Fluttertoast.showToast(
                                msg: 'Este veiculo está bloqueado!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              //Fez uma vez agora ele vai verificar se o motorista também está bloqueado!
                              print("chegou aqui");


                              var result = await FirebaseFirestore.instance
                                  .collection("VisitantesBloqueados")
                                  .get();

                              for (var res in result.docs) {

                                for (int i = result.docs.length; i >= 1; i--) {

                                  if(i == result.docs.length){

                                    print(res.data()['rg']);

                                    if(res.data()['rg'] == RGMotorista){
                                      Navigator.of(context).pop();
                                      Fluttertoast.showToast(
                                        msg: 'Este visitante está bloqueado!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  }
                                }
                              }

                            }else{
                              //Fez uma vez agora ele vai verificar se o motorista também está bloqueado!
                              print("chegou aqui");

                              var result = await FirebaseFirestore.instance
                                  .collection("VisitantesBloqueados")
                                  .get();

                              for (var res in result.docs) {

                                for (int i = result.docs.length; i >= 1; i--) {

                                  if(i == result.docs.length){

                                    print(res.data()['rg']);

                                    if(res.data()['rg'] == RGMotorista){

                                      Fluttertoast.showToast(
                                        msg: 'Este visitante está bloqueado!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      Navigator.of(context).pop();

                                    }else{

                                      if(veiculoInterno == true){
                                        Status = 'Em Verificação';
                                      }

                                      MandarMT();

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
          }
        }
      }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GLK Controls - Cadastro: Motorista e Veiculo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/icon.png',
                width: 100,
                height: 100,
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
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
                    border: OutlineInputBorder(),
                    hintText: 'Nome Completo do Motorista *',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
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
                    border: OutlineInputBorder(),
                    hintText: 'RG do Motorista (Sem digitos) * ',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Veiculo *',
                  style: TextStyle(
                      fontSize: 16,
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
                            fontSize: 16
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
                              fontSize: 16
                          ),
                        ),
                      ),
                      ).toList(),
                    );
                  })
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: placaveiculointerface,
                  onChanged: (valor){

                    String valorpuro = valor.toUpperCase();
                    VeiculoPlaca = valorpuro.replaceAllMapped(
                      RegExp(r'^([a-zA-Z]{3})([0-9]{4})$'),
                          (Match m) => '${m[1]}-${m[2]}',
                    );
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Placa do Veiculo * ',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: telefoneinterface,
                  onChanged: (valor){
                    placaveiculointerface.text = VeiculoPlaca!;
                    String valorpuro = valor.toUpperCase();
                    telefone = valorpuro.replaceAllMapped(
                      RegExp(r'^([0-9]{2})([0-9]{5})([0-9]{4})$'),
                          (Match m) => '${m[1]} ${m[2]}-${m[3]} ',
                    );
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Telefone',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    originEmpresa = valor;
                    telefoneinterface.text = telefone!;
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Empresa de Origem',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Center(
                child: CheckboxListTile(
                  title: Text(
                      'Veiculo Interno',
                    style: TextStyle(
                        fontSize: 16,

                    ),
                  ),
                  value: veiculoInterno,
                  onChanged: (value) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Liberação de veiculo Interno;'),
                          content: Text('Confirma essa liberação?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      veiculoInterno = value!;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text('Prosseguir'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green
                                  ),
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
                padding: EdgeInsets.all(16),
                child: Text(
                  'Empresa destino *',
                  style: TextStyle(
                      fontSize: 16,
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
                            fontSize: 16
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
                              fontSize: 16
                          ),
                        ),
                      ),
                      ).toList(),
                    );
                  })
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
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
                                fontSize: 16
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
                                  fontSize: 16
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
                padding: EdgeInsets.only(top: 16),
                child:
                Column(
                  children: [
                    Text(
                      'Está Entrando com Lacre ou Sem Lacre?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    RadioListTile(
                      title: Text(
                          "Com Lacre",
                        style: TextStyle(
                            fontSize: 16
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
                    RadioListTile(
                      title: Text(
                        "Sem Lacre",
                        style: TextStyle(
                            fontSize: 16
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
                    lacrebool ?
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        onChanged: (valor){
                          lacreSt = valor;
                          //Mudou mandou para a String
                        },
                        //keyboardType: TextInputType.number,
                        //enableSuggestions: false,
                        //autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Numero do lacre *',
                          hintStyle: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ),
                    )
                        :Text(''),
                  ],
                ),
              ),
              ElevatedButton(
              onPressed: uploadInfos,
              child:
              Text(
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
                      padding: EdgeInsets.all(16),
                      child:
                      Image.asset(
                        'assets/sanca.png',
                        fit: BoxFit.contain,
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child:
                    Text(
                      'Operador: ' + widget.nomeUser,
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
              WillPopScope(
                onWillPop: () async {

                  final String ip = 'google.com'; // substitua pelo endereço IP que deseja testar

                  try {
                    final result = await Process.run('ping', ['-c', '1', ip]);
                    if (result.exitCode == 0) {
                      print('Ping realizado com sucesso para o endereço $ip');

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

                      var resulte = await FirebaseFirestore.instance
                          .collection("Condominio")
                          .doc('condominio')
                          .get();

                      String logoPath = resulte.get('imageURL');

                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return mainPorteiro(widget.nomeUser, cadastro, entrada, saida, relatorio, painel, logoPath);
                          }));
                      // retorna false para impedir que a navegação volte à tela anterior

                    } else {
                      print('Falha no ping para o endereço $ip');
                      widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print('Erro ao executar o comando de ping: $e');

                  }
                  return false;
                }, child: Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
