import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CadastroCondominio extends StatefulWidget {

  var dropValue;
  File? imageFile;
  File? imageFile2;
  String empresa = '';
  String endereco = '';
  String cep = '';
  String cidade = '';
  String estadoSelecionado = '';
  String galpaost = '';
  String vagas = '';
  String tags = '';
  CadastroCondominio(this.dropValue, this.imageFile, this.imageFile2, this.empresa, this.endereco, this.cep, this.cidade, this.estadoSelecionado, this.galpaost, this.vagas, this.tags, {super.key});

  @override
  State<CadastroCondominio> createState() => _CadastroCondominioState();
}

class _CadastroCondominioState extends State<CadastroCondominio> {


  String empresa = '';
  String endereco = '';
  String cep = '';
  String cidade = '';
  String estadoSelecionado = '';
  String galpaost = '';
  String vagas = '';
  int tags = 0;
  bool tirado = false;

  List EmpresasOpc = [
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Distrito Federal',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Roraima',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins',
  ];

  @override
  Widget build(BuildContext context) {
    File? imageFile = widget.imageFile;
    File? imageFile2 = widget.imageFile2;

    empresa = widget.empresa;
    endereco = widget.endereco;
    cep = widget.cep;
    cidade = widget.cidade;
    galpaost = widget.galpaost;
    vagas = widget.vagas;

    TextEditingController empresaController = TextEditingController(text: widget.empresa);
    TextEditingController enderecoController = TextEditingController(text: widget.endereco);
    TextEditingController cepController = TextEditingController(text: widget.cep);
    TextEditingController cidadeController = TextEditingController(text: widget.cidade);
    TextEditingController galpaoController = TextEditingController(text: widget.galpaost);
    TextEditingController vagasController = TextEditingController(text: widget.vagas);

    double tamanhotexto = 16;
    double tamanhotextobtns = 18;

    final FirebaseStorage storage = FirebaseStorage.instance;

    Future<File?> _getImageFromCamera() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      return File(pickedFile!.path);
    }
    Future<void> _uploadImage() async {
      imageFile = await _getImageFromCamera();
      setState(() {

        tirado = true;

        imageFile = imageFile;
        imageFile2 = imageFile;
        widget.imageFile = imageFile;
        widget.imageFile2 = imageFile2;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(''),
              actions: [
                TextButton(onPressed: (){
                  _uploadImage();
                },
                  child: Image.file(imageFile!,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                      child: const Text('Prosseguir'),
                    ),
                  ],
                ),
              ],
            );
          },
        );

      });
    }

    Future<String> _uploadImageToFirebase(File file, String id) async {
      // Crie uma referência única para o arquivo

      Fluttertoast.showToast(
          msg: 'Fazendo upload do logo para o banco de dados!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.white,
          fontSize: 16.0
      );

      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);

      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configuração do Condominio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(''),
                            actions: [
                              TextButton(onPressed: (){
                                _uploadImage();
                                Navigator.of(context).pop();
                              },
                                child: Image.file(imageFile!,),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {

                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Prosseguir'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Logo',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                  Image.file(
                    imageFile2!,
                    width: 200,
                    height: 200,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                  'Empresa: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: empresaController,
                onChanged: (valor){
                  setState(() {
                    empresa = valor;
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Empresa *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Endereço: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: enderecoController,
                onChanged: (valor){
                  endereco = valor;
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Endereço *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'CEP: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: cepController,
                onChanged: (valor){
                  cep = valor;
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'CEP *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Cidade: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: cidadeController,
                onChanged: (valor){
                  cidade = valor;
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cidade *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Center(
                child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                  return DropdownButton(
                    hint: const Text(
                      'Estado',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    value: (value.isEmpty)? null : value,
                    onChanged: (escolha) async {
                      widget.dropValue.value = escolha.toString();

                      estadoSelecionado = escolha.toString();

                    },
                    items: EmpresasOpc.map((opcao) => DropdownMenuItem(
                      value: opcao,
                      child:
                      Text(
                        opcao,
                        style: const TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ),
                    ).toList(),
                  );
                })
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Quantidade de Galpões: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: galpaoController,
                onChanged: (valor){
                  galpaost = valor;
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de Galpões *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Quantidade de Vagas: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: vagasController,
                onChanged: (valor){
                  vagas = valor;
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de Vagas *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Quantidade de TAGS: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  tags = int.parse(valor);
                  //Mudou mandou para a String
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de TAGS *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red
                    ),
                      child: Text(
                          'Cancelar',
                        style: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {

                      if(empresa == ''){
                        Fluttertoast.showToast(
                            msg: 'Preencha o campo de Empresa',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey[600],
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        if(endereco == ''){
                          Fluttertoast.showToast(
                              msg: 'Preencha o campo do Endereço',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey[600],
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          if(cep == ''){
                            Fluttertoast.showToast(
                                msg: 'Preencha o campo do CEP',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey[600],
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else{
                            if(cidade == ''){
                              Fluttertoast.showToast(
                                  msg: 'Preencha o campo da cidade',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey[600],
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }else{
                              if(estadoSelecionado == ''){
                                Fluttertoast.showToast(
                                    msg: 'Selecione um Estado',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[600],
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else{
                                if(galpaost == ''){
                                  Fluttertoast.showToast(
                                      msg: 'Preencha o campo de galpão',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[600],
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else{
                                  if(vagas == ''){
                                    Fluttertoast.showToast(
                                        msg: 'Preencha o campo de vagas',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey[600],
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }else{
                                    if(tags == 0){
                                      Fluttertoast.showToast(
                                          msg: 'Preencha o campo de tags disponiveis',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey[600],
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }else{
                                      if(tirado == false){
                                        Fluttertoast.showToast(
                                            msg: 'Coloque um logo!',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey[600],
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }else{
                                        //todo para o db firebase
                                        String idd = 'condominio';

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

                                        final imageUrl = await _uploadImageToFirebase(imageFile!, idd);
                                        Map<String, String> tagsDisp = {};

                                        int number = tags;

                                        for (int i = number; i >= 1; i--) {
                                          tagsDisp.addAll({ '$i': 'naoUsado'});

                                          if(tagsDisp.length == number){
                                            FirebaseFirestore.instance.collection('Condominio').doc(idd).update({
                                              'Empresa': empresa,
                                              'Endereço': endereco,
                                              'cep': cep,
                                              'cidade': cidade,
                                              'estado': estadoSelecionado,
                                              'galpoes': int.parse(galpaost),
                                              'vagas': int.parse(vagas),
                                              'tags': tagsDisp,
                                              'imageURL': imageUrl,
                                              'maxGalpoes': int.parse(galpaost),
                                            }).then((value){
                                              Navigator.of(context).pop();
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg: 'Dados enviados com sucesso!',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey[600],
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
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
                    },
                    child:
                Text(
                    'Prosseguir',
                  style: TextStyle(
                      fontSize: tamanhotextobtns
                  ),
                )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
