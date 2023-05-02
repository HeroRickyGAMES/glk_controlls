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
  final String galpaoPrimario;
  modalVeiculoAgendamento(this.nomeUser, this.NomeEmpresa, this.dropValue2, this.dropValue, this.Galpoes, this.galpaoPrimario, {super.key});

  @override
  State<modalVeiculoAgendamento> createState() => _modalVeiculoAgendamentoState();
}
class _modalVeiculoAgendamentoState extends State<modalVeiculoAgendamento> {
  String? coletaouentrega = '';
  String? empresaSelecionada = '';
  String? galpao = '';

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

  late DateTime dataAgendada;
  late DateTime dataAgendadasaida;
  String dataAgendataST = '';
  String dataAgendataSTsaida = '';

  List VeiculoOPC = [
    'Caminhão',
    'Caminhonete',
    'Carro de passeio',
    'Moto',
  ];

  String motivo = '';

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

      //registre todos os valores no db
      var UID = FirebaseAuth.instance.currentUser?.uid;

      var dateTime= DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/');

      var uuid = const Uuid();

      String idd = "${DateTime.now().toString()}" + uuid.v4();
      FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
        'nomeMotorista': nomeMotorista,
        'RGDoMotorista': RGMotorista,
        'Veiculo': Veiculo,
        'idDoc': idd,
        'DataSaida': dataAgendataSTsaida,
        'PlacaVeiculo': VeiculoPlaca! + "(AG)",
        'Telefone': telefone,
        'EmpresadeOrigin': originEmpresa,
        'ColetaOuEntrega': coletaouentrega,
        'LacreouNao': '',
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
        'verificadoPor': 'Estacionário',
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
        'agendamento': true
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

    uploadInfos() async {
      empresaSelecionada = widget.NomeEmpresa;

      if(nomeMotorista == ""){
        Fluttertoast.showToast(
          msg: 'Preencha o nome do motorista!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else{
        if(RGMotorista == ''){
          Fluttertoast.showToast(
            msg: 'Preencha o RG do motorista',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else{
          if(Veiculo == ''){
            Fluttertoast.showToast(
              msg: 'Preencha tipo de veiculo!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }else{
            if(VeiculoPlaca == ''){
              Fluttertoast.showToast(
                msg: 'Preencha a placa do veiculo!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }else{
                if(empresaSelecionada == ''){
                  Fluttertoast.showToast(
                    msg: 'Selecione uma empresa!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }else{
                  if(coletaouentrega == ''){
                    Fluttertoast.showToast(
                      msg: 'Selecione se é coleta ou entrega!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }else{

                    //Ele vai verificar se o usuario está bloqueado ou não.
                    print("chegou aqui");

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
                          msg: 'Selecione uma data para agendamento para entrada!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{
                        if(dataAgendataSTsaida == ''){
                          Fluttertoast.showToast(
                            msg: 'Selecione uma data para agendamento para saida!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{
                          //Fez uma vez agora ele vai verificar se o motorista também está bloqueado!
                          print("chegou aqui");

                          List Visitantes = [];

                          final VisitantesBloqueadosCollection = FirebaseFirestore.instance.collection('VisitantesBloqueados');
                          final snapshot = await VisitantesBloqueadosCollection.get();
                          final documentsvist = snapshot.docs;
                          for (final docvisit in documentsvist) {
                            final id = docvisit.id;
                            final name = docvisit.get('rg');
                            print('$id - $name');

                            Visitantes.add(name);

                          }

                          print('Visitantes bloqueados no RG $Visitantes');
                          print('Listagem de usuários concluída com sucesso!');

                          List VeiculosBLk = [];

                          final VeiculosBloqueadosCollection = FirebaseFirestore.instance.collection('VisitantesBloqueados');
                          final snapshot2 = await VeiculosBloqueadosCollection.get();
                          final VeiculosBLKK = snapshot.docs;
                          for (final docVeiculoBlock in VeiculosBLKK) {
                            final id = docVeiculoBlock.id;
                            final name = docVeiculoBlock.get('nome');
                            print('$id - $name');

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
                              fontSize: 16.0,
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
                                fontSize: 16.0,
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
              Text(
                'Data de agendamento selecionada de entrada: ${dataAgendataST}',
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
                            dataAgendataST = DateFormat('MM-dd-yyyy HH:mm:ss').format(date).replaceAll('-', '/');
                          });

                        }, locale: LocaleType.pt);
                  },
                  child: const Text(
                    'Selecione a data',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16
                    ),
                  )
              ),
              Text(
                'Data de agendamento selecionada de saida: ${dataAgendataSTsaida}',
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
                          dataAgendadasaida = date;
                          print(dataAgendadasaida);
                        }, onConfirm: (date) {
                          print('confirm $date');
                          dataAgendada = date;

                          setState(() {
                            dataAgendataSTsaida = DateFormat('MM-dd-yyyy HH:mm:ss').format(date).replaceAll('-', '/');
                          });

                        }, locale: LocaleType.pt);
                  },
                  child: const Text(
                    'Selecione a data',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16
                    ),
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
                child: TextFormField(
                  onChanged: (valor){
                    motivo = valor;
                    //Mudou mandou para a String
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Motivo',
                    hintStyle: TextStyle(
                        fontSize: 16
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
