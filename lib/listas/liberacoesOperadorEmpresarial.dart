import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/CameraModulo/camera_comum/Camera.dart';
import 'package:glk_controls/modal/veiculoEntrada.dart';
import 'package:glk_controls/pesquisaDir/pesquisa.dart';
import 'package:glk_controls/modal/operadorEmpresarialAguardandoModal.dart';

//Programado por HeroRickyGames

Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
class liberacoesOperadorEmpresarial extends StatefulWidget {
  final String name;
  final String empresaName;
  final String PreFillPesquisa;
  const liberacoesOperadorEmpresarial(this.name, this.empresaName, this.PreFillPesquisa, {super.key});

  @override
  State<liberacoesOperadorEmpresarial> createState() => _liberacoesOperadorEmpresarialState();
}

class _liberacoesOperadorEmpresarialState extends State<liberacoesOperadorEmpresarial> {

  TextEditingController placaveiculointerface = TextEditingController();
  bool started = false;
  String holderPlaca = '';
  String oqPesquisar = '';

  Widget build(BuildContext context) {
    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    Map Galpoes = { };
    List GalpoesList = [ ];

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

    startedapp(context) async {
      placaveiculointerface.text = widget.PreFillPesquisa;
      holderPlaca = widget.PreFillPesquisa;
      await Future.delayed(const Duration(seconds: 4));

      if(widget.PreFillPesquisa != ''){
        FirebaseFirestore.instance
            .collection('Autorizacoes')
            .where('Empresa', isEqualTo: widget.empresaName)
            .where('Status', isNotEqualTo: 'Saida')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {

            if(doc["nomeMotorista"] == holderPlaca ){
              setState(() {
                oqPesquisar = 'nomeMotorista';
              });
            }else{
              if(doc["PlacaVeiculo"] == holderPlaca ){
                setState(() {
                  oqPesquisar = 'PlacaVeiculo';
                });
              }else{
                if(doc["Empresa"] == holderPlaca){
                  setState(() {
                    oqPesquisar = 'Empresa';
                  });
                }else{
                  if(doc["Galpão"] == holderPlaca){
                    setState(() {
                      oqPesquisar = 'Galpão';
                    });
                  }else{
                    oqPesquisar = 'PlacaVeiculo';
                  }
                }
              }
            }
          });
        });
      }
    }

    if(started == false){
      startedapp(context);
    }

    started = true;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GLK Controls - LIBERAÇÕES'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 180,
                    height: 180,
                    padding: const EdgeInsets.all(16),
                    child:
                    Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.contain,
                    )
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(16),
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Pesquisar Placa:',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 60,
                          child: TextFormField(
                            controller: placaveiculointerface,
                            onChanged: (valor){
                              setState(() {
                                String value = valor.toUpperCase();
                                if(placaveiculointerface.text == ''){
                                  holderPlaca = '';
                                  oqPesquisar = '';
                                }

                                if(value.length == 7){
                                  holderPlaca = value.replaceAllMapped(
                                    RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                                        (Match m) => '${m[1]} ${m[2]}',
                                  );
                                  placaveiculointerface.text = holderPlaca;
                                }
                                FirebaseFirestore.instance
                                    .collection('Autorizacoes')
                                    .where('Empresa', isEqualTo: widget.empresaName)
                                    .where('Status', isNotEqualTo: 'Saida')
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {

                                    if(doc["nomeMotorista"] == holderPlaca ){

                                      oqPesquisar = 'nomeMotorista';


                                    }else{

                                      if(doc["PlacaVeiculo"] == holderPlaca ){
                                        oqPesquisar = 'PlacaVeiculo';

                                      }else{
                                        if(doc["Empresa"] == holderPlaca){
                                          oqPesquisar = 'Empresa';

                                        }else{
                                          if(doc["Galpão"] == holderPlaca){
                                            oqPesquisar = 'Galpão';

                                          }else{

                                          }
                                        }
                                      }
                                    }
                                  });
                                });
                              });
                            },
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(

                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green
                                  )
                              ),
                              hintStyle: TextStyle(
                                  fontSize: tamanhotexto
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: SizedBox(
                              width: 70,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: kIsWeb == false ? (){
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context){
                                        return CameraComum('LiberaçãoEmpresa', widget.name, widget.empresaName);
                                      }));

                                } : null,
                                child: const Icon(Icons.camera_alt),
                              )
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: (){
                          if(holderPlaca == ''){

                            Fluttertoast.showToast(
                              msg: 'Preencha a pesquisa!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: tamanhotextomin,
                            );

                          }else{
                            FirebaseFirestore.instance
                                .collection('Autorizacoes')
                                .where('Empresa', isEqualTo: widget.empresaName)
                                .where('Status', isNotEqualTo: 'Saida')
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {

                                if(doc["nomeMotorista"] == holderPlaca ){

                                  oqPesquisar = 'nomeMotorista';


                                }else{

                                  if(doc["PlacaVeiculo"] == holderPlaca ){
                                    oqPesquisar = 'PlacaVeiculo';

                                  }else{
                                    if(doc["Empresa"] == holderPlaca){
                                      oqPesquisar = 'Empresa';

                                    }else{
                                      if(doc["Galpão"] == holderPlaca){
                                        oqPesquisar = 'Galpão';

                                      }else{

                                        Fluttertoast.showToast(
                                          msg: 'Dados não encontrados!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    }
                                  }
                                }

                              });
                            });
                          }
                        },
                        child: Text(
                          'Pesquisar',
                          style: TextStyle(
                              fontSize: tamanhotexto,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: oqPesquisar != '' ?  FirebaseFirestore
                            .instance
                            .collection('Autorizacoes')
                            .where('Empresa', isEqualTo: widget.empresaName)
                            .where('Status', isNotEqualTo: 'Saida')
                            .where('PlacaVeiculo', isEqualTo: holderPlaca)
                            .snapshots():
                        FirebaseFirestore
                            .instance
                            .collection('Autorizacoes')
                            .where('Empresa', isEqualTo: widget.empresaName)
                            .where('Status', isNotEqualTo: 'Saida')
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

                                    if(documents['Empresa'] == widget.empresaName){
                                      String lacre = '${documents['LacreouNao']}';
                                      String ColetaOuEntrega = '${documents['ColetaOuEntrega']}';
                                      bool lacrebool = false;
                                      bool coletaBool = false;
                                      String lacrado = '';
                                      String ColetaOuEntregast = '';

                                      if(lacre == 'lacre'){
                                        lacrebool = true;
                                        lacrado = 'Lacrado';
                                      }
                                      if(lacre == 'naolacrado'){
                                        lacrebool = false;
                                        lacrado = 'Não Lacrado';
                                      }
                                      if(ColetaOuEntrega == 'coleta'){
                                        coletaBool = true;
                                        ColetaOuEntregast = 'Coleta';
                                      }
                                      if(ColetaOuEntrega == 'entrega'){
                                        coletaBool = false;
                                        ColetaOuEntregast = 'Entrega';
                                      }

                                      Color color = Colors.white as Color;
                                      Color textColor = Colors.white as Color;

                                      if(documents['Status'] == 'Aguardando Liberação'){
                                        color = Colors.red[400] as Color;
                                        textColor = Colors.white as Color;
                                      }
                                      if(documents['Status'] == 'Liberado Entrada'){
                                        color = Colors.grey as Color;
                                        textColor = Colors.white as Color;
                                      }

                                      if(documents['Status'] == 'Rejeitado'){
                                        color = Colors.red[400] as Color;
                                        textColor = Colors.white as Color;
                                      }

                                      if(documents['Status'] == 'Estacionário'){
                                        color = Colors.yellow[400] as Color;
                                        textColor = Colors.black as Color;
                                      }

                                      if(documents['Status'] == 'Liberado Saida'){
                                        color = Colors.yellow[400] as Color;
                                        textColor = Colors.black as Color;
                                      }

                                      if(documents['Status'] == 'Saida'){
                                        color = Colors.green[400] as Color;
                                        textColor = Colors.white as Color;
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: color,
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
                                              ElevatedButton(
                                                  onPressed: () async {

                                                    var UID = FirebaseAuth.instance.currentUser?.uid;

                                                    var userValues = await FirebaseFirestore.instance
                                                        .collection("operadorEmpresarial")
                                                        .doc(UID)
                                                        .get();

                                                    if(documents['Status'] == 'Estacionário' ){

                                                      String lacre = documents['LacreouNao'];

                                                      if(lacre == 'lacre'){
                                                        String liberadopor = documents['QuemAutorizou'];
                                                        String horarioCriacao = documents['Horario Criado'];
                                                        String nomeMotorista = documents['nomeMotorista'];
                                                        String Veiculo = documents['Veiculo'];
                                                        String PlacaVeiculo = documents['PlacaVeiculo'];
                                                        String Empresadestino = documents['Empresa'];
                                                        String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                        String Galpao = documents['Galpão'];
                                                        String lacradoStr = documents['lacrenum'];
                                                        bool interno = documents['interno'];
                                                        String DataEntrada = documents['DataEntradaEmpresa'];
                                                        String verificadoPor = documents['verificadoPor'];

                                                        String DatadeAnalise = documents['DataDeAnalise'];

                                                        String formattedDate = horarioCriacao;
                                                        String formattedDate2 = DataEntrada;
                                                        String formattedDate3 = DatadeAnalise;

                                                        bool LacradoSaida = documents['lacreboolsaida'];
                                                        String LacrenumSaida = documents['lacrenumSaida'];

                                                        Navigator.push(context,
                                                            MaterialPageRoute(builder: (context){
                                                              return veiculoEntrada(lacre, widget.empresaName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, lacradoStr, documents.id, formattedDate2, verificadoPor, formattedDate3, interno, LacrenumSaida, LacradoSaida);
                                                            }));

                                                      }
                                                      else{
                                                        if(lacre == 'naolacrado'){

                                                          String liberadopor = documents['QuemAutorizou'];
                                                          String horarioCriacao = documents['Horario Criado'];
                                                          String nomeMotorista = documents['nomeMotorista'];
                                                          String Veiculo = documents['Veiculo'];
                                                          String PlacaVeiculo = documents['PlacaVeiculo'];
                                                          String Empresadestino = documents['Empresa'];
                                                          String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                          bool interno = documents['interno'];
                                                          String Galpao = documents['Galpão'];
                                                          String lacradoStr = documents['lacrenum'];

                                                          String DataEntrada = documents['DataEntradaEmpresa'];
                                                          String verificadoPor = documents['verificadoPor'];

                                                          String DatadeAnalise = documents['DataDeAnalise'];

                                                          String formattedDate = horarioCriacao;
                                                          String formattedDate2 = DataEntrada;
                                                          String formattedDate3 = DatadeAnalise;
                                                          bool LacradoSaida = documents['lacreboolsaida'];
                                                          String LacrenumSaida = documents['lacrenumSaida'];

                                                          Navigator.push(context,
                                                              MaterialPageRoute(builder: (context){
                                                                return veiculoEntrada(lacre, widget.empresaName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, lacradoStr, documents.id, formattedDate2, verificadoPor, formattedDate3, interno, LacrenumSaida, LacradoSaida);
                                                              }));
                                                        }
                                                      }
                                                    }

                                                    if(documents['Status'] == 'Aguardando Liberação'){


                                                      var result = await FirebaseFirestore.instance
                                                          .collection("empresa")
                                                          .get();

                                                      for (var res in result.docs) {
                                                        for (int i = result.docs.length; i >= 1; i--) {
                                                          if(i == result.docs.length){

                                                            if(res.data()['nome'] == widget.empresaName){

                                                              Galpoes.addAll(res.data()['galpaes']);

                                                              Galpoes.keys.toList();


                                                              String liberadopor = documents['QuemAutorizou'];
                                                              String horarioCriacao = documents['Horario Criado'];
                                                              String nomeMotorista = documents['nomeMotorista'];
                                                              String Veiculo = documents['Veiculo'];
                                                              String PlacaVeiculo = documents['PlacaVeiculo'];
                                                              String Empresadestino = documents['Empresa'];
                                                              String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                              String Galpao = documents['Galpão'];
                                                              String verificadoPor = documents['verificadoPor'];
                                                              String DataDeAnalise = documents['DataDeAnalise'];
                                                              String urlImage1 = documents['uriImage'];
                                                              String urlImage2 = documents['uriImage2'];
                                                              String urlImage3 = documents['uriImage3'];
                                                              String urlImage4 = documents['uriImage4'];
                                                              String motivo = documents['motivo'];

                                                              String formattedDate = horarioCriacao;

                                                              String IDEmpresa = userValues.get('idEmpresa');

                                                              Navigator.push(context,
                                                                  MaterialPageRoute(builder: (context){
                                                                    return operadorEmpresarialAguardando(lacre, widget.empresaName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, verificadoPor, DataDeAnalise, urlImage1, urlImage2, urlImage3, urlImage4, Galpoes, IDEmpresa, motivo);
                                                                  }));
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }else{

                                                    }
                                                  },
                                                  child: Text(
                                                    documents['PlacaVeiculo'],
                                                    style: TextStyle(
                                                        fontSize: tamanhotextobtns,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white
                                                    ),
                                                  )
                                              ),
                                              Center(
                                                child: Container(
                                                  padding: const EdgeInsets.all(16),
                                                  child: Text(
                                                    'Status: \n' +
                                                        documents['Status'],
                                                    style: TextStyle(
                                                        fontSize: tamanhotexto,
                                                        fontWeight: FontWeight.bold,
                                                        color: textColor
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }else{
                                      return const SizedBox(width: 0, height: 0);
                                    }
                                  }
                                  ).toList().reversed.toList(),
                                );
                              },
                            ),
                          );
                        }
                    ),
                  ],
                ),
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
                        'Operador: ${widget.name}',
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
    );
  }
}