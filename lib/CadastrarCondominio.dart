import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroCondominio extends StatefulWidget {

  var dropValue;
  File? imageFile;
  File? imageFile2;
  CadastroCondominio(this.dropValue, this.imageFile, this.imageFile2);

  @override
  State<CadastroCondominio> createState() => _CadastroCondominioState();
}

class _CadastroCondominioState extends State<CadastroCondominio> {
  @override
  Widget build(BuildContext context) {
    File? imageFile = widget.imageFile;
    File? imageFile2 = widget.imageFile2;
    String empresa = '';
    String endereco = '';
    String cep = '';
    String cidade = '';
    String estadoSelecionado = '';
    String galpaost = '';
    String vagas = '';
    String tags = '';
    bool tirado = true;

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

    final FirebaseStorage storage = FirebaseStorage.instance;

    Future<File?> _getImageFromCamera() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      return File(pickedFile!.path);
    }
    Future<void> _uploadImage() async {
      imageFile = await _getImageFromCamera();
      setState(() {

        imageFile = imageFile;
        imageFile2 = imageFile;
        widget.imageFile = imageFile;
        widget.imageFile2 = imageFile2;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
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
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                      child: Text('Prosseguir'),
                    ),
                  ],
                ),
              ],
            );
          },
        );

      });
      print(imageFile);
    }

    Future<String> _uploadImageToFirebase(File file, String id) async {
      // Crie uma referência única para o arquivo
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);

      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      print(url);
      return url;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro de Condominio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  empresa = valor;
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Empresa *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  endereco = valor;
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Endereço *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  cep = valor;
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'CEP *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  cidade = valor;
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cidade *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Center(
                child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                  return DropdownButton(
                    hint: Text(
                      'Estado',
                      style: TextStyle(
                          fontSize: 18
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
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),
                    ).toList(),
                  );
                })
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  galpaost = valor;
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de Galpões *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  vagas = valor;
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de Vagas *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  tags = valor;
                  //Mudou mandou para a String
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de TAGS *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
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
                            title: Text(''),
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
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {

                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Prosseguir'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                        'Logo',
                      style: TextStyle(
                        fontSize: 19
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Text(
                          'Cancelar',
                        style: TextStyle(
                            fontSize: 19
                        ),
                      ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red
                    ),
                  ),
                ),

                ElevatedButton(
                    onPressed: (){
                      
                    },
                    child:
                Text(
                    'Prosseguir',
                  style: TextStyle(
                      fontSize: 19
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
