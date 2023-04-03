import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

List<String> tags = [];
class cadastroEmpresa extends StatefulWidget {
  var dropValue;

  cadastroEmpresa(this.dropValue);
  @override
  State<cadastroEmpresa> createState() => _cadastroEmpresaState();
}

class _cadastroEmpresaState extends State<cadastroEmpresa> {

  String empresaName = '';
  String galpaoNum = '';
  String vagas = '';
  String respName = '';
  String telNum = '';
  List vagasList = [
    '01',
    '02',
    '03',
    '04,',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
  ];
  final _textController = TextEditingController();
  final respNameController = TextEditingController();
  final telNumController = TextEditingController();

  void _addTag(String tag) {
    if (tag.isNotEmpty) {
      setState(() {
        galpaoNum = 'G-0' +  tag;
        tags.add('G-0' + tag);
      });
      _textController.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      galpaoNum = '';
      tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Empresas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    empresaName = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome da Empresa *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
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
                            fontSize: 20
                        ),
                      ),
                      onFieldSubmitted: _addTag,
                    ),
                  ],
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                    return DropdownButton(
                      hint: Text(
                        'Quantidade de vagas *',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue.value = escolha.toString();

                        vagas = escolha.toString();

                      },
                      items: vagasList.map((opcao) => DropdownMenuItem(
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
                  controller: respNameController,
                  onChanged: (valor){
                    respName = valor.toUpperCase();
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Responsável pela Empresa * ',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
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
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(onPressed: (){
                        tags.clear();
                      },
                          child: Text(
                              'Cancelar',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () async {

                              if(empresaName == ''){
                                Fluttertoast.showToast(
                                  msg: 'Preencha o nome da empresa!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 20,
                                );
                              }else{
                                if(galpaoNum == ''){
                                  Fluttertoast.showToast(
                                    msg: 'Preencha a quantidade de galpões disponiveis!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 20,
                                  );
                                }else{
                                  if(tags.isEmpty){
                                    Fluttertoast.showToast(
                                      msg: 'Preencha a quantidade de galpões disponiveis! (Não esqueça de apertar confirmar no seu teclado!)',
                                      toastLength: Toast.LENGTH_LONG,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 20,
                                    );
                                  }else{
                                    if(respName == ''){
                                      Fluttertoast.showToast(
                                        msg: 'Preencha o nome do responsavel pela Empresa!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 20,
                                      );
                                    }else{
                                      if(telNum == ''){
                                        Fluttertoast.showToast(
                                          msg: 'Preencha o telefone!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 20,
                                        );
                                      }else{
                                        if(vagas == ''){
                                          Fluttertoast.showToast(
                                            msg: 'Preencha as vagas!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 20,
                                          );
                                        }else{
                                          var result = await FirebaseFirestore.instance
                                              .collection("Condominio")
                                              .doc('condominio')
                                              .get();

                                          List galpoesUsados = result.get('galpoesUsados');
                                          int galpoesDisponiveis = result.get('galpoes');
                                          int vagasDisponiveis = result.get('vagas');
                                          int number = tags.length;

                                          print(tags);
                                          print(galpoesUsados.contains(tags));

                                          for (int i = number; i >= 1; i--) {
                                            print(galpoesUsados);
                                            print(tags);
                                            print(i-1);

                                            if(galpoesUsados.contains(tags[i-1])){
                                              Fluttertoast.showToast(
                                                msg: 'Os Galpões Selecionados já estão sendo usados por outra empresa!',
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: 20,
                                              );
                                            }else{
                                              if(i == tags.length){
                                                Fluttertoast.showToast(
                                                  msg: 'Cadastrando empresa...',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 20,
                                                );
                                                var uuid = Uuid();

                                                String idd = "${DateTime.now().toString()}" + uuid.v4();

                                                FirebaseFirestore.instance.collection('empresa').doc(idd).set(
                                                    {
                                                      'nome': empresaName,
                                                      'galpaes': tags,
                                                      'NameResponsavel': respName,
                                                      'Telefone': telNum,
                                                      'tipoConta': 'empresa',
                                                      'id': idd,
                                                      'vagas': vagas
                                                    }
                                                ).then((value) {

                                                  int galpaoPass = tags.length;
                                                  int subtracaoGalpao = galpoesDisponiveis - galpaoPass;
                                                  int vagasSubtracao = vagasDisponiveis - int.parse(vagas);
                                                  galpoesUsados.addAll(tags);
                                                  print(galpoesUsados);
                                                  print(subtracaoGalpao);

                                                  FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                                    'galpoes': subtracaoGalpao,
                                                    'galpoesUsados': galpoesUsados,
                                                    'vagas': vagasSubtracao
                                                  }).then((value){
                                                    Fluttertoast.showToast(
                                                      msg: 'Empresa cadastrada com sucesso!',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.black,
                                                      textColor: Colors.white,
                                                      fontSize: 20,
                                                    );
                                                    tags.clear();
                                                    //Navigator.pop(context);
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
                        },
                          child: Text(
                              'Prosseguir',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
