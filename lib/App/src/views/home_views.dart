import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat App'),
      ),
      body: Center(
        child: Text(
          'App de Chat',
        ),
      ),
    );
  }
}
