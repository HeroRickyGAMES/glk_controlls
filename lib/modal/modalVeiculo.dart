import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
  final String idEmpresa;
  final dropValue2;
  List galpaes;
  modalPorteiro(this.EmpresasOpc, this.dropValue, this.nomeUser, this.idEmpresa, this.dropValue2, this.galpaes);

  @override
  State<modalPorteiro> createState() => _modalPorteiroState();
}
class _modalPorteiroState extends State<modalPorteiro> {
  String? coletaouentrega;
  String? lacreounao;
  String? empresaSelecionada;

  //fields
  String? nomeMotorista;
  String? RGMotorista;
  String? Veiculo;
  String? telefone = '';
  String? VeiculoPlaca;
  String? originEmpresa;
  String? galpao;
  String? lacreSt;
  bool lacrebool = false;

  File? imageFile;
  @override
  Widget build(BuildContext context) {
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
            msg: 'Preencha o RG do motorista',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else{
          if(Veiculo == null){
            Fluttertoast.showToast(
              msg: 'Preencha tipo de veiculo!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }else{
            if(VeiculoPlaca == null){
              Fluttertoast.showToast(
                msg: 'Preencha a placa do veiculo!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }else{


            if(originEmpresa == null){
              Fluttertoast.showToast(
                msg: 'Digite a empresa de origem',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }else{
              if(galpao == null){
                Fluttertoast.showToast(
                  msg: 'Digite o galpão',
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }else{
                if(empresaSelecionada == null){
                  Fluttertoast.showToast(
                    msg: 'Selecione uma empresa!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }else{
                  if(coletaouentrega == null){
                    Fluttertoast.showToast(
                      msg: 'Selecione se é coleta ou entrega!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }else{
                    if(lacreounao == null){
                      Fluttertoast.showToast(
                        msg: 'Selecione se é com lacre ou sem!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      if(imageFile == null){
                        Fluttertoast.showToast(
                          msg: 'Tire uma foto do veiculo!',
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

                          if(lacreounao == 'lacre'){

                            //registre todos os valores no db
                            var UID = FirebaseAuth.instance.currentUser?.uid;
                            var db = FirebaseFirestore.instance;
                            db.collection('Users').doc(UID).get().then((event) {

                              event.data()?.forEach((key, value) async {


                                if(key == 'RGouCNPJ'){

                                  print(value);
                                  //put cam
                                  var dateTime= new DateTime.now();

                                  var uuid = Uuid();

                                  String idd = uuid.v4() + "${DateTime.now().toString()}";

                                  final imageUrl = await _uploadImageToFirebase(imageFile!, idd);

                                  print(imageUrl);

                                  FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
                                    'nomeMotorista': nomeMotorista,
                                    'RGDoMotorista': RGMotorista,
                                    'Veiculo': Veiculo,
                                    'PlacaVeiculo': VeiculoPlaca,
                                    'Telefone': telefone,
                                    'EmpresadeOrigin': originEmpresa,
                                    'Empresa': empresaSelecionada,
                                    'ColetaOuEntrega': coletaouentrega,
                                    'Galpão': galpao,
                                    'LacreouNao': lacreounao,
                                    'QuemAutorizou': widget.nomeUser,
                                    'Status': 'Aguardando',
                                    'Lacre': lacreSt,
                                    'lacrenum': lacreSt,
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

                          if(lacreounao == 'naolacrado'){
                            //registre todos os valores no db
                            var UID = FirebaseAuth.instance.currentUser?.uid;
                            var db = FirebaseFirestore.instance;
                            db.collection('Users').doc(UID).get().then((event) {

                              event.data()?.forEach((key, value) async {


                                if(key == 'RGouCNPJ'){

                                  print(value);
                                  //put cam
                                  var dateTime= new DateTime.now();

                                  var uuid = Uuid();

                                  String idd = uuid.v4() + "${DateTime.now().toString()}";

                                  final imageUrl = await _uploadImageToFirebase(imageFile!, idd);

                                  print(imageUrl);

                                  FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
                                    'nomeMotorista': nomeMotorista,
                                    'RGDoMotorista': RGMotorista,
                                    'Veiculo': Veiculo,
                                    'PlacaVeiculo': VeiculoPlaca,
                                    'Telefone': telefone,
                                    'EmpresadeOrigin': originEmpresa,
                                    'Empresa': empresaSelecionada,
                                    'ColetaOuEntrega': coletaouentrega,
                                    'Galpão': galpao,
                                    'LacreouNao': lacreounao,
                                    'QuemAutorizou': widget.nomeUser,
                                    'Status': 'Aguardando',
                                    'Horario Criado': dateTime,
                                    'uriImage': imageUrl,
                                    'lacrenum': '',
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
        }

      }
    }
    List<dynamic> galpaes = ['Valor 1', 'Valor 2', 'Valor 3'];
    String selectedValue = galpaes[0];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(onPressed: (){

              widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
              galpaes.removeRange(0, galpaes.length);

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
            Text('GLK Controls - Cadastro: Motorista e Veiculo'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    nomeMotorista = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome Completo do Motorista *',
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
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'RG do Motorista (Sem digitos) * ',
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
                    Veiculo = valor;
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Veiculo * ',
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

                    String valorpuro = valor.toUpperCase();
                    VeiculoPlaca = valorpuro.replaceAllMapped(
                      RegExp(r'^([a-zA-Z]{3})([0-9]{4})$'),
                          (Match m) => '${m[1]}-${m[2]}',
                    );
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Placa do Veiculo * ',
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
                    telefone = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Telefone',
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
                    originEmpresa = valor;
                    //Mudou mandou para a String
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Empresa de Origem *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Empresa destino *',
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
                      onChanged: (escolha) async {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text("É Coleta"),
                            value: "coleta",
                            groupValue: coletaouentrega,
                            onChanged: (value){
                              setState(() {
                                coletaouentrega = value.toString();
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Empresa Galpão *',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Center(
                      child: ValueListenableBuilder(valueListenable: widget.dropValue2, builder: (context, String value, _){
                        return DropdownButton(
                          hint: Text(
                            'Selecione um Galpão',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          value: (value.isEmpty)? null : value,
                          onChanged: (escolha) {
                            setState(() {
                              widget.dropValue2.value = escolha.toString();

                              galpao = escolha.toString();
                            });
                          },
                          items: widget.galpaes.map((opcao) => DropdownMenuItem(
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
                ],
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
                          "Com Lacre"
                      ),
                      value: "lacre",
                      groupValue: lacreounao,
                      onChanged: (value){
                        setState(() {
                          lacreounao = value.toString();

                          if(value == 'lacre'){
                            lacrebool = true;
                          }
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Sem Lacre",),
                      value: "naolacrado",
                      groupValue: lacreounao,
                      onChanged: (value){
                        setState(() {
                          lacreounao = value.toString();

                          if(value == 'naolacrado'){
                            lacrebool = false;
                          }
                        });
                      },
                    ),
                    lacrebool ?
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        onChanged: (valor){
                          lacreSt = valor;
                          //Mudou mandou para a String
                        },
                        //keyboardType: TextInputType.number,
                        //enableSuggestions: false,
                        //autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Numero do lacre *',
                          hintStyle: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                    )
                        :Text(''),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                    'Adicione a foto no icone abaixo',
                  style: TextStyle(
                      fontSize: 20
                  ),

                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child:
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 180,
                      height: 180,
                      padding: EdgeInsets.all(16),
                      child:
                      Image.asset(
                        'assets/icon.png',
                        fit: BoxFit.contain,
                      )
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child:
                    Text(
                      'Operador: ' + widget.nomeUser,
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
              WillPopScope(
                onWillPop: () async {
                  widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
                  galpaes.removeRange(0, galpaes.length);
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return mainPorteiro(widget.nomeUser);
                      }));
                  // retorna false para impedir que a navegação volte à tela anterior
                  return false;
                }, child: Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
