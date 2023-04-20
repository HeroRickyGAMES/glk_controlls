import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Programado por HeroRickyGames

class operadorEmpresarialAguardando extends StatefulWidget {

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
  String DateAnalise = '';
  String verificadoPor = '';
  String urlImage1 = '';
  String urlImage2 = '';
  String urlImage3 = '';
  String urlImage4 = '';
  Map Galpoes;
  String UIDEmpresa;

  operadorEmpresarialAguardando(
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
      this.DateAnalise,
      this.verificadoPor,
      this.urlImage1,
      this.urlImage2,
      this.urlImage3,
      this.urlImage4,
      this.Galpoes,
      this.UIDEmpresa, {super.key}
      );
  @override
  State<operadorEmpresarialAguardando> createState() => _operadorEmpresarialAguardandoState();
}

class _operadorEmpresarialAguardandoState extends State<operadorEmpresarialAguardando> {
  bool lacrebool = false;
  String? lacreSt;
  bool entradabool = false;
  bool regeitado = false;
  String galpaoSelecionado = '';
  final dropValue = ValueNotifier('');

  bool empresaPikada = false;
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
            'GLK Controls - Liberação de Veiculo',
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
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Galpões da Empresa *',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Center(
                    child: ValueListenableBuilder(valueListenable: dropValue, builder: (context, String value, _){
                      return DropdownButton(
                        hint: const Text(
                          'Selecione um galpão',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        value: (value.isEmpty)? null : value,
                        onChanged: (escolha) async {
                          dropValue.value = escolha.toString();

                          galpaoSelecionado = escolha.toString();

                          print(galpaoSelecionado);

                        },
                        items: widget.Galpoes.keys.map((opcao) => DropdownMenuItem(
                          value: opcao,
                          child:
                          Text(
                            opcao,
                            style: const TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ),
                        ).toList(),
                      );
                    })
                ),
              ],
            ),
            RadioListTile(
              title: const Text(
                  "Com Lacre"
              ),
              value: "lacre",
              groupValue: widget.lacreounao,
              onChanged: (value){
                setState(() {
                  widget.lacreounao = value.toString();

                  if(value == 'lacre'){
                    lacrebool = true;
                  }
                });
              },
            ),
            RadioListTile(
              title: const Text("Sem Lacre",),
              value: "naolacrado",
              groupValue: widget.lacreounao,
              onChanged: (value){
                setState(() {
                  widget.lacreounao = value.toString();

                  if(value == 'naolacrado'){
                    lacrebool = false;
                  }
                });
              },
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
              child:
              CheckboxListTile(
                title: const Text('Autorizo Entrada'),
                value: entradabool,
                onChanged: (value) {
                  setState(() {
                    entradabool = value!;
                    regeitado = false;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              child:
              CheckboxListTile(
                title: const Text('Rejeito a Entrada'),
                value: regeitado,
                onChanged: (value) {
                  setState(() {
                    regeitado = value!;
                    entradabool = false;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {

                  var valorEmpresas = await FirebaseFirestore.instance
                      .collection("empresa")
                      .doc(widget.UIDEmpresa)
                      .get();


                  if(valorEmpresas.get('galpaes')[galpaoSelecionado] == 0){
                    Fluttertoast.showToast(
                      msg: 'Infelizmente não existe mais vagas disponiveis, selecione outro galpão!',
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }else{

                    if(widget.Galpoes.containsKey(galpaoSelecionado)){

                      print("Antes da Subtração ${widget.Galpoes.values}");

                      widget.Galpoes[galpaoSelecionado] = widget.Galpoes[galpaoSelecionado] - 1;

                      print("Depois da Subtração ${widget.Galpoes.values}");

                      if(lacrebool == false){
                        if(entradabool == true){
                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataEntradaEmpresa': DateTime.now(),
                            'Galpão': galpaoSelecionado,
                            'Status': 'Liberado Entrada'
                          }).then((value){
                            FirebaseFirestore.instance.collection('empresa').doc(widget.UIDEmpresa).update(
                                {
                                  "galpaes": widget.Galpoes
                                }
                            ).then((value){
                              Navigator.pop(context);
                            });
                          });
                        }
                        if(regeitado == true){

                          FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                            'DataAnaliseEmpresa': DateTime.now(),
                            'Status': 'Rejeitado'
                          }).then((value){
                            Navigator.pop(context);
                          });

                        }
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
                          if(entradabool == true){
                            FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                              'DataEntradaEmpresa': DateTime.now(),
                              'Galpão': galpaoSelecionado,
                              'Status': 'Liberado Entrada'
                            }).then((value){

                              FirebaseFirestore.instance.collection('empresa').doc(widget.UIDEmpresa).update(
                                  {
                                    "galpaes": widget.Galpoes
                                  }
                              ).then((value){
                                Navigator.pop(context);
                              });

                            });
                          }
                          if(regeitado == true){
                            FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                              'DataEntradaEmpresa': DateTime.now(),
                              'Galpão': galpaoSelecionado,
                              'Status': 'Rejeitado'
                            }).then((value){
                              Navigator.pop(context);
                            });
                          }
                        }
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
          ],
        ),
      ),
    );
  }
}