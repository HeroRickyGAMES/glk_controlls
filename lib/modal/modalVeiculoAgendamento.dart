import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

//Programado Por HeroRickyGames

class modalVeiculoAgendamento extends StatefulWidget {
  final String nomeUser;
  final String NomeEmpresa;
  final dropValue2;
  final dropValue;
  List Galpoes;
  modalVeiculoAgendamento(this.nomeUser, this.NomeEmpresa, this.dropValue2, this.dropValue, this.Galpoes, {super.key});

  @override
  State<modalVeiculoAgendamento> createState() => _modalVeiculoAgendamentoState();
}
class _modalVeiculoAgendamentoState extends State<modalVeiculoAgendamento> {
  String? coletaouentrega;
  String? lacreounao;
  String? empresaSelecionada;
  String? galpao;

  //fields
  String? nomeMotorista;
  String? RGMotorista;
  String? Veiculo;
  String? telefone = '';
  String? VeiculoPlaca;
  String? originEmpresa;
  String? lacreSt;
  bool lacrebool = false;
  TextEditingController nameMotoristaAllcaps = TextEditingController();
  TextEditingController placaveiculointerface = TextEditingController();
  TextEditingController telefoneinterface = TextEditingController();

  late DateTime dataAgendada;
  String dataAgendataST = '';

  List VeiculoOPC = [
    'Caminhão',
    'Caminhonete',
    'Carro de passeio',
    'Moto',
  ];

