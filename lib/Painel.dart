import 'package:flutter/material.dart';
import 'package:glk_controls/modal/cadastroEmpresa.dart';
import 'package:glk_controls/modal/cadastroUsuarioADM.dart';

//Programado por HeroRickyGames

class painelADM extends StatefulWidget {
  final String ADMName;
  const painelADM(this.ADMName);

  @override
  State<painelADM> createState() => _painelADMState();
}

class _painelADMState extends State<painelADM> {
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
              padding: EdgeInsets.all(16),
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
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

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
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

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
              padding: EdgeInsets.all(16),
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
              padding: EdgeInsets.all(16),
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
              padding: EdgeInsets.all(16),
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
