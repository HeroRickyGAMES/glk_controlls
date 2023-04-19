import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/Painel.dart';

//Programado por HeroRickyGames

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
        title: const Text('SETOR ADIMISTRATIVO'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                const Text(
                  'Cadastrar',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                const Text(
                  'Entrada',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                const Text(
                  'Saída',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){

                },
                child:
                const Text(
                  'Relatorio',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {

                  var result = await FirebaseFirestore.instance
                      .collection("Condominio")
                      .doc('condominio')
                      .get();

                  String logoPath = result.get('imageURL');

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return painelADM(widget.ADMName, logoPath);
                      }));

                },
                child:
                const Text(
                  'Painel',
                  style: TextStyle(
                      fontSize: 16
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
                  padding: const EdgeInsets.all(16),
                  child:
                  Image.asset(
                    'assets/icon.png',
                    fit: BoxFit.contain,
                  )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child:
                Text(
                  'ADM : ' + widget.ADMName,
                  style: const TextStyle(
                      fontSize: 16
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
