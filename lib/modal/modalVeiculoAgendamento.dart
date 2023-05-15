import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//Programado Por HeroRickyGames

class modalVeiculoAgendamento extends StatefulWidget {
  final String nomeUser;
  final String NomeEmpresa;
  final dropValue2;
  final dropValue;
  List Galpoes;
  final String galpaoPrimario;
  modalVeiculoAgendamento(this.nomeUser, this.NomeEmpresa, this.dropValue2, this.dropValue, this.Galpoes, this.galpaoPrimario, {super.key});

  @override
  State<modalVeiculoAgendamento> createState() => _modalVeiculoAgendamentoState();
}
class _modalVeiculoAgendamentoState extends State<modalVeiculoAgendamento> {
  String? coletaouentrega = '';
  String? empresaSelecionada = '';
  String? galpao = '';
  String? lacreounao = '';
  bool lacrebool = false;
  //fields
  String? nomeMotorista = '';
  String? RGMotorista = '';
  String? Veiculo =  '';
  String? telefone = '';
  String? VeiculoPlaca = '';
  String? originEmpresa = '';
  TextEditingController nameMotoristaAllcaps = TextEditingController();
  TextEditingController placaveiculointerface = TextEditingController();
  TextEditingController telefoneinterface = TextEditingController();

  DateTime dataAgendada = DateTime(2023);
  DateTime dataAgendadasaida = DateTime(2023);
  String dataAgendataST = '';
  String dataAgendataSTsaida = '';
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  List VeiculoOPC = [
    'Carreta',
    'Caminhão',
    'Caminhonete',
    'Moto',
    'Carro de Passeio'
  ];

