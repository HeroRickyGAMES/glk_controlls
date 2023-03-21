import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/modal/cadastroEmpresa.dart';
import 'package:glk_controls/modal/cadastroUsuarioADM.dart';
import 'package:glk_controls/operadorInterno.dart';

//Programado por HeroRickyGames

class painelADM extends StatefulWidget {
  final String ADMName;
  const painelADM(this.ADMName);

  @override
  State<painelADM> createState() => _painelADMState();
}

class _painelADMState extends State<painelADM> {
  List listaNome = [];
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

                },
                child:
                Text(
                  'Cadastro visitantes',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 180,
                  height: 180,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child:
                  Image.asset(
                    'assets/sanca.png',
                    fit: BoxFit.contain,
                  )
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
