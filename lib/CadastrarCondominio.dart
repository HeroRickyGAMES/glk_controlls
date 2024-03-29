import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enhanced_url_launcher/enhanced_url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

//Programado por HeroRickyGames

class CadastroCondominio extends StatefulWidget {

  var dropValue;
  File? imageFile;
  File? imageFile2;
  String empresa = '';
  String endereco = '';
  String cep = '';
  String cidade = '';
  String estadoSelecionado = '';
  String galpaost = '';
  String vagas = '';
  String tags = '';
  String vagasInternas = '';
  String vagasMoto = '';
  String emailADM = '';
  String EstadoSelecionado = '';
  String entrada01CamIP = '';
  String entrada02CamIP = '';
  String saida01CamIP = '';
  String saida02CamIP = '';
  CadastroCondominio(this.dropValue, this.imageFile, this.imageFile2, this.empresa, this.endereco, this.cep, this.cidade, this.estadoSelecionado, this.galpaost, this.vagas, this.tags, this.vagasInternas, this.vagasMoto, this.emailADM, this.EstadoSelecionado, this.entrada01CamIP, this.entrada02CamIP, this.saida01CamIP, this.saida02CamIP, {super.key});

  @override
  State<CadastroCondominio> createState() => _CadastroCondominioState();
}

class _CadastroCondominioState extends State<CadastroCondominio> {

  bool start = false;
  
  String empresa = '';
  String endereco = '';
  String cep = '';
  String cidade = '';
  String estadoSelecionado = '';
  String galpaost = '';
  String vagas = '';
  String vagasInternas = '';
  String vagasMoto = '';
  String tagsNum = '';
  String emailADM = '';
  String entrada01CamIP = '';
  String entrada02CamIP = '';
  String saida01CamIP = '';
  String saida02CamIP = '';
  int tags = 0;
  bool tirado = false;

  List EmpresasOpc = [
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Distrito Federal',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Roraima',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins',
  ];

  TextEditingController empresaController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController galpaoController = TextEditingController();
  TextEditingController vagasController = TextEditingController();
  TextEditingController vagasInternasController = TextEditingController();
  TextEditingController vagasMotoController = TextEditingController();
  TextEditingController tagsNumbers = TextEditingController();
  TextEditingController emailADMController = TextEditingController();
  TextEditingController entrada01CamIPController = TextEditingController();
  TextEditingController entrada02CamIPController = TextEditingController();
  TextEditingController saida01CamIPController = TextEditingController();
  TextEditingController saida02CamIPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    File? imageFile = widget.imageFile;
    File? imageFile2 = widget.imageFile2;

    if(start == false){
      empresa = widget.empresa;
      endereco = widget.endereco;
      cep = widget.cep;
      cidade = widget.cidade;
      galpaost = widget.galpaost;
      vagas = widget.vagas;
      vagasMoto = widget.vagasMoto;
      vagasInternas = widget.vagasInternas;
      emailADM = widget.emailADM;
      tags = int.parse(widget.tags);
      entrada01CamIP = widget.entrada01CamIP;
      entrada02CamIP = widget.entrada02CamIP;
      saida01CamIP = widget.saida01CamIP;
      saida02CamIP = widget.saida02CamIP;
      estadoSelecionado = widget.EstadoSelecionado;
      empresaController = TextEditingController(text: empresa);
      enderecoController = TextEditingController(text: endereco);
      cepController = TextEditingController(text: cep);
      cidadeController = TextEditingController(text: cidade);
      galpaoController = TextEditingController(text: galpaost);
      vagasController = TextEditingController(text: vagas);
      vagasInternasController = TextEditingController(text: vagasInternas);
      vagasMotoController = TextEditingController(text: vagasMoto);
      tagsNumbers = TextEditingController(text: '$tags');
      emailADMController = TextEditingController(text: emailADM);
      entrada01CamIPController = TextEditingController(text: entrada01CamIP);
      entrada02CamIPController = TextEditingController(text: entrada02CamIP);
      saida01CamIPController = TextEditingController(text: saida01CamIP);
      saida02CamIPController = TextEditingController(text: saida02CamIP);
    }
    
    

    final FirebaseStorage storage = FirebaseStorage.instance;

    setState(() {
      start = true;
    });

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

    final textSizeandroid = (textWidth / dpi / 15) * textScaleFactor;
    final textSizeandroidbtn = (textWidth / dpi / 13) * textScaleFactor;

    if(Platform.isAndroid){

      tamanhotexto = textSizeandroid;
      tamanhotextobtns = textSizeandroidbtn;
      aspect = 0.8;

    }

