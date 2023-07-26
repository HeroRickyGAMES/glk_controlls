import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/CameraModulo/camera_comum/Camera.dart';
import 'package:glk_controls/callToAPI.dart';
import 'package:glk_controls/modal/veiculoAguardando.dart';
import 'package:glk_controls/pesquisaDir/pesquisa.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

//Programado por HeroRickyGames

class listEntrada extends StatefulWidget {
  String porteiroName;
  String Entrada;
  String PreFillPesquisa;
  listEntrada(this.porteiroName, this.Entrada, this.PreFillPesquisa, {Key? key}) : super(key: key);

  @override
  State<listEntrada> createState() => _listEntradaState();
}

class _listEntradaState extends State<listEntrada> {
  String? idDocumento;
  TextEditingController placaveiculointerface = TextEditingController();
  bool started = false;
  String holderPlaca = '';
  String oqPesquisar = '';
  @override
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
            .where('Status', isEqualTo: 'Liberado Entrada')
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
        title: const Text('GLK Controls - ENTRADA'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                                      .where('Status', isEqualTo: 'Liberado Entrada')
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
                                        return CameraComum(widget.Entrada, widget.porteiroName, '');
                                      }));
                                }: null,
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
                                  .where('Status', isEqualTo: 'Liberado Entrada')
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
                              .where('Status', isEqualTo: 'Liberado Entrada')
                              .where(oqPesquisar, isEqualTo: holderPlaca)
                              .snapshots():
                          FirebaseFirestore
                              .instance
                              .collection('Autorizacoes')
                              .where('Status', isEqualTo: 'Liberado Entrada')
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

                                        String lacre = '${documents['LacreouNao']}';
                                        String ColetaOuEntrega = '${documents['ColetaOuEntrega']}';
                                        bool lacrebool = false;
                                        bool coletaBool = false;
                                        String lacrado = '';
                                        String ColetaOuEntregast = '';
                                        idDocumento = documents.id;

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
                                                      if(documents['Status'] == 'Liberado Entrada'){

                                                        String liberadopor = documents['QuemAutorizou'];
                                                        String horarioCriacao = documents['Horario Criado'];
                                                        String nomeMotorista = documents['nomeMotorista'];
                                                        String Veiculo = documents['Veiculo'];
                                                        String PlacaVeiculo = documents['PlacaVeiculo'];
                                                        String Empresadestino = documents['Empresa'];
                                                        String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                        String Galpao = documents['galpaoPrimario'];
                                                        String verificadoPor = documents['verificadoPor'];
                                                        String RGMotorista = documents['RGDoMotorista'];
                                                        bool lacreboolLigado = documents['lacreboolLigado'];
                                                        String formattedDate2 = '';

                                                        if(documents['PlacaVeiculo'].contains('(AG)')){


                                                          if(int.parse(DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/').replaceAll('/', '').replaceAll(":", "").replaceAll(" ", "")) >= int.parse(documents['DataEntradaEmpresa'].replaceAll('/', '').replaceAll(' ', '').replaceAll(':', ''))){


                                                            formattedDate2 = documents['DataEntradaEmpresa'];

                                                            String formattedDate = horarioCriacao;


                                                            final ByteData imageData = await rootBundle.load('assets/error-image.png');

                                                            final Uint8List uint8List = imageData.buffer.asUint8List();

                                                            final compressedImage = await FlutterImageCompress.compressWithList(
                                                              uint8List,
                                                              quality: 85, // ajuste a qualidade da imagem conforme necessário
                                                            );

                                                            final tempDir = await getTemporaryDirectory();
                                                            final file = File('${tempDir.path}/imagem.jpg');
                                                            await file.writeAsBytes(compressedImage);

                                                            final file2 = File('${tempDir.path}/imagem.jpg');
                                                            await file2.writeAsBytes(compressedImage);

                                                            final file3 = File('${tempDir.path}/imagem.jpg');
                                                            await file3.writeAsBytes(compressedImage);

                                                            final file4 = File('${tempDir.path}/imagem.jpg');
                                                            await file4.writeAsBytes(compressedImage);



                                                            var result = await FirebaseFirestore.instance
                                                                .collection("Condominio")
                                                                .doc('condominio')
                                                                .get();

                                                            Map tags = (result.get('tags'));
                                                            List tagsDisponiveis = [];

                                                            bool semSaida = documents['semSaida'];

                                                            tags.removeWhere((key, value) => value == 'Usado');
                                                            tagsDisponiveis.addAll(tags.keys);

                                                            List<int> numerosInt = tags.keys.toList().map((e) => int.parse(e)).toList();

                                                            numerosInt.sort();

                                                            List<String> numerosOrdenados = numerosInt.map((e) => e.toString()).toList();

                                                            Navigator.push(context,
                                                                MaterialPageRoute(builder: (context){
                                                                  return veiculoAguardando(lacre, widget.porteiroName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, file, file2, file3, file4, formattedDate2, numerosOrdenados, widget.Entrada, RGMotorista, semSaida, lacreboolLigado);
                                                                }));

                                                          }

                                                        }else{

                                                          String DataEmpresaAnalise = documents['DataEntradaEmpresa'];
                                                          formattedDate2 = DataEmpresaAnalise;

                                                          String formattedDate = horarioCriacao;


                                                          final ByteData imageData = await rootBundle.load('assets/error-image.png');

                                                          final Uint8List uint8List = imageData.buffer.asUint8List();

                                                          if(kIsWeb){
                                                            Fluttertoast.showToast(
                                                              msg: 'Essa função não está disponivel para a versão web do app, por favor, tente com a versão mobile do App!',
                                                              toastLength: Toast.LENGTH_LONG,
                                                              timeInSecForIosWeb: 5,
                                                              backgroundColor: Colors.black,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0,
                                                            );
                                                          }else{
                                                            final compressedImage = await FlutterImageCompress.compressWithList(
                                                              uint8List,
                                                              quality: 85, // ajuste a qualidade da imagem conforme necessário
                                                            );

                                                            final tempDir = await getTemporaryDirectory();
                                                            final file = File('${tempDir.path}/imagem.jpg');
                                                            await file.writeAsBytes(compressedImage);

                                                            final file2 = File('${tempDir.path}/imagem.jpg');
                                                            await file2.writeAsBytes(compressedImage);

                                                            final file3 = File('${tempDir.path}/imagem.jpg');
                                                            await file3.writeAsBytes(compressedImage);

                                                            final file4 = File('${tempDir.path}/imagem.jpg');
                                                            await file4.writeAsBytes(compressedImage);

                                                            String RGMotorista = documents['RGDoMotorista'];

                                                            var result = await FirebaseFirestore.instance
                                                                .collection("Condominio")
                                                                .doc('condominio')
                                                                .get();

                                                            Map tags = (result.get('tags'));

                                                            List tagsDisponiveis = [];

                                                            tags.removeWhere((key, value) => value == 'Usado');

                                                            tagsDisponiveis.addAll(tags.keys.toList());

                                                            List<int> numerosInt = tags.keys.toList().map((e) => int.parse(e)).toList();

                                                            numerosInt.sort();

                                                            List<String> numerosOrdenados = numerosInt.map((e) => e.toString()).toList();

                                                            bool semSaida = documents['semSaida'];

                                                            Navigator.push(context,
                                                                MaterialPageRoute(builder: (context){
                                                                  return veiculoAguardando(lacre, widget.porteiroName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, file, file2, file3, file4, formattedDate2, numerosOrdenados, widget.Entrada, RGMotorista, semSaida, lacreboolLigado);
                                                                }));
                                                          }
                                                        }
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
                                    }
                                    ).toList().reversed.toList(),
                                  );
                                },
                              ),
                            );
                          }
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {

                              String Entrada = widget.Entrada;
                              String Senha = '';

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Liberação Manual."),
                                    actions: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: TextFormField(
                                          onChanged: (valor){
                                            Senha = valor;
                                            //Mudou mandou para a String
                                          },
                                          obscureText: true,
                                          keyboardType: TextInputType.visiblePassword,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Senha',

                                            hintStyle: TextStyle(
                                                fontSize: 16
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red[800]
                                            ),
                                            child: const Text(
                                                "Cancelar",
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {

                                              if(Senha == ""){
                                                Fluttertoast.showToast(
                                                  msg: 'Preencha a senha!',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              }else{
                                                if(Senha == "glk@12345678\$"){

                                                  Fluttertoast.showToast(
                                                    msg: 'Ligando reles!',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );

                                                  var result = await FirebaseFirestore.instance
                                                      .collection("Reles")
                                                      .doc(Entrada)
                                                      .get();


                                                  //rele 1
                                                  if(result.get('localAplicacao1') == "Cancela"){
                                                    //Verifica a função dos outros relês

                                                    if(result.get('funcao-rele1').contains('Pulso')){


                                                      rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                    }else{
                                                      releCancelaEntrada();
                                                    }

                                                    if(result.get('localAplicacao2') == 'Fechamento'){

                                                      if(result.get('funcao-rele2').contains('Pulso')){

                                                        rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFechamento02();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao2') == 'Farol'){
                                                      if(result.get('funcao-rele2').contains('Pulso')){

                                                        rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFechamento02();
                                                      }
                                                    }

                                                    //Verifica a função dos outros relês

                                                    if(result.get('localAplicacao3') == 'Fechamento'){
                                                      if(result.get('funcao-rele3').contains('Pulso')){

                                                        rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol03();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao3') == 'Farol'){

                                                      if(result.get('funcao-rele3').contains('Pulso')){

                                                        rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol03();
                                                      }
                                                    }

                                                    //Verifica a função dos outros relês


                                                    if(result.get('localAplicacao4') == 'Fechamento'){
                                                      if(result.get('funcao-rele4').contains('Pulso')){

                                                        rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol04();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao4') == 'Farol'){
                                                      if(result.get('funcao-rele4').contains('Pulso')){

                                                        rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol04();
                                                      }
                                                    }
                                                  }

                                                  //rele 2

                                                  if(result.get('localAplicacao2') == "Cancela"){
                                                    if(result.get('funcao-rele2').contains('Pulso')){

                                                      rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                    }else{
                                                      await Future.delayed(const Duration(seconds: 5));
                                                      releFarol02();
                                                    }

                                                    if(result.get('localAplicacao1') == 'Fechamento'){

                                                      if(result.get('funcao-rele1').contains('Pulso')){

                                                        rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releCancelaEntrada();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao1') == 'Farol'){

                                                      if(result.get('funcao-rele1').contains('Pulso')){
                                                        rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releCancelaEntrada();
                                                      }
                                                    }

                                                    //Verifica a função dos outros relês

                                                    if(result.get('localAplicacao3') == 'Fechamento'){

                                                      if(result.get('funcao-rele3').contains('Pulso')){

                                                        rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol03();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao3') == 'Farol'){

                                                      if(result.get('funcao-rele3').contains('Pulso')){

                                                        rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));

                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol03();
                                                      }
                                                    }

                                                    //Verifica a função dos outros relês

                                                    if(result.get('localAplicacao4') == 'Fechamento'){
                                                      if(result.get('funcao-rele4').contains('Pulso')){

                                                        rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol04();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao4') == 'Farol'){
                                                      if(result.get('funcao-rele4').contains('Pulso')){

                                                        rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol04();
                                                      }
                                                    }

                                                  }


                                                  //Rele3

                                                  if(result.get('localAplicacao3') == "Cancela"){
                                                    if(result.get('localAplicacao1') == 'Fechamento'){

                                                      if(result.get('funcao-rele1').contains('Pulso')){

                                                        rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releCancelaEntrada();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao1') == 'Farol'){

                                                      if(result.get('funcao-rele1').contains('Pulso')){
                                                        rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releCancelaEntrada();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao2') == 'Fechamento'){

                                                      if(result.get('funcao-rele2').contains('Pulso')){

                                                        rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFechamento02();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao2') == 'Farol'){
                                                      if(result.get('funcao-rele2').contains('Pulso')){

                                                        rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFechamento02();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao4') == 'Fechamento'){
                                                      if(result.get('funcao-rele4').contains('Pulso')){

                                                        rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol04();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao4') == 'Farol'){
                                                      if(result.get('funcao-rele4').contains('Pulso')){

                                                        rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol04();
                                                      }
                                                    }
                                                  }

                                                  //rele 4

                                                  if(result.get('localAplicacao4') == 'Cancela'){
                                                    if(result.get('funcao-rele4').contains('Pulso')){

                                                      rele4comDelay(int.parse(result.get('funcao-rele4').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                    }else{
                                                      await Future.delayed(const Duration(seconds: 5));
                                                      releFarol04();
                                                    }

                                                    if(result.get('localAplicacao1') == 'Fechamento'){

                                                      if(result.get('funcao-rele1').contains('Pulso')){

                                                        rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releCancelaEntrada();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao1') == 'Farol'){

                                                      if(result.get('funcao-rele1').contains('Pulso')){
                                                        rele1comDelay(int.parse(result.get('funcao-rele1').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releCancelaEntrada();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao2') == 'Fechamento'){

                                                      if(result.get('funcao-rele2').contains('Pulso')){

                                                        rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFechamento02();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao2') == 'Farol'){
                                                      if(result.get('funcao-rele2').contains('Pulso')){

                                                        rele2comDelay(int.parse(result.get('funcao-rele2').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFechamento02();
                                                      }
                                                    }

                                                    if(result.get('localAplicacao3') == 'Fechamento'){

                                                      if(result.get('funcao-rele3').contains('Pulso')){

                                                        rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol03();
                                                      }

                                                    }

                                                    if(result.get('localAplicacao3') == 'Farol'){

                                                      if(result.get('funcao-rele3').contains('Pulso')){

                                                        rele3comDelay(int.parse(result.get('funcao-rele3').replaceAll('Pulso', '').replaceAll(' ', '').replaceAll('s', '')));
                                                      }else{
                                                        await Future.delayed(const Duration(seconds: 5));
                                                        releFarol03();
                                                      }
                                                    }
                                                  }
                                                  Navigator.of(context).pop();

                                                }else{
                                                  Fluttertoast.showToast(
                                                    msg: 'Senha invalida',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green[800]
                                            ),
                                            child: const Text(
                                                "Prosseguir",
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red[800]
                            ),
                            child: const Text(
                              'Liberação Manual',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
                        'Operador: ${widget.porteiroName}',
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
