import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/modal/modalVeiculoAgendamento.dart';

//Programado por HeroRickyGames

class meusAgendamentosActivity extends StatefulWidget {
  String Empresa;
  String nome;
  meusAgendamentosActivity(this.Empresa, this.nome, {Key? key}) : super(key: key);

  @override
  State<meusAgendamentosActivity> createState() => _meusAgendamentosActivityState();
}

class _meusAgendamentosActivityState extends State<meusAgendamentosActivity> {

  String dataAgendataST = '';
  String dataAgendataSTsaida = '';

  Map map = Map();
  List listaNome = [];
  Map Galpoes = { };

  DateTime dataAgendada = DateTime(2023);
  DateTime dataAgendadasaida = DateTime(2023);

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 1000,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Autorizacoes')
                    .where("agendamento", isEqualTo: true)
                    .where("Empresa", isEqualTo: widget.Empresa)
                    .where("Status", isEqualTo: 'Liberado Entrada')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((documents) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Placa: ${documents['PlacaVeiculo']}',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        TextEditingController nameMotoristaAllcaps = TextEditingController(text: documents['nomeMotorista']);
                                        TextEditingController RGController = TextEditingController(text: documents['RGDoMotorista']);
                                        TextEditingController placaveiculointerface = TextEditingController(text: documents['PlacaVeiculo'].replaceAll('(AG)', ""));
                                        TextEditingController telefoneinterface = TextEditingController(text: documents['Telefone']);
                                        TextEditingController originEmpresaController = TextEditingController(text: documents['EmpresadeOrigin']);
                                        String nomeMotorista = documents['nomeMotorista'];
                                        String RGMotorista = documents['RGDoMotorista'];
                                        String VeiculoPlaca = documents['PlacaVeiculo'].replaceAll('(AG)', "");
                                        String telefone = documents['Telefone'];
                                        String originEmpresa = documents['EmpresadeOrigin'];
                                        dataAgendataST = documents['DataEntrada'];
                                        dataAgendataSTsaida = documents['DataSaida'];

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context, StateSetter setState) {
                                                return SingleChildScrollView(
                                                  child: AlertDialog(
                                                    title: const Text('Editar agendamento'),
                                                    actions: [
                                                      Container(
                                                        padding: const EdgeInsets.all(16),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                padding: const EdgeInsets.all(8),
                                                                child:
                                                                const Text('Devido algumas váriaveis do aplicativo, o padrão de datas ficou como o padrão gringo (MM/DD/AAAA)')
                                                            ),
                                                            Text(dataAgendataST == ''
                                                                ? 'Nenhum data selecionada para Entrada'
                                                                : 'Data selecionada para Entrada: $dataAgendataST'),
                                                            ElevatedButton(
                                                              onPressed: () async {
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
                                                              },
                                                              child: const Text(
                                                                  'Selecionar Data e Horario de Entrada',
                                                                style: TextStyle(
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                            ),
                                                            Text(dataAgendataSTsaida == ''
                                                                ? 'Nenhum data selecionada para Saída'
                                                                : 'Data selecionada para Saída: $dataAgendataSTsaida'),
                                                            ElevatedButton(
                                                              onPressed: () async {
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
                                                              },
                                                              child: const Text(
                                                                  'Selecionar Data e Horario de Saída',
                                                                style: TextStyle(
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                padding: const EdgeInsets.only(top: 16),
                                                                child: const Text(
                                                                    'Nome:'
                                                                )
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
                                                                child: const Text(
                                                                    'RG:'
                                                                )
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.only(top: 16),
                                                              child: TextFormField(
                                                                onChanged: (valor){
                                                                  RGMotorista = valor;
                                                                  nameMotoristaAllcaps.text = nomeMotorista;
                                                                  //Mudou mandou para a String
                                                                },
                                                                controller: RGController,
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
                                                                padding: const EdgeInsets.only(top: 16),
                                                                child: const Text(
                                                                    'Placa: '
                                                                )
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.only(top: 16),
                                                              child: TextFormField(
                                                                controller: placaveiculointerface,
                                                                onChanged: (valor){

                                                                  String valorpuro = valor.toUpperCase();
                                                                  if(valorpuro.length == 7){
                                                                    VeiculoPlaca = '${
                                                                        valorpuro.replaceAllMapped(
                                                                          RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                                                                              (Match m) => '${m[1]} ${m[2]}',
                                                                        )
                                                                    }(AG)';
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
                                                                child: const Text(
                                                                    'Telefone (DDD): '
                                                                )
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

                                                                    telefoneinterface.text = telefone;
                                                                  }
                                                                },
                                                                keyboardType: TextInputType.number,
                                                                enableSuggestions: false,
                                                                autocorrect: false,
                                                                decoration: InputDecoration(
                                                                  border: const OutlineInputBorder(),
                                                                  hintText: 'Telefone (DDD)',
                                                                  hintStyle: TextStyle(
                                                                      fontSize: tamanhotexto
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                padding: const EdgeInsets.only(top: 16),
                                                                child: const Text(
                                                                    'Empresa de Origem: '
                                                                )
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.only(top: 16),
                                                              child: TextFormField(
                                                                onChanged: (valor){
                                                                  originEmpresa = valor;
                                                                  //Mudou mandou para a String
                                                                },
                                                                controller: originEmpresaController,
                                                                decoration: InputDecoration(
                                                                  border: const OutlineInputBorder(),
                                                                  hintText: 'Empresa de Origem',
                                                                  hintStyle: TextStyle(
                                                                      fontSize: tamanhotexto
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets.only(top: 16),
                                                                  child: ElevatedButton(
                                                                    onPressed: (){
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary: Colors.red
                                                                    ),
                                                                    child: const Text(
                                                                        'Cancelar',
                                                                      style: TextStyle(
                                                                          color: Colors.white
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets.only(top: 16),
                                                                  child: ElevatedButton(
                                                                    onPressed: (){

                                                                      if(nomeMotorista == ''){
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
                                                                            msg: 'Preencha o RG do motorista!',
                                                                            toastLength: Toast.LENGTH_SHORT,
                                                                            timeInSecForIosWeb: 1,
                                                                            backgroundColor: Colors.black,
                                                                            textColor: Colors.white,
                                                                            fontSize: tamanhotexto,
                                                                          );
                                                                        }else{
                                                                          if(VeiculoPlaca == ''){
                                                                            Fluttertoast.showToast(
                                                                              msg: 'Preencha a placa do motorista!',
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: Colors.black,
                                                                              textColor: Colors.white,
                                                                              fontSize: tamanhotexto,
                                                                            );
                                                                          }else{

                                                                            if(dataAgendataST == ''){
                                                                              Fluttertoast.showToast(
                                                                                msg: 'Selecione uma data de entrada!',
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.black,
                                                                                textColor: Colors.white,
                                                                                fontSize: tamanhotexto,
                                                                              );
                                                                            }else{
                                                                              if(dataAgendataSTsaida == ''){
                                                                                Fluttertoast.showToast(
                                                                                  msg: 'Selecione uma data de saida!',
                                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                                  timeInSecForIosWeb: 1,
                                                                                  backgroundColor: Colors.black,
                                                                                  textColor: Colors.white,
                                                                                  fontSize: tamanhotexto,
                                                                                );
                                                                              }else{
                                                                                FirebaseFirestore.instance.collection('Autorizacoes').doc(documents['idDoc']).update({
                                                                                  'nomeMotorista': nomeMotorista,
                                                                                  'RGDoMotorista': RGMotorista,
                                                                                  'PlacaVeiculo': VeiculoPlaca,
                                                                                  'Telefone': telefone,
                                                                                  'DataEntrada': dataAgendataST,
                                                                                  'DataSaida': dataAgendataSTsaida
                                                                                }).then((value){
                                                                                  Navigator.of(context).pop();
                                                                                });
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary: Colors.green
                                                                    ),
                                                                    child: const Text(
                                                                        'Prosseguir',
                                                                      style: TextStyle(
                                                                          color: Colors.white
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(Icons.edit)
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: ElevatedButton(
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection('Autorizacoes').doc(documents['id']).delete().then((value){
                                            Fluttertoast.showToast(
                                                msg: 'Deletado!',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.grey[600],
                                                textColor: Colors.white,
                                                fontSize: tamanhotexto
                                            );
                                          });
                                        },
                                        child: const Icon(Icons.delete)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: ElevatedButton(
                        onPressed: () async {


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

                            setState(() {
                              listaNome.add(res.data()['nome']);

                              final dropValue = ValueNotifier('');
                              final dropValue2 = ValueNotifier('');

                              var db = FirebaseFirestore.instance;
                              var UID = FirebaseAuth.instance.currentUser?.uid;
                              db.collection('Users').doc(UID).get().then((event){

                                event.data()?.forEach((key, value) {


                                  if(key == 'nome'){
                                    String PorteiroNomee = value;

                                    var db = FirebaseFirestore.instance;
                                    var UID = FirebaseAuth.instance.currentUser?.uid;
                                    db.collection('Users').doc(UID).get().then((event){

                                      event.data()?.forEach((key, value) async {

                                        if(key == 'nome'){

                                          var resultEmpresa = await FirebaseFirestore.instance
                                              .collection("empresa")
                                              .get();

                                          for (var res in resultEmpresa.docs) {
                                            //print('cheguei aqui');
                                            for (int i = resultEmpresa.docs.length; i >= 1; i--) {
                                              if(i == resultEmpresa.docs.length){
                                                if(res.data()['nome'] == widget.Empresa){

                                                  Galpoes.addAll(res.data()['galpaes']);
                                                  String galpaoPrimario = res.data()['galpaoPrimario'];

                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return modalVeiculoAgendamento(widget.nome, widget.Empresa,dropValue2, dropValue, Galpoes.keys.toList(), galpaoPrimario);
                                                      }));
                                                }
                                              }
                                            }
                                          }
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
                        },
                        child: const Icon(Icons.add)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
