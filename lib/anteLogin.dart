import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'PainelAdministrativo/painelAdmin.dart';
import 'login.dart';

class anteLogin extends StatelessWidget {
  const anteLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String User = '';
    String pass = '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GLK Controls')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return login();
                    }));
              },
              child: Text(
                  'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.yellow[700]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Painel Administrativo'),
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'User',
                            hintStyle: TextStyle(
                                fontSize: 20
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                                fontSize: 20
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
                              child: Text('Cancelar'),
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
                                              return painelAdmin();
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
                              child: Text('Prosseguir'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Painel',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey
              ),
            ),
          ),
        ],
      ),
    );
  }
}
