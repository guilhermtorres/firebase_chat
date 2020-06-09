import 'package:firebase_chat/App/src/components/text_composer_components.dart';
import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat App'),
      ),
      body: TextComposer(),
    );
  }
}
