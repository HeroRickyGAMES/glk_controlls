import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/geral/Modals/cadastrarVeiculoPrestador.dart';
import 'package:glk_controls/ModuloPrestador/geral/Modals/editarVeiculo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RecuperarInfos extends StatefulWidget {
  String EmpresaNome = '';
  String EmpresaID = '';
  File? imageFile;
  String Nome = '';
  String RG = '';
  String Telefone = '';
  String idd = '';
  bool PreenchidoTipoVeiculo;
  bool PreenchidoPermissao;
  bool carroOuMoto;
  bool moto;
  bool carroEmoto;
  bool VagaComum;
  bool VagaMoto;
  bool VagaDiretoria;
  bool PreenchidoBloqueado;
  bool Liberado;
  bool bloqueadoBool;
  bool isTired;
  bool poscadastro;
  String OperadorName = '';
  bool Empresa;

  RecuperarInfos(this.EmpresaNome, this.EmpresaID, this.imageFile,this.Nome, this.RG, this.Telefone, this.idd, this.PreenchidoTipoVeiculo, this.PreenchidoPermissao, this.carroOuMoto, this.moto, this.carroEmoto, this.VagaComum, this.VagaMoto, this.VagaDiretoria, this.PreenchidoBloqueado, this.Liberado, this.bloqueadoBool, this.isTired, this.poscadastro, this.OperadorName, this.Empresa, {Key? key}) : super(key: key);

  @override
  State<RecuperarInfos> createState() => _RecuperarInfosState();
}

class _RecuperarInfosState extends State<RecuperarInfos> {
  File? imageFile;
  bool initialized = false;
  TextEditingController nameAllcaps = TextEditingController();
  TextEditingController RGController = TextEditingController();
  TextEditingController TelefoneController = TextEditingController();
  String nome = '';
  String RG = '';
  String telefone = '';
  bool PreenchidoTipoVeiculo = false;
  bool PreenchidoPermissao = false;
  bool carroOuMoto = false;
  bool moto = false;
  bool carroEmoto = false;

  bool VagaComum = false;
  bool VagaMoto = false;
  bool VagaDiretoria = false;

  bool PreenchidoBloqueado = false;
  bool Liberado = false;
  bool bloqueadoBool = false;

  bool isTired = false;

  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {

    if(initialized == false){
      nameAllcaps = TextEditingController(text: widget.Nome);
      RGController = TextEditingController(text: widget.RG);
      TelefoneController = TextEditingController(text: widget.Telefone);
      nome = widget.Nome;
      RG = widget.RG;
      telefone = widget.Telefone;
      PreenchidoTipoVeiculo = widget.PreenchidoTipoVeiculo;
      PreenchidoPermissao = widget.PreenchidoPermissao;
      carroOuMoto = widget.carroOuMoto;
      moto = widget.moto;
      carroEmoto = widget.carroEmoto;

      VagaComum = widget.VagaComum;
      VagaMoto = widget.VagaMoto;
      VagaDiretoria = widget.VagaDiretoria;

      PreenchidoBloqueado = widget.PreenchidoBloqueado;
      Liberado = widget.Liberado;
      bloqueadoBool = widget.bloqueadoBool;

      isTired = widget.isTired;
      imageFile = widget.imageFile;
    }

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

    Future<File?> _getImageFromCamera() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      return File(pickedFile!.path);
    }

