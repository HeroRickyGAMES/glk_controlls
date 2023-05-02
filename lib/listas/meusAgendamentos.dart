import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class meusAgendamentosActivity extends StatefulWidget {
  String Empresa;
  meusAgendamentosActivity(this.Empresa, {Key? key}) : super(key: key);

  @override
  State<meusAgendamentosActivity> createState() => _meusAgendamentosActivityState();
}

class _meusAgendamentosActivityState extends State<meusAgendamentosActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                            style: const TextStyle(
                                fontSize: 16
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
                                    String dataAgendataST = documents['DataEntrada'];
                                    String dataAgendataSTsaida = documents['DataSaida'];

                                    late DateTime dataAgendada;
                                    late DateTime dataAgendadasaida;

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Editar agendamento'),
                                          actions: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(16),
                                                    child: Text(
                                                      'Data de agendamento selecionada de entrada: ${dataAgendataST}',
                                                      style: const TextStyle(
                                                          fontSize: 16
                                                      ),
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
                                                      decoration: const InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        hintText: 'Nome completo do motorista *',
                                                        hintStyle: TextStyle(
                                                            fontSize: 16
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
                                                      decoration: const InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        hintText: 'RG do motorista * ',
                                                        hintStyle: TextStyle(
                                                            fontSize: 16
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
                                                        VeiculoPlaca = '${valorpuro.replaceAllMapped(
                                                          RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                                                              (Match m) => '${m[1]} ${m[2]}',
                                                        )}(AG)';
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
                                                      child: const Text(
                                                          'Telefone: '
                                                      )
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
                                                                (Match m) => '${m[1]} ${m[2]}-${m[3]} '
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
                                                      child: const Text(
                                                          'Empresa de Origem: '
                                                      )
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 16),
                                                    child: TextFormField(
                                                      onChanged: (valor){
                                                        originEmpresa = valor;
                                                        telefoneinterface.text = telefone;
                                                        //Mudou mandou para a String
                                                      },
                                                      controller: originEmpresaController,
                                                      decoration: const InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        hintText: 'Empresa de Origem',
                                                        hintStyle: TextStyle(
                                                            fontSize: 16
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

                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              primary: Colors.red
                                                          ),
                                                          child: const Text('Cancelar'),
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
                                                                fontSize: 16.0,
                                                              );
                                                            }else{
                                                              if(RGMotorista == ''){
                                                                Fluttertoast.showToast(
                                                                  msg: 'Preencha o RG do motorista!',
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  timeInSecForIosWeb: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0,
                                                                );
                                                              }else{
                                                                if(VeiculoPlaca == ''){
                                                                  Fluttertoast.showToast(
                                                                    msg: 'Preencha a placa do motorista!',
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.black,
                                                                    textColor: Colors.white,
                                                                    fontSize: 16.0,
                                                                  );
                                                                }else{

                                                                  if(dataAgendataST == ''){
                                                                    Fluttertoast.showToast(
                                                                      msg: 'Selecione uma data de entrada!',
                                                                      toastLength: Toast.LENGTH_SHORT,
                                                                      timeInSecForIosWeb: 1,
                                                                      backgroundColor: Colors.black,
                                                                      textColor: Colors.white,
                                                                      fontSize: 16.0,
                                                                    );
                                                                  }else{
                                                                    if(dataAgendataSTsaida == ''){
                                                                      Fluttertoast.showToast(
                                                                        msg: 'Selecione uma data de saida!',
                                                                        toastLength: Toast.LENGTH_SHORT,
                                                                        timeInSecForIosWeb: 1,
                                                                        backgroundColor: Colors.black,
                                                                        textColor: Colors.white,
                                                                        fontSize: 16.0,
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
                                                          child: const Text('Prosseguir'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
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
                                            fontSize: 16.0
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
      ),
    );
  }
}
