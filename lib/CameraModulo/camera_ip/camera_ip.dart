import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/PesquisaPlacaSaida.dart';
import 'package:glk_controls/ModuloPrestador/geral/pesquisa/pesquisaPlaca.dart';
import 'package:glk_controls/listas/liberacoesOperadorEmpresarial.dart';
import 'package:glk_controls/listas/listaEntrada.dart';
import 'package:glk_controls/listas/listaSaida.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

//Programado por HeroRickyGames
//Tecnologia feita pela Google e a equipe do VLC

final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
String extractedText = '';

class ipCamera extends StatefulWidget {
  final String cameraIP;
  final String entradaouSaida;
  final String entradaouSaidaselecionado;
  final String OperadorName;
  final String empresaName;
  ipCamera({super.key, required this.cameraIP, required this.entradaouSaida, required this.entradaouSaidaselecionado, required this.OperadorName, required this.empresaName});

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  @override
  State<ipCamera> createState() => _ipCameraState();
}
String textocomEstado = '';
class _ipCameraState extends State<ipCamera> {
  String text = "";
  String tratado = '';
  late VlcPlayerController _videoPlayerController;

  disposer() async {
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      widget.cameraIP,
      hwAcc: HwAcc.auto,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
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

      _videoPlayerController.setVideoScale(1.3);

      return Scaffold(
          appBar: AppBar(
            title: const Text('Camera IP'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        'Observação: Algumas Vezes é comum que a ip camera demore para se exibida!',
                      style: TextStyle(
                        fontSize: tamanhotexto
                      ),
                    )
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: VlcPlayer(
                    controller:
                  _videoPlayerController,
                    aspectRatio: 16 / 9,
                    placeholder: const Center(
                        child: CircularProgressIndicator()
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(onPressed: () async {

                    Uint8List videoFrame = await _videoPlayerController.takeSnapshot();



                    final dir = (await getTemporaryDirectory()).path;
                    final imageFile = File('$dir/b.png')..writeAsBytesSync(videoFrame);
                    final image = InputImage.fromFile(imageFile);



                    String Anterior = '';
                    final result = await textRecognizer.processImage(image);

                    setState(() {
                      extractedText = result.text.toUpperCase()
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
                          .replaceAll("SÃO BERNARDO DOS CAMPOS", '')
                          .replaceAll("GUARULHOS", '')
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
                          .replaceAll('\n', '');
                      Anterior = extractedText;
                    });


                    TextEditingController placaveiculointerface = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {

                              placaveiculointerface.text = extractedText;

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
                                              extractedText = valor.trim().toUpperCase();
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

                                                if(extractedText != Anterior){
                                                  FirebaseFirestore.instance.collection('LogDaCamera').doc().set({
                                                    'TextoOriginal': Anterior,
                                                    'TextoModificado': extractedText
                                                  });
                                                }

                                                //Portaria
                                                if(widget.entradaouSaida == 'Rele01'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listEntrada(widget.OperadorName, widget.entradaouSaida, extractedText);
                                                      }));
                                                }

                                                if(widget.entradaouSaida == 'Rele03'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listEntrada(widget.OperadorName, widget.entradaouSaida, extractedText);
                                                      }));
                                                }

                                                if(widget.entradaouSaida == 'Rele02'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listaSaida(widget.OperadorName, widget.entradaouSaida, extractedText);
                                                      }));
                                                }

                                                if(widget.entradaouSaida == 'Rele04'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return listaSaida(widget.OperadorName, widget.entradaouSaida, extractedText);
                                                      }));
                                                }

                                                //Empresa
                                                if(widget.entradaouSaida == 'LiberaçãoEmpresa'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return liberacoesOperadorEmpresarial(widget.OperadorName, widget.empresaName, extractedText);
                                                      }));
                                                }

                                                if(widget.entradaouSaida == 'Entrada Colaborador Porteiros'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return PesquisaPlaca(widget.OperadorName, extractedText);
                                                      }));
                                                }

                                                if(widget.entradaouSaida == 'Saída Colaborador Porteiros'){
                                                  Navigator.of(context).pop();
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context){
                                                        return PesquisaPlacaSaida(widget.OperadorName, extractedText);
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

                    print('Texto Extraido: $extractedText');
                    print('Fim');

                  }, child: Text(
                      'Tirar foto',
                    style: TextStyle(
                        fontSize: tamanhotextobtns
                    ),
                  )
                  ),
                ),
                Text(
                    'Texto extraido: $extractedText',
                  style: TextStyle(
                      fontSize: tamanhotexto
                  ),
                )
              ],
            ),
          ));

    });
  }
}