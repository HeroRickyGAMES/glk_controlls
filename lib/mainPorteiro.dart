import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/Painel.dart';
import 'package:glk_controls/callToAPI.dart';
import 'package:glk_controls/listas/listaEntrada.dart';
import 'package:glk_controls/modal/modalVeiculoEdit.dart';
import 'package:glk_controls/pesquisaDir/pesquisaNovoCadastro.dart';
import 'package:glk_controls/relatorio.dart';

import 'listas/listaSaida.dart';
import 'modal/liberacaooffModal.dart';
import 'modal/modalVeiculo.dart';


//Programado por HeroRickyGames

Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
String idDocumento = '';
List listaNome = [];
List galpao = [ ];
String pass = '';

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
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return pesquisaCadastro(widget.PorteiroNome);
          }));
    }

    openModalOffline() async {

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
          final dropValue3 = ValueNotifier('');

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
                            return liberacaoOff(listaNome, dropValue, PorteiroNomee, '',dropValue2, galpao, dropValue3);

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
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return relatorio(widget.PorteiroNome);
          }));
    }

    painelMT() async {

      var result = await FirebaseFirestore.instance
          .collection("Condominio")
          .doc('condominio')
          .get();

      String logoPath = result.get('imageURL');

      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return painelADM(widget.PorteiroNome, logoPath);

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              ],
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
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
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
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
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: widget.relatorio ? relatorioMT : null,
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
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: (){

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Liberação Manual'),
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

                                          Navigator.of(context).pop();
                                          openModalOffline();

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
                    child: Text(
                      'Liberação Manual',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[800]
                    ),
                  ),
                )
              ],
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
                      'assets/sanca.png',
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
      ),
    );
  }
}