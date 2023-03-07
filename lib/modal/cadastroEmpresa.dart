import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<String> tags = [];
class cadastroEmpresa extends StatefulWidget {
  const cadastroEmpresa({Key? key}) : super(key: key);

  @override
  State<cadastroEmpresa> createState() => _cadastroEmpresaState();
}

class _cadastroEmpresaState extends State<cadastroEmpresa> {
  @override
  Widget build(BuildContext context) {

    final _textController = TextEditingController();
    final respNameController = TextEditingController();
    final telNumController = TextEditingController();

    print(tags);

    void _addTag(String tag) {
      if (tag.isNotEmpty) {
        setState(() {
          tags.add(tag);
        });
        _textController.clear();
      }
    }

    void _removeTag(String tag) {
      setState(() {
        tags.remove(tag);
      });
    }

    String empresaName = '';
    String galpaoNum = '';
    String respName = '';
    String telNum = '';
    String email = '';
    String pass = '';
    List<String> lista = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Empresas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  'Preencha o campo de Dias primeiro!\n(Aperte Enter quando adicionar um dia)',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: tags.map((tag) {
                        return InputChip(
                          label: Text(tag),
                          onDeleted: () => _removeTag(tag),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      controller: _textController,
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Dias em que a empresa pode usar o relatorio',
                        hintStyle: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      onFieldSubmitted: _addTag,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  onChanged: (valor){
                    empresaName = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome da Empresa *',
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
                    galpaoNum = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Quantidade de Galpões (Preencha depois de preencher o nome da empresa por favor!) *',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: (){
                    int number = int.parse(galpaoNum);

                    Fluttertoast.showToast(
                      msg: 'Calculando.',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 20,
                    );
                    for (int i = number; i >= 1; i--) {
                      print(i);
                      lista.add('G-0${i} ' + empresaName);
                      print(lista);
                    }
                  },
                  child: Text(
                      'Calcular quantidade de Galpões',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: respNameController,
                  onChanged: (valor){
                    respName = valor.toUpperCase();
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Responsável pela Empresa * ',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  controller: telNumController,
                  onChanged: (valor){
                    respNameController.text = respName;


                    String valorpuro = valor.toUpperCase();
                    telNum = valorpuro.replaceAllMapped(
                      RegExp(r'^([0-9]{2})([0-9]{5})([0-9]{4})$'),
                          (Match m) => '${m[1]} ${m[2]}-${m[3]} ',
                    );
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Telefone',
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
                    telNumController.text = telNum;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
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
                    hintText: 'Senha',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {

                        if(empresaName == ''){
                          Fluttertoast.showToast(
                            msg: 'Preencha o nome da empresa!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 20,
                          );
                        }else{
                          if(galpaoNum == ''){
                            Fluttertoast.showToast(
                              msg: 'Preencha a quantidade de galpões disponiveis!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 20,
                            );
                          }else{
                            if(respName == ''){
                              Fluttertoast.showToast(
                                msg: 'Preencha o nome do responsavel pela Empresa!',
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
                                    msg: 'Preencha o email da empresa!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 20,
                                  );
                                }else{
                                  if(pass == ''){
                                    Fluttertoast.showToast(
                                      msg: 'Preencha a senha da empresa!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 20,
                                    );
                                  }else{

                                     if(tags.isEmpty){
                                       Fluttertoast.showToast(
                                         msg: 'Adicione pelo menos um dia!',
                                         toastLength: Toast.LENGTH_SHORT,
                                         timeInSecForIosWeb: 1,
                                         backgroundColor: Colors.black,
                                         textColor: Colors.white,
                                         fontSize: 20,
                                       );

                                     }else{

                                       FirebaseApp app = await Firebase.initializeApp(
                                           name: 'Secondary', options: Firebase.app().options);
                                       try {
                                         UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
                                             .createUserWithEmailAndPassword(email: email, password: pass);

                                         Fluttertoast.showToast(
                                           msg: 'Cadastrando empresa...',
                                           toastLength: Toast.LENGTH_SHORT,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Colors.black,
                                           textColor: Colors.white,
                                           fontSize: 20,
                                         );
                                         FirebaseFirestore.instance.collection('empresa').doc(userCredential.user?.uid).set(
                                             {
                                               'nome': empresaName,
                                               'galpaes': lista,
                                               'NameResponsavel': respName,
                                               'Telefone': telNum,
                                               'email': email,
                                               'tipoConta': 'empresa',
                                               'estaativo': true,
                                               'RelatorioDays': tags,
                                               'id': userCredential.user?.uid
                                             }
                                         );
                                         FirebaseFirestore.instance.collection('Users').doc(userCredential.user?.uid).set(
                                             {
                                               'nome': empresaName,
                                               'galpaes': lista,
                                               'NameResponsavel': respName,
                                               'Telefone': telNum,
                                               'email': email,
                                               'tipoConta': 'empresa',
                                               'estaativo': true,
                                               'id': userCredential.user?.uid,
                                               'RelatorioDays': tags,
                                             }
                                         ).then((value) {
                                           Fluttertoast.showToast(
                                             msg: 'Empresa cadastrada com sucesso!',
                                             toastLength: Toast.LENGTH_SHORT,
                                             timeInSecForIosWeb: 1,
                                             backgroundColor: Colors.black,
                                             textColor: Colors.white,
                                             fontSize: 20,
                                           );

                                           tags.removeRange(0, tags.length);
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
                        }
                  },
                    child: Text(
                        'Confirmar cadastro',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
