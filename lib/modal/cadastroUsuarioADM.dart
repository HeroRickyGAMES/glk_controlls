import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class cadastroUsuarioModal extends StatefulWidget {
  var dropValue;
  List listaNome;


  cadastroUsuarioModal(this.dropValue, this.listaNome);

  @override
  State<cadastroUsuarioModal> createState() => _cadastroUsuarioModalState();
}

class _cadastroUsuarioModalState extends State<cadastroUsuarioModal> {
  @override
  Widget build(BuildContext context) {

    String nomeComp = '';
    String RG = '';
    String telNum = '';
    String email = '';
    String pass = '';
    String? empresaSelecionada;
    String? IDSe;
    String? NamesE;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Operadores de Empresas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    nomeComp = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome Completo *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    RG = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'RG * ',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    telNum = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Telefone *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    email = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    pass = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.visiblePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Senha * ',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Empresa do Operador *',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                    return DropdownButton(
                      hint: Text(
                        'Selecione uma empresa',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue.value = escolha.toString();

                        empresaSelecionada = escolha.toString();

                      },
                      items: widget.listaNome.map((opcao) => DropdownMenuItem(
                        value: opcao,
                        child:
                        Text(
                          opcao,
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ),
                      ).toList(),
                    );
                  })
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () async {

                      if(nomeComp == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o nome completo!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 20,
                          );
                      }else{

                        if(RG == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o RG!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 20,
                          );
                        }else{
                          if(telNum == ''){

                            Fluttertoast.showToast(
                              msg: 'Preencha o telefone!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 20,
                            );

                          }else{
                            if(email == ''){
                              Fluttertoast.showToast(
                                msg: 'Preencha o email!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 20,
                              );
                            }else{
                              if(empresaSelecionada == ''){
                                Fluttertoast.showToast(
                                  msg: 'Selecione a empresa que o Operador irá trabalhar!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 20,
                                );
                              }else{
                                if(pass == ''){
                                  Fluttertoast.showToast(
                                    msg: 'Preencha a senha!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 20,
                                  );
                                }else{

                                  var result = await FirebaseFirestore.instance
                                      .collection("empresa")
                                      .get();
                                  result.docs.forEach((res) {
                                    print(res.data()['nome']);

                                    setState(() {
                                      
                                      IDSe = res.data()['id'];
                                      NamesE = res.data()['nome'];


                                    });

                                  });

                                  FirebaseApp app = await Firebase.initializeApp(
                                      name: 'Secondary', options: Firebase.app().options);
                                  try {
                                    UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
                                        .createUserWithEmailAndPassword(email: email, password: pass);

                                    Fluttertoast.showToast(
                                      msg: 'Cadastrando Operador Empresarial...',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 20,
                                    );
                                    FirebaseFirestore.instance.collection('operadorEmpresarial').doc(userCredential.user?.uid).set(
                                        {
                                          'nome': nomeComp,
                                          'RG': RG,
                                          'Telefone': telNum,
                                          'email': email,
                                          'tipoConta': 'operadorEmpresarial',
                                          'empresa': empresaSelecionada?.replaceAll(IDSe as Pattern, ''),
                                          'idEmpresa': empresaSelecionada?.replaceAll(NamesE as Pattern, ''),
                                          'estaativo': true,
                                          'id': userCredential.user?.uid
                                        }
                                    );
                                    FirebaseFirestore.instance.collection('Users').doc(userCredential.user?.uid).set(
                                        {
                                          'nome': nomeComp,
                                          'RG': RG,
                                          'Telefone': telNum,
                                          'email': email,
                                          'tipoConta': 'operadorEmpresarial',
                                          'empresa': empresaSelecionada?.replaceAll(IDSe as Pattern, ''),
                                          'idEmpresa': empresaSelecionada?.replaceAll(NamesE as Pattern, ''),
                                          'estaativo': true,
                                          'id': userCredential.user?.uid
                                        }
                                    ).then((value) {
                                      Fluttertoast.showToast(
                                        msg: 'Operador Empresarial cadastrado com sucesso!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 20,
                                      );
                                      Navigator.pop(context);
                                    });

                                  }
                                  on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                      msg: e.message.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 20,
                                    );
                                  }
                                  await app.delete();

                                }
                              }
                            }
                          }
                        }

                      }
                    },
                    child: Text(
                      'Confirmar cadastro',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
