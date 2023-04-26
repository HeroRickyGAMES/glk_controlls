import 'dart:async';
import 'package:flutter/material.dart';
import 'package:glk_controls/mainActivityPrepare.dart';
//Programado por HeroRickyGames

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        //brightness: Brightness.dark,
        //useMaterial3: true,
        //primaryColor: Colors.white,
      ),
      home: const loginScreen(),
    ),
  );
}

calltoprepare(context){
  String calloff = 'NaoAtivo';
  Navigator.pop(context);
  Navigator.push(context,
      MaterialPageRoute(builder: (context){
        return mainActivityPrepare(calloff);
      }));
}
class loginScreen extends StatefulWidget {

  const loginScreen();

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {



  final emailController = TextEditingController();
  final passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    Timer(const Duration(seconds: 8), () {

      calltoprepare(context);
    });
    return Scaffold(
      body: Image.asset(
          'assets/glkcontrols-init.gif',
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
   );
  }
}
