import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glk_controls/mainEmpresa.dart';
import 'package:glk_controls/mainPorteiro.dart';

//Programado por HeroRickyGames

class registro extends StatefulWidget {
  const registro({Key? key}) : super(key: key);

  @override
  State<registro> createState() => _registroState();

}

class _registroState extends State<registro> {
  String? tipos;
  String? cnpjourg = 'Seu RG';
  String? NomeOuRazao = 'Seu Nome completo';
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final passController = TextEditingController();
  final rgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.red[900],
        title: Container(
          child:
          Text(
              'GLK Controls - Cadastro'
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child:
        Center(
          child:
          Column(
            children: [
              RadioListTile(
                title: Text(
                    "Sou um Operador",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                value: "porteiro",
                groupValue: tipos,
                onChanged: (value){
                  setState(() {
                    tipos = value.toString();
                    cnpjourg = 'Seu RG';
                    NomeOuRazao = 'Seu Nome completo';
                  });
                },
              ),

              RadioListTile(
                title: Text(
                    "Sou uma Empresa",
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                value: "empresa",
                groupValue: tipos,
                onChanged: (value){
                  setState(() {
                    tipos = value.toString();
                    cnpjourg = 'CNPJ da Empresa';
                    NomeOuRazao = 'Razão Social';
                  });
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: NomeOuRazao,
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Seu Email',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: rgController,
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: cnpjourg,
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextField(
                  controller: passController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Sua Senha',
                    hintStyle: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ElevatedButton(
                    onPressed: (){

                      if(emailController.text != ''){
                        print(emailController.text);

                        if(passController.text != ''){
                          print(passController.text);

                          if(rgController.text != ''){
                            print(rgController.text);

                            if(nomeController.text != ''){
                              print(nomeController.text);

                              if(tipos == 'porteiro'){

                                print(tipos);
                                //Fazer o cadastro no banco

                                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text).then((value) {

                                        FirebaseFirestore.instance.collection('Users').doc(value.user?.uid).set({
                                          'email': value.user?.email,
                                          'tipoConta': tipos,
                                          'RGouCNPJ': rgController.text,
                                          'nome': nomeController.text,
                                          'estaativo': false
                                        });

                                        FirebaseFirestore.instance.collection(tipos!).doc(value.user?.uid).set({
                                          'email': value.user?.email,
                                          'tipoConta': tipos,
                                          'RGouCNPJ': rgController.text,
                                          'nome': nomeController.text,
                                          'estaativo': false
                                        });

                                        print('cadastrado');

                                        AlertDialog alert = AlertDialog(
                                          title: Text("Sua conta ainda não está ativa!"),
                                          content: Text("A sua conta foi criada com sucesso! Porém ainda não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                                          actions: [
                                            TextButton(
                                                onPressed: (){
                                                  SystemNavigator.pop();
                                                },
                                                child: Text('Ok')
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
                                  );

                              }else{

                                if(tipos == 'empresa'){

                                  print(tipos);
                                  //Fazer o cadastro no banco

                                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text).then((value) {

                                    FirebaseFirestore.instance.collection('Users').doc(value.user?.uid).set({
                                      'email': value.user?.email,
                                      'tipoConta': tipos,
                                      'RGouCNPJ': rgController.text,
                                      'nome': nomeController.text,
                                      'estaativo': false
                                    });

                                    FirebaseFirestore.instance.collection(tipos!).doc(value.user?.uid).set({
                                      'email': value.user?.email,
                                      'tipoConta': tipos,
                                      'RGouCNPJ': rgController.text,
                                      'nome': nomeController.text,
                                      'estaativo': false
                                    });
                                      print('Ele é uma empresa');
                                      print('O está ativo está funcionando!');

                                      AlertDialog alert = AlertDialog(
                                        title: Text("Sua conta ainda não está ativa!"),
                                        content: Text("A sua conta foi criada com sucesso! Porém ainda não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                                        actions: [
                                          TextButton(
                                              onPressed: (){
                                                SystemNavigator.pop();
                                              },
                                              child: Text('Ok')
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
                                  );

                                }
                              }
                            }else{

                            }
                          }else{

                          }

                        }else{

                        }
                      }else{

                      }

                    },
                    child:
                    Text(
                        'Cadastrar',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    )
                ),
              )
            ],
          ),
        ),
      )
   );
  }
}
