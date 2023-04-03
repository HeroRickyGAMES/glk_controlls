import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/modal/cadastroEmpresa.dart';
import 'package:glk_controls/modal/cadastroUsuarioADM.dart';
import 'package:glk_controls/operadorInterno.dart';
import 'package:glk_controls/permissoes/permissoes.dart';
import 'package:glk_controls/relatorio.dart';

import 'callToAPI.dart';
import 'callToAPIADM.dart';
import 'callToAPItoOFF.dart';
import 'modal/ReleModalConfig.dart';

//Programado por HeroRickyGames

class painelADM extends StatefulWidget {
  final String ADMName;
  final String LogoPath;
  const painelADM(this.ADMName, this.LogoPath);

  @override
  State<painelADM> createState() => _painelADMState();
}

class _painelADMState extends State<painelADM> {
  List listaNome = [];
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SETOR ADIMISTRATIVO - Painel'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return cadastroEmpresa();
                      }));
                },
                child:
                Text(
                  'Cadastrar Empresa',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: () async {
                  var result = await FirebaseFirestore.instance
                      .collection("empresa")
                      .get();
                  result.docs.forEach((res) {
                    print(res.data()['nome']);

                    listaNome.add(res.data()['nome'] + res.data()['id']);

                    final dropValue = ValueNotifier('');

                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return cadastroUsuarioModal(dropValue, listaNome);
                        }));

                  });
                  
                  
                },
                child:
                Text(
                  'Cadastrar Operador da Empresa',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return operadorInterno();
                      }));
                },
                child:
                Text(
                  'Cadastrar Operador Interno',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return permissoes();
                      }));
                },
                child:
                Text(
                  'Permissões',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return relatorio(widget.ADMName);
                      }));
                },
                child:
                Text(
                  'Relatorios Gerais',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Ligação de Relês'),
                        actions: [
                          TextFormField(
                            onChanged: (valor){
                              pass = valor;
                              //Mudou mandou para a String
                            },
                            keyboardType: TextInputType.name,
                            enableSuggestions: false,
                            obscureText: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Senha',
                              hintStyle: TextStyle(
                                  fontSize: 20
                              ),
                            ),
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

                                  if(pass == ''){

                                    Fluttertoast.showToast(
                                        msg: 'Preencha a senha!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey[600],
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                  }else{
                                    if(pass == '1234'){

                                      getReleAPI1adm();

                                    }else{
                                      Fluttertoast.showToast(
                                          msg: 'Senha invalida!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey[600],
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  }
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
                child:
                Text(
                  'Ligar Relês',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Ligação de Relês'),
                        actions: [
                          TextFormField(
                            onChanged: (valor){
                              pass = valor;
                              //Mudou mandou para a String
                            },
                            keyboardType: TextInputType.name,
                            enableSuggestions: false,
                            obscureText: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Senha',
                              hintStyle: TextStyle(
                                  fontSize: 20
                              ),
                            ),
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

                                  if(pass == ''){

                                    Fluttertoast.showToast(
                                        msg: 'Preencha a senha!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey[600],
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                  }else{
                                    if(pass == '1234'){

                                      getReleAPI5();

                                    }else{
                                      Fluttertoast.showToast(
                                          msg: 'Senha invalida!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey[600],
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  }
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
                child:
                Text(
                  'Desligar Relês',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: () async {
                  var result = await FirebaseFirestore.instance
                      .collection("Server")
                      .doc('serverValues')
                      .get();
                  String urlRele = (result.get('URLRele'));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return releModalConfig(urlRele);
                      }));
                },
                child:
                Text(
                  'Configurações de Relês',
                  style: TextStyle(
                      fontSize: 20
                  ),
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
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child:
                  Image.network(
                    widget.LogoPath,
                    fit: BoxFit.contain,
                  ),
              ),
              Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child:
                Text(
                  'ADM : ' + widget.ADMName,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
