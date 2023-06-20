import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Programado por HeroRickyGames

class permissoes extends StatefulWidget {
  @override
  _permissoesState createState() => _permissoesState();
}

class _permissoesState extends State<permissoes> {
  bool painelbool = false;
  bool relatoriosbool = false;
  bool entradabool = false;
  bool cadastrarbool = false;
  bool saidabool = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Permissões dos Operadores Internos'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('porteiro')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((documents) {

              bool Cadastrarbl = documents['cadastrar'];
              bool saidabl = documents['saida'];
              bool entradabl = documents['entrada'];
              bool Relatoriobl = documents['relatorio'];
              bool painelbl = documents['painel'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Nome do Operador: '+ documents['nome'],
                        style: const TextStyle(
                          fontSize: 16
                        ),
                      ),
                      Column(
                        children: [
                          CheckboxListTile(
                            title: const Text('Cadastrar'),
                            value: documents['cadastrar'],
                            onChanged: (value) {
                              setState(() {
                                Cadastrarbl = value!;

                                FirebaseFirestore.instance.collection('porteiro').doc(documents.id).update({
                                  'cadastrar': Cadastrarbl
                                });
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Saida'),
                            value: saidabl,
                            onChanged: (value) {
                              setState(() {
                                saidabl = value!;
                                FirebaseFirestore.instance.collection('porteiro').doc(documents.id).update({
                                  'saida': saidabl
                                });
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Entrada'),
                            value: documents['entrada'],
                            onChanged: (value) {
                              setState(() {
                                entradabl = value!;
                                FirebaseFirestore.instance.collection('porteiro').doc(documents.id).update({
                                  'entrada': value
                                });
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Relatórios'),
                            value: documents['relatorio'],
                            onChanged: (value) {
                              setState(() {
                                Relatoriobl = value!;
                                FirebaseFirestore.instance.collection('porteiro').doc(documents.id).update({
                                  'relatorio': value
                                });
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: const Text('Painel'),
                            value: documents['painel'],
                            onChanged: (value) {
                              setState(() {
                                painelbl = value!;
                                FirebaseFirestore.instance.collection('porteiro').doc(documents.id).update({
                                  'painel': value
                                });
                              });
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                      ),
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