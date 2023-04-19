import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:glk_controls/pesquisaDir/pesquisaNovoCadastro.dart';

//Programado Por HeroRickyGames

class modalVeiculofill extends StatefulWidget {
  final List<dynamic> EmpresasOpc;
  final dropValue;
  final String nomeUser;
  final String idEmpresa;
  final String autofillName;
  final String autofillRG;
  final dropValue2;
  final dropValue3;
  List galpaes;
  modalVeiculofill(this.EmpresasOpc, this.dropValue, this.nomeUser, this.idEmpresa, this.dropValue2, this.galpaes, this.dropValue3, this.autofillName, this.autofillRG);

  @override
  State<modalVeiculofill> createState() => _modalVeiculofillState();
}
class _modalVeiculofillState extends State<modalVeiculofill> {
  String? coletaouentrega;
  String? lacreounao;
  String? empresaSelecionada;

  List VeiculoOPC = [
    'Caminhão',
    'Caminhonete',
    'Carro de passeio',
    'Moto',
  ];

  @override
  Widget build(BuildContext context) {
    //fields
    String? nomeMotorista = widget.autofillName;
    String? RGMotorista = widget.autofillRG;
    String? Veiculo;
    String? telefone = '';
    String? VeiculoPlaca;
    String? originEmpresa;
    String? galpao;
    String? lacreSt;
    String? transportadora;
    bool lacrebool = false;
    TextEditingController nameMotoristaAllcaps = TextEditingController(text: nomeMotorista);
    TextEditingController placaveiculointerface = TextEditingController();
    TextEditingController RGController = TextEditingController(text: RGMotorista);
    TextEditingController telefoneinterface = TextEditingController();

    uploadInfos(){
      if(nomeMotorista == null){
        Fluttertoast.showToast(
          msg: 'Preencha o nome do motorista!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else{

        if(RGMotorista == null){
          Fluttertoast.showToast(
            msg: 'Preencha o RG do motorista',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }else{
          if(Veiculo == null){
            Fluttertoast.showToast(
              msg: 'Preencha tipo de veiculo!',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }else{
            if(VeiculoPlaca == null){
              Fluttertoast.showToast(
                msg: 'Preencha a placa do veiculo!',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }else{
              if(originEmpresa == null){
                Fluttertoast.showToast(
                  msg: 'Digite a empresa de origem',
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }else{
                if(galpao == null){
                  Fluttertoast.showToast(
                    msg: 'Digite o galpão',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }else{
                  if(empresaSelecionada == null){
                    Fluttertoast.showToast(
                      msg: 'Selecione uma empresa!',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }else{
                    if(coletaouentrega == null){
                      Fluttertoast.showToast(
                        msg: 'Selecione se é coleta ou entrega!',
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }else{
                      if(lacreounao == null){
                        Fluttertoast.showToast(
                          msg: 'Selecione se é com lacre ou sem!',
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else{
                        if(transportadora == ''){
                          Fluttertoast.showToast(
                            msg: 'Digite o campo de Transportadora',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }else{
                          Fluttertoast.showToast(
                            msg: 'Enviando informações para o servidor...',
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          print(lacreounao);
                          if(lacreounao == 'lacre'){

                            //registre todos os valores no db
                            var UID = FirebaseAuth.instance.currentUser?.uid;

                            var dateTime= new DateTime.now();

                            var uuid = const Uuid();

                            String idd = "${DateTime.now().toString()}" + uuid.v4();
                            FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
                              'nomeMotorista': nomeMotorista,
                              'RGDoMotorista': RGMotorista,
                              'Veiculo': Veiculo,
                              'PlacaVeiculo': VeiculoPlaca,
                              'Telefone': telefone,
                              'EmpresadeOrigin': originEmpresa,
                              'Empresa': empresaSelecionada,
                              'ColetaOuEntrega': coletaouentrega,
                              'Galpão': galpao,
                              'saidaLiberadaPor': '',
                              'uriImage': '',
                              'LacreouNao': lacreounao,
                              'QuemAutorizou': widget.nomeUser,
                              'Status': 'Em Verificação',
                              'idDoc': idd,
                              'DataEntrada': '',
                              'DataSaida': '',
                              'Lacre': lacreSt,
                              'lacrenum': lacreSt,
                              'Horario Criado': dateTime,
                              'verificadoPor': '',
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
                              widget.galpaes.removeRange(0, widget.galpaes.length);

                              var db = FirebaseFirestore.instance;
                              var UID = FirebaseAuth.instance.currentUser?.uid;
                              db.collection('Users').doc(UID).get().then((event){
                                print("${event.data()}");

                                event.data()?.forEach((key, value) async {

                                  print(key);
                                  print(value);

                                  if(key == 'nome'){
                                    String PorteiroNome = value;

                                    print('Porteiro name é' + PorteiroNome);

                                    var UID = FirebaseAuth.instance.currentUser?.uid;
                                    var result = await FirebaseFirestore.instance
                                        .collection("porteiro")
                                        .doc(UID)
                                        .get();

                                    bool cadastro = result.get('cadastrar');
                                    bool entrada = result.get('entrada');
                                    bool saida = result.get('saida');
                                    bool relatorio = result.get('relatorio');
                                    bool painel = result.get('painel');

                                    FirebaseFirestore.instance.collection('Motoristas').doc().set({
                                      'nomeMotorista': nomeMotorista,
                                      'RGDoMotorista': RGMotorista,
                                    });

                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return pesquisaCadastro(widget.nomeUser);
                                        }));

                                  }

                                });

                              }
                              );
                            });
                          }
                          if(lacreounao == 'naolacrado'){
                            //registre todos os valores no db
                            var UID = FirebaseAuth.instance.currentUser?.uid;

                            var dateTime= new DateTime.now();

                            var uuid = const Uuid();

                            String idd = "${DateTime.now().toString()}" + uuid.v4();
                            FirebaseFirestore.instance.collection('Autorizacoes').doc(idd).set({
                              'nomeMotorista': nomeMotorista,
                              'RGDoMotorista': RGMotorista,
                              'Veiculo': Veiculo,
                              'idDoc': idd,
                              'DataEntrada': '',
                              'DataSaida': '',
                              'PlacaVeiculo': VeiculoPlaca,
                              'Telefone': telefone,
                              'EmpresadeOrigin': originEmpresa,
                              'Empresa': empresaSelecionada,
                              'ColetaOuEntrega': coletaouentrega,
                              'Galpão': galpao,
                              'LacreouNao': lacreounao,
                              'QuemAutorizou': widget.nomeUser,
                              'Status': 'Em Verificação',
                              'Horario Criado': dateTime,
                              'saidaLiberadaPor': '',
                              'uriImage': '',
                              'lacrenum': '',
                              'verificadoPor': '',
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
                              widget.galpaes.removeRange(0, widget.galpaes.length);

                              var db = FirebaseFirestore.instance;
                              var UID = FirebaseAuth.instance.currentUser?.uid;
                              db.collection('Users').doc(UID).get().then((event){
                                print("${event.data()}");

                                event.data()?.forEach((key, value) async {

                                  print(key);
                                  print(value);

                                  if(key == 'nome'){
                                    String PorteiroNome = value;

                                    print('Porteiro name é' + PorteiroNome);

                                    var UID = FirebaseAuth.instance.currentUser?.uid;
                                    var result = await FirebaseFirestore.instance
                                        .collection("porteiro")
                                        .doc(UID)
                                        .get();

                                    print('cheguei aqui!');

                                    bool cadastro = result.get('cadastrar');
                                    bool entrada = result.get('entrada');
                                    bool saida = result.get('saida');
                                    bool relatorio = result.get('relatorio');
                                    bool painel = result.get('painel');

                                    FirebaseFirestore.instance.collection('Motoristas').doc().set({
                                      'nomeMotorista': nomeMotorista,
                                      'RGDoMotorista': RGMotorista,
                                    });

                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context){
                                          return pesquisaCadastro(widget.nomeUser);
                                        }));
                                  }
                                });
                              }
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
    List<dynamic> galpaes = ['Valor 1', 'Valor 2', 'Valor 3'];
    String selectedValue = galpaes[0];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(onPressed: (){

              widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
              widget.galpaes.removeRange(0, widget.galpaes.length);
              galpaes.removeRange(0, galpaes.length);

              var db = FirebaseFirestore.instance;
              var UID = FirebaseAuth.instance.currentUser?.uid;
              db.collection('Users').doc(UID).get().then((event){
                print("${event.data()}");

                event.data()?.forEach((key, value) async {

                  print(key);
                  print(value);

                  if(key == 'nome'){
                    String PorteiroNome = value;

                    print('Porteiro name é' + PorteiroNome);

                    var UID = FirebaseAuth.instance.currentUser?.uid;
                    var result = await FirebaseFirestore.instance
                        .collection("porteiro")
                        .doc(UID)
                        .get();

                    bool cadastro = result.get('cadastrar');
                    bool entrada = result.get('entrada');
                    bool saida = result.get('saida');
                    bool relatorio = result.get('relatorio');
                    bool painel = result.get('painel');


                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return pesquisaCadastro(widget.nomeUser);
                        }));

                  }

                });

              }
              );
            },
                child:
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )
            ),
            const Text('GLK Controls - Cadastro: Motorista e Veiculo'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/icon.png',
                width: 100,
                height: 100,
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: nameMotoristaAllcaps,
                  onChanged: (valor){
                    nomeMotorista = valor.toUpperCase().replaceAll(" ", '');
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome Completo do Motorista *',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    RGMotorista = valor;
                    nameMotoristaAllcaps.text = nomeMotorista!;
                    //Mudou mandou para a String
                  },
                  controller: RGController,
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'RG do Motorista (Sem digitos) * ',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Veiculo *',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue3, builder: (context, String value, _){
                    return DropdownButton(
                      hint: const Text(
                        'Selecione um tipo de Veiculo *',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue3.value = escolha.toString();

                        Veiculo = escolha.toString();

                      },
                      items: VeiculoOPC.map((opcao) => DropdownMenuItem(
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
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: placaveiculointerface,
                  onChanged: (valor){

                    String valorpuro = valor.toUpperCase();
                    VeiculoPlaca = valorpuro.replaceAllMapped(
                      RegExp(r'^([a-zA-Z]{3})([0-9]{4})$'),
                          (Match m) => '${m[1]}-${m[2]}',
                    );
                    //Mudou mandou para a String
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Placa do Veiculo * ',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    placaveiculointerface.text = VeiculoPlaca!;
                    transportadora = valor;
                    //Mudou mandou para a String
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Transportadora * ',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: telefoneinterface,
                  onChanged: (valor){
                    String valorpuro = valor.toUpperCase();
                    telefone = valorpuro.replaceAllMapped(
                      RegExp(r'^([0-9]{2})([0-9]{5})([0-9]{4})$'),
                          (Match m) => '${m[1]} ${m[2]}-${m[3]} ',
                    );
                    //Mudou mandou para a String
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Telefone',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (valor){
                    originEmpresa = valor;
                    telefoneinterface.text = telefone!;
                    //Mudou mandou para a String
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Empresa de Origem *',
                    hintStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Empresa destino *',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                  child: ValueListenableBuilder(valueListenable: widget.dropValue, builder: (context, String value, _){
                    return DropdownButton(
                      hint: const Text(
                        'Selecione uma empresa',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      value: (value.isEmpty)? null : value,
                      onChanged: (escolha) async {
                        widget.dropValue.value = escolha.toString();

                        empresaSelecionada = escolha.toString();

                      },
                      items: widget.EmpresasOpc.map((opcao) => DropdownMenuItem(
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
                padding: const EdgeInsets.only(top: 16),
                child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text(
                              "Coleta",
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            value: "coleta",
                            groupValue: coletaouentrega,
                            onChanged: (value){
                              setState(() {
                                coletaouentrega = value.toString();
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
                            title: const Text(
                              "Entrega",
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            value: "entrega",
                            groupValue: coletaouentrega,
                            onChanged: (value){
                              setState(() {
                                coletaouentrega = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Selecione um disponivel Galpão (Selecione o que bate com com o nome da empresa)*',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Center(
                      child: ValueListenableBuilder(valueListenable: widget.dropValue2, builder: (context, String value, _){
                        return DropdownButton(
                          hint: const Text(
                            'Selecione um Galpão',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                          value: (value.isEmpty)? null : value,
                          onChanged: (escolha) {
                            setState(() {
                              widget.dropValue2.value = escolha.toString();

                              galpao = escolha.toString();
                            });
                          },
                          items: widget.galpaes.map((opcao) => DropdownMenuItem(
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
              Container(
                padding: const EdgeInsets.only(top: 16),
                child:
                Column(
                  children: [
                    const Text(
                      'Está Entrando com Lacre ou Sem Lacre?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    RadioListTile(
                      title: const Text(
                        "Com Lacre",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      value: "lacre",
                      groupValue: lacreounao,
                      onChanged: (value){
                        setState(() {
                          lacreounao = value.toString();

                          if(value == 'lacre'){
                            lacrebool = true;
                          }
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text(
                        "Sem Lacre",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      value: "naolacrado",
                      groupValue: lacreounao,
                      onChanged: (value){
                        setState(() {
                          lacreounao = value.toString();

                          if(value == 'naolacrado'){
                            lacrebool = false;
                          }
                        });
                      },
                    ),
                    lacrebool ?
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                        onChanged: (valor){
                          lacreSt = valor;
                          //Mudou mandou para a String
                        },
                        //keyboardType: TextInputType.number,
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
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: uploadInfos,
                  child:
                  const Text(
                    'Adicionar novo Motorista',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  )
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
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child:
                    Text(
                      'Operador: ' + widget.nomeUser,
                      style: const TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
              WillPopScope(
                onWillPop: () async {
                  widget.EmpresasOpc.removeRange(0, widget.EmpresasOpc.length);
                  widget.galpaes.removeRange(0, widget.galpaes.length);
                  galpaes.removeRange(0, galpaes.length);

                  var UID = FirebaseAuth.instance.currentUser?.uid;
                  var result = await FirebaseFirestore.instance
                      .collection("porteiro")
                      .doc(UID)
                      .get();

                  bool cadastro = result.get('cadastrar');
                  bool entrada = result.get('entrada');
                  bool saida = result.get('saida');
                  bool relatorio = result.get('relatorio');
                  bool painel = result.get('painel');


                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return pesquisaCadastro(widget.nomeUser);
                      }));
                  // retorna false para impedir que a navegação volte à tela anterior
                  return false;
                }, child: const Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
