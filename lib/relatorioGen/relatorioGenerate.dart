import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'generatePDF/gerarPDF.dart';

//Programado por HeroRickyGames

class relatorioGenerate extends StatefulWidget {

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
  String dataEntrada = '';
  String dataSaida = '';
  String RG = '';
  String telefone = '';
  String saidaLiberadaPor = '';
  String imageURL = '';
  String id = '';
  String imageURL2 = '';
  String imageURL3 = '';
  String imageURL4 = '';
  String DatadeAnalise = '';
  String verificadoPor = '';
  String DateEntrada = '';
  String EmpresaDoc = '';
  String DataSaidaPortaria = '';

  relatorioGenerate(
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
      this.dataEntrada,
      this.dataSaida,
      this.RG,
      this.telefone,
      this.saidaLiberadaPor,
      this.imageURL,
      this.id,
      this.imageURL2,
      this.imageURL3,
      this.imageURL4,
      this.DatadeAnalise,
      this.verificadoPor,
      this.DateEntrada,
      this.EmpresaDoc,
      this.DataSaidaPortaria,
      {super.key}
      );
  @override
  State<relatorioGenerate> createState() => _relatorioGenerateState();
}

class _relatorioGenerateState extends State<relatorioGenerate> {
  bool lacrebool = false;
  String? lacreSt;

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
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: const Text(
          'GLK Controls - Relatório',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child:
              Text(
                'Liberação: ' + 'Motorista e Veiculo',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
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
                        fontSize: tamanhotexto 
                    ),
                  ),
                  Text(
                    ' - Portaria - ${widget.liberadopor}',
                    style: TextStyle(
                        fontSize: tamanhotexto 
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
                    style: TextStyle(
                        fontSize: tamanhotexto 
                    ),
                  ),
                  Text(
                    ' - Analise na Empresa - ${widget.EmpresaDoc}',
                    style: TextStyle(
                        fontSize: tamanhotexto 
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
                    style: TextStyle(
                        fontSize: tamanhotexto 
                    ),
                  ),
                  Text(
                    ' - Entrada - ${widget.verificadoPor}',
                    style: TextStyle(
                        fontSize: tamanhotexto 
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
                    'Data: ${widget.DataSaidaPortaria}' ,
                    style: TextStyle(
                        fontSize: tamanhotexto 
                    ),
                  ),
                  Text(
                    ' - Saida - ${widget.saidaLiberadaPor}',
                    style: TextStyle(
                        fontSize: tamanhotexto 
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Nome: ${widget.nomeMotorista}',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'RG: ${widget.RG}',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Veiculo: ${widget.Veiculo}',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Placa: ${widget.PlacaVeiculo}',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de destino: ${widget.Empresadestino}',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Telefone: ${widget.telefone}',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Empresa de origem: ${widget.EmpresadeOrigin}',
                style: TextStyle(
                    fontSize: tamanhotexto 
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child:
              Text(
                'Galpão: ${widget.Galpao}',
                style: TextStyle(
                    fontSize: tamanhotexto 
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
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Numero do lacre *',
                  hintStyle: TextStyle(
                      fontSize: tamanhotexto 
                  ),
                ),
              ),
            )
                :const Text(''),
            Container(
              height: 300,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child:
                      Image.network(
                          widget.imageURL
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    Image.network(
                        widget.imageURL2
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
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    Image.network(
                        widget.imageURL3
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    child:
                    Image.network(
                        widget.imageURL4
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {

                  String portaria =  'Data: ${widget.horarioCriacao}' + ' - Portaria - ' + widget.liberadopor;
                  String analise =  'Data: ${widget.DatadeAnalise}' +  ' - Analise - ' + widget.verificadoPor;
                  String EntradaEmpresa =   'Data: ${widget.DateEntrada}'  + ' - Entrada Empresa - ' + widget.EmpresaDoc;
                  String SaidaEmpresa =  'Data: ${widget.DataSaidaPortaria}' + ' - Saida - ' + widget.saidaLiberadaPor;

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return generatePDF(widget.liberadopor, widget.dataEntrada, widget.nomeMotorista, widget.Veiculo, widget.PlacaVeiculo, widget.Empresadestino, widget.telefone, widget.EmpresadeOrigin, widget.Galpao, widget.saidaLiberadaPor, widget.lacradoStr, widget.dataSaida, lacrebool, widget.id, portaria, analise, EntradaEmpresa, SaidaEmpresa);
                      }));

                },
                child: Text(
                  'Gerar/Imprimir',
                  style: TextStyle(
                      fontSize: tamanhotextobtns 
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
                          'assets/sanca.png',
                          fit: BoxFit.contain,
                        )
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
