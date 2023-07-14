import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/Entrada/entradaModuloPrestador.dart';

//Programado por HeroRickyGames

class PesquisaPlaca extends StatefulWidget {
  String Porteiro;
  PesquisaPlaca(this.Porteiro, {Key? key}) : super(key: key);

  @override
  State<PesquisaPlaca> createState() => _PesquisaPlacaState();
}

class _PesquisaPlacaState extends State<PesquisaPlaca> {
  TextEditingController placaveiculointerface = TextEditingController();
  String Placa = '';
  String Pre = '';

  var dbInstance = FirebaseFirestore.instance;

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

    return LayoutBuilder(builder: (context, constrains){
      double wid = 700;
      double widin = 700;
      double heig = 50;
      if(constrains.maxWidth < 600){
        tamanhotexto = textSize;
        tamanhotextobtns = textSize;
        tamanhotextomin = 16;
        //aspect = 1.0;
        aspect = 1.0;
        wid = 700;
        widin = 800;
        heig = 50;
      }else {
        if(constrains.maxWidth > 600){
          tamanhotexto = textSizeandroid;
          tamanhotextobtns = textSizeandroidbtn;
          aspect = 0.8;
          wid = 1000;
          widin = 1200;
          heig = 100;
        }
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Liberação: Entrada de veiculo'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: 500,
                  child: Image.asset(
                    'assets/icon.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                Text(
                  'Digite a placa:',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: placaveiculointerface,
                    onChanged: (valor){
                      setState(() {
                        String valorpuro = valor.trim().toUpperCase();
                        Pre = valorpuro;
                        if(valorpuro.length == 7){
                          Placa = valorpuro.replaceAllMapped(
                            RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                                (Match m) => '${m[1]} ${m[2]}',
                          );
                          placaveiculointerface.text = Placa;
                        }
                      });
                      //Mudou mandou para a String
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Digite a placa *',
                      hintStyle: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green[700]
                      ),
                      onPressed: () async {
                        setState(() {
                          Placa = Pre;
                        });
                      },
                      child: Text(
                        'Pesquisar',
                        style: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                    )
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: StreamBuilder(
                      stream: FirebaseFirestore
                          .instance
                          .collection('VeiculosdePrestadores')
                          .where('PlacaVeiculo', isEqualTo: Placa)
                          .where('Liberado', isEqualTo: true)
                          .where('status', isEqualTo: '')
                      //.orderBy("Status", descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 700,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: OrientationBuilder(
                            builder: (context, orientation) {
                              return GridView.count(
                                crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: orientation == Orientation.portrait ? 1.0 : 0.7,
                                children:
                                snapshot.data!.docs.map((documents) {

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                      ),
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                  "Placa: ${documents['PlacaVeiculo']}",
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                "Nome: ${documents['PertenceA']}",
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                "RG: ${documents['RG']}",
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              child: ElevatedButton(
                                                onPressed: () async {

                                                  String urlImage = '';
                                                  String Telefone = '';
                                                  String PermitidosVeiculos = '';
                                                  bool vagaComum = false;
                                                  bool vagaMoto = false;
                                                  bool VagaDiretoria = false;
                                                  bool carro = false;
                                                  bool carroEmoto = false;
                                                  bool moto = false;

                                                  final PrestadorDoc = FirebaseFirestore.instance.collection('Prestadores').where('id', isEqualTo: documents['idPertence']);
                                                  final snapshot6 = await PrestadorDoc.get();
                                                  final PrestadorDocs = snapshot6.docs;
                                                  for (final PLACADOC in PrestadorDocs) {
                                                    setState(() {
                                                      urlImage = PLACADOC.get('urlImage');
                                                      Telefone = PLACADOC.get('Telefone');
                                                      vagaComum = PLACADOC.get('vagaComum');
                                                      vagaMoto = PLACADOC.get('vagaMoto');
                                                      VagaDiretoria = PLACADOC.get('VagaDiretoria');
                                                      carro = PLACADOC.get('carro');
                                                      carroEmoto = PLACADOC.get('carroEmoto');
                                                      moto = PLACADOC.get('moto');
                                                    });
                                                  }
                                                  print(urlImage);

                                                  if(carro == true){
                                                    PermitidosVeiculos = 'Carro';
                                                  }
                                                  if(carroEmoto == true){
                                                    PermitidosVeiculos = 'Carro+Moto';
                                                  }
                                                  if(moto == true){
                                                    PermitidosVeiculos = 'Moto';
                                                  }

                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return entradaModuloPrestador(widget.Porteiro, urlImage, documents['PertenceA'], documents['TipoDeVeiculo'], documents['Empresa'], Telefone, vagaComum, vagaMoto, VagaDiretoria, documents['Marca'], documents['Modelo'], documents['cor'], documents['PlacaVeiculo'], PermitidosVeiculos, documents['id'], documents['idEmpresa'], documents['galpao'], documents['RG']);
                                                      }));
                                                },
                                                child: const Text('Autorizar entrada'),
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                ).toList().reversed.toList(),
                              );
                            },
                          ),
                        );
                      }
                  ),
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
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child:
                      Column(
                        children: [
                          Text(
                            'Operador: ${widget.Porteiro}',
                            style: TextStyle(
                                fontSize: tamanhotexto
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
