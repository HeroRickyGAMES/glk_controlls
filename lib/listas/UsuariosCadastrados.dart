import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        title: const Text('Usuarios Cadastrados'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: CheckboxListTile(
                title: Text(
                  OperadorTipe,
                  style: const TextStyle(
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
                padding: const EdgeInsets.all(16),
                child: const Text(
                    "Nome",
                  style: TextStyle(
                  ),
                ),
              ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Empresa",
                    style: TextStyle(
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Status",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "",
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
            if (interno == true) SizedBox(
              height: 700,
              child: StreamBuilder(
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          ),
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documents['nome'],
                              style: const TextStyle(
                                fontSize: 16
                                ),
                              ),
                              const Text('SLG Sanca',
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                              Row(
                                children: [
                                  const Text('Interno',
                                    style: TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
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
                                                      const Center(
                                                        child: Text(
                                                          'Deseja Excluir?',
                                                          style: TextStyle(
                                                              fontSize: 18
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          TextButton(onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                              child: const Text(
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
                                                              child: const Text(
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
                                              children: const [
                                                Icon(Icons.delete),
                                              ],
                                            ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Usuario: ${documents['nome']}'),
                                                      actions: [
                                                        Center(
                                                          child: Text(
                                                            'Informações do Usuario: \n Email: ${documents['email']}',
                                                            style: const TextStyle(
                                                                fontSize: 18
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            TextButton(onPressed: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                                child: const Text(
                                                                  'Cancelar',
                                                                  style: TextStyle(
                                                                      fontSize: 18
                                                                  ),
                                                                )
                                                            ),
                                                            TextButton(onPressed: () async {
                                                              Navigator.of(context).pop();
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Tem certeza que deseja resetar essa senha?'),
                                                                    actions: [
                                                                      Center(
                                                                        child: Container(
                                                                          padding: const EdgeInsets.all(16),
                                                                          child: const Text(
                                                                            'Depois de fazer essa ação, enviaremos um email para a conta cadastrada',
                                                                            style: TextStyle(
                                                                                fontSize: 18
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          TextButton(onPressed: (){
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                              child: const Text(
                                                                                'Cancelar',
                                                                                style: TextStyle(
                                                                                    fontSize: 18
                                                                                ),
                                                                              )
                                                                          ),
                                                                          TextButton(onPressed: () async {
                                                                            try {
                                                                              await FirebaseAuth.instance.sendPasswordResetEmail(email: documents['email']).then((value){
                                                                                Fluttertoast.showToast(
                                                                                  msg: 'Enviado, verifique o email para resetar a senha!',
                                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                                  timeInSecForIosWeb: 1,
                                                                                  backgroundColor: Colors.black,
                                                                                  textColor: Colors.white,
                                                                                  fontSize: 16.0,
                                                                                );
                                                                                print('enviado!');
                                                                              });
                                                                            } catch (e) {
                                                                              Fluttertoast.showToast(
                                                                                msg: 'Ocorreu um erro $e!',
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.black,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0,
                                                                              );
                                                                              print('Erro! $e');
                                                                            }
                                                                          },
                                                                              child: const Text(
                                                                                'Resetar Senha',
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
                                                                child: const Text(
                                                                  'Resetar Senha',
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
                                                children: const [
                                                  Icon(Icons.remove_red_eye),
                                                ],
                                              )
                                          ),
                                        ),
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
            ) else SizedBox(
              height: 800,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('operadorEmpresarial')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
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
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          ),
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documentos['nome'],
                                style: const TextStyle(
                                    fontSize: 16
                                ),
                              ),
                              Text(documentos['empresa'],
                                style: const TextStyle(
                                ),
                              ),
                              Row(
                                children: [
                                  const Text('Empresa',
                                    style: TextStyle(
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
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
                                                      const Center(
                                                        child: Text(
                                                          'Deseja Excluir?',
                                                          style: TextStyle(
                                                              fontSize: 18
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          TextButton(onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                              child: const Text(
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
                                                              child: const Text(
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
                                              children: const [
                                                Icon(Icons.delete),
                                              ],
                                            ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 16),
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Usuario: ${documentos['nome']}'),
                                                      actions: [
                                                        Center(
                                                          child: Text(
                                                            'Informações do Usuario: \n Email: ${documentos['email']}',
                                                            style: const TextStyle(
                                                                fontSize: 18
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            TextButton(onPressed: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                                child: const Text(
                                                                  'Cancelar',
                                                                  style: TextStyle(
                                                                      fontSize: 18
                                                                  ),
                                                                )
                                                            ),
                                                            TextButton(onPressed: () async {
                                                              Navigator.of(context).pop();
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Tem certeza que deseja resetar essa senha?'),
                                                                    actions: [
                                                                      Center(
                                                                        child: Container(
                                                                          padding: const EdgeInsets.all(16),
                                                                          child: const Text(
                                                                            'Depois de fazer essa ação, enviaremos um email para a conta cadastrada',
                                                                            style: TextStyle(
                                                                                fontSize: 18
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          TextButton(onPressed: (){
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                              child: const Text(
                                                                                'Cancelar',
                                                                                style: TextStyle(
                                                                                    fontSize: 18
                                                                                ),
                                                                              )
                                                                          ),
                                                                          TextButton(onPressed: () async {
                                                                            try {
                                                                              await FirebaseAuth.instance.sendPasswordResetEmail(email: documentos['email']).then((value){
                                                                                Fluttertoast.showToast(
                                                                                  msg: 'Enviado, verifique o email para resetar a senha!',
                                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                                  timeInSecForIosWeb: 1,
                                                                                  backgroundColor: Colors.black,
                                                                                  textColor: Colors.white,
                                                                                  fontSize: 16.0,
                                                                                );
                                                                                print('enviado!');
                                                                              });
                                                                            } catch (e) {
                                                                              Fluttertoast.showToast(
                                                                                msg: 'Ocorreu um erro $e!',
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.black,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0,
                                                                              );
                                                                              print('Erro! $e');
                                                                            }
                                                                          },
                                                                              child: const Text(
                                                                                'Resetar Senha',
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
                                                                child: const Text(
                                                                  'Resetar Senha',
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
                                                children: const [
                                                  Icon(Icons.remove_red_eye),
                                                ],
                                              )
                                          ),
                                        ),
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
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child:
                    Image.network(
                      widget.LogoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                    child:
                    Text(
                      'ADM : ' + widget.ADMName,
                      style: const TextStyle(
                          fontSize: 16
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
