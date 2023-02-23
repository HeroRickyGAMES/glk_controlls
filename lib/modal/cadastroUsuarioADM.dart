import 'package:flutter/material.dart';

class cadastroUsuarioModal extends StatefulWidget {
  const cadastroUsuarioModal({Key? key}) : super(key: key);

  @override
  State<cadastroUsuarioModal> createState() => _cadastroUsuarioModalState();
}

class _cadastroUsuarioModalState extends State<cadastroUsuarioModal> {
  String? tipos;
  String? cnpjourg = 'RG';
  String? NomeOuRazao = 'Nome completo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro Users")
      ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: RadioListTile(
              title: Text(
                "Operador",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              value: "porteiro",
              groupValue: tipos,
              onChanged: (value){
                setState(() {
                  tipos = value.toString();
                  cnpjourg = 'Seu RG';
                  NomeOuRazao = 'Seu Nome completo';
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: RadioListTile(
              title: Text(
                "Empresa",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              value: "empresa",
              groupValue: tipos,
              onChanged: (value){
                setState(() {
                  tipos = value.toString();
                  cnpjourg = 'CNPJ da Empresa';
                  NomeOuRazao = 'Razão Social';
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (value){

              },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nome Completo',
              hintStyle: TextStyle(
                  fontSize: 20
              ),
            ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (value){

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'RG',
                hintStyle: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (value){

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
                hintStyle: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (value){

              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Senha',
                hintStyle: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
                onPressed: (){

            },
                child:
                Text(
                    'Cadastrar usuario',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
            ),
          )
        ],
      ),
    ),
    );
  }
}
