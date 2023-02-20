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
              'GLK Controls - Interface para Operadores. Usuario logado: ' + widget.PorteiroNome
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirebaseFirestore
            .instance
            .collection('Autorizacoes')
            .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children:
                    snapshot.data!.docs.map((documents) {
                      String lacre = '${documents['LacreouNao']}';
                      String ColetaOuEntrega = '${documents['ColetaOuEntrega']}';
                      bool lacrebool = false;
                      bool coletaBool = false;
                      String lacrado = '';
                      String ColetaOuEntregast = '';
                      idDocumento = documents.id;

                      if(documents['Status'] != 'Autorizado a Sair' ){
                        if(documents['Status'] != 'Autorizado a entrar na empresa'){
                        if(lacre == 'lacre'){
                          lacrebool = true;
                          lacrado = 'Lacrado';
                        }
                        if(lacre == 'naolacrado'){
                          lacrebool = false;
                          lacrado = 'Não Lacrado';
                        }
                        if(ColetaOuEntrega == 'coleta'){
                          coletaBool = true;
                          ColetaOuEntregast = 'Coleta';
                        }
                        if(ColetaOuEntrega == 'entrega'){
                          coletaBool = false;
                          ColetaOuEntregast = 'Entrega';
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey[300],
                            padding: EdgeInsets.all(16),
                            child:
                            Column(
                              children: [
                                Text(
                                  'Motorista: ' +
                                      documents['nomeMotorista'],
                                  style:
                                  TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Empresa: ' +
                                      documents['Empresa'],
                                  style:
                                  TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Quem autorizou: ' +
                                      documents['QuemAutorizou'],
                                  style:
                                  TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'CNH: ' +
                                      documents['CNHMotorista'],
                                  style:
                                  TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Placa Do Veiculo: ' +
                                      documents['PlacaDoVeiculo'],
                                  style:
                                  TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Status: ' +
                                      documents['Status'],
                                  style:
                                  TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'RG do Motorista: ' +
                                      documents['RGDoMotorista'],
                                  style:
                                  TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  lacrado,
                                  style:
                                  TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  ColetaOuEntregast,
                                  style:
                                  TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Image
                                      .network(
                                      documents['uriImage'],
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: (){

                                      print(documents.id);

                                      if(documents['Status'] == 'Saída Solicitada'){

                                          AlertDialog alert = AlertDialog(
                                            title: Text("Autorizar saída?"),
                                            content: Text("Deseja autorizar a saída?"),
                                            actions: [
                                              TextButton(onPressed: (){

                                                FirebaseFirestore.instance
                                                    .collection("Autorizacoes")
                                                    .doc(documents.id).update({
                                                  'Status': 'Autorizado a Sair'
                                                });
                                                Navigator.pop(context);

                                              },child:
                                                Text(
                                                    'Sim'
                                                ),
                                              ),
                                            ],
                                          );

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                      }
                                    },
                                    child:
                                    Text('Autorizar Saída')
                                )
                              ],
                            ),
                          ),
                        );
                        }else{
                          return Text('');
                        }
                      }else{
                        return Text('');
                      }
                    }).toList(),
                  );
            }
        ),
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () => openModal(),
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}