import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CadastroDoOperador extends StatefulWidget {
  String EmpresaNome = '';
  String EmpresaID = '';
  File? imageFile;
  CadastroDoOperador(this.EmpresaNome, this.EmpresaID, this.imageFile,{Key? key}) : super(key: key);

  @override
  State<CadastroDoOperador> createState() => _CadastroDoOperadorState();
}

class _CadastroDoOperadorState extends State<CadastroDoOperador> {

  TextEditingController nameAllcaps = TextEditingController();
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

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;
    File? imageFile = widget.imageFile;
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

    salvarmt(){

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
                var dateTime= DateFormat('MM-dd-yyyy HH:mm:ss').format(DateTime.now()).replaceAll('-', '/');

                var uuid = const Uuid();

                String idd = "${DateTime.now().toString()}${uuid.v4()}";
                FirebaseFirestore.instance.collection('Prestadores').doc(idd).set({
                  'nome': nome,
                  'RG': RG,
                  'Telefone': telefone,
                  'carro': carroOuMoto,
                  'moto': moto,
                  'carroEmoto': carroEmoto,
                  'vagaComum': VagaComum,
                  'vagaMoto': VagaMoto,
                  'VagaDiretoria': VagaDiretoria,
                  'Liberado': Liberado
                }).then((value){

                });
              }
            }
          }
        }
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
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
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
                child: TextFormField(
                  onChanged: (valor){
                    RG = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'RG (Sem Digito)*',
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
                child: TextFormField(
                  onChanged: (valor){
                    telefone = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Telefone *',
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
                      onChanged: (value) {
                        setState(() {

                          if(value == true){
                            PreenchidoTipoVeiculo = true;
                            moto = false;
                            carroOuMoto = true;
                            carroEmoto = false;
                          }

                        });
                      },
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
                      onChanged: (value) {
                        setState(() {

                          if(value == true){
                            PreenchidoTipoVeiculo = true;
                            moto = true;
                            carroOuMoto = false;
                            carroEmoto = false;
                          }

                        });
                      },
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
                      onChanged: (value) {
                        setState(() {

                          if(value == true){
                            PreenchidoTipoVeiculo = true;
                            moto = false;
                            carroOuMoto = false;
                            carroEmoto = true;
                          }

                        });
                      },
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
                        onChanged: (value) {
                          setState(() {

                            if(value == true){
                              PreenchidoPermissao = true;
                              VagaMoto = false;
                              VagaComum = true;
                              VagaDiretoria = false;
                            }

                          });
                        },
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
                        onChanged: (value) {
                          setState(() {

                            if(value == true){
                              PreenchidoPermissao = true;
                              VagaMoto = true;
                              VagaComum = false;
                              VagaDiretoria = false;
                            }

                          });
                        },
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
                        onChanged: (value) {
                          setState(() {

                            if(value == true){
                              PreenchidoPermissao = true;
                              VagaMoto = false;
                              VagaComum = false;
                              VagaDiretoria = true;
                            }

                          });
                        },
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
                        onChanged: (value) {
                          setState(() {

                            if(value == true){
                              bloqueadoBool = false;
                              PreenchidoBloqueado = true;
                              Liberado = true;
                            }

                          });
                        },
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
                        onChanged: (value) {
                          setState(() {

                            if(value == true){
                              bloqueadoBool = true;
                              PreenchidoBloqueado = true;
                              Liberado = false;
                            }

                          });
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
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
                              'Operador: ${widget.EmpresaNome}',
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
            ],
          ),
        ),
      ),
    );
  }
}
