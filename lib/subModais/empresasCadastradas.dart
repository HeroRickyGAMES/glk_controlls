import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class empresaCadastrada extends StatefulWidget {
  String ADMName;
  String LogoPath;

  @override
  empresaCadastrada(this.ADMName, this.LogoPath);
  _empresaCadastradaState createState() => _empresaCadastradaState();
}

class _empresaCadastradaState extends State<empresaCadastrada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Empresas cadastradas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Image.asset(
                      'assets/icon.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                        child: Text(
                        'Empresas',
                          style: TextStyle(
                              fontSize: 18
                          ),
                       ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Vagas',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 500,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('empresa')
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
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)
                              ),
                            ),
                            width: double.infinity,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          documents['nome'],
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      Text(
                                        documents['vagas'],
                                        style: TextStyle(
                                            fontSize: 18
                                        ),
                                      ),
                                      ElevatedButton(onPressed: () async {

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(documents['nome']),
                                              actions: [
                                                Center(
                                                  child: Text(
                                                      'Deseja Excluir?',
                                                    style: TextStyle(
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(onPressed: (){
                                                      Navigator.of(context);
                                                    },
                                                        child: Text(
                                                            'Cancelar',
                                                          style: TextStyle(
                                                              fontSize: 18
                                                          ),
                                                        )
                                                    ),
                                                    TextButton(onPressed: () async {
                                                      var result = await FirebaseFirestore.instance
                                                          .collection("Condominio")
                                                          .doc('condominio')
                                                          .get();

                                                      List galpoesUsados = result.get('galpoesUsados');
                                                      int galpoesRestantes = result.get('galpoes');
                                                      List galpoes = documents['galpaes'];

                                                      print(galpoesUsados);

                                                      int vagasDisp = result.get('vagas');

                                                      int galpoesRestantesResult = galpoesRestantes + galpoes.length;

                                                      galpoesUsados.remove(galpoes[0]);

                                                      int number = galpoesUsados.length;

                                                      for (int i = number; i >= 1; i--) {

                                                        if(i == galpoesUsados.length){

                                                          int resultadoVagas = vagasDisp + int.parse(documents['vagas']);

                                                          print(galpoesUsados);
                                                          print(documents['id']);

                                                          FirebaseFirestore.instance
                                                              .collection('empresa')
                                                              .doc(documents['id'])
                                                              .delete().then((value){
                                                            FirebaseFirestore.instance.collection('Condominio').doc('condominio').update({
                                                              'galpoesUsados': galpoesUsados,
                                                              'vagas': resultadoVagas,
                                                              'galpoes': galpoesRestantesResult
                                                            }).then((value){
                                                            });
                                                          });
                                                        }
                                                      }
                                                    },
                                                        child: Text(
                                                            'Prosseguir',
                                                          style: TextStyle(
                                                              fontSize: 18
                                                          ),
                                                        )
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );

                                      }, child: Icon(Icons.delete),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                      child:
                      Image.network(
                        widget.LogoPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                      child:
                      Text(
                        'ADM : ' + widget.ADMName,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}