import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NomesDePessoas extends StatefulWidget {
  @override
  permissoes createState() => permissoes();
}

class permissoes extends State<NomesDePessoas> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('porteiro')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((documents) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    width: 100,
                    color: Colors.amber,
                    child: Text(documents['nome']),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}