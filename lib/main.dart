import 'dart:async';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glk_controls/mainActivityPrepare.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Programado por HeroRickyGames

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
              onPrimary: Colors.white
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: const loginScreen(),
    ),
  );
}

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

calltoprepare(context) async {
  ConnectivityUtils.instance
    ..serverToPing =
        "https://raw.githubusercontent.com/HeroRickyGAMES/glk_controlls/master/onlineCheck.txt"
    ..verifyResponseCallback =
        (response) => response.contains("estaOnline");

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

  String introPath = '';
  bool telagrande = false;
  @override
  Widget build(BuildContext context) {
    if(kIsWeb){
      SystemChrome.setApplicationSwitcherDescription(
          const ApplicationSwitcherDescription(
            label: 'GLK CONTROLS',
          ));
    }

    Timer(const Duration(seconds: 10), () {

      calltoprepare(context);
    });
    return LayoutBuilder(builder: (context, constrain){

          if(constrain.maxWidth < 600){
            introPath = 'assets/glkcontrols-init.gif';
            telagrande = false;
          }
          if(constrain.maxWidth > 600){
            introPath = 'assets/introtelagrande.gif';
            telagrande = true;
          }

        return Scaffold(
          body: Center(
            child: telagrande == true? Image.asset(
              introPath,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ):
            Image.asset(
              introPath,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            )
          ),
        );
    });

  }
}
