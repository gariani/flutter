import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';
import 'pages/map_page.dart';

void main() async {

  /*final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication _googleAuth =
      await _googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: _googleAuth.accessToken,
    idToken: _googleAuth.idToken,
  );

  final FirebaseUser _user =
      (await _auth.signInWithCredential(credential)).user;

  Widget _initialPage = LoginPage();
  if (_user != null) {
    _initialPage = null;
  }*/

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      //home: _initialPage,
      routes: {
        '/': (context) => MapPage(),
        '/login': (context) => LoginPage()
      },
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: null,
      ),
    );
  }
}
