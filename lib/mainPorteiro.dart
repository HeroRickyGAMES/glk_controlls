import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/Painel.dart';
import 'package:glk_controls/listas/listaEntrada.dart';
import 'package:glk_controls/modal/modalVeiculoEdit.dart';

import 'listas/listaSaida.dart';
import 'modal/modalVeiculo.dart';


//Programado por HeroRickyGames

Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
String idDocumento = '';
List listaNome = [];
List galpao = [ ];

class mainPorteiro extends StatefulWidget {

  bool cadastro;
  bool entrada;
  bool saida;
  bool relatorio;
  bool painel;

  final String PorteiroNome;
  mainPorteiro(this.PorteiroNome, this.cadastro, this.entrada, this.saida, this.relatorio, this.painel);

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

          galpao.addAll(res.data()['galpaes']);

          print('dentro da array: ${galpao}' );
          final dropValue = ValueNotifier('');
          final dropValue2 = ValueNotifier('');

          var db = FirebaseFirestore.instance;
          var UID = FirebaseAuth.instance.currentUser?.uid;
          db.collection('Users').doc(UID).get().then((event){
            print("${event.data()}");

            event.data()?.forEach((key, value) {

              print(key);
              print(value);

              if(key == 'nome'){
                String PorteiroNomee = value;

                var db = FirebaseFirestore.instance;
                var UID = FirebaseAuth.instance.currentUser?.uid;
                db.collection('Users').doc(UID).get().then((event){
                  print("${event.data()}");

                  event.data()?.forEach((key, value) {

                    print(key);
                    print(value);

                    if(key == 'nome'){

                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return modalPorteiro(listaNome, dropValue, PorteiroNomee, '',dropValue2, galpao);

                          }));

                    }

                  });

                }
                );

              }

            });

          }
          );


        });

      });
      print(listaNome);
    }

    entradaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return listEntrada(widget.PorteiroNome);
          }));
    }

    saidaMT(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return listaSaida(widget.PorteiroNome);
          }));
    }

    relatorioMT(){
      //todo ir para o relatorio
    }

    painelMT(){

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return painelADM(widget.PorteiroNome);

          }));

    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                onPressed: widget.cadastro? openModal: null,
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
            child: ElevatedButton(
              onPressed: widget.entrada? entradaMT : null,
              child: Text(
                'Verificar Entrada',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green[700]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: widget.saida ? saidaMT : null,
              child: Text(
                'Verificar Saída',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[800]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: widget.relatorio ? relatorioMT() : null,
              child: Text(
                'Relatorio',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              style: ElevatedButton.styleFrom(
                  //primary: Colors.yellow[800]
              ),
            ),
          ),
          widget.painel ?
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: painelMT,
              child: Text(
                'Painel',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              style: ElevatedButton.styleFrom(
                //primary: Colors.yellow[800]
              ),
            ),
          ) : Text(''),
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