  String motivo = '';
  bool semSaida = false;
  @override
  Widget build(BuildContext context) {

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2025)
      );
      if (picked != null && picked != dataAgendada) {
        setState(() {
          dataAgendada = picked;
        });
      }
      if(dataAgendada == DateTime(2023)){

      }else{
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );
        setState(() {
          selectedTime = pickedTime!;
          dataAgendataST = "${dataAgendada.month}/${dataAgendada.day}/${dataAgendada.year} ${pickedTime.toString().replaceAll("TimeOfDay", "").replaceAll("(", "").replaceAll(")", "")}";
        });
      }
    }
    Future<void> _selectDate2(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2025)
      );
      if (picked != null && picked != dataAgendadasaida) {
        setState(() {
          dataAgendadasaida = picked;
        });
      }
      if(dataAgendada == DateTime(2023)){

      }else{
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );
        setState(() {
          selectedTime2 = pickedTime!;
          dataAgendataSTsaida = "${dataAgendadasaida.month}/${dataAgendadasaida.day}/${dataAgendadasaida.year} ${pickedTime.toString().replaceAll("TimeOfDay", "").replaceAll("(", "").replaceAll(")", "")}";
        });
      }
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
    
    MandarMT(){

      if(dataAgendataSTsaida == ''){
        semSaida = true;
      }else{
        semSaida = false;
      }

      Fluttertoast.showToast(
        msg: 'Enviando informações para o servidor...',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: tamanhotexto,
      );

      //registre todos os valores no db
      var UID = FirebaseAuth.instance.currentUser?.uid;

      var dateTime= DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/');

      var uuid = const Uuid();

      String idd = "${DateTime.now().toString()}${uuid.v4()}";
      FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
        'nomeMotorista': nomeMotorista,
        'RGDoMotorista': RGMotorista,
        'Veiculo': Veiculo,
        'idDoc': idd,
        'DataSaida': dataAgendataSTsaida,
        'PlacaVeiculo': "${VeiculoPlaca!}(AG)",
        'Telefone': telefone,
        'EmpresadeOrigin': originEmpresa,
        'ColetaOuEntrega': coletaouentrega,
        'LacreouNao': lacreounao,
        'QuemAutorizou': widget.nomeUser,
        'Status': 'Liberado Entrada',
        'galpaoPrimario': widget.galpaoPrimario,
        'Horario Criado': dateTime,
        'saidaLiberadaPor': '',
        'uriImage': '',
        'uriImage2': '',
        'uriImage3': '',
        'uriImage4': '',
        'lacrenum': '',
        'verificadoPor': '',
        'Empresa': widget.NomeEmpresa,
        'DataDeAnalise': '',
        'DataEntradaEmpresa': DateFormat('MM-dd-yyyy HH:mm:ss').format(dataAgendada).replaceAll('-', '/'),
        'DataEntrada': DateFormat('MM-dd-yyyy HH:mm:ss').format(dataAgendada).replaceAll('-', '/'),
        'DataAnaliseEmpresa': DateFormat('MM-dd-yyyy HH:mm:ss').format(dataAgendada).replaceAll('-', '/'),
        'DateSaidaPortaria': '',
        'liberouSaida': '',
        'Galpão': galpao,
        'tag': '',
        'motivo': motivo,
        'interno': false,
        'agendamento': true,
        'lacrenumSaida': '',
        'lacreboolsaida': false,
        'EntradaInt': int.parse(DateFormat('MM-dd-yyyy HH:mm:ss').format(dataAgendada).replaceAll('-', '/').replaceAll('/', '').replaceAll(":", "").replaceAll(" ", "")),
        'semSaida': semSaida
      }).then((value) async {
        Fluttertoast.showToast(
          msg: 'Enviado com sucesso!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: tamanhotexto,
        );

        var UID = FirebaseAuth.instance.currentUser?.uid;
        var result = await FirebaseFirestore.instance
            .collection("operadorEmpresarial")
            .doc(UID)
            .get();

        String idEmpresa = (result.get('idEmpresa'));

        var resultEmpresa = await FirebaseFirestore.instance
            .collection("empresa")
            .doc(idEmpresa)
            .get();

        Map galpoes = (resultEmpresa.get('galpaes'));


        galpoes[galpao] = galpoes[galpao] - 1;

        FirebaseFirestore.instance.collection('empresa').doc(idEmpresa).update({
          'galpaes': galpoes
        }).then((value){
          Navigator.pop(context);
        });
      });
    }

    resto() async {

      //Fez uma vez agora ele vai verificar se o motorista também está bloqueado!

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

          var UID = FirebaseAuth.instance.currentUser?.uid;
          var result = await FirebaseFirestore.instance
              .collection("operadorEmpresarial")
              .doc(UID)
              .get();

          String idEmpresa = (result.get('idEmpresa'));

          var resultEmpresa = await FirebaseFirestore.instance
              .collection("empresa")
              .doc(idEmpresa)
              .get();

          Map galpoes = (resultEmpresa.get('galpaes'));


          galpoes[galpao];
          if(galpoes[galpao] == 0){
            Fluttertoast.showToast(
              msg: 'Não existe mais vagas nesse galpão, tente outro galpão!',
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

                MandarMT();
              }
            }
          }
        }
      }
    }

    uploadInfos() async {
      empresaSelecionada = widget.NomeEmpresa;

      if(nomeMotorista == ""){
        Fluttertoast.showToast(
          msg: 'Preencha o nome do motorista!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: tamanhotexto,
        );
      }else{
        if(RGMotorista == ''){
          Fluttertoast.showToast(
            msg: 'Preencha o RG do motorista',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );
        }else{
          if(Veiculo == ''){
            Fluttertoast.showToast(
              msg: 'Preencha tipo de veiculo!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: tamanhotexto,
            );
          }else{
            if(VeiculoPlaca == ''){
              Fluttertoast.showToast(
                msg: 'Preencha a placa do veiculo!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: tamanhotexto,
              );
            }else{
                if(empresaSelecionada == ''){
                  Fluttertoast.showToast(
                    msg: 'Selecione uma empresa!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: tamanhotexto,
                  );
                }else{
                  if(coletaouentrega == ''){
                    Fluttertoast.showToast(
                      msg: 'Selecione se é coleta ou entrega!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: tamanhotexto,
                    );
                  }else{

                    //Ele vai verificar se o usuario está bloqueado ou não.

                    if(galpao == ''){
                      Fluttertoast.showToast(
                        msg: 'Selecione um galpão!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: tamanhotexto,
                      );
                    }else{
                      if(dataAgendataST == ''){
                        Fluttertoast.showToast(
                          msg: 'Selecione uma data para agendamento para entrada!',
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
                          resto();
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
                            resto();
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
        title: const Text('GLK Controls - Cadastro: Motorista e Veiculo'),
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
                padding: EdgeInsets.all(8),
                  child:
                  const Text('Devido algumas váriaveis do aplicativo, o padrão de datas ficou como o padrão gringo (MM/DD/AAAA)')
              ),
              Text(dataAgendataST == ''
                  ? 'Nenhum data selecionada para Entrada'
                  : 'Data selecionada para Entrada: $dataAgendataST'),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Selecionar Data e Horario de Entrada'),
              ),
              Text(dataAgendataSTsaida == ''
                  ? 'Nenhum data selecionada para Saída'
                  : 'Data selecionada para Saída: $dataAgendataSTsaida'),
              ElevatedButton(
                onPressed: () => _selectDate2(context),
                child: const Text('Selecionar Data e Horario de Saída'),
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
                    hintText: 'Nome Completo do Motorista *',
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
                    hintText: 'RG do Motorista (Sem digitos) * ',
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
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Galpão *',
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
                        'Selecione um Galpão *',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue.value = escolha.toString();

                        galpao = escolha.toString();

                      },
                      items: widget.Galpoes.map((opcao) => DropdownMenuItem(
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
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Empresa destino *',
                  style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.NomeEmpresa,
                  style: TextStyle(
                      fontSize: tamanhotexto,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    motivo = valor;
                    //Mudou mandou para a String
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
              Container(
                padding: const EdgeInsets.only(top: 16),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        "Com Lacre divergente",
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
              ElevatedButton(
              onPressed: uploadInfos,
              child:
              Text(
                  'Prosseguir',
                style: TextStyle(
                    fontSize: tamanhotextobtns,
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
                    Column(
                      children: [
                        Text(
                          'Operador: ${widget.nomeUser}',
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context);

                  // retorna false para impedir que a navegação volte à tela anterior
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
