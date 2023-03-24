import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modal/modalVeiculoPesquisafill.dart';

class listaUsuarios extends StatefulWidget {
  @override
  _listaUsuariosState createState() => _listaUsuariosState();
}

class _listaUsuariosState extends State<listaUsuarios> {

  List listaNome = [];
  List galpao = [ ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lista com os Motoristas'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Motoristas')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((documents) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: Text( 'Nome do Motorista: '+ documents['nomeMotorista'],
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: Text( 'RG do motorista: '+ documents['RGDoMotorista'],
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            )
                        ),
                      ),
                      ElevatedButton(onPressed: () async {

                        //todo novo cadastro

                        var result = await FirebaseFirestore.instance
                            .collection("empresa")
                            .get();
                        for (var res in result.docs) {
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

                                        String autofillName = documents['nomeMotorista'];

                                        String autofillRG = documents['RGDoMotorista'];

                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return modalVeiculofill(listaNome, dropValue, PorteiroNomee, '',dropValue2, galpao, dropValue3, autofillName, autofillRG);

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
                        }
                        print(listaNome);

                      }, child: Text(
                          'Selecionar esse motorista',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      )
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}