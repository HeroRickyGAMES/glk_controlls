import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/modal/cadastroEmpresa.dart';
import 'package:glk_controls/modal/cadastroUsuarioADM.dart';
import 'package:glk_controls/operadorInterno.dart';
import 'package:glk_controls/relatorio.dart';
import 'package:glk_controls/subModais/BloqueioDeVeiculos.dart';
import 'package:glk_controls/subModais/bloqueiodeVisitantes.dart';
import 'package:glk_controls/subModais/empresasCadastradas.dart';
import 'package:glk_controls/modal/ReleModalConfig.dart';
import 'package:glk_controls/listas/UsuariosCadastrados.dart';

//Programado por HeroRickyGames

class painelADM extends StatefulWidget {
  final String ADMName;
  final String LogoPath;
  const painelADM(this.ADMName, this.LogoPath);

  @override
  State<painelADM> createState() => _painelADMState();
}

class _painelADMState extends State<painelADM> {
  List listaNome = [];
  String pass = '';

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
        title: const Text('SETOR ADIMISTRATIVO - Painel'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: (){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text('Aguarde!'),
                                    actions: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                },
                              );

                              final dropValue = ValueNotifier('');

                              Navigator.of(context).pop();

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return cadastroEmpresa(dropValue, widget.ADMName, widget.LogoPath);
                                  }));

                            },
                            child:
                            Text(
                              'Cadastrar Empresa',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: () async {

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text('Aguarde!'),
                                    actions: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                },
                              );

                              var result = await FirebaseFirestore.instance
                                  .collection("empresa")
                                  .get();
                              result.docs.forEach((res) {

                                listaNome.add(res.data()['nome'] + res.data()['id']);

                                final dropValue = ValueNotifier('');


                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return cadastroUsuarioModal(dropValue, listaNome, widget.ADMName, widget.LogoPath);
                                    }));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green
                            ),
                            child:
                            Text(
                              'Cadastrar Operador da Empresa',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: (){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text('Aguarde!'),
                                    actions: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                },
                              );

                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return operadorInterno(widget.ADMName, widget.LogoPath);
                                  }));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow
                            ),
                            child:
                            Text(
                              'Cadastrar Operador Interno',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return relatorio(widget.ADMName, widget.LogoPath);
                                  }));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey
                            ),
                            child:
                            Text(
                              'Relatorios Gerais',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text('Aguarde!'),
                                    actions: [
                                      Center(
                                      child: CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                },
                              );

                              Navigator.of(context).pop();

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return empresaCadastrada(widget.ADMName, widget.LogoPath);
                                  }));

                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[400]
                            ),
                            child:
                            Text(
                              'Empresas Cadastrados',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return UsuariosCadastrados(widget.ADMName, widget.LogoPath);
                                  }));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple
                            ),
                            child:
                            Text(
                              'Usuarios Cadastrados',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: () async {
                              var result = await FirebaseFirestore.instance
                                  .collection("Reles")
                                  .doc('Rele01')
                                  .get();
                              var result2 = await FirebaseFirestore.instance
                                  .collection("Reles")
                                  .doc('Rele02')
                                  .get();

                              String urlRele1 = (result.get('ip'));
                              String urlRele2 = (result2.get('ip'));

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return releModalConfig(urlRele1, urlRele2, widget.ADMName, widget.LogoPath);
                                  }));
                            },
                            child:
                            Text(
                              'Configurações de Relês',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return bloqueioDePlacas(widget.ADMName, widget.LogoPath);
                                  }));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red
                            ),
                            child:
                            Text(
                              'Bloqueio de veiculos',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return bloqueioDeVisitantes(widget.ADMName, widget.LogoPath);
                                  }));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red
                            ),
                            child:
                            Text(
                              'Bloqueio de visitantes',
                              style: TextStyle(
                                  fontSize: tamanhotextobtns
                              ),
                            ),
                          ),
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
                            Column(
                              children: [
                                Text(
                                  'ADM : ${widget.ADMName}',
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
            ],
          ),
        ),
      ),
    );
  }
}
