import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/CameraModulo/camera_ip/camera_ip.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/PesquisaPlacaSaida.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/pesquisaPlaca.dart';
import 'package:glk_controls/listas/liberacoesOperadorEmpresarial.dart';
import 'package:glk_controls/listas/listaEntrada.dart';
import 'package:glk_controls/listas/listaSaida.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


//Programado por HeroRickyGames
//Tecnologia feita pela Google e a equipe do qedcode.io



class CameraComum extends StatefulWidget {
  String EntradaouSaida;
  String OperadorName;
  String empresaName;
  CameraComum(this.EntradaouSaida, this.OperadorName, this.empresaName, {super.key});

  @override
  State<CameraComum> createState() => _CameraComumState();
}
String textocomEstado = '';
class _CameraComumState extends State<CameraComum> {

  String text = "";
  String tratado = '';

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  CameraController? _cameraController;
  var picture;

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<CameraController> _initializeCamera() async {
    // Obtenha uma lista de câmeras disponíveis no dispositivo
    final cameras = await availableCameras();
    // Inicialize a primeira câmera da lista (câmera traseira, se disponível)
    final cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    // Inicialize o controlador da câmera
    await cameraController.initialize();
    return cameraController;
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera().then((controller) {
      setState(() {
        _cameraController = controller;
      });
    });
  }

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

    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }

    return LayoutBuilder(builder: (context, constrains){

      if(constrains.maxWidth < 600){
        tamanhotexto = textSize;
        tamanhotextobtns = textSize;
        tamanhotextomin = 16;
        //aspect = 1.0;
        aspect = 1.0;
      }else {
        if(constrains.maxWidth > 600){
          tamanhotexto = textSizeandroid;
          tamanhotextobtns = textSizeandroidbtn;
          aspect = 0.8;
        }
      }

      return Scaffold(
          appBar: AppBar(
            title: const Text('Escanear com Camera'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Recomendamos que mantenha centralizado na placa antes de tirar a foto! Quando processado, aguarde alguns segundos para que o texto seja colocado na pesquisa.',
                      style: TextStyle(
                          fontSize: tamanhotexto,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                    Container(
                      height: 800,
                      child: AspectRatio(
                        aspectRatio: _cameraController!.value.aspectRatio,
                        child: CameraPreview(_cameraController!),
                      ),
                    ),
                  Container(
                    child: Text(
                        tratado,
                      style: TextStyle(
                        fontSize: tamanhotexto,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 32),
                    child: ElevatedButton(
                        onPressed: () async {

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

                      picture = await _cameraController!.takePicture();


                      final image = InputImage.fromFile(File(picture.path));
                      final result = await textRecognizer.processImage(image);

                      String x = '';
                      setState(() {
                        textocomEstado = result.text;

                        List<String> partes = textocomEstado.split(' ');

                        String nomePlaca = partes.join('');

                        x = nomePlaca.toUpperCase()
                            .replaceAll("BRASIL", '')
                            .replaceAll("BR", '')
                            .replaceAll("ACRE", '')
                            .replaceAll("ALAGOAS", '')
                            .replaceAll("ALAGOAS", '')
                            .replaceAll("AMAPÁ", '')
                            .replaceAll("AMAZONAS", '')
                            .replaceAll("AMAZONAS", '')
                            .replaceAll("BAHIA", '')
                            .replaceAll("CEARÁ", '')
                            .replaceAll("DISTRITO FEDERAL", '')
                            .replaceAll("ESPÍRITO SANTO", '')
                            .replaceAll("GOIÁS", '')
                            .replaceAll("MARANHÃO", '')
                            .replaceAll("MATO GROSSO", '')
                            .replaceAll("MATO GROSSO DO SUL", '')
                            .replaceAll("MINAS GERAIS", '')
                            .replaceAll("PARÁ", '')
                            .replaceAll("PARAÍBA", '')
                            .replaceAll("PARANÁ", '')
                            .replaceAll("PERNAMBUCO", '')
                            .replaceAll("PIAUÍ", '')
                            .replaceAll("RIO DE JANEIRO", '')
                            .replaceAll("RIO GRANDE DO NORTE", '')
                            .replaceAll("RIO GRANDE DO SUL", '')
                            .replaceAll("RONDÔNIA", '')
                            .replaceAll("RORAIMA", '')
                            .replaceAll("SANTA CATARINA", '')
                            .replaceAll("SÃO PAULO", '')
                            .replaceAll("SERGIPE", '')
                            .replaceAll("TOCANTINS", '')
                            .replaceAll("AC", '')
                            .replaceAll("AL", '')
                            .replaceAll("AP", '')
                            .replaceAll("AM", '')
                            .replaceAll("BA", '')
                            .replaceAll("CE", '')
                            .replaceAll("DF", '')
                            .replaceAll("ES", '')
                            .replaceAll("GO", '')
                            .replaceAll("MA", '')
                            .replaceAll("MT", '')
                            .replaceAll("MS", '')
                            .replaceAll("MG", '')
                            .replaceAll("PA", '')
                            .replaceAll("PB", '')
                            .replaceAll("PR", '')
                            .replaceAll("PE", '')
                            .replaceAll("PI", '')
                            .replaceAll("RJ", '')
                            .replaceAll("RN", '')
                            .replaceAll("RS", '')
                            .replaceAll("RO", '')
                            .replaceAll("RR", '')
                            .replaceAll("SC", '')
                            .replaceAll("SP", '')
                            .replaceAll("SE", '')
                            .replaceAll("TO", '')
                            .replaceAll("-", ' ')
                            .replaceAll('\n', '')
                            .replaceAllMapped(
                          RegExp(r'^([a-zA-Z]{3})([0-9a-zA-Z]{4})$'),
                              (Match m) => '${m[1]} ${m[2]}',
                        ).trim();

                        tratado = x;

                        picture = null;

                        Navigator.of(context).pop();

                        String anterior = x;

                        TextEditingController placaveiculointerface = TextEditingController();

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {

                              placaveiculointerface.text = x;

                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    'Placa Extraida!',
                                    style: TextStyle(
                                        fontSize: tamanhotexto
                                    ),
                                  ),
                                ),
                                actions: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            'A placa descrita logo a baixo foi extraida! A placa extraida condiz com a placa real? Se não, edite antes de mandar!',
                                            style: TextStyle(
                                                fontSize: tamanhotexto
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          child: TextFormField(
                                            controller: placaveiculointerface,
                                            onChanged: (valor){
                                              x = valor.trim().toUpperCase();
                                              //Mudou mandou para a String
                                            },
                                            keyboardType: TextInputType.name,
                                            enableSuggestions: false,
                                            autocorrect: false,
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(),
                                              hintText: 'Placa',
                                              hintStyle: TextStyle(
                                                  fontSize: tamanhotexto
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  fontSize: tamanhotextobtns
                                              ),
                                            )
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              child: ElevatedButton(onPressed: () {

                                                if(x != anterior){
                                                  FirebaseFirestore.instance.collection('LogDaCamera').doc().set({
                                                  'TextoOriginal': anterior,
                                                  'TextoModificado': x
                                                  });
                                                }

                                                //Portaria
                                                if(widget.EntradaouSaida == 'Rele01'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listEntrada(widget.OperadorName, widget.EntradaouSaida, x);
                                                      }));
                                                }

                                                if(widget.EntradaouSaida == 'Rele03'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listEntrada(widget.OperadorName, widget.EntradaouSaida, x);
                                                      }));
                                                }

                                                if(widget.EntradaouSaida == 'Rele02'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listaSaida(widget.OperadorName, widget.EntradaouSaida, x);
                                                      }));
                                                }

                                                if(widget.EntradaouSaida == 'Rele04'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listaSaida(widget.OperadorName, widget.EntradaouSaida, x);
                                                      }));
                                                }

                                                //Empresa
                                                if(widget.EntradaouSaida == 'LiberaçãoEmpresa'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return liberacoesOperadorEmpresarial(widget.OperadorName, widget.empresaName, x);
                                                      }));
                                                }

                                                if(widget.EntradaouSaida == 'Entrada Colaborador Porteiros'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return PesquisaPlaca(widget.OperadorName, x);
                                                      }));
                                                }

                                                if(widget.EntradaouSaida == 'Saída Colaborador Porteiros'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return PesquisaPlacaSaida(widget.OperadorName, x);
                                                      }));
                                                }

                                              }, child: Text(
                                                'Prosseguir',
                                                style: TextStyle(
                                                    fontSize: tamanhotextobtns
                                                ),
                                              )
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                              }
                            );


                          },
                        );
                      });

                    }, child: Text(
                      'Tirar foto',
                      style: TextStyle(
                          fontSize: tamanhotextobtns
                      ),
                    )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () async {
                        var dbInstance = FirebaseFirestore.instance;

                        if(widget.EntradaouSaida == 'Rele01'){

                          var result = await dbInstance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          String ip_camera_entrada01 = result.get('ip_camera_entrada01');

                          Navigator.of(context).pop();
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return ipCamera(cameraIP: ip_camera_entrada01, entradaouSaida: widget.EntradaouSaida, entradaouSaidaselecionado: '', OperadorName: widget.OperadorName, empresaName: '',);
                              }));
                        }

                        if(widget.EntradaouSaida == 'Rele03'){
                          var result = await dbInstance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          String ip_camera_entrada02 = result.get('ip_camera_entrada02');

                          Navigator.of(context).pop();
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return ipCamera(cameraIP: ip_camera_entrada02, entradaouSaida: widget.EntradaouSaida, entradaouSaidaselecionado: '', OperadorName: widget.OperadorName, empresaName: '',);
                              }));
                        }

                        if(widget.EntradaouSaida == 'Rele02'){
                          var result = await dbInstance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          String ip_camera_saida01 = result.get('ip_camera_saida01');

                          Navigator.of(context).pop();
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return ipCamera(cameraIP: ip_camera_saida01, entradaouSaida: widget.EntradaouSaida, entradaouSaidaselecionado: '', OperadorName: widget.OperadorName, empresaName: '',);
                              }));
                        }
                        if(widget.EntradaouSaida == 'Rele04'){
                          var result = await dbInstance
                              .collection("Condominio")
                              .doc('condominio')
                              .get();

                          String ip_camera_saida02 = result.get('ip_camera_saida02');

                          Navigator.of(context).pop();
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return ipCamera(cameraIP: ip_camera_saida02, entradaouSaida: widget.EntradaouSaida, entradaouSaidaselecionado: '', OperadorName: widget.OperadorName, empresaName: '',);
                              }));
                        }

                        if(widget.EntradaouSaida == 'LiberaçãoEmpresa'){
                          Navigator.of(context).pop();
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return ipCamera(cameraIP: '', entradaouSaida: widget.EntradaouSaida, entradaouSaidaselecionado: '', OperadorName: widget.OperadorName, empresaName: widget.empresaName,);
                              }));
                        }

                        if(widget.EntradaouSaida == 'Entrada Colaborador Porteiros'){
                          bool Entrada01 = false;
                          bool Entrada02 = false;
                          String Entrada = '';
                          String EntradaST = '';
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                                return AlertDialog(
                                  title: const Text('Selecione a Câmera'),
                                  actions: [
                                    Center(
                                      child: Column(
                                        children: [
                                          const Text('Selecione a Câmera'),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: Entrada01,
                                                onChanged: (bool? value) async {
                                                  setState(() {
                                                    Entrada01 = value!;
                                                    Entrada02 = !value;
                                                    Entrada = 'Rele01';
                                                  });
                                                  if(Entrada01 == true){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();
                                                    EntradaST = result.get('ip_camera_entrada01');
                                                  }else if(Entrada01 == false){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();

                                                    EntradaST = result.get('ip_camera_entrada02');
                                                  }
                                                },
                                              ),
                                              Text(
                                                'Câmera Entrada 01',
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: Entrada02,
                                                onChanged: (bool? value) async {
                                                  setState(() {
                                                    Entrada01 = !value!;
                                                    Entrada02 = value;
                                                    Entrada = 'Rele03';
                                                  });
                                                  if(Entrada02 == true){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();

                                                    EntradaST = result.get('ip_camera_entrada02');
                                                  }else if(Entrada02 == false){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();
                                                    EntradaST = result.get('ip_camera_entrada01');
                                                  }
                                                },
                                              ),
                                              Text(
                                                'Câmera Entrada 02',
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.pop(context);
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context){
                                                      return ipCamera(cameraIP: EntradaST, entradaouSaida: widget.EntradaouSaida, entradaouSaidaselecionado: '', OperadorName: widget.OperadorName, empresaName: widget.empresaName,);
                                                    }));
                                              }, child: const Text('Prosseguir')
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },);
                            },
                          );
                        }

                        if(widget.EntradaouSaida == 'Saída Colaborador Porteiros'){
                          bool Entrada01 = false;
                          bool Entrada02 = false;
                          String EntradaST = '';
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                                return AlertDialog(
                                  title: const Text('Selecione a Câmera'),
                                  actions: [
                                    Center(
                                      child: Column(
                                        children: [
                                          const Text('Selecione a Câmera'),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: Entrada01,
                                                onChanged: (bool? value) async {
                                                  setState(() {
                                                    Entrada01 = value!;
                                                    Entrada02 = !value;
                                                  });
                                                  if(Entrada01 == true){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();
                                                    EntradaST = result.get('ip_camera_saida02');
                                                  }else if(Entrada01 == false){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();

                                                    EntradaST = result.get('ip_camera_saida01');
                                                  }
                                                },
                                              ),
                                              Text(
                                                'Câmera Saida 01',
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: Entrada02,
                                                onChanged: (bool? value) async {
                                                  setState(() {
                                                    Entrada01 = !value!;
                                                    Entrada02 = value;
                                                  });
                                                  if(Entrada02 == true){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();
                                                    EntradaST = result.get('ip_camera_saida02');
                                                  }else if(Entrada02 == false){
                                                    var result = await dbInstance
                                                        .collection("Condominio")
                                                        .doc('condominio')
                                                        .get();

                                                    EntradaST = result.get('ip_camera_saida01');
                                                  }
                                                },
                                              ),
                                              Text(
                                                'Câmera Saida 02',
                                                style: TextStyle(
                                                    fontSize: tamanhotexto,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.pop(context);
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context){
                                                      return ipCamera(cameraIP: EntradaST, entradaouSaida: widget.EntradaouSaida, entradaouSaidaselecionado: '', OperadorName: widget.OperadorName, empresaName: widget.empresaName,);
                                                    }));
                                              }, child: const Text('Prosseguir')
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },);
                            },
                          );
                        }

                      },
                      child: Text(
                          'Ir para Camera IP',
                        style: TextStyle(
                          fontSize: tamanhotextobtns
                        ),
                      ),
                    ),
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
          )
      );

    });


  }
}