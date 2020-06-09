import 'package:flutter/material.dart';
import 'src/views/home_views.dart';

class FirebaseChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeViews(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cursorColor: Colors.blue,
        buttonColor: Colors.blue,
        indicatorColor: Colors.blue,
        accentColor: Colors.grey[600],
        hintColor: Colors.black26,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
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
          color: Colors.blue[700],
          iconTheme: IconThemeData(color: Colors.white),
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
