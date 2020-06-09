import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/App/src/components/chat_message_components.dart';
import 'package:firebase_chat/App/src/components/text_composer_components.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeViews extends StatefulWidget {
  @override
  _HomeViewsState createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseUser _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUser();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  teste() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print(googleSignInAccount.email);
  }

  Future<FirebaseUser> _getUser() async {
    if (_currentUser != null)
      return _currentUser;
    else
      try {
        final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;

        return user;
      } catch (error) {
        return null;
      }
  }

  void _sendMessage({String text, File imgFile}) async {
    final FirebaseUser user = await _getUser();
    print(user == null);
    if (user == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possível fazer o login. Tente Novamente!',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Map<String, dynamic> data = {
        'uid': user.uid,
        'senderName': user.displayName,
        'senderPhotoUrl': user.photoUrl,
        'time': Timestamp.now(),
      };

      if (imgFile != null) {
        StorageUploadTask task = FirebaseStorage.instance
            .ref()
            .child(
              'Images',
            )
            .child(
              user.uid + DateTime.now().millisecondsSinceEpoch.toString(),
            )
            .putFile(
              imgFile,
            );
        setState(() {
          _isLoading = true;
        });
        StorageTaskSnapshot taskSnapshot = await task.onComplete;
        String url = await taskSnapshot.ref.getDownloadURL();
        data['imgUrl'] = url;
        setState(() {
          _isLoading = false;
        });
      }
      if (text != null) data['text'] = text;
      Firestore.instance.collection('messages').add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _currentUser != null ? 'Olá,  ${_currentUser.displayName}' : 'Chat App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        elevation: 5,
        actions: <Widget>[
          _currentUser != null
              ? IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    googleSignIn.signOut();
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(
                        'Você saiu com sucesso!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.green,
                    ));
                  },
                )
              : Container()
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('messages').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ChatMessage(documents[index].data, documents[index].data['uid'] == _currentUser?.uid);
                      },
                    );
                }
              },
            ),
          ),
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(
            _sendMessage,
          ),
        ],
      ),
    );
  }
}
