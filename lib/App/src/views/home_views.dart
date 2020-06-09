import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/App/src/components/text_composer_components.dart';
import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  void _sendMessage(String text) {
    Firestore.instance.collection('messages').add({'text': text});
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
