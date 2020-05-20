import 'package:flutter/material.dart';

import 'src/views/home_views.dart';

class FirebaseChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeViews(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cursorColor: Colors.brown,
        buttonColor: Colors.brown,
        indicatorColor: Colors.brown,
        accentColor: Colors.grey[600],
        hintColor: Colors.brown,
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown,
        fontFamily: '',
        canvasColor: Colors.yellow[50],
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontFamily: '',
            color: Colors.black,
            fontSize: 16,
          ),
          headline6: TextStyle(
            fontFamily: '',
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 5,
          color: Colors.brown[700],
          iconTheme: IconThemeData(color: Colors.grey),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: '',
              color: Colors.white,
              letterSpacing: 3,
            ),
          ),
        ),
      ),
    );
  }
}