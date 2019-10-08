import 'package:carimbinho/pages/route.dart';
import 'package:flutter/material.dart';
import 'pages/route.dart' as router;
import 'utils/google_login.dart';

void main() async {

  await googleSignIn.signOut();
  user = await auth.currentUser();

  bool _isLogged = await googleSignIn.isSignedIn();
  String _route = _isLogged ? TabPageRoute : LoginPageRoute;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _route,
      onGenerateRoute: router.generateRoute,
    ),
  );
}
