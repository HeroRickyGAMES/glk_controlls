import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Programado por HeroRickyGames

class veiculoEntrada extends StatefulWidget {

  String lacreounao = '';
  String empresaName = '';
  String liberadopor = '';
  String horarioCriacao;
  String nomeMotorista = '';
  String Veiculo = '';
  String PlacaVeiculo = '';
  String Empresadestino = '';
  String EmpresadeOrigin = '' ;
  String Galpao = '';
  String lacradoStr = '';
  String idDocumento = '';
  String DateEntrada = '';
  String verificadoPor = '';
  String DatadeAnalise = '';
  bool interno;
  veiculoEntrada(
      this.lacreounao,
      this.empresaName,
      this.liberadopor,
      this.horarioCriacao,
      this.nomeMotorista,
      this.Veiculo,
      this.PlacaVeiculo,
      this.Empresadestino,
      this.EmpresadeOrigin,
      this.Galpao,
      this.lacradoStr,
      this.idDocumento,
      this.DateEntrada,
      this.verificadoPor,
      this.DatadeAnalise,
      this.interno, {super.key}
      );
  @override
  State<veiculoEntrada> createState() => _veiculoEntradaState();
}

class _veiculoEntradaState extends State<veiculoEntrada> {
  bool lacrebool = false;
  String? lacreSt;

  @override
  Widget build(BuildContext context) {


    if(widget.lacreounao == 'lacre'){

      lacrebool = true;

    }

    if(widget.lacreounao == 'naolacrado'){

      lacrebool = false;

    }

    String _textoPredefinido = widget.lacradoStr;
    lacreSt = widget.lacradoStr;

    TextEditingController _textEditingController = TextEditingController(text: _textoPredefinido);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
            'GLK Controls - Entrada',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.horarioCriacao}' ,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.liberadopor,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DateEntrada}' ,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Analise na Empresa - ' + widget.empresaName,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Data: ${widget.DatadeAnalise}' ,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Entrada - ' + widget.verificadoPor,
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Nome: ' + widget.nomeMotorista,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Veiculo: ' + widget.Veiculo,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Placa: ' + widget.PlacaVeiculo,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Empresa de destino: ' + widget.Empresadestino,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Empresa de origem: ' + widget.EmpresadeOrigin,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                  'Galpão: ' + widget.Galpao,
                style: const TextStyle(
                    fontSize: 16
                ),
              ),
            ),
            RadioListTile(
              title: const Text(
                  "Com Lacre"
              ),
              value: "lacre",
              groupValue: widget.lacreounao,
              onChanged: null,
            ),
              RadioListTile(
                title: const Text("Sem Lacre",),
                value: "naolacrado",
                groupValue: widget.lacreounao,
                onChanged: null,
              ),
              lacrebool ?
              Container(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _textEditingController,
                  onChanged: (valor){
                    lacreSt = valor;
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  //enableSuggestions: false,
                  //autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Numero do lacre *',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              )
                  :const Text(''),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {

                  //todo subtract

                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  var result = await FirebaseFirestore.instance
                      .collection("operadorEmpresarial")
                      .doc(UID)
                      .get();

                  String idEmpresa = (result.get('idEmpresa'));

                  var resultEmpresa = await FirebaseFirestore.instance
                      .collection("empresa")
                      .doc(idEmpresa)
                      .get();


                  if(widget.interno == false){
                    Map galpoes = (resultEmpresa.get('galpaes'));


                    galpoes[widget.Galpao] = galpoes[widget.Galpao] + 1;

                    FirebaseFirestore.instance.collection('empresa').doc(idEmpresa).update({
                      'galpaes': galpoes
                    }).then((value){
                      if(lacrebool == false){
                        FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                          'DataSaida': DateTime.now(),
                          'Status': 'Liberado Saida'
                        });
                        Navigator.pop(context);
                      }

                      if(lacrebool == true){
                        if(lacreSt == null){
                          Fluttertoast.showToast(
                            msg: 'Preencha o numero do lacre!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{
                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataSaida': DateTime.now(),
                            'Status': 'Liberado Saida'
                          });
                          Navigator.pop(context);
                        }
                      }
                    });
                  }else{
                    if(lacrebool == false){
                      FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                        'DataSaida': DateTime.now(),
                        'Status': 'Liberado Saida'
                      });
                      Navigator.pop(context);
                    }

                    if(lacrebool == true){
                      if(lacreSt == null){
                        Fluttertoast.showToast(
                          msg: 'Preencha o numero do lacre!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{
                        FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                          'DataSaida': DateTime.now(),
                          'Status': 'Liberado Saida'
                        });
                        Navigator.pop(context);
                      }
                    }
                  }
                },
                child: const Text(
                  'Prosseguir',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 180,
                        height: 180,
                        padding: const EdgeInsets.all(16),
                        child:
                        Image.asset(
                          'assets/icon.png',
                          fit: BoxFit.contain,
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child:
                      Text(
                        'Operador: ' + widget.empresaName,
                        style: const TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
