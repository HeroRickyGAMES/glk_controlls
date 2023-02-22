import 'package:flutter/material.dart';
import 'package:glk_controls/modal/cadastroUsuarioADM.dart';

class setorADM extends StatefulWidget {
  const setorADM({Key? key}) : super(key: key);

  @override
  State<setorADM> createState() => _setorADMState();
}

class _setorADMState extends State<setorADM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SETOR ADIMISTRATIVO'),
      ),
      body: Text('data'),
      floatingActionButton:
      FloatingActionButton(
        child: Icon(
          Icons.add
        ),
          onPressed: (){
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return cadastroUsuarioModal();
                }));
        }
      ),
    );
  }
}
