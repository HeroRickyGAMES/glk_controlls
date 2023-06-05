import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class entradaModuloPrestador extends StatefulWidget {
  String Operador;
  String URLImage;
  String NomeUser;
  String TipoDeVeiculo;
  String Empresa;
  String Telefone;
  bool vagaComum;
  bool vagaMoto;
  bool VagaDiretoria;
  String Marca;
  String Modelo;
  String Cor;
  String placa;
  String PermitidosVeiculos;
  String ID;
  String IDEmpresa;
  entradaModuloPrestador(this.Operador, this.URLImage, this.NomeUser, this.TipoDeVeiculo, this.Empresa, this.Telefone, this.vagaComum, this.vagaMoto, this.VagaDiretoria, this.Marca, this.Modelo, this.Cor, this.placa, this.PermitidosVeiculos, this.ID, this.IDEmpresa, {super.key});

  @override
  State<entradaModuloPrestador> createState() => _entradaModuloPrestadorState();
}

class _entradaModuloPrestadorState extends State<entradaModuloPrestador> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    String vaga = '';

    if(widget.vagaComum == true){
      vaga = 'Vaga';
    }
    if(widget.vagaMoto == true){
      vaga = 'Moto';
    }
    if(widget.VagaDiretoria == true){
      vaga = 'Diretoria';
    }

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
        title: Text('Entrada - Placa: ${widget.placa}'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Dados de Cadastro',
                    style: TextStyle(
                        fontSize: tamanhotextobtns,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                  width: 250,
                  height: 250,
                  padding: const EdgeInsets.all(16),
                  child: Image.network(widget.URLImage)
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Nome: ${widget.NomeUser}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Veiculo permitido: ${widget.PermitidosVeiculos}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Empresa: ${widget.Empresa}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Telefone: ${widget.Telefone}",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Permissão: $vaga",
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Veiculo Liberado',
                          style: TextStyle(
                              fontSize: tamanhotextobtns,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Marca: ${widget.Marca}',
                          style: TextStyle(
                              fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Modelo: ${widget.Modelo}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Cor: ${widget.Cor}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Placa: ${widget.placa}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Tipo de Veiculo: ${widget.TipoDeVeiculo}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Tipo de Veiculo: ${widget.TipoDeVeiculo}',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Liberar Entrada',
                      style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white60
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                              'Cancelar',
                            style: TextStyle(
                              fontSize: tamanhotexto,
                              color: Colors.black
                            ),
                          )
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green
                          ),
                          onPressed: () async {
                            if(_isChecked == false){
                              Fluttertoast.showToast(
                                msg: 'O botão liberar entrada não está checado!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: tamanhotexto,
                              );
                            }else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text('Aguarde!'),
                                    actions: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ],
                                  );
                                },
                              );

                              double vagasInterno = 0.0;
                              int vagasDeDiretoria = 0;
                              int vagasMoto = 0;

                              final EmpresaCollection = FirebaseFirestore.instance.collection('empresa');
                              final snapshot6 = await EmpresaCollection.get();
                              final EMPRESADOC = snapshot6.docs;
                              for (final NOMEDOC in EMPRESADOC) {

                                final Vagasinternos = NOMEDOC.get('vagasInterno') + 0.0;
                                final VagasDirecao = NOMEDOC.get('vagasDeDiretoria');
                                final VagasMoto = NOMEDOC.get('vagasMoto');

                                vagasInterno = Vagasinternos;
                                vagasDeDiretoria = VagasDirecao;
                                vagasMoto = VagasMoto;
                              }

                              if(widget.vagaComum == true){
                                if(widget.TipoDeVeiculo == 'Carro'){
                                  vagasInterno = vagasInterno - 1.0;
                                  print(vagasInterno);
                                }else{
                                  if(widget.TipoDeVeiculo == 'Moto'){
                                    vagasInterno = vagasInterno - 0.5;
                                  }
                                }

                              }
                              if(widget.vagaMoto == true){
                                vagasDeDiretoria = vagasDeDiretoria - 1;
                              }
                              if(widget.VagaDiretoria == true){
                                vagasMoto = vagasMoto - 1;
                              }

                              FirebaseFirestore.instance.collection('empresa').doc(widget.IDEmpresa).update({
                                'vagasInterno': vagasInterno,
                                'vagasDeDiretoria': vagasDeDiretoria,
                                'vagasMoto': vagasMoto
                              }).then((value){
                                FirebaseFirestore.instance.collection('VeiculosdePrestadores').doc(widget.ID).update({
                                  'status': 'Liberado Entrada',
                                  'lastStatus': 'Liberado Entrada'
                                }).then((value){
                                  Fluttertoast.showToast(
                                    msg: 'Pronto!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: tamanhotexto,
                                  );
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);
                                });
                              });

                            }
                          },
                          child: Text(
                            'Prosseguir',
                            style: TextStyle(
                                fontSize: tamanhotexto,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 180,
                      height: 180,
                      padding: const EdgeInsets.all(16),
                      child:
                      Image.asset(
                        'assets/sanca.png',
                        fit: BoxFit.contain,
                      )
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
