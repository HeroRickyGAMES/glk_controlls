import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:glk_controls/ModuloPrestador/geral/Modals/cadastrarVeiculoPrestador.dart';
import 'package:glk_controls/ModuloPrestador/geral/Modals/editarVeiculo.dart';
import 'package:image_picker/image_picker.dart';

class editarInfosADM extends StatefulWidget {
  String EmpresaNome = '';
  String EmpresaID = '';
  String Nome = '';
  String RG = '';
  String Telefone = '';
  String idd = '';
  bool PreenchidoTipoVeiculo;
  bool PreenchidoPermissao;
  bool carroOuMoto;
  bool moto;
  bool carroEmoto;
  bool VagaComum;
  bool VagaMoto;
  bool VagaDiretoria;
  bool PreenchidoBloqueado;
  bool Liberado;
  bool bloqueadoBool;
  bool isTired;
  bool poscadastro;
  String OperadorName = '';
  String URLImage = '';

  editarInfosADM(this.EmpresaNome, this.EmpresaID,this.Nome, this.RG, this.Telefone, this.idd, this.PreenchidoTipoVeiculo, this.PreenchidoPermissao, this.carroOuMoto, this.moto, this.carroEmoto, this.VagaComum, this.VagaMoto, this.VagaDiretoria, this.PreenchidoBloqueado, this.Liberado, this.bloqueadoBool, this.isTired, this.poscadastro, this.OperadorName, this.URLImage, {Key? key}) : super(key: key);

  @override
  State<editarInfosADM> createState() => _editarInfosADMState();
}

class _editarInfosADMState extends State<editarInfosADM> {

  bool initialized = false;
  TextEditingController nameAllcaps = TextEditingController();
  TextEditingController RGController = TextEditingController();
  TextEditingController TelefoneController = TextEditingController();
  String nome = '';
  String RG = '';
  String telefone = '';
  String LiberarEntrada = 'Bloquear Entrada';
  String LiberadoCheck = 'Liberado';
  bool PreenchidoTipoVeiculo = false;
  bool PreenchidoPermissao = false;
  bool carroOuMoto = false;
  bool moto = false;
  bool carroEmoto = false;

  bool VagaComum = false;
  bool VagaMoto = false;
  bool VagaDiretoria = false;

  bool PreenchidoBloqueado = false;
  bool Liberado = false;
  bool bloqueadoBool = false;

