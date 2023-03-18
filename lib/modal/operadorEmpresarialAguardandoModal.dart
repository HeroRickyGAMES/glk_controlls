import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/mainEmpresa.dart';
import 'package:glk_controls/mainPorteiro.dart';

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
  String DateEntrada = '';
  String DateAnalise = '';
  String verificadoPor = '';
  String urlImage1 = '';
  String urlImage2 = '';
  String urlImage3 = '';
  String urlImage4 = '';

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
      this.DateEntrada,
      this.DateAnalise,
      this.verificadoPor,
      this.urlImage1,
      this.urlImage2,
      this.urlImage3,
      this.urlImage4
      );
  @override
  State<operadorEmpresarialAguardando> createState() => _operadorEmpresarialAguardandoState();
}

class _operadorEmpresarialAguardandoState extends State<operadorEmpresarialAguardando> {
  bool lacrebool = false;
  String? lacreSt;
  bool entradabool = false;
  bool regeitado = false;
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
        title: Text(
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
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Portaria - ' + widget.liberadopor,
                    style: TextStyle(
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
                    'Data: ${widget.horarioCriacao}' ,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                  Text(
                    ' - Analise - ' + widget.verificadoPor,
                    style: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Nome: ' + widget.nomeMotorista,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ' + widget.Veiculo,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Placa: ' + widget.PlacaVeiculo,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ' + widget.Empresadestino,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ' + widget.EmpresadeOrigin,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Galpão: ' + widget.Galpao,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            RadioListTile(
              title: Text(
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
              title: Text("Sem Lacre",),
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
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: _textEditingController,
                onChanged: (valor){
                  lacreSt = valor;
                  //Mudou mandou para a String
                },
                keyboardType: TextInputType.number,
                //enableSuggestions: false,
                //autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Numero do lacre *',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            )
                :Text(''),
            Container(
              height: 300,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    Image.network(
                        widget.urlImage1
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    Image.network(
                        widget.urlImage2
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    Image.network(
                        widget.urlImage3
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    Image.network(
                        widget.urlImage4
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child:
              CheckboxListTile(
                title: Text('Autorizo Entrada'),
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
                title: Text('Rejeito a Entrada'),
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
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (){
                  if(lacrebool == false){
                    if(entradabool == true){
                      FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                        'DataEntradaEmpresa': DateTime.now(),
                        'Status': 'Entrada'
                      });
                      Navigator.pop(context);
                    }
                    if(regeitado == true){
                      FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                        'DataEntradaEmpresa': DateTime.now(),
                        'Status': 'Rejeitado'
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
                          'Status': 'Entrada'
                        });
                        Navigator.pop(context);
                      }
                      if(regeitado == true){
                        FirebaseFirestore.instance.collection('Autorizacoes').doc(widget.idDocumento).update({
                          'DataEntradaEmpresa': DateTime.now(),
                          'Status': 'Rejeitado'
                        });
                      }
                    }
                  }
                },
                child: Text(
                  'Autorizar saída',
                  style: TextStyle(
                      fontSize: 30
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