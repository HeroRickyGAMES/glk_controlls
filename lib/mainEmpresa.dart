import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/modal/veiculoEntrada.dart';
import 'package:glk_controls/pesquisaDir/pesquisa.dart';
import 'package:intl/intl.dart';
import 'modal/modalVeiculo.dart';


//Programado por HeroRickyGames
Map map = Map();

Map<String, String> map1 = {};
Map<String, String> mapNome = {};
class mainEmpresa extends StatefulWidget {
  final String empresaName;
  const mainEmpresa(this.empresaName);

  @override
  State<mainEmpresa> createState() => _mainEmpresaState();
}

class _PlateFormatter extends TextInputFormatter {
  static const int _firstGroupLength = 3;
  static const int _secondGroupLength = 4;
  static const String _separator = ' ';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String cleaned = newValue.text.replaceAll(RegExp('[^a-zA-Z0-9]'), '');
    String plate = '';
    int i = 0;
    while (i < cleaned.length) {
      int remaining = cleaned.length - i;
      if (remaining > _firstGroupLength) {
        plate += cleaned.substring(i, i + _firstGroupLength) + _separator;
        i += _firstGroupLength;
      } else {
        plate += cleaned.substring(i, i + remaining);
        i += remaining;
      }
      if (i == _firstGroupLength && remaining > 0) {
        plate += _separator;
      }
    }
    return TextEditingValue(
      text: plate,
      selection: TextSelection.fromPosition(
        TextPosition(offset: plate.length),
      ),
    );
  }
}

