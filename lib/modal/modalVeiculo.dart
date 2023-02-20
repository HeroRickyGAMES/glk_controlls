import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../mainPorteiro.dart';

//Programado Por HeroRickyGames

class modalPorteiro extends StatefulWidget {
  final List<dynamic> EmpresasOpc;
  final dropValue;
  final String nomeUser;
  modalPorteiro(this.EmpresasOpc, this.dropValue, this.nomeUser);

  @override
  State<modalPorteiro> createState() => _modalPorteiroState();
}

class _modalPorteiroState extends State<modalPorteiro> {
  String? coletaouentrega;
  String? lacreounao;
  String? empresaSelecionada;

  String? cpfoucnpj;


  @override
  Widget build(BuildContext context) {
    final cnhController = TextEditingController();
    final motoristaController = TextEditingController();
    final cpfMotoristaController = TextEditingController();
    final placaDoVeiculoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(onPressed: (){

              widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return mainPorteiro();
                          }));
            },
                child:
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
            ),
            Text('GLK Controls - Adicionar novo motorista'),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                  'Selecione a Empresa que o motorista irá entrar',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Center(
              child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                return DropdownButton(
                  hint: Text(
                      'Selecione uma empresa',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  value: (value.isEmpty)? null : value,
                  onChanged: (escolha) {
                    widget.dropValue.value = escolha.toString();

                    empresaSelecionada = escolha.toString();
                  },
                  items: widget.EmpresasOpc.map((opcao) => DropdownMenuItem(
                      value: opcao,
                      child:
                      Text(
                          opcao,
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),
                  ).toList(),
                );
              })
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child:
              Column(
                children: [
                  Text(
                    'É Coleta ou Entrega?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  RadioListTile(
                    title: Text("É Coleta"),
                    value: "coleta",
                    groupValue: coletaouentrega,
                    onChanged: (value){
                      setState(() {
                        coletaouentrega = value.toString();
                      });
                    },
                  ),

                  RadioListTile(
                    title: Text(
                        "É Entrega"
                    ),
                    value: "entrega",
                    groupValue: coletaouentrega,
                    onChanged: (value){
                      setState(() {
                        coletaouentrega = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child:
              Column(
                children: [
                  Text(
                    'Está Entrando com Lacre ou Sem Lacre?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  RadioListTile(
                    title: Text(
                        "Entrando com Lacre"
                    ),
                    value: "lacre",
                    groupValue: lacreounao,
                    onChanged: (value){
                      setState(() {
                        lacreounao = value.toString();
                      });
                    },
                  ),

                  RadioListTile(
                    title: Text("Entrando sem Lacre",),
                    value: "naolacrado",
                    groupValue: lacreounao,
                    onChanged: (value){
                      setState(() {
                        lacreounao = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: TextField(
                controller: cnhController,
                keyboardType: TextInputType.number,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'CNH do Motorista (Apenas números)',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: TextField(
                controller: motoristaController,
                keyboardType: TextInputType.name,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nome Completo do Motorista',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: TextField(
                controller: cpfMotoristaController,
                keyboardType: TextInputType.number,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'RG do Motorista (Apenas Números)',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: TextField(
                controller: placaDoVeiculoController,
                keyboardType: TextInputType.text,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Placa do veiculo',
                  hintStyle: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){

              if(empresaSelecionada == null){
                Fluttertoast.showToast(
                  msg: 'Selecione a empresa!',
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }else{
                print('Empresa selecionada $empresaSelecionada');

                if(cnhController.text == ''){
                  Fluttertoast.showToast(
                    msg: 'Preencha a CNH do motorista!',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }else{

                  if(motoristaController.text == ''){
                    Fluttertoast.showToast(
                      msg: 'Preencha o nome do motorista!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }else{

                    if(cpfMotoristaController.text == ''){

                      Fluttertoast.showToast(
                        msg: 'Preencha a CNH do motorista!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                    }else{
                      if(coletaouentrega == null){

                        Fluttertoast.showToast(
                          msg: 'Selecione se é Coleta ou Entrega',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                      }else{

                        if(lacreounao == null){

                          Fluttertoast.showToast(
                            msg: 'Selecione se está entrando com lacre ou não!',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );

                        }else{

                          if(placaDoVeiculoController.text == ''){

                            Fluttertoast.showToast(
                              msg: 'Preencha o Campo da Placa do veiculo!',
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );

                          }else{

                            //registre todos os valores no db
                            var UID = FirebaseAuth.instance.currentUser?.uid;
                            var db = FirebaseFirestore.instance;
                            db.collection('Users').doc(UID).get().then((event) {

                              event.data()?.forEach((key, value) {


                                if(key == 'RGouCNPJ'){

                                  print(value);

                                  cpfoucnpj = value;

                                  FirebaseFirestore.instance.collection('Autorizacoes').doc().set({
                                    'Empresa': empresaSelecionada,
                                    'ColetaOuEntrega': coletaouentrega,
                                    'LacreouNao': lacreounao,
                                    'CNHMotorista': cnhController.text,
                                    'nomeMotorista': motoristaController.text,
                                    'RGDoMotorista': cpfMotoristaController.text,
                                    'QuemAutorizou': widget.nomeUser,
                                    'CPFcnpjAutorizou': cpfoucnpj,
                                    'PlacaDoVeiculo': placaDoVeiculoController.text,
                                    'Status': 'Autorizado pela Portaria',
                                  }).then((value) {

                                    Fluttertoast.showToast(
                                      msg: 'Enviado com sucesso!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);

                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return mainPorteiro();
                                        }));

                                  });
                                }

                              }
                              );

                            }
                            );

                          }
                        }

                      }

                    }

                  }

                }

              }
            },
            child:
            Text(
                'Adicionar novo Motorista',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            )
            )
          ],
        ),
      ),
    );
  }
}
