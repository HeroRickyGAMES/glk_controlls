import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:glk_controls/login.dart';
import 'package:glk_controls/PainelAdministrativo/painelAdmin.dart';
class anteLogin extends StatefulWidget {
  String logoCondominio;
  anteLogin(this.logoCondominio, {Key? key}) : super(key: key);

  @override
  State<anteLogin> createState() => _anteLoginState();
}

class _anteLoginState extends State<anteLogin> {
  @override
  Widget build(BuildContext context) {
    String User = '';
    String pass = '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GLK Controls')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Image.asset(
                'assets/icon.png',
              width: 200,
              height: 200,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return const login();
                    }));
              },
              child: const Text(
                  'Login',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700]
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Painel Administrativo'),
                      actions: [
                        TextFormField(
                          onChanged: (valor){
                            User = valor;
                            //Mudou mandou para a String
                          },
                          keyboardType: TextInputType.name,
                          enableSuggestions: false,
                          obscureText: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'User',
                            hintStyle: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ),
                        TextFormField(
                          onChanged: (valor){
                            pass = valor;
                            //Mudou mandou para a String
                          },
                          keyboardType: TextInputType.visiblePassword,
                          enableSuggestions: false,
                          obscureText: true,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {

                                if(User == ''){
                                  Fluttertoast.showToast(
                                      msg: 'Preencha o usuario!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[600],
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else{

                                  if(pass == ''){

                                    Fluttertoast.showToast(
                                        msg: 'Preencha a senha!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey[600],
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                  }else{
                                    if(User == 'GRUPOLK'){

                                      if(pass == 'GLK@12345678\$'){

                                        Navigator.of(context).pop();

                                        Navigator.pop(context);
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return const painelAdmin();
                                            }));

                                      }else{
                                        Fluttertoast.showToast(
                                            msg: 'Senha invalida!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey[600],
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }

                                    }else{
                                      Fluttertoast.showToast(
                                          msg: 'Usuario invalido!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey[600],
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  }
                                }
                              },
                              child: const Text('Prosseguir'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                'Painel',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Image.network(
              widget.logoCondominio,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
