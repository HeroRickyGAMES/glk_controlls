import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:glk_controls/relatorioGen/generatePDF/gerarPDFBloqueio2.dart';

class bloqueioDeVisitantes extends StatefulWidget {
  String ADMName;
  String LogoPath;
  @override
  bloqueioDeVisitantes(this.ADMName, this.LogoPath, {super.key});


  _bloqueioDeVisitantesState createState() => _bloqueioDeVisitantesState();
}

class _bloqueioDeVisitantesState extends State<bloqueioDeVisitantes> {
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bloqueio de Visitantes'),
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
                      'Nome',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'RG',
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
                      .collection('VisitantesBloqueados')
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
                                  documents['nome'],
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                                Text(
                                  documents['rg'],
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
                                                        Text('Nome:'  + documents['nome']),
                                                        Text('Data do Bloqueio:'  + documents['dataDoBloqueio'].replaceAll('-', '/'),),
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
                                                            return generatePDF3(documents['nome'], documents['rg'], documents['Motivo'], documents['dataDoBloqueio'].replaceAll('-', '/'));
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
                                        FirebaseFirestore.instance.collection('VisitantesBloqueados').doc(documents['id']).delete().then((value){
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

                        String Nome = '';
                        String RG = '';
                        String bloqueioMotivo = '';

                        TextEditingController NameController = TextEditingController();

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
                                      controller: NameController,
                                      onChanged: (valor){

                                        Nome = valor.toUpperCase();
                                        //Mudou mandou para a String
                                      },
                                      keyboardType: TextInputType.text,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'Nome do Motorista * ',
                                        hintStyle: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      onChanged: (valor){

                                        RG = valor;
                                        NameController.text = Nome;
                                        //Mudou mandou para a String
                                      },
                                      keyboardType: TextInputType.number,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'RG do Motorista (Só numeros)* ',
                                        hintStyle: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      ),
                                    ),
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

                                      if(Nome == ''){

                                        Fluttertoast.showToast(
                                            msg: 'Preencha o nome do motorista!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey[600],
                                            textColor: Colors.white,
                                            fontSize: tamanhotexto
                                        );

                                      }else{
                                        if(RG == ''){
                                          Fluttertoast.showToast(
                                              msg: 'Preencha o RG do motorista!',
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

                                            var dateTime= DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/');

                                            var uuid = const Uuid();

                                            String idd = "${DateTime.now().toString()}${uuid.v4()}";

                                            FirebaseFirestore.instance.collection('VisitantesBloqueados').doc(idd).set(
                                                {
                                                  'nome': Nome,
                                                  'Motivo': bloqueioMotivo,
                                                  'rg' : RG,
                                                  'id': idd,
                                                  'dataDoBloqueio': dateTime
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