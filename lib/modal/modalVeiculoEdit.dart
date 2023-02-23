import 'package:flutter/material.dart';

class modalVeiculoEdit extends StatefulWidget {
  const modalVeiculoEdit({Key? key}) : super(key: key);

  @override
  State<modalVeiculoEdit> createState() => _modalVeiculoEditState();
}

class _modalVeiculoEditState extends State<modalVeiculoEdit> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Editar essa autorização'),
      ),
    );
  }
}
