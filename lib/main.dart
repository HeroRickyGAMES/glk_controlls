import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glk_controls/login.dart';
import 'package:glk_controls/mainEmpresa.dart';
import 'package:glk_controls/mainPorteiro.dart';
import 'package:glk_controls/operadorEmpresarial.dart';
import 'package:glk_controls/setorADM.dart';
import 'anteLogin.dart';
import 'firebase_options.dart';

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

 checkislog(context) async {
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   await FirebaseAuth.instance
       .idTokenChanges()
       .listen((User? user) {
     if (user == null) {

       print('User is currently signed out!');
       Navigator.pop(context);
       Navigator.push(context,
           MaterialPageRoute(builder: (context){
             return anteLogin();
           }));

     } else {

       var UID = FirebaseAuth.instance.currentUser?.uid;

       var db = FirebaseFirestore.instance;
       db.collection('Users').doc(UID).get().then((event){
         print("${event.data()}");

         event.data()?.forEach((key, value) {

           print(key);
           print(value);

           if(value == 'ADM'){

             var db = FirebaseFirestore.instance;
             var UID = FirebaseAuth.instance.currentUser?.uid;
             db.collection('Users').doc(UID).get().then((event){
               print("${event.data()}");

               event.data()?.forEach((key, value) {

                 print(key);
                 print(value);

                 if(key == 'nome'){
                   String ADMName = value;

                   print('O ADM é ' + ADMName);

                   var db = FirebaseFirestore.instance;
                   var UID = FirebaseAuth.instance.currentUser?.uid;
                   db.collection('Users').doc(UID).get().then((event){
                     print("${event.data()}");

                     Navigator.pop(context);
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context){
                           return setorADM(ADMName);
                         }));
                   }
                   );
                 }

               });

             }
             );
             print('Ele é um ADM');
             //Passar o codigo para mandar a tela
           }

           if(value == 'porteiro'){

             var db = FirebaseFirestore.instance;
             var UID = FirebaseAuth.instance.currentUser?.uid;
             db.collection('Users').doc(UID).get().then((event){
               print("${event.data()}");

               event.data()?.forEach((key, value) {

                 print(key);
                 print(value);

                 if(key == 'nome'){
                   String PorteiroNome = value;

                   print('Porteiro name é' + PorteiroNome);

                   var db = FirebaseFirestore.instance;
                   var UID = FirebaseAuth.instance.currentUser?.uid;
                   db.collection('Users').doc(UID).get().then((event){
                     print("${event.data()}");

                     event.data()?.forEach((key, value) async {

                       print(key);
                       print(value);

                       if(key == 'estaativo'){
                         if(value == true){

                           print('Porteiro name é' + PorteiroNome);

                           var result = await FirebaseFirestore.instance
                               .collection("porteiro")
                               .doc(UID)
                               .get();

                           bool cadastro = result.get('cadastrar');
                           bool entrada = result.get('entrada');
                           bool saida = result.get('saida');
                           bool relatorio = result.get('relatorio');
                           bool painel = result.get('painel');


                           var resulte = await FirebaseFirestore.instance
                               .collection("Condominio")
                               .doc('condominio')
                               .get();

                           String logoPath = resulte.get('imageURL');

                           Navigator.pop(context);
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context){
                                 return mainPorteiro(PorteiroNome, cadastro, entrada, saida, relatorio, painel, logoPath);
                               }));

                         }else{

                           print('O está ativo está funcionando!');

                           AlertDialog alert = AlertDialog(
                             title: Text("Sua conta ainda não está ativa!"),
                             content: Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                             actions: [
                               TextButton(
                                   onPressed: (){
                                     SystemNavigator.pop();
                                   },
                                   child: Text('Ok')
                               ),
                             ],
                           );

                           showDialog(
                             context: context,
                             builder: (BuildContext context) {
                               return alert;
                             },
                           );
                         }


                       }

                     });

                   }
                   );
                 }

               });

             }
             );
             print('Ele é um porteiro');
             //Passar o codigo para mandar a tela
           }

           if(value == 'empresa'){
             print('Ele é uma empresa');

             db.collection('Users').doc(UID).get().then((event){
               print("${event.data()}");

               event.data()?.forEach((key, value) {

                 print(key);
                 print(value);

                 bool relatorio = false;

                 if(key == 'nome'){
                   print('É uma empresa');
                   String nome = value;
                   //Passar o codigo para mandar a tela
                   var db = FirebaseFirestore.instance;
                   var UID = FirebaseAuth.instance.currentUser?.uid;
                   db.collection('Users').doc(UID).get().then((event){
                     print("${event.data()}");

                     event.data()?.forEach((key, value) {

                       print(key);
                       print(value);

                       if(key == 'estaativo'){
                         if(value == true){

                           var db2 = FirebaseFirestore.instance;
                           db2.collection('Users').doc(UID).get().then((event){
                             print("${event.data()}");

                             event.data()?.forEach((key, value) {

                               print(key);
                               print(value);

                               if(key == 'nome'){
                                 print('É uma empresa');
                                 String nome = value;
                                 //Passar o codigo para mandar a tela
                                 var db = FirebaseFirestore.instance;
                                 var UID = FirebaseAuth.instance.currentUser?.uid;
                                 db.collection('Users').doc(UID).get().then((event){
                                   print("${event.data()}");

                                   event.data()?.forEach((key, value) {

                                     print(key);
                                     print(value);

                                     if(key == 'RelatorioDays'){

                                       String dayHj = '${DateTime.now().day}';
                                       print('Dia do relatiorio são ${value}');
                                       print('Dia de hoje é ${DateTime.now().day}');

                                       if(value.contains(dayHj)){
                                         relatorio = true;

                                         Navigator.pop(context);
                                         Navigator.push(context,
                                             MaterialPageRoute(builder: (context){
                                               return mainEmpresa(nome, relatorio);
                                             }));

                                       }else{
                                         relatorio = false;

                                         Navigator.pop(context);
                                         Navigator.push(context,
                                             MaterialPageRoute(builder: (context){
                                               return mainEmpresa(nome, relatorio);
                                             }));

                                       }


                                     }
                                   });

                                 }
                                 );
                               }

                             });

                           }
                           );

                         }else{
                           print('O está ativo está funcionando!');

                           AlertDialog alert = AlertDialog(
                             title: Text("Sua conta ainda não está ativa!"),
                             content: Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                             actions: [
                               TextButton(
                                   onPressed: (){
                                     SystemNavigator.pop();
                                   },
                                   child: Text('Ok')
                               ),
                             ],
                           );

                           showDialog(
                             context: context,
                             builder: (BuildContext context) {
                               return alert;
                             },
                           );
                         }


                       }

                     });

                   }
                   );
                 }

               });

             }
             );
           }
           if(value == 'operadorEmpresarial'){
             print('Ele é um Operador Empresarial');

             db.collection('Users').doc(UID).get().then((event){
               print("${event.data()}");

               event.data()?.forEach((key, value) {

                 print(key);
                 print(value);

                 if(key == 'nome'){
                   print('Ele é um Operador Empresarial');
                   String nome = value;
                   //Passar o codigo para mandar a tela
                   var db = FirebaseFirestore.instance;
                   var UID = FirebaseAuth.instance.currentUser?.uid;
                   db.collection('Users').doc(UID).get().then((event){
                     print("${event.data()}");

                     event.data()?.forEach((key, value) async {

                       print(key);
                       print(value);

                       if(key == 'estaativo'){
                         if(value == true){

                           var result = await FirebaseFirestore.instance
                               .collection("operadorEmpresarial")
                                .doc(UID)
                               .get();

                           String empresaName = (result.get('empresa'));

                           Navigator.pop(context);
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context){
                                 return operadorEmpresarial(nome, empresaName);
                               }));

                         }else{

                           print('O está ativo está funcionando!');

                           AlertDialog alert = AlertDialog(
                             title: Text("Sua conta ainda não está ativa!"),
                             content: Text("A sua conta não está ativa no momento, por favor, aguarde até que sua conta seja ativa pelo adiministrador!"),
                             actions: [
                               TextButton(
                                   onPressed: (){
                                     SystemNavigator.pop();
                                   },
                                   child: Text('Ok')
                               ),
                             ],
                           );

                           showDialog(
                             context: context,
                             builder: (BuildContext context) {
                               return alert;
                             },
                           );
                         }
                       }
                     });
                   }
                   );
                 }
               });
             }
             );
           }
         });
        }
       );
     }
   });
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
    
    Timer(Duration(seconds: 8), () {
      checkislog(context);
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
