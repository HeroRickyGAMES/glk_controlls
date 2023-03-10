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
      this.id
      );
  @override
  State<relatorioGenerate> createState() => _relatorioGenerateState();
}

class _relatorioGenerateState extends State<relatorioGenerate> {
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
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          'GLK Controls - Relatório',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child:
              Text(
                'Entrada Liberada: ' + widget.liberadopor,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Data de Entrada: ${widget.dataEntrada}' ,
                style: TextStyle(
                    fontSize: 30
                ),
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
                'RG: ' + widget.RG,
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
                'Telefone: ' + widget.telefone,
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
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Saída Liberada por : ' + widget.saidaLiberadaPor,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child:
              Text(
                'Data da liberação de saída: ' + widget.dataSaida,
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
                width: 512,
                height: 512,
              padding: EdgeInsets.all(16),
              child: Image.network(
                  widget.imageURL,
                fit: BoxFit.contain,
              )
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return generatePDF(widget.liberadopor, widget.dataEntrada, widget.nomeMotorista, widget.Veiculo, widget.PlacaVeiculo, widget.Empresadestino, widget.telefone, widget.EmpresadeOrigin, widget.Galpao, widget.saidaLiberadaPor, widget.lacradoStr, widget.dataSaida, lacrebool, widget.id);
                      }));

                },
                child: Text(
                  'Gerar/Imprimir',
                  style: TextStyle(
                      fontSize: 30
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
                        padding: EdgeInsets.all(16),
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