  bool isTired = false;

  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {

    if(initialized == false){
      nameAllcaps = TextEditingController(text: widget.Nome);
      RGController = TextEditingController(text: widget.RG);
      TelefoneController = TextEditingController(text: widget.Telefone);
      nome = widget.Nome;
      RG = widget.RG;
      telefone = widget.Telefone;
      PreenchidoTipoVeiculo = widget.PreenchidoTipoVeiculo;
      PreenchidoPermissao = widget.PreenchidoPermissao;
      carroOuMoto = widget.carroOuMoto;
      moto = widget.moto;
      carroEmoto = widget.carroEmoto;

      VagaComum = widget.VagaComum;
      VagaMoto = widget.VagaMoto;
      VagaDiretoria = widget.VagaDiretoria;

      PreenchidoBloqueado = widget.PreenchidoBloqueado;
      Liberado = widget.Liberado;
      bloqueadoBool = widget.bloqueadoBool;

      isTired = widget.isTired;
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

    salvarmt() async {
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

      FirebaseFirestore.instance.collection('Prestadores').doc(widget.idd).update({
        'nome': nome,
        'RG': RG,
        'Telefone': telefone,
        'carro': carroOuMoto,
        'moto': moto,
        'carroEmoto': carroEmoto,
        'vagaComum': VagaComum,
        'vagaMoto': VagaMoto,
        'VagaDiretoria': VagaDiretoria,
        'Liberado': Liberado,
      }).then((value){
        Navigator.of(context).pop();
        Navigator.pop(context);
      });
    }

    started() async {
      await Future.delayed(const Duration(seconds: 2));
      if(widget.poscadastro == true){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Cadastro feito com sucesso! / Foi adicionado um botão!',
                style: TextStyle(
                    fontSize: tamanhotextobtns
                ),
              ),
              actions: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'O botão Cadastrar Veiculos foi liberado!',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text(
                        'Prosseguir',
                        style: TextStyle(
                            fontSize: tamanhotexto
                        ),
                      ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      }
    }
    if(initialized == false){
      started();
    }

    if(Liberado == true){
      LiberarEntrada = 'Bloquear Entrada';
      LiberadoCheck = 'Liberado';
    }else{
      if(Liberado == false){
        LiberarEntrada = 'Liberar Entrada';
        LiberadoCheck = 'Bloqueado';
      }
    }


    initialized = true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Dados de cadastro'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/icon.png',
                      width: 150,
                      height: 150,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white
                              ),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: tamanhotextobtns,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: salvarmt,
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green
                            ),
                            child: Text(
                              'Salvar',
                              style: TextStyle(
                                fontSize: tamanhotextobtns,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 300,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    if(Liberado == false){
                                      bloqueadoBool = false;
                                      PreenchidoBloqueado = true;
                                      Liberado = true;
                                    }else{
                                      if(Liberado == true){
                                        bloqueadoBool = true;
                                        PreenchidoBloqueado = true;
                                        Liberado = false;
                                      }
                                    }

                                  });
                                },
                              style: Liberado == true? ElevatedButton.styleFrom(
                                  primary: Colors.red[800]
                              ) :ElevatedButton.styleFrom(
                                  primary: Colors.green[800]
                              ),
                                child: Text(
                                  LiberarEntrada,
                                  style: TextStyle(
                                      fontSize: tamanhotexto
                                  ),
                                ),
                            ),
                            Text(
                                'Status: $LiberadoCheck',
                              style: TextStyle(
                                fontSize: tamanhotexto
                              ),
                            ),
                            Liberado == true ?
                            const Icon(
                                Icons.done,
                              color: Colors.green,
                              size: 50,
                            ):
                            const Icon(
                              Icons.block,
                              color: Colors.red,
                              size: 50,
                            )
                          ],
                        )
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        child:
                        Image.network(
                          widget.URLImage,
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Nome: $nome',
                    style: TextStyle(
                        fontSize: tamanhotexto
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'RG: $RG',
                  style: TextStyle(
                    fontSize: tamanhotexto
                  ),
                )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Empresa: ${widget.EmpresaNome}',
                  style: TextStyle(
                    fontSize: tamanhotexto,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Telefone: $telefone',
                  style: TextStyle(
                    fontSize: tamanhotexto,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Tipo de veiculo:',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Carro',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: carroOuMoto,
                        onChanged: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Moto',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: moto,
                        onChanged: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Carro + Moto',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: carroEmoto,
                        onChanged: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Permissão:',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Vaga',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: VagaComum,
                        onChanged: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Vaga Moto',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: VagaMoto,
                        onChanged: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Vaga Diretoria',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: VagaDiretoria,
                        onChanged: null,
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
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
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(
                          'Liberado',
                          style: TextStyle(
                            fontSize: tamanhotexto,
                          ),
                        ),
                        value: Liberado,
                        onChanged: (value) {
                          setState(() {
                            if(value == true){
                              bloqueadoBool = false;
                              PreenchidoBloqueado = true;
                              Liberado = true;
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
                        value: bloqueadoBool,
                        onChanged: (value) {
                          setState(() {
                            if(value == true){
                              bloqueadoBool = true;
                              PreenchidoBloqueado = true;
                              Liberado = false;
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
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Veiculos Liberado:',
                    style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('VeiculosdePrestadores')
                      .where('idPertence', isEqualTo: widget.idd)
                  //.where('Liberado', isEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: ListView(
                        children: snapshot.data!.docs.map((documents) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Text(
                                      'Veiculo;',
                                      style: TextStyle(
                                        fontSize: tamanhotexto,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Text(
                                      '${documents['Marca']}-',
                                      style: TextStyle(
                                        fontSize: tamanhotexto,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Text(
                                      '${documents['Modelo']}-',
                                      style: TextStyle(
                                        fontSize: tamanhotexto,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Text(
                                      '${documents['cor']}-',
                                      style: TextStyle(
                                        fontSize: tamanhotexto,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Text(
                                      '${documents['PlacaVeiculo']}-',
                                      style: TextStyle(
                                        fontSize: tamanhotexto,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Text(
                                      '${documents['TipoDeVeiculo']}-',
                                      style: TextStyle(
                                        fontSize: tamanhotexto,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextButton(onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                              return editarVeiculo(widget.EmpresaNome, widget.EmpresaID, widget.idd, nome, carroEmoto, carroOuMoto, nome, widget.OperadorName, documents['Marca'], documents['Modelo'], documents['cor'], documents['PlacaVeiculo'], documents['TipoDeVeiculo'], documents['Liberado'], documents['id']);
                                            }));
                                      },
                                        child: const Icon(Icons.edit),
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextButton(onPressed: (){
                                        if(documents['Liberado'] == true){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Bloqueio do Administrativo!',
                                                  style: TextStyle(
                                                    fontSize: tamanhotexto
                                                  ),
                                                ),
                                                actions: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(16),
                                                        child: Text(
                                                            'Deseja confirmar o bloqueio desse veiculo?',
                                                          style: TextStyle(
                                                              fontSize: tamanhotexto
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.all(16),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.all(16),
                                                              child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    primary: Colors.red[800]
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: Text(
                                                                    'Cancelar',
                                                                  style: TextStyle(
                                                                    fontSize: tamanhotextobtns
                                                                  ),
                                                                ),
                                                              )
                                                            ),
                                                            Container(
                                                                padding: const EdgeInsets.all(16),
                                                                child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary: Colors.green[800]
                                                                  ),
                                                                  onPressed: () {
                                                                    FirebaseFirestore.instance.collection('VeiculosdePrestadores').doc(documents['id']).update({
                                                                      'Liberado' : false
                                                                    }).then((value){
                                                                      Navigator.of(context).pop();
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    'Prosseguir',
                                                                    style: TextStyle(
                                                                        fontSize: tamanhotextobtns
                                                                    ),
                                                                  ),
                                                                ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        }else{
                                          
                                        }
                                      },
                                        child: documents['Liberado'] == true ? const Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        ) : const Icon(
                                          Icons.block,
                                          color: Colors.red,
                                        ),
                                      )
                                  ),
                                ),

                                Expanded(
                                  child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextButton(onPressed: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Atenção!',
                                                style: TextStyle(
                                                    fontSize: tamanhotextobtns
                                                ),
                                              ),
                                              actions: [
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Tem certeza que deseja cancelar esse veiculo?\nOs dados não poderão ser recuperados pós deletação!',
                                                        style: TextStyle(
                                                            fontSize: tamanhotexto
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.all(16),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: TextButton(onPressed: (){
                                                                Navigator.of(context).pop();
                                                              }, child: Text(
                                                                'Cancelar',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotexto
                                                                ),
                                                              ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: TextButton(onPressed: (){
                                                                FirebaseFirestore.instance.collection('VeiculosdePrestadores').doc(documents['id']).delete().whenComplete((){
                                                                  Fluttertoast.showToast(
                                                                    msg: 'O veiculo selecionado foi deletado!',
                                                                    toastLength: Toast.LENGTH_SHORT,
                                                                    timeInSecForIosWeb: 1,
                                                                    backgroundColor: Colors.black,
                                                                    textColor: Colors.white,
                                                                    fontSize: tamanhotexto,
                                                                  );
                                                                  Navigator.of(context).pop();
                                                                });
                                                              }, child: Text(
                                                                'Prosseguir',
                                                                style: TextStyle(
                                                                    fontSize: tamanhotexto
                                                                ),
                                                              ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      }, child: const Icon(Icons.delete),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
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
