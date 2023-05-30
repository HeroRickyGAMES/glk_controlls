import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:glk_controls/login.dart';
import 'package:glk_controls/PainelAdministrativo/painelAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class anteLogin extends StatefulWidget {
  String logoCondominio;
  anteLogin(this.logoCondominio, {Key? key}) : super(key: key);

  @override
  State<anteLogin> createState() => _anteLoginState();
}

class _anteLoginState extends State<anteLogin> {


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setarComoOnline() async {

    final SharedPreferences prefs = await _prefs;

    await prefs.setBool('OfflineMode', false);

  }

  @override
  Widget build(BuildContext context) {
    String User = '';
    String pass = '';

    double tamanhotexto = 20;
    double tamanhotextomin = 16;
    double tamanhotextobtns = 16;
    double aspect = 1.0;

    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final textScaleFactor = mediaQueryData.textScaleFactor;
    final dpi = mediaQueryData.devicePixelRatio;

    final textHeight = screenHeight * 0.05;
    final textWidth = screenWidth * 0.8;

    final textSize = (textHeight / dpi / 2) * textScaleFactor;
    final textSizeandroid = (textWidth / dpi / 15) * textScaleFactor;
    final textSizeandroidbtn = (textWidth / dpi / 13) * textScaleFactor;

    if(kIsWeb){
      tamanhotexto = textSize;
      tamanhotextobtns = textSize;
      tamanhotextomin = 16;
      //aspect = 1.0;
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = textSizeandroid;
        tamanhotextobtns = textSizeandroidbtn;
        aspect = 0.8;

      }
    }

    setarComoOnline();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GLK Controls')
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: 500,
              child: Image.asset(
                  'assets/icon.png',
                width: 200,
                height: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 500,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return const login();
                      }));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.yellow[700]
                ),
                child: Text(
                    'Login',
                  style: TextStyle(
                    fontSize: tamanhotexto,
                    color: Colors.black
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 500,
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
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'User',
                              hintStyle: TextStyle(
                                  fontSize: tamanhotexto
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
                              border: const OutlineInputBorder(),
                              hintText: 'Senha',
                              hintStyle: TextStyle(
                                  fontSize: tamanhotexto
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
                                        fontSize: tamanhotexto
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
                                          fontSize: tamanhotexto
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
                                              fontSize: tamanhotexto
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
                                            fontSize: tamanhotexto
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
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey
                ),
                child: Text(
                  'Painel',
                  style: TextStyle(
                      fontSize: tamanhotexto,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: 500,
              child: Image.network(
                widget.logoCondominio,
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
