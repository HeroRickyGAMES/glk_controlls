import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/relatorio/posPesquisa/posPesquisa.dart';

//Programado por HeroRickyGames

class Relatorio extends StatefulWidget {
  String Porteiro;
  String LogoPath;
  Relatorio(this.Porteiro, this.LogoPath, {super.key});

  @override
  State<Relatorio> createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {
  String Pesquisa = '';
  String OqPesquisar = '';

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
        centerTitle: true,
        title: const Text('Pesquisa relatorio'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Digite Nome, RG, Placa, Empresa ou Galpão:',
                style: TextStyle(
                    fontSize: tamanhotexto
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    setState(() async {
                      Pesquisa = valor;
                    });
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Digite Nome, RG, Placa, Empresa ou Galpão *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                          'Cancelar',
                        style: TextStyle(
                            fontSize: tamanhotexto,
                            color: Colors.black
                        ),
                      ),
                    )
                  ),
                  Container(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green
                        ),
                        onPressed: () async {

                          if(Pesquisa == ''){
                            Fluttertoast.showToast(
                              msg: 'Preencha a pesquisa!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: tamanhotexto,
                            );
                          }else{
                            List pesquisaNome = [];

                            final NomeCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador').where('Nome', isEqualTo: Pesquisa);
                            final snapshot6 = await NomeCollections.get();
                            final NOMEDOC = snapshot6.docs;
                            for (final NOMEDOC in NOMEDOC) {

                              final nome = NOMEDOC.get('Nome');

                              pesquisaNome.add('$nome');
                            }

                            List pesquisaRG = [];

                            final RGCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador').where('RG', isEqualTo: Pesquisa);
                            final snapshot7 = await RGCollections.get();
                            final RGDOC = snapshot7.docs;
                            for (final RGDOCU in RGDOC) {

                              final RG = RGDOCU.get('RG');

                              pesquisaRG.add('$RG');
                            }

                            List pesquisaEmpresa = [];

                            final EmpresaCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador').where('Empresa', isEqualTo: Pesquisa);
                            final snapshot8 = await EmpresaCollections.get();
                            final EmpresaDOC = snapshot8.docs;
                            for (final EmpresaDOCU in EmpresaDOC) {

                              final Empresa = EmpresaDOCU.get('Empresa');

                              pesquisaEmpresa.add('$Empresa');
                            }

                            List galpaoPesquisa = [];

                            final GalpaoCollections = FirebaseFirestore.instance.collection('relatorioModuloPrestador').where('galpao', isEqualTo: Pesquisa);
                            final snapshot9 = await GalpaoCollections.get();
                            final GalpaoDOC = snapshot9.docs;
                            for (final EmpresaDOCU in GalpaoDOC) {

                              final galpao = EmpresaDOCU.get('galpao');

                              galpaoPesquisa.add('$galpao');
                            }

                            if(pesquisaNome.contains(Pesquisa)){
                              setState(() {
                                OqPesquisar = 'Nome';
                              });

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return PosPesquisaRelatorio(Pesquisa, OqPesquisar);
                                  }));
                            }else{
                              if(pesquisaRG.contains(Pesquisa)){
                                setState(() {
                                  OqPesquisar = 'RG';
                                });

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return PosPesquisaRelatorio(Pesquisa, OqPesquisar);
                                    }));
                              }else{
                                if(pesquisaEmpresa.contains(Pesquisa)){
                                  setState(() {
                                    OqPesquisar = 'Empresa';
                                  });

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context){
                                        return PosPesquisaRelatorio(Pesquisa, OqPesquisar);
                                      }));
                                }else{
                                  if(galpaoPesquisa.contains(Pesquisa)){
                                    setState(() {
                                      OqPesquisar = 'galpao';
                                    });

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return PosPesquisaRelatorio(Pesquisa, OqPesquisar);
                                        }));
                                  }else{
                                    Fluttertoast.showToast(
                                      msg: 'Eu não achei nada!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: tamanhotexto,
                                    );
                                  }
                                }
                              }
                            }
                          }
                        },
                        child: Text(
                          'Pesquisar',
                          style: TextStyle(
                              fontSize: tamanhotexto,
                              color: Colors.white
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    padding: const EdgeInsets.all(16),
                    child:
                    Image.network(
                      widget.LogoPath,
                      fit: BoxFit.contain,
                    ),
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
