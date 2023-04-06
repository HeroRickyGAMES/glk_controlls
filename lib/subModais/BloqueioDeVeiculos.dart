import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../relatorioGen/generatePDF/gerarPDFBloqueio.dart';

class bloqueioDePlacas extends StatefulWidget {
  @override
  _bloqueioDePlacasState createState() => _bloqueioDePlacasState();
}

class _bloqueioDePlacasState extends State<bloqueioDePlacas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bloqueio de Placas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Image.asset(
              'assets/icon.png',
              width: 300,
              height: 300,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Placa',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Veiculo',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Data',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  '',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('VeiculosBloqueados')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((documents) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                documents['placa'],
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            Text(
                              documents['tipoVeiculo'],
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat('dd-MM-yyyy HH:mm:ss').format(documents['dataDoBloqueio'].toDate()).replaceAll('-', '/'),
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                                TextButton(
                                  onPressed: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          icon:  Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Icon(Icons.zoom_out_sharp),
                                            ],
                                          ),
                                          title: Column(
                                            children: [
                                              Text('Bloqueio'),
                                              Container(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text('Veiculo:'  + documents['tipoVeiculo']),
                                                    Text('Data do Bloqueio:'  + DateFormat('dd-MM-yyyy HH:mm:ss').format(documents['dataDoBloqueio'].toDate()).replaceAll('-', '/'),),
                                                    Container(
                                                        padding: EdgeInsets.all(16),
                                                        child: Text('Motivo: \n'  + documents['Motivo']
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Row(

                                              mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                              children: [
                                                ElevatedButton(onPressed: (){

                                                  Navigator.of(context).pop();

                                                }, child: Text(
                                                    'Voltar',
                                                  style: TextStyle(
                                                      fontSize: 18
                                                  ),
                                                ),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.red
                                                  ),
                                                ),
                                                ElevatedButton(onPressed: (){

                                                  Navigator.of(context).pop();

                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return generatePDF2(documents['placa'], documents['tipoVeiculo'], documents['Motivo'], DateFormat('dd-MM-yyyy HH:mm:ss').format(documents['dataDoBloqueio'].toDate()).replaceAll('-', '/'));
                                                      }));

                                                }, child: Text(
                                                    'Imprimir',
                                                  style: TextStyle(
                                                      fontSize: 18
                                                  ),
                                                ),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.blue
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child:
                                  Icon(Icons.zoom_out_sharp),
                                ),
                                TextButton(
                                  onPressed: (){
                                    FirebaseFirestore.instance.collection('VeiculosBloqueados').doc(documents['id']).delete().then((value){
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
                                  child: Icon(Icons.delete),
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
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: (){

                    String Placa = '';
                    String Veiculost = '';
                    String bloqueioMotivo = '';
                    TextEditingController placaController = TextEditingController();
                    List VeiculoOPC = [
                      'Caminhão',
                      'Caminhonete',
                      'Carro de passeio',
                      'Moto',
                    ];
                    final dropValue = ValueNotifier('');

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            icon:  Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.zoom_out_sharp),
                              ],
                            ),
                            title: Column(
                              children: [
                                Text('Novo Bloqueio'),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: TextFormField(
                                    onChanged: (valor){

                                      String valorpuro = valor.toUpperCase();
                                      Placa = valorpuro.replaceAllMapped(
                                        RegExp(r'^([a-zA-Z]{3})([0-9]{4})$'),
                                            (Match m) => '${m[1]}-${m[2]}',
                                      );

                                      //Mudou mandou para a String
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: placaController,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Placa do veiculo * ',
                                      hintStyle: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                    child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                                      return DropdownButton(
                                        hint: Text(
                                          'Veiculo *',
                                          style: TextStyle(
                                              fontSize: 18
                                          ),
                                        ),
                                        value: (value.isEmpty)? null : value,
                                        onChanged: (escolha) async {
                                          dropValue.value = escolha.toString();

                                          Veiculost = escolha.toString();

                                          placaController.text = Placa;

                                        },
                                        items: VeiculoOPC.map((opcao) => DropdownMenuItem(
                                          value: opcao,
                                          child:
                                          Text(
                                            opcao,
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                        ).toList(),
                                      );
                                    })
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    'Motivo do Bloqueio:'
                                  )
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: TextFormField(
                                    maxLines: null,
                                    onChanged: (valor){

                                      bloqueioMotivo = valor;

                                      //Mudou mandou para a String
                                    },
                                    keyboardType: TextInputType.multiline,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Motivo do Bloqueio * ',
                                      hintStyle: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                children: [
                                  ElevatedButton(onPressed: (){

                                    Navigator.of(context).pop();

                                  }, child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red
                                    ),
                                  ),
                                  ElevatedButton(onPressed: (){

                                    if(Placa == ''){

                                      Fluttertoast.showToast(
                                          msg: 'Preencha a placa!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey[600],
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );

                                    }else{
                                      if(Veiculost == ''){
                                        Fluttertoast.showToast(
                                            msg: 'Selecione o tipo de veiculo!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey[600],
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }else{
                                        if(bloqueioMotivo == ''){
                                          Fluttertoast.showToast(
                                              msg: 'Preencha a Motivo do bloqueio!',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey[600],
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else{

                                          //todo bloqueio db

                                          var dateTime= new DateTime.now();

                                          var uuid = Uuid();

                                          String idd = "${DateTime.now().toString()}" + uuid.v4();

                                          FirebaseFirestore.instance.collection('VeiculosBloqueados').doc(idd).set(
                                            {
                                            'placa': Placa,
                                             'Motivo': bloqueioMotivo,
                                             'tipoVeiculo' : Veiculost,
                                              'id': idd,
                                              'dataDoBloqueio': DateTime.now()
                                            }
                                          );

                                          Navigator.of(context).pop();
                                        }
                                      }
                                    }

                                  }, child: Text(
                                    'Prosseguir',
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  ),
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
                    child: Text(
                        'Bloquear',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Prosseguir',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}