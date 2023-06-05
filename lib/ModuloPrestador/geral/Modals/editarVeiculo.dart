import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class editarVeiculo extends StatefulWidget {
  String NomeEmpresa;
  String idEmpresa;
  String idPrestador;
  String NomePrestador;
  bool carroEmoto;
  bool carroOuMoto;
  String nomeUser;
  String OperadorName;
  String Marca;
  String Modelo;
  String Cor;
  String Placa;
  String tipodeVeiculo;
  bool Liberado;
  String ID;
  editarVeiculo(this.NomeEmpresa, this.idEmpresa, this.idPrestador, this.NomePrestador, this.carroEmoto, this.carroOuMoto, this.nomeUser, this.OperadorName, this.Marca, this.Modelo, this.Cor, this.Placa, this.tipodeVeiculo, this.Liberado, this.ID,  {Key? key}) : super(key: key);

  @override
  State<editarVeiculo> createState() => _editarVeiculoState();
}

class _editarVeiculoState extends State<editarVeiculo> {

  bool init = false;
  //Strings
  List Veiculos = [];
  String marca = '';
  String modelo = '';
  String cor = '';
  String VeiculoPlaca = '';
  String Veiculo = '';

  //bools
  bool liberado = false;

  //Controlador
  TextEditingController placaveiculointerface = TextEditingController();
  TextEditingController marcainterface = TextEditingController();
  TextEditingController modelointerface = TextEditingController();
  TextEditingController corinterface = TextEditingController();

  //dropvalues
  final dropValue = ValueNotifier('');

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

    if(init == false){

      marca = widget.Marca;
      modelo = widget.Modelo;
      cor = widget.Cor;
      VeiculoPlaca = widget.Placa;
      Veiculo = widget.tipodeVeiculo;
      liberado = widget.Liberado;

      placaveiculointerface = TextEditingController(text: VeiculoPlaca);
      marcainterface = TextEditingController(text: marca);
      modelointerface = TextEditingController(text: modelo);
      corinterface = TextEditingController(text: cor);
    }

    if(widget.carroEmoto == true){
      Veiculos = [
        'Carro',
        'Moto',
      ];
    }else{
      if(widget.carroOuMoto == false){
        Veiculos = [
          'Moto',
        ];
      }else{
        if(widget.carroOuMoto == true){
          Veiculos = [
            'Carro',
          ];
        }
      }
    }

    init == true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Cadastro de Veiculo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Dados do veiculo; ${widget.NomePrestador}',
                    style: TextStyle(
                        fontSize: tamanhotextobtns,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: marcainterface,
                  onChanged: (valor){
                    marca = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Marca * ',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: modelointerface,
                  onChanged: (valor){
                    modelo = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Modelo * ',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: corinterface,
                  onChanged: (valor){
                    cor = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Cor *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: placaveiculointerface,
                  onChanged: (valor){
                    String valorpuro = valor.toUpperCase();
                    if(valorpuro.length == 7){
                      VeiculoPlaca = valorpuro.replaceAllMapped(
                        RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                            (Match m) => '${m[1]} ${m[2]}',
                      );
                      placaveiculointerface.text = VeiculoPlaca;
                    }
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Placa *',
                    hintStyle: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                    return DropdownButton(
                      hint: Text(
                        'Tipo de Veiculo *',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      value: (value.isEmpty)? Veiculo : value,
                      onChanged: (escolha) async {
                        dropValue.value = escolha.toString();

                        Veiculo = escolha.toString();

                      },
                      items: Veiculos.map((opcao) => DropdownMenuItem(
                        value: opcao,
                        child:
                        Text(
                          opcao,
                          style: TextStyle(
                              fontSize: tamanhotexto
                          ),
                        ),
                      ),
                      ).toList(),
                    );
                  })
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Permissão',
                      style: TextStyle(
                          fontSize: tamanhotexto
                      ),
                    )
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(
                        'Liberado',
                        style: TextStyle(
                          fontSize: tamanhotexto,
                        ),
                      ),
                      value: liberado,
                      onChanged: (value) {
                        setState(() {
                          if(value == true){
                            liberado = true;
                          }
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(
                        'Bloqueado',
                        style: TextStyle(
                          fontSize: tamanhotexto,
                        ),
                      ),
                      value: !liberado,
                      onChanged: (value) {
                        setState(() {
                          if(value == true){
                            liberado = false;
                          }
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text(
                          'Cancelar',
                          style: TextStyle(
                              fontSize: tamanhotextobtns,
                              color: Colors.black
                          ),
                        ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[300]
                          ),
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(onPressed: () async {
                          if(marca == ''){
                            Fluttertoast.showToast(
                              msg: 'Preencha a marca!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: tamanhotexto,
                            );
                          }else{
                            if(modelo == ''){
                              Fluttertoast.showToast(
                                msg: 'Preencha o modelo!',
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: tamanhotexto,
                              );
                            }else{
                              if(cor == ''){
                                Fluttertoast.showToast(
                                  msg: 'Preencha a cor!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: tamanhotexto,
                                );
                              }else{
                                if(VeiculoPlaca == ''){
                                  Fluttertoast.showToast(
                                    msg: 'Preencha a placa do veiculo!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: tamanhotexto,
                                  );
                                }else{
                                  if(VeiculoPlaca.length != 8){
                                    Fluttertoast.showToast(
                                      msg: 'A placa do veiculo está escrita errada!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: tamanhotexto,
                                    );
                                  }else{
                                    if(Veiculo == ''){
                                      Fluttertoast.showToast(
                                        msg: 'Selecione o tipo de veiculo!',
                                        toastLength: Toast.LENGTH_SHORT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: tamanhotexto,
                                      );
                                    }else{
                                      FirebaseFirestore.instance.collection('VeiculosdePrestadores').doc(widget.ID).update({
                                        'PlacaVeiculo': VeiculoPlaca,
                                        'idPertence': widget.idPrestador,
                                        'Modelo': modelo,
                                        'Marca': marca,
                                        'cor': cor,
                                        'TipoDeVeiculo': Veiculo,
                                        'Liberado': liberado,
                                        'idEmpresa': widget.idEmpresa,
                                        'Empresa': widget.NomeEmpresa,
                                        'PertenceA': widget.NomePrestador,
                                      }).whenComplete((){
                                        Navigator.pop(context);
                                      });
                                    }
                                  }
                                }
                              }
                            }
                          }
                        },style: ElevatedButton.styleFrom(
                            primary: Colors.green[800]
                        ), child: Text(
                          'Salvar',
                          style: TextStyle(
                              fontSize: tamanhotextobtns
                          ),
                        )
                        )
                    ),
                  ),
                ],
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
                          'Operador: ${widget.OperadorName}',
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