class _mainEmpresaState extends State<mainEmpresa> {
  openModal(BuildContext context){


    var db = FirebaseFirestore.instance;

    db.collection('empresa').get().then((event) {

      for(var doc in event.docs){

        doc.data().forEach((key, value) {
          print('O valores são ' + value);

          print('O valor é ' + value);

          if(key == 'nome'){

            print( 'valor com nome é' + value);

            final EmpresasOpc = [];

            EmpresasOpc.add(value);
            final dropValue = '';

            var UID = FirebaseAuth.instance.currentUser?.uid;
            var db = FirebaseFirestore.instance;
            String nomeUser;
            db.collection('Users').doc(UID).get().then((value) {

              value.data()?.forEach((key, value) {
                if(key == 'nome'){

                  print(value);
                  nomeUser = value;

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return modalPorteiro(EmpresasOpc, dropValue, nomeUser);

                      }));

                }

              });

            });
          }
        }
        );
      }
    });
    print('chegou aqui!');
  }

  Widget build(BuildContext context) {
    String idDocumento;

    String holderPlaca = '';

    bool estaPesquisando = false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GLK Controls - EMPRESAS'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Pesquisar Placa:',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    TextFormField(
                      onChanged: (valor){

                        String value = valor.replaceAll(' ', '').toUpperCase();;

                        holderPlaca = value.replaceAllMapped(
                          RegExp(r'^([a-zA-Z]{3})([0-9]{4})$'),
                              (Match m) => '${m[1]}-${m[2]}',
                        );
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(

                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green
                            )
                        ),
                        hintStyle: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: (){
                          if(holderPlaca == ''){

                            Fluttertoast.showToast(
                              msg: 'Preencha a pesquisa!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );

                          }else{


                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return pesquisa(holderPlaca);
                                }));
                          }
                      },
                        child: Text(
                            'Pesquisar',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore
                            .instance
                            .collection('Autorizacoes')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            height: 700,
                            width: double.infinity,
                            child: GridView.count(
                              padding: const EdgeInsets.all(5),
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                              children:
                              snapshot.data!.docs.map((documents) {
                                String lacre = '${documents['LacreouNao']}';
                                String ColetaOuEntrega = '${documents['ColetaOuEntrega']}';
                                bool lacrebool = false;
                                bool coletaBool = false;
                                String lacrado = '';
                                String ColetaOuEntregast = '';
                                idDocumento = documents.id;

                                    if(lacre == 'lacre'){
                                      lacrebool = true;
                                      lacrado = 'Lacrado';
                                    }
                                    if(lacre == 'naolacrado'){
                                      lacrebool = false;
                                      lacrado = 'Não Lacrado';
                                    }
                                    if(ColetaOuEntrega == 'coleta'){
                                      coletaBool = true;
                                      ColetaOuEntregast = 'Coleta';
                                    }
                                    if(ColetaOuEntrega == 'entrega'){
                                      coletaBool = false;
                                      ColetaOuEntregast = 'Entrega';
                                    }

                                     Color color = Colors.white as Color;
                                     Color textColor = Colors.white as Color;

                                    if(documents['Status'] == 'Aguardando'){
                                      color = Colors.red[400] as Color;
                                      textColor = Colors.white as Color;
                                    }

                                    if(documents['Status'] == 'Entrada'){
                                      color = Colors.yellow[400] as Color;
                                      textColor = Colors.black as Color;
                                    }

                                    if(documents['Status'] == 'Saida'){
                                      color = Colors.green[400] as Color;
                                      textColor = Colors.white as Color;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        color: color,
                                        padding: EdgeInsets.all(16),
                                        child:
                                        Column(
                                          children: [
                                            Text(
                                              'Placa:\n' +
                                              documents['PlacaVeiculo'],
                                              style:
                                              TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(16),
                                              child: Image
                                                  .network(
                                                documents['uriImage'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(16),
                                              child: Text(
                                                'Status: \n' +
                                                    documents['Status'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: (){

                                                  if(documents['Status'] == 'Entrada'){

                                                          String lacre = documents['LacreouNao'];

                                                          if(lacre == 'lacre'){
                                                            String liberadopor = documents['QuemAutorizou'];
                                                            Timestamp horarioCriacao = documents['Horario Criado'];
                                                            String nomeMotorista = documents['nomeMotorista'];
                                                            String Veiculo = documents['Veiculo'];
                                                            String PlacaVeiculo = documents['PlacaVeiculo'];
                                                            String Empresadestino = documents['Empresa'];
                                                            String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                            String Galpao = documents['Galpão'];
                                                            Timestamp DataEntrada = documents['DataEntrada'];
                                                            String lacradoStr = documents['lacrenum'];

                                                            String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(horarioCriacao.toDate()).replaceAll('-', '/');
                                                            String formattedDate2 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataEntrada.toDate()).replaceAll('-', '/');

                                                            Navigator.push(context,
                                                                MaterialPageRoute(builder: (context){
                                                                  return veiculoEntrada(lacre, widget.empresaName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, lacradoStr, documents.id, formattedDate2);
                                                                }));

                                                          }
                                                          else{
                                                            if(lacre == 'naolacrado'){
                                                              String liberadopor = documents['QuemAutorizou'];
                                                              Timestamp horarioCriacao = documents['Horario Criado'];
                                                              Timestamp DataEntrada = documents['DataEntrada'];
                                                              String nomeMotorista = documents['nomeMotorista'];
                                                              String Veiculo = documents['Veiculo'];
                                                              String PlacaVeiculo = documents['PlacaVeiculo'];
                                                              String Empresadestino = documents['Empresa'];
                                                              String EmpresadeOrigin = documents['EmpresadeOrigin'];
                                                              String Galpao = documents['Galpão'];

                                                              String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(horarioCriacao.toDate()).replaceAll('-', '/');
                                                              String formattedDate2 = DateFormat('dd-MM-yyyy HH:mm:ss').format(DataEntrada.toDate()).replaceAll('-', '/');

                                                              print(formattedDate);

                                                              Navigator.push(context,
                                                                  MaterialPageRoute(builder: (context){
                                                                    return veiculoEntrada(lacre, widget.empresaName, liberadopor, formattedDate, nomeMotorista, Veiculo, PlacaVeiculo, Empresadestino, EmpresadeOrigin, Galpao, '', documents.id, formattedDate2);
                                                                  }));
                                                            }
                                                          }
                                                        }

                                                  if(documents['Status'] == 'Aguardando'){
                                                    showDialog<void>(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text('Deseja autorizar entrada?'),
                                                          content: SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <Widget>[
                                                                Text('Deseja autorizar entrada desse veiculo?'),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text('Não deixar'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();

                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text('Deixar'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();

                                                                FirebaseFirestore.instance.collection('Autorizacoes').doc(documents.id).update({
                                                                  'DataEntrada': DateTime.now(),
                                                                  'Status': 'Entrada'
                                                                });

                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }else{

                                                  }
                                                },
                                                child: Text(
                                                  'Mudar Status',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                }
                              ).toList().reversed.toList(),
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: 180,
                    height: 180,
                    padding: EdgeInsets.all(16),
                    child:
                    Image.asset(
                      'assets/icon.png',
                      fit: BoxFit.contain,
                    )
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child:
                  Text(
                    'Empresa: ' + widget.empresaName,
                    style: TextStyle(
                        fontSize: 20
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
