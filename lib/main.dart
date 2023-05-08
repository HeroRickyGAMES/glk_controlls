import 'dart:async';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:glk_controls/mainActivityPrepare.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

calltoprepare(context) async {
  ConnectivityUtils.instance
    ..serverToPing =
        "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt"
    ..verifyResponseCallback =
        (response) => response.contains("This is a test!");

  if(await ConnectivityUtils.instance.isPhoneConnected()){
    final SharedPreferences prefs = await _prefs;

    bool? offlinemode =  prefs.getBool('OfflineMode');


    if(offlinemode == true){
      String calloff = 'Ativo';
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return mainActivityPrepare(calloff);
          }));
    }else{
      String calloff = 'NaoAtivo';
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return mainActivityPrepare(calloff);
          }));

    }

  }else{
    String calloff = 'Ativo';
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return mainActivityPrepare(calloff);
        }));
  }
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
      body: Center(
        child: Image.asset(
            'assets/glkcontrols-init.gif',
          fit: BoxFit.fill,
          width: 700,
          height: double.infinity,
        ),
      ),
   );
  }
}
