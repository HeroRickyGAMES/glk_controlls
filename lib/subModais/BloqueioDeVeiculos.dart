import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:glk_controls/relatorioGen/generatePDF/gerarPDFBloqueio.dart';
class bloqueioDePlacas extends StatefulWidget {
  String ADMName;
  String LogoPath;
  @override
  bloqueioDePlacas(this.ADMName, this.LogoPath);


  _bloqueioDePlacasState createState() => _bloqueioDePlacasState();
}

class _bloqueioDePlacasState extends State<bloqueioDePlacas> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text('Bloqueio de Placas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
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
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        'Placa',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        'Veiculo',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        'Data',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '',
                      style: TextStyle(
                          fontSize: tamanhotexto
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
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('VeiculosBloqueados')
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
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    documents['placa'],
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                                Text(
                                  documents['tipoVeiculo'],
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      documents['dataDoBloqueio'].replaceAll('-', '/'),
                                      style: TextStyle(
                                          fontSize: tamanhotexto
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
                                                  const Icon(Icons.zoom_out_sharp),
                                                ],
                                              ),
                                              title: Column(
                                                children: [
                                                  const Text('Bloqueio'),
                                                  Container(
                                                    padding: const EdgeInsets.all(16),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text('Veiculo:'  + documents['tipoVeiculo']),
                                                        Text('Data do Bloqueio:'  + documents['dataDoBloqueio'],),
                                                        Container(
                                                            padding: const EdgeInsets.all(16),
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

                                                    },
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.red
                                                      ), child: Text(
                                                        'Voltar',
                                                      style: TextStyle(
                                                          fontSize: tamanhotexto
                                                      ),
                                                    ),
                                                    ),
                                                    ElevatedButton(onPressed: (){

                                                      Navigator.of(context).pop();

                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context){
                                                            return generatePDF2(documents['placa'], documents['tipoVeiculo'], documents['Motivo'], documents['dataDoBloqueio']);
                                                          }));

                                                    },
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.blue
                                                      ), child: Text(
                                                        'Imprimir',
                                                      style: TextStyle(
                                                          fontSize: tamanhotexto
                                                      ),
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
                                      const Icon(Icons.zoom_out_sharp),
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
                                              fontSize: tamanhotexto
                                          );
                                        });
                                      },
                                      child: const Icon(Icons.delete),
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
                                    const Icon(Icons.zoom_out_sharp),
                                  ],
                                ),
                                title: Column(
                                  children: [
                                    const Text('Novo Bloqueio'),
                                    Container(
                                      padding: const EdgeInsets.all(16),
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
                                          border: const OutlineInputBorder(),
                                          hintText: 'Placa do veiculo * ',
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
                                              'Veiculo *',
                                              style: TextStyle(
                                                  fontSize: tamanhotexto
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
                                      child: const Text(
                                        'Motivo do Bloqueio:'
                                      )
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(16),
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
                                          border: const OutlineInputBorder(),
                                          hintText: 'Motivo do Bloqueio * ',
                                          hintStyle: TextStyle(
                                              fontSize: tamanhotexto
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

                                      },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red
                                        ), child: Text(
                                        'Cancelar',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
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
                                              fontSize: tamanhotexto
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
                                                fontSize: tamanhotexto
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
                                                  fontSize: tamanhotexto
                                              );
                                            }else{

                                              //todo bloqueio db

                                              var uuid = const Uuid();

                                              String idd = "${DateTime.now().toString()}${uuid.v4()}";

                                              FirebaseFirestore.instance.collection('VeiculosBloqueados').doc(idd).set(
                                                {
                                                'placa': Placa,
                                                 'Motivo': bloqueioMotivo,
                                                 'tipoVeiculo' : Veiculost,
                                                  'id': idd,
                                                  'dataDoBloqueio': DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/'),
                                                }
                                              );

                                              Navigator.of(context).pop();
                                            }
                                          }
                                        }

                                      },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green
                                        ), child: Text(
                                        'Prosseguir',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red
                      ),
                        child: Text(
                            'Bloquear',
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red
                      ),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green
                      ),
                      child: Text(
                        'Prosseguir',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
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
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child:
                    Image.network(
                      widget.LogoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child:
                    Text(
                      'ADM : ${widget.ADMName}',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
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