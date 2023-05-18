import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/modal/modalCadastroVeiculoInterno.dart';

class meusVeiculosActivity extends StatefulWidget {
  String Empresa;
  String idEmpresa;
  meusVeiculosActivity(this.Empresa, this.idEmpresa, {Key? key}) : super(key: key);

  @override
  State<meusVeiculosActivity> createState() => _meusVeiculosActivityState();
}

class _meusVeiculosActivityState extends State<meusVeiculosActivity> {

  String dataAgendataST = '';
  String dataAgendataSTsaida = '';

  DateTime dataAgendada = DateTime(2023);
  DateTime dataAgendadasaida = DateTime(2023);

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  Map map = Map();
  List listaNome = [];
  Map Galpoes = { };

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
        title: const Text('Meus Veiculos Internos'),
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
                    .collection('veiculosDeEmpresa')
                    .where("idEmpresa", isEqualTo: widget.idEmpresa)
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
                                'Placa: ${documents['Placa']}',
                                style: TextStyle(
                                    fontSize: tamanhotexto
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: ElevatedButton(
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection('veiculosDeEmpresa').doc(documents['id']).delete().then((value){
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
                         var UID = FirebaseAuth.instance.currentUser?.uid;

                         var result = await FirebaseFirestore.instance
                             .collection("operadorEmpresarial")
                             .doc(UID)
                             .get();

                         String idEmpresa = result.get('idEmpresa');

                         Navigator.push(context,
                             MaterialPageRoute(builder: (context){
                               return cadastroVeiculoInterno(idEmpresa);
                             }));
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
