import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class cadastroVeiculoInterno extends StatefulWidget {
  String idEmpresa;
  cadastroVeiculoInterno(this.idEmpresa, {Key? key}) : super(key: key);

  @override
  State<cadastroVeiculoInterno> createState() => _cadastroVeiculoInternoState();
}

class _cadastroVeiculoInternoState extends State<cadastroVeiculoInterno> {
  String placaVeiculo = '';
  String Veiculo = '';
  List VeiculoOPC = [
    'Caminhão',
    'Caminhonete',
    'Carro de passeio',
    'Moto',
  ];
  TextEditingController placaveiculointerface = TextEditingController();
  final dropValue = ValueNotifier('');

  @override
  Widget build(BuildContext context) {

    double tamanhotexto = 20;
    double tamanhotextobtns = 16;

    if(kIsWeb){
      tamanhotexto = 25;
      tamanhotextobtns = 34;
    }else{
      if(Platform.isAndroid){

        tamanhotexto = 16;
        tamanhotextobtns = 18;

      }
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Veiculos internos'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (valor){

                String valorpuro = valor.toUpperCase();
                placaVeiculo = valorpuro.replaceAllMapped(
                  RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                      (Match m) => '${m[1]} ${m[2]}',
                );
                //Mudou mandou para a String
              },
              controller: placaveiculointerface,
              keyboardType: TextInputType.name,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Placa * ',
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
                    'Selecione um veiculo *',
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  ),
                  value: (value.isEmpty)? null : value,
                  onChanged: (escolha) async {
                    dropValue.value = escolha.toString();

                    Veiculo = escolha.toString();
                    placaveiculointerface.text = placaVeiculo;
                  },
                  items: VeiculoOPC.map((opcao) => DropdownMenuItem(
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
              child: ElevatedButton(
                  onPressed: (){
                    FirebaseFirestore.instance.collection('veiculosDeEmpresa').doc().set({
                      'Placa': placaVeiculo,
                      'tipodeVeiculo': Veiculo,
                      'idEmpresa': widget.idEmpresa
                    }).then((value){
                      Navigator.pop(context);
                    });
                  },
                  child:
                  Text(
                      'Prosseguir',
                    style: TextStyle(
                      fontSize: tamanhotextobtns
                    ),
                  )
              )
          ),
        ],
      ),
    );
  }
}
