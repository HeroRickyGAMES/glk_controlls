import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../relatorioGen/generatePDF/gerarPDFBloqueio.dart';
import '../relatorioGen/generatePDF/gerarPDFBloqueio2.dart';

class bloqueioDeVisitantes extends StatefulWidget {
  String ADMName;
  String LogoPath;
  @override
  bloqueioDeVisitantes(this.ADMName, this.LogoPath);


  _bloqueioDeVisitantesState createState() => _bloqueioDeVisitantesState();
}

class _bloqueioDeVisitantesState extends State<bloqueioDeVisitantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bloqueio de Visitantes'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
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
                      'Nome',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'RG',
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
                      .collection('VisitantesBloqueados')
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
                                  documents['nome'],
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                                Text(
                                  documents['rg'],
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
                                                        Text('Nome:'  + documents['nome']),
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
                                                            return generatePDF3(documents['nome'], documents['rg'], documents['Motivo'], DateFormat('dd-MM-yyyy HH:mm:ss').format(documents['dataDoBloqueio'].toDate()).replaceAll('-', '/'));
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
                                        FirebaseFirestore.instance.collection('VisitantesBloqueados').doc(documents['id']).delete().then((value){
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
                                  Icon(Icons.zoom_out_sharp),
                                ],
                              ),
                              title: Column(
                                children: [
                                  Text('Novo Bloqueio'),
                                  Container(
                                    padding: EdgeInsets.all(16),
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
                                        border: OutlineInputBorder(),
                                        hintText: 'Nome do Motorista * ',
                                        hintStyle: TextStyle(
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16),
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
                                        border: OutlineInputBorder(),
                                        hintText: 'RG do Motorista (Só numeros)* ',
                                        hintStyle: TextStyle(
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
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

                                      if(Nome == ''){

                                        Fluttertoast.showToast(
                                            msg: 'Preencha o nome do motorista!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey[600],
                                            textColor: Colors.white,
                                            fontSize: 16.0
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

                                            FirebaseFirestore.instance.collection('VisitantesBloqueados').doc(idd).set(
                                                {
                                                  'nome': Nome,
                                                  'Motivo': bloqueioMotivo,
                                                  'rg' : RG,
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child:
                    Image.network(
                      widget.LogoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child:
                    Text(
                      'ADM : ' + widget.ADMName,
                      style: TextStyle(
                          fontSize: 20
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