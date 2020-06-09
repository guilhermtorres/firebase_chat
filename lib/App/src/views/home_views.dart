import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/App/src/components/text_composer_components.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  void _sendMessage({String text, File imgFile}) async {
    Map<String, dynamic> data = {};
    if (imgFile != null) {
      StorageUploadTask task = FirebaseStorage.instance.ref().child('Images').child(DateTime.now().millisecondsSinceEpoch.toString()).putFile(imgFile);
      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
    }
    if (text != null) data['text'] = text;
    Firestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat App'),
      ),
      body: TextComposer(_sendMessage),
    );
  }
}
