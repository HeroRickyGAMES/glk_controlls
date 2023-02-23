import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'modal/modalVeiculo.dart';


//Programado por HeroRickyGames
Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
class mainEmpresa extends StatelessWidget {
  final String empresaName;
  const mainEmpresa(this.empresaName);
  openModal(BuildContext context){


    var db = FirebaseFirestore.instance;

    db.collection('empresa').get().then((event) {

      for(var doc in event.docs){

        doc.data().forEach((key, value) {
          print('O valores são ' + value);

          print('O valor é ' + value);

          if(key == 'nome'){

            print( 'valor com nome é' + value);

            final EmpresasOpc = [];

            EmpresasOpc.add(value);
            final dropValue = '';

            var UID = FirebaseAuth.instance.currentUser?.uid;
            var db = FirebaseFirestore.instance;
            String nomeUser;
            db.collection('Users').doc(UID).get().then((value) {

              value.data()?.forEach((key, value) {
                if(key == 'nome'){

                  print(value);
                  nomeUser = value;

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return modalPorteiro(EmpresasOpc, dropValue, nomeUser);

                      }));

                }

              });

            });
          }
        }
        );
      }
    });
    print('chegou aqui!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child:
          Text(
              'GLK Controls - Interface para Empresas'
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
                  child: Text(''),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((documents) {

                  if(documents['Empresa'] == empresaName){

                    if(documents['Status'] != 'Autorizado a Sair'){

                      String lacre = '${documents['LacreouNao']}';
                      String ColetaOuEntrega = '${documents['ColetaOuEntrega']}';
                      bool lacrebool = false;
                      bool coletaBool = false;
                      String lacrado = '';
                      String ColetaOuEntregast = '';
                      bool letGo = false;

                      late String BTNStatus = '';

                      if(documents['Status'] == 'Autorizado pela Portaria'){
                        BTNStatus = 'Autorizar Entrada';

                        letGo = false;

                      }

                      if(documents['Status'] == 'Saída Solicitada'){

                        letGo = true;

                      }

                      if(documents['Status'] == 'Autorizado a entrar na empresa'){

                        BTNStatus = 'Autorizar saida da empresa';


                      }


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
                                'Status: ' +
                                    documents['Status'],
                                style:
                                TextStyle(
                                  fontSize: 20,
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
                              letGo?
                                  Text('')
                              : ElevatedButton(
                                  onPressed: (){

                                    print(documents.id);

                                    if(documents['Status'] == 'Autorizado pela Portaria'){

                                      AlertDialog alert = AlertDialog(
                                        title: Text("Autorizar entrada?"),
                                        content: Text("Deseja autorizar entrada na empresa?"),
                                        actions: [
                                          TextButton(onPressed: (){

                                            FirebaseFirestore.instance
                                                .collection("Autorizacoes")
                                                .doc(documents.id).update({
                                              'Status': 'Autorizado a entrar na empresa'
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
                                    if(documents['Status'] == 'Autorizado a entrar na empresa'){

                                      AlertDialog alert = AlertDialog(
                                        title: Text("Autorizar saída?"),
                                        content: Text("Deseja autorizar saída na empresa?"),
                                        actions: [
                                          TextButton(onPressed: (){

                                            FirebaseFirestore.instance
                                                .collection("Autorizacoes")
                                                .doc(documents.id).update({
                                              'Status': 'Saída Solicitada'
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
                                  Text(BTNStatus)
                              ),
                            ],
                          ),
                        ),
                      );

                    }else{
                      return Text('');
                    }

                  }else{
                    return Center(
                      child: Text(''),
                    );
                  }
                }).toList(),
              );
            }
        ),
      ),
    );
  }
}