  @override
  Widget build(BuildContext context) {

    MandarMT(){
      Fluttertoast.showToast(
        msg: 'Enviando informações para o servidor...',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print(lacreounao);
      if(lacreounao == 'lacre'){

        //registre todos os valores no db
        var UID = FirebaseAuth.instance.currentUser?.uid;

        var dateTime= new DateTime.now();

        var uuid = const Uuid();

        String idd = "${DateTime.now().toString()}" + uuid.v4();
        FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
          'nomeMotorista': nomeMotorista,
          'RGDoMotorista': RGMotorista,
          'Veiculo': Veiculo,
          'idDoc': idd,
          'DataSaida': '',
          'PlacaVeiculo': VeiculoPlaca! + "(AG)",
          'Telefone': telefone,
          'EmpresadeOrigin': originEmpresa,
          'ColetaOuEntrega': coletaouentrega,
          'LacreouNao': lacreounao,
          'QuemAutorizou': widget.nomeUser,
          'Status': 'Em Verificação',
          'Horario Criado': dateTime,
          'saidaLiberadaPor': '',
          'uriImage': '',
          'uriImage2': '',
          'uriImage3': '',
          'uriImage4': '',
          'lacrenum': '',
          'verificadoPor': 'Agendamento',
          'Empresa': widget.NomeEmpresa,
          'DataDeAnalise': '',
          'DataEntradaEmpresa': dataAgendada,
          'DataEntrada': dataAgendada,
          'DataAnaliseEmpresa': dataAgendada,
          'DateSaidaPortaria': '',
          'liberouSaida': '',
          'Galpão': galpao,
          'Lacre': lacreSt,
          'tag': ''
        }).then((value) async {

          Fluttertoast.showToast(
            msg: 'Enviado com sucesso!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
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
      if(lacreounao == 'naolacrado'){

        //registre todos os valores no db
        var UID = FirebaseAuth.instance.currentUser?.uid;

        var dateTime= new DateTime.now();

        var uuid = const Uuid();

        String idd = "${DateTime.now().toString()}" + uuid.v4();
        FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
          'nomeMotorista': nomeMotorista,
          'RGDoMotorista': RGMotorista,
          'Veiculo': Veiculo,
          'idDoc': idd,
          'DataSaida': '',
          'PlacaVeiculo': VeiculoPlaca! + "(AG)",
          'Telefone': telefone,
          'EmpresadeOrigin': originEmpresa,
          'ColetaOuEntrega': coletaouentrega,
          'LacreouNao': lacreounao,
          'QuemAutorizou': widget.nomeUser,
          'Status': 'Em Verificação',
          'Horario Criado': dateTime,
          'saidaLiberadaPor': '',
          'uriImage': '',
          'uriImage2': '',
          'uriImage3': '',
          'uriImage4': '',
          'lacrenum': '',
          'verificadoPor': 'Agendamento',
          'Empresa': widget.NomeEmpresa,
          'DataDeAnalise': '',
          'DataEntradaEmpresa': dataAgendada,
          'DataEntrada': dataAgendada,
          'DataAnaliseEmpresa': dataAgendada,
          'DateSaidaPortaria': '',
          'liberouSaida': '',
          'Galpão': galpao,
          'tag': ''
        }).then((value) async {
          Fluttertoast.showToast(
            msg: 'Enviado com sucesso!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
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
    }

    uploadInfos() async {
      empresaSelecionada = widget.NomeEmpresa;

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

                                    }else{

                                      if(galpao == ''){
                                        Fluttertoast.showToast(
                                          msg: 'Selecione um galpão!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }else{
                                        if(dataAgendataST == ''){
                                          Fluttertoast.showToast(
                                            msg: 'Selecione uma data para agendamento!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        }else{
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome Completo do Motorista *',
                    hintStyle: TextStyle(
                        fontSize: 16
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'RG do Motorista (Sem digitos) * ',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
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
                      hint: const Text(
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
                child: const Text(
                  'Galpão *',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                    return DropdownButton(
                      hint: const Text(
                        'Selecione um Galpão *',
                        style: TextStyle(
                            fontSize: 16
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
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: placaveiculointerface,
                  onChanged: (valor){

                    String valorpuro = valor.toUpperCase();
                    VeiculoPlaca = valorpuro.replaceAllMapped(
                      RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                          (Match m) => '${m[1]} ${m[2]}',
                    );
                    //Mudou mandou para a String
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Placa do Veiculo * ',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: telefoneinterface,
                  onChanged: (valor){
                    placaveiculointerface.text = VeiculoPlaca!;
                    String valorpuro = valor.toUpperCase();
                    telefone = valorpuro.replaceAllMapped(
                      RegExp(r'^([0-9]{2})([0-9]{5})([0-9]{4})$'),
                          (Match m) => '${m[1]} ${m[2]}-${m[3]} ',
                    );

                    if(VeiculoPlaca!.length != 8){
                      Fluttertoast.showToast(
                        msg: 'A placa está escrita errada, faltam caracteres!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }

                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Telefone',
                    hintStyle: TextStyle(
                        fontSize: 16
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Empresa de Origem',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Empresa destino *',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.NomeEmpresa,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
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
                            title: const Text(
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
                            title: const Text(
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
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Selecione um Galpão galpão (Selecione o que bate com com o nome da empresa)*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                  'Data de agendamento selecionada ${dataAgendataST}',
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
              TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                          dataAgendada = date;
                          print(dataAgendada);
                        }, onConfirm: (date) {
                          print('confirm $date');
                          dataAgendada = date;

                          setState(() {
                            dataAgendataST = DateFormat('dd-MM-yyyy HH:mm:ss').format(date).replaceAll('-', '/');
                          });

                        }, locale: LocaleType.pt);
                  },
                  child: const Text(
                    'Selecione a data',
                    style: TextStyle(
                        color: Colors.blue,
                      fontSize: 16
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child:
                Column(
                  children: [
                    const Text(
                      'Está Entrando com Lacre ou Sem Lacre?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    RadioListTile(
                      title: const Text(
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
                      title: const Text(
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
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                        onChanged: (valor){
                          lacreSt = valor;
                          //Mudou mandou para a String
                        },
                        //keyboardType: TextInputType.number,
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
                  ],
                ),
              ),
              ElevatedButton(
              onPressed: uploadInfos,
              child:
              const Text(
                  'Prosseguir',
                style: TextStyle(
                    fontSize: 16,
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
                      'Operador: ' + widget.nomeUser,
                      style: const TextStyle(
                          fontSize: 16
                      ),
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
