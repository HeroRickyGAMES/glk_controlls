import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class releModalConfig extends StatefulWidget {
  String urlPadrao;
  releModalConfig(this.urlPadrao);

  @override
  State<releModalConfig> createState() => _releModalConfigState();
}

class _releModalConfigState extends State<releModalConfig> {



  @override
  Widget build(BuildContext context) {
    String urlString = widget.urlPadrao;
    TextEditingController urlStringRele = TextEditingController(text: widget.urlPadrao);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configurações de Relê'),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: urlStringRele,
              onChanged: (valor){
                urlString = valor;
                //Mudou mandou para a String
              },
              keyboardType: TextInputType.number,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'URL do Relê * ',
                hintStyle: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: (){

                if(urlString == ''){

                  Fluttertoast.showToast(
                      msg: 'Preencha o campo da URL do Relê!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[600],
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }else{

                  Fluttertoast.showToast(
                      msg: 'Enviando ao servidor!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[600],
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                  FirebaseFirestore.instance.collection('Server').doc('serverValues').set({
                    'URLRele': urlString
                  }).then((value){
                    Fluttertoast.showToast(
                        msg: 'Enviado com sucesso!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    Navigator.pop(context);
                  });

                }

              },
              child: Text(
                'Prosseguir',
                style: TextStyle(
                   fontSize: 16
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
