import 'package:flutter/material.dart';
import 'package:glk_controls/modal/cadastroUsuarioADM.dart';

class setorADM extends StatefulWidget {
  final String ADMName;
  const setorADM(this.ADMName);

  @override
  State<setorADM> createState() => _setorADMState();
}

class _setorADMState extends State<setorADM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SETOR ADIMISTRATIVO'),
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
                        return cadastroUsuarioModal();
                      }));
                },
                child:
                Text(
                  'Cadastrar',
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
                  'Entrada',
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
                  'Saída',
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
                  'Relatorio',
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
                  'Painel',
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
                  'Operador: ' + widget.ADMName,
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
