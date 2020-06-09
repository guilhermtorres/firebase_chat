import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/App/app.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(FirebaseChatApp());
  Firestore.instance.collection('mensagens').document().setData({'texto': 'Olá!', 'from': 'Guilherme', 'read': false});
  // QuerySnapshot = vários documentos;
  // DocumentSnapshot = de um documento;
  QuerySnapshot snapshot = await Firestore.instance.collection('mensagens').getDocuments();
  snapshot.documents.forEach((d) {
    print(d.data);
    print(d.documentID);
    d.reference.updateData({'lido': false});
  });
  // Para toda vez que atualizar os dados ler em tempo real as atualizações:
  Firestore.instance.collection('mensagens').snapshots().listen((dado) {
    dado.documents.forEach((d) {
      print(d.data);
    });
  });
}