    Future<File?> _getImageFromCamera() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      return File(pickedFile!.path);
    }
    Future<void> _uploadImage() async {
      imageFile = await _getImageFromCamera();
      setState(() {

        tirado = true;

        imageFile = imageFile;
        imageFile2 = imageFile;
        widget.imageFile = imageFile;
        widget.imageFile2 = imageFile2;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(''),
              actions: [
                TextButton(onPressed: (){
                  _uploadImage();
                },
                  child: Image.file(imageFile!,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                      child: const Text('Prosseguir'),
                    ),
                  ],
                ),
              ],
            );
          },
        );

      });
    }

    Future<String> _uploadImageToFirebase(File file, String id) async {
      // Crie uma referência única para o arquivo

      Fluttertoast.showToast(
          msg: 'Fazendo upload do logo para o banco de dados!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.white,
          fontSize: 16.0
      );

      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$id/$fileName');

      // Faça upload da imagem para o Cloud Storage
      await reference.putFile(file);

      // Recupere a URL do download da imagem para salvar no banco de dados
      final url = await reference.getDownloadURL();
      return url;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configuração do Condominio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                  'Empresa: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: empresaController,
                onChanged: (valor){
                  setState(() {
                    empresa = valor.trim();
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Empresa *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Endereço: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: enderecoController,
                onChanged: (valor){
                  setState(() {
                    endereco = valor;
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Endereço *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'CEP: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: cepController,
                onChanged: (valor){
                  setState(() {
                    cep = valor;
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'CEP *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Cidade: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: cidadeController,
                onChanged: (valor){
                  setState(() {
                    cidade = valor.trim();
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cidade *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Center(
                child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                  return DropdownButton(
                    hint: const Text(
                      'Estado',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    value: (value.isEmpty) ? widget.EstadoSelecionado : value,
                    onChanged: (escolha) async {
                      setState(() {
                        widget.dropValue.value = escolha.toString();

                        estadoSelecionado = escolha.toString();
                      });
                    },
                    items: EmpresasOpc.map((opcao) => DropdownMenuItem(
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
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Quantidade de Galpões: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: galpaoController,
                onChanged: (valor){
                  setState(() {
                    galpaost = valor;
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de Galpões *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Email ADM: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailADMController,
                onChanged: (valor){
                  setState(() {
                    emailADM = valor;
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email ADM *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Vagas Cargas: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: vagasController,
                onChanged: (valor){
                  setState(() {
                    vagas = valor;
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Vagas Cargas *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Vagas motos: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: vagasMotoController,
                onChanged: (valor){
                  setState(() {
                    vagasMoto = valor;
                  });
                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Vagas Motos *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Vagas Internas: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: vagasInternasController,
                onChanged: (valor){
                  setState(() {
                    widget.vagasInternas = valor;
                    vagasInternas = valor;
                  });


                  //Mudou mandou para a String
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Vagas Internas *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Quantidade de TAGS: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState(() {
                    tags = int.parse(valor);
                  });
                  //Mudou mandou para a String
                },
                controller: tagsNumbers,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantidade de TAGS *',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Para verificar o IP de cada camera faça o passo a passo a seguir: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: AlertDialog(
                          title: Text(
                              'Como conectar uma Camera IP no GLK Controls?',
                            style: TextStyle(
                              fontSize: tamanhotextobtns,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          actions: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text('O primeiro passo para conseguir conectar uma Câmera IP ao app é baixar o aplicativo UniCam na PlayStore',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Uri uri = Uri.parse("https://play.google.com/store/apps/details?id=com.nittbit.mvr.android");
                                      if (!await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                      )) {
                                      throw Exception('Could not launch $uri');
                                      }
                                    },
                                    child: Text(
                                        'Baixe agora!',
                                      style: TextStyle(
                                          fontSize: tamanhotexto,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                          'Pós baixar o aplicativo, agora é só abrir o APP',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/1passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                          'Quando aberto, clique em Conectar',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/2passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                          'Ele irá verificar se existe alguma Camera IP em sua rede local.',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/3passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                          'Algumas vezes pode ser que não seja exibida a camera, então clique em Add device manually',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/4passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                          'Preencha todas as informações como nome da camera, endereço IP, porta, e a parte de autenticação',
                                        style: TextStyle(
                                          fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/5passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/6passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Quando a configuração terminada, clique em Not now',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/7passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Logo em seguida irá aparecer a Camera configurada na lista, clique nela',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/8passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Se tudo ocorrer bem, teremos uma visualização da Câmera Ip',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/9passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Com tudo isso pronto, agora vamos clicar e segurar na Camera',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/10passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Logo aparecerá algumas coisas diferentes na barra da aplicação, clique no botão do lapis para editar',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/11passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Vai aparecer todas as configurações da camera no app, clique em CHANNELS e selecione a Camera1 ou qualquer que esteja aparecendo a baixo do CHANNELS',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/12passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Logo vai aparecer alguns RTSP dessa camera, use a primeira que normalmente tem mais qualidade.',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/13passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Image.asset('assets/tuto/14passo.png')
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'E pronto, você já tem um IP de uma camera, agora verifique de qual setor ele é e configure corretamente no app, copiando e colando aqui no GLK Controls.',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Para continuar consultando o RTSP de outras cameras é só clicar no + e fazer a configuração de outra camera, assim obtendo o RTSP de cada camera para cada setor',
                                        style: TextStyle(
                                            fontSize: tamanhotexto
                                        ),
                                      )
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                            'Fechar essa janela',
                                          style: TextStyle(
                                              fontSize: tamanhotexto
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );

                },
                child: const Text('Como conectar uma Câmera IP no GLK CONTROLS?'),
              )
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'RTSP da Camera IP Entrada 01: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState(() {
                    entrada01CamIP = valor.trim();
                  });
                  //Mudou mandou para a String
                },
                controller: entrada01CamIPController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'RTSP Camera IP Entrada 01',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'RTSP Camera IP Entrada 02: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState(() {
                    entrada02CamIP = valor.trim();
                  });
                  //Mudou mandou para a String
                },
                controller: entrada02CamIPController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'RTSP Camera IP Entrada 02',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'RTSP Camera IP Saida 01: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState(() {
                    saida01CamIP = valor.trim();
                  });
                  //Mudou mandou para a String
                },
                controller: saida01CamIPController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'RTSP Camera IP Saida 01',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'RTSP Camera IP Saida 02: ',
                style: TextStyle(
                  fontSize: tamanhotexto,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                onChanged: (valor){
                  setState(() {
                    saida02CamIP = valor.trim();
                  });
                  //Mudou mandou para a String
                },
                controller: saida02CamIPController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'RTSP Camera IP Saida 02',
                  hintStyle: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(''),
                            actions: [
                              TextButton(onPressed: (){
                                _uploadImage();
                                Navigator.of(context).pop();
                              },
                                child: Image.file(imageFile!,),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {

                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Prosseguir'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Logo',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                  Image.file(
                    imageFile2!,
                    width: 200,
                    height: 200,
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red
                    ),
                      child: Text(
                          'Cancelar',
                        style: TextStyle(
                            fontSize: tamanhotextobtns
                        ),
                      ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {

                      if(empresa == ''){
                        Fluttertoast.showToast(
                            msg: 'Preencha o campo de Empresa',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey[600],
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                        if(endereco == ''){
                          Fluttertoast.showToast(
                              msg: 'Preencha o campo do Endereço',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey[600],
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          if(cep == ''){
                            Fluttertoast.showToast(
                                msg: 'Preencha o campo do CEP',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey[600],
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else{
                            if(cidade == ''){
                              Fluttertoast.showToast(
                                  msg: 'Preencha o campo da cidade',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey[600],
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }else{
                              if(estadoSelecionado == ''){
                                Fluttertoast.showToast(
                                    msg: 'Selecione um Estado',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[600],
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else{
                                if(galpaost == ''){
                                  Fluttertoast.showToast(
                                      msg: 'Preencha o campo de galpão',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[600],
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else{
                                  if(emailADM == ''){
                                    Fluttertoast.showToast(
                                        msg: 'Preencha o Email do ADM',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey[600],
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }else{
                                    if(vagas == ''){
                                      Fluttertoast.showToast(
                                          msg: 'Preencha o campo de vagas cagas',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey[600],
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }else{
                                      if(vagasInternas == ''){
                                        Fluttertoast.showToast(
                                            msg: 'Digite as vagas internas!',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey[600],
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }else{
                                        if(vagasMoto == ''){
                                          Fluttertoast.showToast(
                                              msg: 'Digite as vagas de Motos!',
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.grey[600],
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }else{
                                          if(tags == 0){
                                            Fluttertoast.showToast(
                                                msg: 'Preencha o campo de tags disponiveis',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.grey[600],
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }else{
                                            if(tirado == false){
                                              Fluttertoast.showToast(
                                                  msg: 'Coloque um logo!',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey[600],
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                            }else{
                                              //todo para o db firebase
                                              String idd = 'condominio';

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

                                              final imageUrl = await _uploadImageToFirebase(imageFile!, idd);
                                              Map<String, String> tagsDisp = {};

                                              int number = tags;

                                              for (int i = number; i >= 1; i--) {
                                                tagsDisp.addAll({ '$i': 'naoUsado'});

                                                if(tagsDisp.length == number){
                                                  FirebaseFirestore.instance.collection('Condominio').doc(idd).update({
                                                    'Empresa': empresa,
                                                    'Endereço': endereco,
                                                    'cep': cep,
                                                    'cidade': cidade,
                                                    'estado': estadoSelecionado,
                                                    'galpoes': int.parse(galpaost),
                                                    'vagas': int.parse(vagas),
                                                    'tags': tagsDisp,
                                                    'imageURL': imageUrl,
                                                    'maxGalpoes': int.parse(galpaost),
                                                    'VagasPrestadores': double.parse(vagasInternas) + 0.0,
                                                    'VagasMotos': double.parse(vagasMoto) + 0.0,
                                                    'emailADM': emailADM,
                                                    'ip_camera_entrada01': entrada01CamIP,
                                                    'ip_camera_entrada02': entrada02CamIP,
                                                    'ip_camera_saida01': saida01CamIP,
                                                    'ip_camera_saida02': saida02CamIP,
                                                  }).then((value){
                                                    Navigator.of(context).pop();
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg: 'Dados enviados com sucesso!',
                                                        toastLength: Toast.LENGTH_LONG,
                                                        gravity: ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.grey[600],
                                                        textColor: Colors.white,
                                                        fontSize: 16.0
                                                    );
                                                  });
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
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
                    'Prosseguir',
                  style: TextStyle(
                      fontSize: tamanhotextobtns
                  ),
                )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