    Future<String> _uploadImageToFirebase(File file, String id) async {
      // Crie uma referência única para o arquivo
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/colaboradores/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);

      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }

    salvarmt() async {
      if(imageFile == null){
        Fluttertoast.showToast(
          msg: 'Ponha uma foto para esse cadastro!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: tamanhotexto,
        );
      }else{
        if(nome == ""){
          Fluttertoast.showToast(
            msg: 'Preencha o campo de nome',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: tamanhotexto,
          );
        }else{
          if(RG == ''){
            Fluttertoast.showToast(
              msg: 'Preencha o campo de RG',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: tamanhotexto,
            );
          }else{
            if(PreenchidoTipoVeiculo == false){
              Fluttertoast.showToast(
                msg: 'Preencha o tipo de veiculo!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: tamanhotexto,
              );
            }else{
              if(PreenchidoPermissao == false){
                Fluttertoast.showToast(
                  msg: 'Preencha a permissão!',
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: tamanhotexto,
                );
              }else{
                if(PreenchidoBloqueado == false){
                  Fluttertoast.showToast(
                    msg: 'Preencha se o veiculo é bloqueado ou não!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: tamanhotexto,
                  );
                }else{
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
                  final imageUrl = await _uploadImageToFirebase(imageFile!, widget.idd);

                  FirebaseFirestore.instance.collection('Prestadores').doc(widget.idd).update({
                    'nome': nome,
                    'RG': RG,
                    'Telefone': telefone,
                    'carro': carroOuMoto,
                    'moto': moto,
                    'carroEmoto': carroEmoto,
                    'vagaComum': VagaComum,
                    'vagaMoto': VagaMoto,
                    'VagaDiretoria': VagaDiretoria,
                    'Liberado': Liberado,
                    'urlImage': imageUrl,
                  }).then((value){
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  });
                }
              }
            }
          }
        }
      }
    }

    trocandoparaverdadeiro(){
      setState(() {
        isTired = true;
      });
    }

    Future<void> _uploadImage() async {
      imageFile = await _getImageFromCamera();
      setState(() {

        imageFile = imageFile;
        widget.imageFile = imageFile;
      });
      trocandoparaverdadeiro();
    }

    started() async {
      await Future.delayed(const Duration(seconds: 2));
      if(widget.poscadastro == true){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'Cadastro feito com sucesso! / Foi adicionado um botão!',
                style: TextStyle(
                    fontSize: tamanhotextobtns
                ),
              ),
              actions: [
                Center(
                  child: Column(
                    children: [
                      Text(
                          'O botão Cadastrar Veiculos foi liberado!',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text(
                          'Prosseguir',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      }
    }
    if(initialized == false){
      started();
    }


    initialized = true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Dados de cadastro'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/icon.png',
                    width: 150,
                    height: 150,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white
                          ),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: tamanhotextobtns,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: salvarmt,
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green
                        ),
                        child: Text(
                          'Salvar',
                          style: TextStyle(
                            fontSize: tamanhotextobtns,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                width: 700,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    ElevatedButton(
                      onPressed: _uploadImage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                      child:
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              'Foto *',
                              style: TextStyle(
                                  fontSize: textSize,
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Image.file(
                            imageFile!,
                            height: 265,
                            width: 200,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: widget.Empresa == false ?
                    Text(
                      'Nome: $nome',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    )
                    : TextFormField(
                  controller: nameAllcaps,
                  onChanged: (valor){
                    nome = valor.toUpperCase();
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Nome *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: widget.Empresa == false ?
                Text(
                  "RG: $RG",
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                )
                    : TextFormField(
                  controller: RGController,
                  onChanged: (valor){
                    RG = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'RG (Sem Digito) *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Empresa: ${widget.EmpresaNome}',
                  style: TextStyle(
                    fontSize: tamanhotexto,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: widget.Empresa == false ?
                Text(
                  "Telefone: $telefone",
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                )
                    :
                TextFormField(
                  controller: TelefoneController,
                  onChanged: (valor){
                    telefone = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Telefone',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Tipo de veiculo:',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(
                        'Carro',
                        style: TextStyle(
                          fontSize: tamanhotexto,
                        ),
                      ),
                      value: carroOuMoto,
                      onChanged:
                      widget.Empresa == true ? (value) {
                        setState(() {
                          if(value == true){
                            PreenchidoTipoVeiculo = true;
                            moto = false;
                            carroOuMoto = true;
                            carroEmoto = false;
                          }

                        });
                      } :null,
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(
                        'Moto',
                        style: TextStyle(
                          fontSize: tamanhotexto,
                        ),
                      ),
                      value: moto,
                      onChanged: widget.Empresa == true ? (value) {
                        setState(() {

                          if(value == true){
                            PreenchidoTipoVeiculo = true;
                            moto = true;
                            carroOuMoto = false;
                            carroEmoto = false;
                          }
                        });
                      } : null,
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(
                        'Carro + Moto',
                        style: TextStyle(
                          fontSize: tamanhotexto,
                        ),
                      ),
                      value: carroEmoto,
                      onChanged: widget.Empresa == true ? (value) {
                        setState(() {
                          if(value == true){
                            PreenchidoTipoVeiculo = true;
                            moto = false;
                            carroOuMoto = false;
                            carroEmoto = true;
                          }
                        });
                      }: null,
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Permissão:',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Vaga',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: VagaComum,
                        onChanged: widget.Empresa == true ? (value) {
                          setState(() {

                            if(value == true){
                              PreenchidoPermissao = true;
                              VagaMoto = false;
                              VagaComum = true;
                              VagaDiretoria = false;
                            }

                          });
                        }: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Vaga Moto',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: VagaMoto,
                        onChanged: widget.Empresa == true ? (value) {
                          setState(() {
                            if(value == true){
                              PreenchidoPermissao = true;
                              VagaMoto = true;
                              VagaComum = false;
                              VagaDiretoria = false;
                            }
                          });
                        } : null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Vaga Diretoria',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: VagaDiretoria,
                        onChanged: widget.Empresa == true ? (value) {
                          setState(() {
                            if(value == true){
                              PreenchidoPermissao = true;
                              VagaMoto = false;
                              VagaComum = false;
                              VagaDiretoria = true;
                            }
                          });
                        }: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Liberado',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: Liberado,
                        onChanged: widget.Empresa == true ? (value) {
                          setState(() {
                            if(value == true){
                              bloqueadoBool = false;
                              PreenchidoBloqueado = true;
                              Liberado = true;
                            }
                          });
                        }: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Bloqueado',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: bloqueadoBool,
                        onChanged: widget.Empresa == true ? (value) {
                          setState(() {
                            if(value == true){
                              bloqueadoBool = true;
                              PreenchidoBloqueado = true;
                              Liberado = false;
                            }
                          });
                        }: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Veiculos Liberado:',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('VeiculosdePrestadores')
                        .where('idPertence', isEqualTo: widget.idd)
                        //.where('Liberado', isEqualTo: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: ListView(
                          children: snapshot.data!.docs.map((documents) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Text(
                                          'Veiculo;',
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Text(
                                        '${documents['Marca']}-',
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Text(
                                        '${documents['Modelo']}-',
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Text(
                                        '${documents['cor']}-',
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Text(
                                        '${documents['PlacaVeiculo']}-',
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Text(
                                        '${documents['TipoDeVeiculo']}-',
                                        style: TextStyle(
                                          fontSize: tamanhotexto,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextButton(onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return editarVeiculo(widget.EmpresaNome, widget.EmpresaID, widget.idd, nome, carroEmoto, carroOuMoto, nome, widget.OperadorName, documents['Marca'], documents['Modelo'], documents['cor'], documents['PlacaVeiculo'], documents['TipoDeVeiculo'], documents['Liberado'], documents['id']);
                                            }));
                                      }, child: const Icon(Icons.edit),
                                      )
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: TextButton(onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Atenção!',
                                                  style: TextStyle(
                                                      fontSize: tamanhotextobtns
                                                  ),
                                                ),
                                                actions: [
                                                  Center(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            'Tem certeza que deseja cancelar esse veiculo?\nOs dados não poderão ser recuperados pós deletação!',
                                                          style: TextStyle(
                                                            fontSize: tamanhotexto
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: TextButton(onPressed: (){
                                                                Navigator.of(context).pop();
                                                              }, child: Text(
                                                                  'Cancelar',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotexto
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: TextButton(onPressed: (){
                                                                FirebaseFirestore.instance.collection('VeiculosdePrestadores').doc(documents['id']).delete().whenComplete((){
                                                                  Fluttertoast.showToast(
                                                                    msg: 'O veiculo selecionado foi deletado!',
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.black,
                                                                    textColor: Colors.white,
                                                                    fontSize: tamanhotexto,
                                                                  );
                                                                  Navigator.of(context).pop();
                                                                });
                                                              }, child: Text(
                                                                  'Prosseguir',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotexto
                                                                 ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        }, child: const Icon(Icons.delete),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return CadastrarPrestador(widget.EmpresaNome, widget.EmpresaID, widget.idd, nome, carroEmoto, carroOuMoto, nome, widget.OperadorName, RG);
                            }));
                      },
                      child: Text(
                          'Cadastrar Veiculos',
                        style: TextStyle(
                          fontSize: tamanhotextobtns,
                        ),
                      )
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                              'Operador: ${widget.OperadorName}',
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
              WillPopScope(
                onWillPop: () async {
                  setState(() async {
                    final appDirectory = await getApplicationDocumentsDirectory();
                    final filePath = '${appDirectory.path}/image.jpg';
                    File imageFilee = File(filePath);

                    await imageFilee.delete();

                    imageFile = null;
                    Navigator.pop(context);

                  });
                  return false;
                }, child: const Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
