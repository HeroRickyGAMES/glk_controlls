import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class meusAgendamentosActivity extends StatefulWidget {
  const meusAgendamentosActivity({Key? key}) : super(key: key);

  @override
  State<meusAgendamentosActivity> createState() => _meusAgendamentosActivityState();
}

class _meusAgendamentosActivityState extends State<meusAgendamentosActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 1000,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Autorizacoes')
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),

                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Placa: ${documents['PlacaVeiculo']}',
                            style: const TextStyle(
                                fontSize: 16
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: (){

                                  },
                                  child: const Icon(Icons.edit)
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 16),
                                child: ElevatedButton(
                                    onPressed: (){
                                      
                                    },
                                    child: const Icon(Icons.delete)
                                ),
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
        ),
      ),
    );
  }
}
