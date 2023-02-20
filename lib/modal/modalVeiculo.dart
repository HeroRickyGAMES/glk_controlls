import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../mainPorteiro.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

//Programado Por HeroRickyGames

class modalPorteiro extends StatefulWidget {
  final List<dynamic> EmpresasOpc;
  final dropValue;
  final String nomeUser;
  modalPorteiro(this.EmpresasOpc, this.dropValue, this.nomeUser);

  @override
  State<modalPorteiro> createState() => _modalPorteiroState();
}
class _modalPorteiroState extends State<modalPorteiro> {
  String? coletaouentrega;
  String? lacreounao;
  String? empresaSelecionada;

  String? cpfoucnpj;

  //fields
  String? CNHst;
  String? nomeMotorista;
  String? RGMotorista;
  String? PlacaVeiculo;

  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    var cnhController = TextEditingController();
    final motoristaController = TextEditingController();
    final cpfMotoristaController = TextEditingController();
    final placaDoVeiculoController = TextEditingController();
    final FirebaseStorage storage = FirebaseStorage.instance;

    Future<File?> _getImageFromCamera() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      return File(pickedFile!.path);
    }
    Future<String> _uploadImageToFirebase(File file, String id) async {
      // Crie uma referência única para o arquivo
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);

      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }
    
    Future<void> _uploadImage() async {
      imageFile = await _getImageFromCamera();
      if (imageFile != null) {
        setState(() {
          imageFile = imageFile;


        });

        print(imageFile);

        // Salve a URL do download da imagem no banco de dados
      }
    }
    uploadInfos(){
      if(empresaSelecionada == null){
        Fluttertoast.showToast(
          msg: 'Selecione a empresa!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else{
        print('Empresa selecionada $empresaSelecionada');

        if(CNHst == null){
          Fluttertoast.showToast(
            msg: 'Preencha a CNH do motorista!',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else{

          if(nomeMotorista == null){
            Fluttertoast.showToast(
              msg: 'Preencha o nome do motorista!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }else{

            if(RGMotorista == null){

              Fluttertoast.showToast(
                msg: 'Preencha o RG do motorista!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );

            }else{
              if(coletaouentrega == null){

                Fluttertoast.showToast(
                  msg: 'Selecione se é Coleta ou Entrega',
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );

              }else{

                if(lacreounao == null){

                  Fluttertoast.showToast(
                    msg: 'Selecione se está entrando com lacre ou não!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );

                }else{

                  if(PlacaVeiculo == null){

                    Fluttertoast.showToast(
                      msg: 'Preencha o Campo da Placa do veiculo!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

                  }else{

                    if(imageFile == null){
                      Fluttertoast.showToast(
                        msg: 'Por favor, tire uma foto do veiculo!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{

                      Fluttertoast.showToast(
                        msg: 'Enviando informações para o servidor...',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      //registre todos os valores no db
                      var UID = FirebaseAuth.instance.currentUser?.uid;
                      var db = FirebaseFirestore.instance;
                      db.collection('Users').doc(UID).get().then((event) {

                        event.data()?.forEach((key, value) async {


                          if(key == 'RGouCNPJ'){

                            print(value);

                            cpfoucnpj = value;

                            //put cam
                            var dateTime= new DateTime.now();

                            var uuid = Uuid();

                            String idd = uuid.v4();

                            final imageUrl = await _uploadImageToFirebase(imageFile!, idd);

                            print(imageUrl);

                            FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
                              'Empresa': empresaSelecionada,
                              'ColetaOuEntrega': coletaouentrega,
                              'LacreouNao': lacreounao,
                              'CNHMotorista': CNHst,
                              'nomeMotorista': nomeMotorista,
                              'RGDoMotorista': RGMotorista,
                              'QuemAutorizou': widget.nomeUser,
                              'CPFcnpjAutorizou': cpfoucnpj,
                              'PlacaDoVeiculo': PlacaVeiculo,
                              'Status': 'Autorizado pela Portaria',
                              'Horario Criado': dateTime,
                              'uriImage': imageUrl
                            }).then((value) {

                              Fluttertoast.showToast(
                                msg: 'Enviado com sucesso!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

                              var db = FirebaseFirestore.instance;
                              var UID = FirebaseAuth.instance.currentUser?.uid;
                              db.collection('Users').doc(UID).get().then((event){
                                print("${event.data()}");

                                event.data()?.forEach((key, value) {

                                  print(key);
                                  print(value);

                                  if(key == 'nome'){
                                    String PorteiroNome = value;

                                    print('Porteiro name é' + PorteiroNome);

                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return mainPorteiro(PorteiroNome);
                                        }));

                                  }

                                });

                              }
                              );

                            });
                          }

                        }
                        );

                      }
                      );

                    }
                  }
                }

              }

            }

          }

        }

      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(onPressed: (){

              widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

              var db = FirebaseFirestore.instance;
              var UID = FirebaseAuth.instance.currentUser?.uid;
              db.collection('Users').doc(UID).get().then((event){
                print("${event.data()}");

                event.data()?.forEach((key, value) {

                  print(key);
                  print(value);

                  if(key == 'nome'){
                    String PorteiroNome = value;

                    print('Porteiro name é' + PorteiroNome);

                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return mainPorteiro(PorteiroNome);
                        }));

                  }

                });

              }
              );
            },
                child:
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
            ),
            Text('GLK Controls - Adicionar novo motorista'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Selecione a Empresa que o motorista irá entrar',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                  return DropdownButton(
                    hint: Text(
                        'Selecione uma empresa',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    value: (value.isEmpty)? null : value,
                    onChanged: (escolha) {
                      widget.dropValue.value = escolha.toString();

                      empresaSelecionada = escolha.toString();
                    },
                    items: widget.EmpresasOpc.map((opcao) => DropdownMenuItem(
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
                padding: EdgeInsets.only(top: 16),
                child:
                Column(
                  children: [
                    Text(
                      'É Coleta ou Entrega?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    RadioListTile(
                      title: Text("É Coleta"),
                      value: "coleta",
                      groupValue: coletaouentrega,
                      onChanged: (value){
                        setState(() {
                          coletaouentrega = value.toString();
                        });
                      },
                    ),

                    RadioListTile(
                      title: Text(
                          "É Entrega"
                      ),
                      value: "entrega",
                      groupValue: coletaouentrega,
                      onChanged: (value){
                        setState(() {
                          coletaouentrega = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child:
                Column(
                  children: [
                    Text(
                      'Está Entrando com Lacre ou Sem Lacre?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    RadioListTile(
                      title: Text(
                          "Entrando com Lacre"
                      ),
                      value: "lacre",
                      groupValue: lacreounao,
                      onChanged: (value){
                        setState(() {
                          lacreounao = value.toString();
                        });
                      },
                    ),

                    RadioListTile(
                      title: Text("Entrando sem Lacre",),
                      value: "naolacrado",
                      groupValue: lacreounao,
                      onChanged: (value){
                        setState(() {
                          lacreounao = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    CNHst = valor;
                    print(CNHst);
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'CNH do Motorista (Apenas números)',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    nomeMotorista = valor;
                    print(CNHst);
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome Completo do Motorista',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    RGMotorista = valor;
                    print(CNHst);
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'RG do Motorista (Apenas Números)',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: _uploadImage,
                      child: Text('Selecionar imagem da camera'),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    PlacaVeiculo = valor;
                    print(CNHst);
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Placa do veiculo',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              ElevatedButton(
              onPressed: uploadInfos,
              child:
              Text(
                  'Adicionar novo Motorista',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
