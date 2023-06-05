import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/Entrada/entradaModuloPrestador.dart';
import 'package:glk_controls/ModuloPrestador/saida/saidaPrestadorVeiculo.dart';

class PesquisaPlacaSaida extends StatefulWidget {
  String Porteiro;
  PesquisaPlacaSaida(this.Porteiro, {Key? key}) : super(key: key);

  @override
  State<PesquisaPlacaSaida> createState() => _PesquisaPlacaSaidaState();
}

class _PesquisaPlacaSaidaState extends State<PesquisaPlacaSaida> {
  TextEditingController placaveiculointerface = TextEditingController();
  String Placa = '';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liberação: Saida de veiculo'),
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
                    setState(() async {
                      String valorpuro = valor.toUpperCase();
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
                      if(Placa == ''){
                        Fluttertoast.showToast(
                          msg: 'Preencha a placa!',
                          toastLength: Toast.LENGTH_LONG,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{
                        //todo pesquisa

                        String placaLista = '';
                        String statusList = '';
                        String Pertence = '';
                        String Empresa = '';
                        String tipoDeVeiculo = '';
                        String IDPrestador = '';
                        String Marca = '';
                        String Modelo = '';
                        String Cor = '';
                        String ID = '';
                        bool liberado = false;
                        String galpao = '';

                        final PlacaCollections = FirebaseFirestore.instance.collection('VeiculosdePrestadores').where('PlacaVeiculo', isEqualTo: Placa);
                        final snapshot6 = await PlacaCollections.get();
                        final PLACADOC = snapshot6.docs;
                        for (final PLACADOC in PLACADOC) {

                          final placa = PLACADOC.get('PlacaVeiculo');
                          final status = PLACADOC.get('status');
                          final pertence = PLACADOC.get('PertenceA');
                          final empresa = PLACADOC.get('Empresa');
                          final veiculo = PLACADOC.get('TipoDeVeiculo');
                          final prestadorID = PLACADOC.get('idPertence');
                          final marcaDoc = PLACADOC.get('Marca');
                          final ModeloDoc = PLACADOC.get('Modelo');
                          final CorDoc = PLACADOC.get('cor');
                          final idDoc = PLACADOC.get('id');
                          final liberadoDoc = PLACADOC.get('Liberado');
                          final galpaoDoc = PLACADOC.get('galpao');
                          placaLista = placa;
                          statusList = status;
                          Pertence = pertence;
                          Empresa = empresa;
                          tipoDeVeiculo = veiculo;
                          IDPrestador = prestadorID;
                          Marca = marcaDoc;
                          Marca = marcaDoc;
                          Modelo = ModeloDoc;
                          Cor = CorDoc;
                          ID = idDoc;
                          liberado = liberadoDoc;
                          galpao = galpaoDoc;
                        }

                        if(liberado == false){
                          Fluttertoast.showToast(
                            msg: 'Esse veiculo está bloqueado!',
                            toastLength: Toast.LENGTH_LONG,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{
                          if(statusList.contains('Liberado Entrada')){

                            bool vagaComum = false;
                            bool vagaMoto = false;
                            bool VagaDiretoria = false;
                            String telefone = '';
                            String imageURL = '';
                            String PermitidosVeiculos = '';
                            String IDEmpresa = '';

                            final RGCollections = FirebaseFirestore.instance.collection('Prestadores');
                            final snapshot5 = await RGCollections.get();
                            final RGDOC = snapshot5.docs;
                            for (final VEICULODOC in RGDOC) {

                              final vagacomum = VEICULODOC.get('vagaComum');
                              final vagamoto = VEICULODOC.get('vagaMoto');
                              final vagadirecao = VEICULODOC.get('VagaDiretoria');
                              final telefoneDOC = VEICULODOC.get('Telefone');
                              final imageURI = VEICULODOC.get('urlImage');
                              final carro = VEICULODOC.get('carro');
                              final carroEmoto = VEICULODOC.get('carroEmoto');
                              final moto = VEICULODOC.get('moto');
                              final idEmpresaDoc = VEICULODOC.get('EmpresaID');

                              if(carro == true){
                                PermitidosVeiculos = 'Carro';
                              }
                              if(carroEmoto == true){
                                PermitidosVeiculos = 'Carro+Moto';
                              }
                              if(moto == true){
                                PermitidosVeiculos = 'Moto';
                              }

                              vagaComum = vagacomum;
                              vagaMoto = vagamoto;
                              VagaDiretoria = vagadirecao;
                              telefone = telefoneDOC;
                              imageURL = imageURI;
                              IDEmpresa = idEmpresaDoc;
                            }

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return SaidaPrestadorSaida(widget.Porteiro, imageURL, Pertence, tipoDeVeiculo, Empresa, telefone, vagaComum, vagaMoto, VagaDiretoria, Marca, Modelo, Cor, placaLista, PermitidosVeiculos, ID, IDEmpresa, galpao);
                                }));

                          }else{
                            Fluttertoast.showToast(
                              msg: 'Esse veiculo não está dentro da empresa!',
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                          if(placaLista.isEmpty){
                            Fluttertoast.showToast(
                              msg: 'Não encontrei nada, por favor tente novamente!',
                              toastLength: Toast.LENGTH_LONG,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        }
                      }
                    },
                    child: Text(
                      'Pesquisar',
                      style: TextStyle(
                          fontSize: tamanhotextobtns
                      ),
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
  }
}
