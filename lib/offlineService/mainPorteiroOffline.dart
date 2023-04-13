import 'package:flutter/material.dart';

class mainPorteiroOff extends StatefulWidget {
  const mainPorteiroOff({Key? key}) : super(key: key);

  @override
  State<mainPorteiroOff> createState() => _mainPorteiroOffState();
}

class _mainPorteiroOffState extends State<mainPorteiroOff> {

  conectarDB() async {

  }

  @override
  void initState() {
    conectarDB();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Liberação offline'),
      ),
      body: Center(
        child: Text('Centro'),
      ),
    );
  }
}
