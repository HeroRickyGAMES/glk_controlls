import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/PesquisaPlacaSaida.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/pesquisaColaborador.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/pesquisaCriarVeiculo.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/pesquisaPlaca.dart';
import 'package:glk_controls/ModuloPrestador/relatorio/relatorio.dart';

//Programado por HeroRickyGames

class mainPorteiroInternoPrestador extends StatefulWidget {
  String Operador;
  String LogoPath;
  bool listaColaborador;
  bool relatorioColaborador;
  mainPorteiroInternoPrestador(this.Operador, this.LogoPath, this.listaColaborador, this.relatorioColaborador, {Key? key}) : super(key: key);

  @override
  State<mainPorteiroInternoPrestador> createState() => _mainPorteiroInternoPrestadorState();
}

class _mainPorteiroInternoPrestadorState extends State<mainPorteiroInternoPrestador> {
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
      aspect = 1.0;

    }else{
      if(Platform.isAndroid){

        tamanhotexto = textSizeandroid;
        tamanhotextobtns = textSizeandroidbtn;
        aspect = 0.8;

      }
    }

    cadastrodoVeiculo(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return pesquisaCriarVeiculo(widget.Operador, '');
          }));
    }

    EntradaColaborador(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return PesquisaPlaca(widget.Operador, '');
          }));
    }

    saidaColaborador(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return PesquisaPlacaSaida(widget.Operador, '');
          }));
    }

    listaDeColaboradores(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return pesquisaColaborador(widget.Operador, '');
          }));
    }

    relatorioColaborador(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return Relatorio(widget.Operador, widget.LogoPath);
          }));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acesso interno'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: cadastrodoVeiculo,
                  child: Text(
                    'Cadastro do Veiculo',
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
                  onPressed: EntradaColaborador,
                  child: Text(
                    'Entrada Colaborador',
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
                  onPressed: saidaColaborador,
                  child: Text(
                    'Saida Colaborador',
                    style: TextStyle(
                        fontSize: tamanhotextobtns
                    ),
                  ),
                ),
              ),
              widget.listaColaborador == true? Container(
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: listaDeColaboradores,
                  child: Text(
                    'Lista de Colaboradores',
                    style: TextStyle(
                        fontSize: tamanhotextobtns
                    ),
                  ),
                ),
              ):Container(),
              widget.relatorioColaborador == true? Container(
                width: 500,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
                child: ElevatedButton(
                  onPressed: relatorioColaborador,
                  child: Text(
                    'Relatorio de colaboradores',
                    style: TextStyle(
                        fontSize: tamanhotextobtns
                    ),
                  ),
                ),
              ): Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    padding: const EdgeInsets.all(16),
                    child:
                    Image.network(
                      widget.LogoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child:
                    Column(
                      children: [
                        Text(
                          'Operador: ${widget.Operador}',
                          style: TextStyle(
                              fontSize: tamanhotexto
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
      ),
    );
  }
}
