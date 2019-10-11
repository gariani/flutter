import 'package:carimbinho/core/viewmodels/CRUDModel.dart';
import 'package:carimbinho/helpers/locator.dart';
import 'package:carimbinho/pages/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/google_login.dart';
import 'pages/route.dart' as router;

String route;

void main() async {
  await googleSignIn.signOut();

  bool result = await googleSignIn.isSignedIn();
  route = result ? TabPageRoute : LoginPageRoute;

  setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [ChangeNotifierProvider(builder: (_) => locator<CRUDModel>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: route,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
