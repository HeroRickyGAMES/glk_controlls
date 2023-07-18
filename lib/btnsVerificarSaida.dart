import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/listas/listaSaida.dart';

//Programado por HeroRickyGames

class btnsVerificarSaida extends StatefulWidget {
  String PorteiroName;
  btnsVerificarSaida(
      this.PorteiroName,
      {Key? key}):
        super(key: key);

  @override
  State<btnsVerificarSaida> createState() => _btnsVerificarSaidaState();
}

class _btnsVerificarSaidaState extends State<btnsVerificarSaida> {

  String Saida = '';
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Qual entrada está operando?'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: (){

                      Saida = 'Rele02';

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return listaSaida(widget.PorteiroName, Saida, '');
                          }));
                    },
                    child: Text(
                      'Saida 01',
                      style: TextStyle(
                          fontSize: tamanhotextobtns
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 500,
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: (){

                      Saida = 'Rele04';

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return listaSaida(widget.PorteiroName, Saida, '');
                          }));
                    },
                    child: Text(
                      'Saida 02',
                      style: TextStyle(
                          fontSize: tamanhotextobtns
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
