import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsuariosCadastrados extends StatefulWidget {
  String ADMName;
  String LogoPath;
  UsuariosCadastrados(this.ADMName, this.LogoPath);

  @override
  State<UsuariosCadastrados> createState() => _UsuariosCadastradosState();
}

class _UsuariosCadastradosState extends State<UsuariosCadastrados> {

  bool interno = true;
  String OperadorTipe = 'Operador Interno';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(interno == true){
      setState(() {
        OperadorTipe = 'Operador Interno';
      });
    }else{
      setState(() {
        OperadorTipe = 'Operador de Empresa';
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Usuarios Cadastrados'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: CheckboxListTile(
                title: Text(
                  OperadorTipe,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                value: interno,
                onChanged: (bool? value) {
                  setState(() {
                    interno = value!;

                    if(interno == true){
                      setState(() {
                        OperadorTipe = 'Operador Interno';
                      });
                    }else{
                      setState(() {
                        OperadorTipe = 'Operador de Empresa';
                      });
                    }

                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    "Nome",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Empresa",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Status",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
              ],
            ),
            interno == true ?  Container(
              height: 700,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('porteiro')
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
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documents['nome'],
                              style: TextStyle(
                                fontSize: 18
                                ),
                              ),
                              Text('SLG Sanca',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              Row(
                                children: [
                                  Text('Interno',
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {

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
                                                            Navigator.of(context).pop();
                                                          },
                                                              child: Text(
                                                                'Cancelar',
                                                                style: TextStyle(
                                                                    fontSize: 18
                                                                ),
                                                              )
                                                          ),
                                                          TextButton(onPressed: () async {
                                                            FirebaseFirestore.instance
                                                                .collection('porteiro')
                                                                .doc(documents['id'])
                                                                .delete().then((value){
                                                              Navigator.of(context).pop();
                                                            });
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

                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),
                                              ],
                                            )
                                        )
                                      ],
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
            ) :
            Container(
              height: 800,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('operadorEmpresarial')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((documentos) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documentos['nome'],
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              Text(documentos['empresa'],
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              Row(
                                children: [
                                  Text('Empresa',
                                    style: TextStyle(
                                        fontSize: 18
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: (){
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(documentos['nome']),
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
                                                            Navigator.of(context).pop();
                                                          },
                                                              child: Text(
                                                                'Cancelar',
                                                                style: TextStyle(
                                                                    fontSize: 18
                                                                ),
                                                              )
                                                          ),
                                                          TextButton(onPressed: () async {
                                                            FirebaseFirestore.instance
                                                                .collection('operadorEmpresarial')
                                                                .doc(documentos['id'])
                                                                .delete().then((value){
                                                              Navigator.of(context).pop();
                                                            });
                                                          },
                                                              child: Text(
                                                                'prosseguir',
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

                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),
                                              ],
                                            )
                                        )
                                      ],
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
    );
  }
}
