import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'modal/modalVeiculo.dart';


//Programado por HeroRickyGames
Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
String idDocumento = '';
List listaNome = [];

class mainPorteiro extends StatefulWidget {
  final String PorteiroNome;
  const mainPorteiro(this.PorteiroNome);

  @override
  State<mainPorteiro> createState() => _mainPorteiroState();
}

class _mainPorteiroState extends State<mainPorteiro> {

  @override
  Widget build(BuildContext context) {
    openModal() async {

      var result = await FirebaseFirestore.instance
          .collection("empresa")
          .get();
      result.docs.forEach((res) {
        print(res.data()['nome']);

        setState(() {
          listaNome.add(res.data()['nome']);

          final dropValue = ValueNotifier('');

          var db = FirebaseFirestore.instance;
          var UID = FirebaseAuth.instance.currentUser?.uid;
          db.collection('Users').doc(UID).get().then((event){
            print("${event.data()}");

            event.data()?.forEach((key, value) {

              print(key);
              print(value);

              if(key == 'nome'){
                String PorteiroNomee = value;

                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return modalPorteiro(listaNome, dropValue, PorteiroNomee);

                    }));

              }

            });

          }
          );


        });

      });
      print(listaNome);
    }

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.red[900],
        title: Container(
          child:
          Text(
              'GLK Controls - OPERADORES'
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: ElevatedButton(
                onPressed: openModal,
                  child: Text(
                      'Novo cadastro',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: TextFormField(
                onChanged: (valor){
                  //Mudou mandou para a String

                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'RG:',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(16),
            child:
            Text(
                'RG: Sem Digito',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: (){},
              child: Text(
                'Fazer busca',
                style: TextStyle(
                    fontSize: 20
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
                  'Operador: ' + widget.PorteiroNome,
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