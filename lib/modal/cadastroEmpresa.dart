import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

//Programado por HeroRickyGames

List<String> tags = [];
List<String> gpLs = [];
class cadastroEmpresa extends StatefulWidget {
  var dropValue;
  String ADMName;
  String LogoPath;
  cadastroEmpresa(this.dropValue, this.ADMName, this.LogoPath);
  @override
  State<cadastroEmpresa> createState() => _cadastroEmpresaState();
}

class _cadastroEmpresaState extends State<cadastroEmpresa> {

  final dropValue = ValueNotifier('');
  String empresaName = '';
  String galpaoNum = '';
  String vagas = '';
  String respName = '';
  String telNum = '';
  String GpDisp = '';
  String GpUsados = '';
  String galpaoPikadoPrincipal = '';
  String vagasInterno = '';
  String vagasMoto = '';
  String vagasDiretoria = '';
  List vagasList = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
  ];
  Map<String, int> galpoesMap = { };
  bool gpSelecionado = false;

  final _textController = TextEditingController();
  final respNameController = TextEditingController();
  final telNumController = TextEditingController();

  void _addTag(String tag) {
    if (tag.isNotEmpty) {
      setState(() {
        galpaoNum = 'G-0' +  tag;
        tags.add('G-0' + tag);
        gpLs.add('G-0' + tag);
        gpSelecionado = true;
      });
      _textController.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      galpaoNum = '';
      tags.remove(tag);
      gpLs.remove(tag);
      if(tags.length == 0){
        gpSelecionado = false;
      }

    });
  }

  chekdb() async {

    var result = await FirebaseFirestore.instance
        .collection("Condominio")
        .doc('condominio')
        .get();

    List galpoesUsados = result.get('galpoesUsados');
    int galpoesDisponiveis = result.get('galpoes');
    int vagasDisponiveis = result.get('vagas');

    setState(() {
      GpUsados = "${galpoesUsados}";
      GpDisp = "${galpoesDisponiveis}";
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chekdb();
  }

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
        title: const Text('Cadastro de Empresas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      onChanged: (valor){
                        empresaName = valor.trim().toUpperCase();
                        //Mudou mandou para a String
                      },
                      keyboardType: TextInputType.name,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome da Empresa *',
                        hintStyle: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: tags.map((tag) {
                            return InputChip(
                              label: Text(tag),
                              onDeleted: () => _removeTag( tag),
                            );
                          }).toList(),
                        ),
                        TextFormField(
                          controller: _textController,
                          keyboardType: TextInputType.number,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Galpões *',
                            hintStyle: TextStyle(
                                fontSize: tamanhotexto
                            ),
                          ),
                          onFieldSubmitted: _addTag,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      onChanged: (valor){
                        vagas = valor.toUpperCase();
                        //Mudou mandou para a String
                      },
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Quantidade de vagas de carga para cada galpão *',
                        hintStyle: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      onChanged: (valor){
                        vagasInterno = valor.toUpperCase();
                        //Mudou mandou para a String
                      },
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Quantidade de vagas internas *',
                        hintStyle: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      onChanged: (valor){
                        vagasMoto = valor.toUpperCase();
                        //Mudou mandou para a String
                      },
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Vagas Moto *',
                        hintStyle: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      onChanged: (valor){
                        vagasDiretoria = valor.toUpperCase();
                        //Mudou mandou para a String
                      },
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Vagas diretoria *',
                        hintStyle: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: respNameController,
                      onChanged: (valor){
                        respName = valor.trim().toUpperCase();
                        //Mudou mandou para a String
                      },
                      keyboardType: TextInputType.name,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Responsável pela Empresa * ',
                        hintStyle: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      controller: telNumController,
                      onChanged: (valor){
                        respNameController.text = respName;


                        String valorpuro = valor.toUpperCase();
                        telNum = valorpuro.replaceAllMapped(
                          RegExp(r'^([0-9]{2})([0-9]{5})([0-9]{4})$'),
                              (Match m) => '${m[1]} ${m[2]}-${m[3]} ',
                        );
                        //Mudou mandou para a String
                      },
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Telefone',
                        hintStyle: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                    ),
                  ),
                  gpSelecionado == true ? Container(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                        child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                          return DropdownButton(
                            hint: Text(
                              'Selecione o Galpão de recepção *',
                              style: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            ),
                            value: (value.isEmpty)? null : value,
                            onChanged: (escolha) async {
                              dropValue.value = escolha.toString();

                              galpaoPikadoPrincipal = escolha.toString();
                              setState(() {
                                tags.remove(galpaoPikadoPrincipal);
                              });
                            },
                            items: gpLs.map((opcao) => DropdownMenuItem(
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
                  ): Text(''),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(onPressed: (){
                            tags.clear();
                          },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red
                            ),
                              child: Text(
                                  'Cancelar',
                                style: TextStyle(
                                    fontSize: tamanhotextobtns,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () async {

                                  if(empresaName == ''){
                                    Fluttertoast.showToast(
                                      msg: 'Preencha o nome da empresa!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: tamanhotextobtns,
                                    );
                                  }else{
                                    if(galpaoNum == ''){
                                      Fluttertoast.showToast(
                                        msg: 'Preencha a quantidade de galpões disponiveis!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: tamanhotextobtns,
                                      );
                                    }else{
                                      if(tags.isEmpty){
                                        Fluttertoast.showToast(
                                          msg: 'Preencha a quantidade de galpões disponiveis! (Não esqueça de apertar confirmar no seu teclado!)',
                                          toastLength: Toast.LENGTH_LONG,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: tamanhotextobtns,
                                        );
                                      }else{
                                        if(respName == ''){
                                          Fluttertoast.showToast(
                                            msg: 'Preencha o nome do responsavel pela Empresa!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: tamanhotextobtns,
                                          );
                                        }else{

                                          if(vagasInterno == ''){
                                            Fluttertoast.showToast(
                                              msg: 'Preencha as vagas dos internos!',
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: tamanhotextobtns,
                                            );
                                          }else{
                                            if(vagasMoto == ''){
                                              Fluttertoast.showToast(
                                                msg: 'Preencha as vagas de motos!',
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: tamanhotextobtns,
                                              );
                                            }else{
                                              if(vagasDiretoria == ''){
                                                Fluttertoast.showToast(
                                                  msg: 'Preencha as vagas de diretoria!',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: tamanhotextobtns,
                                                );
                                              }else{
                                                if(vagas == ''){
                                                  Fluttertoast.showToast(
                                                    msg: 'Preencha as vagas de cargas!',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: tamanhotextobtns,
                                                  );
                                                }else{
                                                  if(galpaoPikadoPrincipal == ''){
                                                    Fluttertoast.showToast(
                                                      msg: 'Selecione o galpão de recepção!',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.black,
                                                      textColor: Colors.white,
                                                      fontSize: tamanhotextobtns,
                                                    );
                                                  }else{
                                                    var result = await FirebaseFirestore.instance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();

                                                    List galpoesUsados = result.get('galpoesUsados');
                                                    int galpoesDisponiveis = result.get('galpoes');
                                                    int vagasDisponiveis = result.get('vagas');
                                                    double vagasInternoDisponiveis = result.get('VagasPrestadores');
                                                    int vagasMotoDisponiveis = result.get('VagasMotos');
                                                    int number = tags.length;

                                                    if(galpoesDisponiveis == 0){
                                                      Fluttertoast.showToast(
                                                        msg: 'Não há galpões Disponiveis!',
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.black,
                                                        textColor: Colors.white,
                                                        fontSize: tamanhotextobtns,
                                                      );
                                                    }else{
                                                      if(galpoesDisponiveis < tags.length){
                                                        Fluttertoast.showToast(
                                                          msg: 'A quantidade de galpões escolhida por você é menor que as Disponiveis!',
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor: Colors.black,
                                                          textColor: Colors.white,
                                                          fontSize: tamanhotextobtns,
                                                        );
                                                      }else{
                                                        for (int i = number; i >= 1; i--) {
                                                          galpoesMap.putIfAbsent(tags[i-1], () => int.parse(vagas));


                                                          if(galpoesUsados.contains(tags[i-1])){
                                                            Fluttertoast.showToast(
                                                              msg: 'Os Galpões Selecionados já estão sendo usados por outra empresa!',
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.black,
                                                              textColor: Colors.white,
                                                              fontSize: tamanhotextobtns,
                                                            );
                                                          }else{
                                                            if(i == tags.length){
                                                              Fluttertoast.showToast(
                                                                msg: 'Cadastrando empresa...',
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.black,
                                                                textColor: Colors.white,
                                                                fontSize: tamanhotextobtns,
                                                              );
                                                              var uuid = const Uuid();

                                                              String idd = "${DateTime.now().toString()}" + uuid.v4();


                                                              FirebaseFirestore.instance.collection('empresa').doc(idd).set({
                                                                    'nome': empresaName,
                                                                    'galpaes': galpoesMap,
                                                                    'NameResponsavel': respName,
                                                                    'Telefone': telNum,
                                                                    'tipoConta': 'empresa',
                                                                    'id': idd,
                                                                    'galpaoPrimario': galpaoPikadoPrincipal,
                                                                    'vagas': vagas,
                                                                    'vagasInterno': double.parse(vagasInterno),
                                                                    'vagasMoto': int.parse(vagasMoto),
                                                                    'vagasDeDiretoria': int.parse(vagasDiretoria),
                                                                  }
                                                              ).then((value) {
                                                                int galpaoPass = tags.length;
                                                                int subtracaoGalpao = galpoesDisponiveis - galpaoPass;
                                                                int vagasSubtracao = vagasDisponiveis - int.parse(vagas);
                                                                double vagasSubtracaoInterno = vagasInternoDisponiveis - int.parse(vagasInterno);
                                                                int vagasSubtracaoMoto = vagasMotoDisponiveis - int.parse(vagasMoto);
                                                                galpoesUsados.addAll(tags);

                                                                FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                                                  'galpoes': subtracaoGalpao,
                                                                  'galpoesUsados': galpoesUsados,
                                                                  'vagas': vagasSubtracao,
                                                                  'VagasMotos': vagasSubtracaoInterno,
                                                                  'VagasPrestadores': double.parse("$vagasSubtracaoMoto"),
                                                                }).then((value){
                                                                  Fluttertoast.showToast(
                                                                    msg: 'Empresa cadastrada com sucesso!',
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.black,
                                                                    textColor: Colors.white,
                                                                    fontSize: tamanhotextobtns,
                                                                  );
                                                                  galpoesUsados.addAll(gpLs);

                                                                  FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                                                    'galpoesUsados': galpoesUsados,
                                                                  }).then((value) {
                                                                    gpLs.clear();
                                                                    tags.clear();
                                                                    Navigator.pop(context);
                                                                  });
                                                                });
                                                              });
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green
                            ),
                              child: Text(
                                  'Prosseguir',
                              style: TextStyle(
                                fontSize: tamanhotextobtns,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      'Galpões Usados: ${GpUsados}',
                      style: TextStyle(
                          fontSize: tamanhotextobtns,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                        'Numero de Galpões Disponiveis: ${GpDisp}',
                      style: TextStyle(
                          fontSize: tamanhotextobtns,
                          fontWeight: FontWeight.bold
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
                      'ADM : ' + widget.ADMName,
                      style: const TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),
            WillPopScope(
              onWillPop: () async {
                gpLs.clear();
                tags.clear();
                Navigator.pop(context);
                return false;
              }, child: const Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
