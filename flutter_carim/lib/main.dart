import 'package:carimbinho/helpers/locator.dart';
import 'package:carimbinho/views/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_setup.dart';
import 'views/route.dart' as router;

String route;

void main() async {
  Provider.debugCheckInvalidValueType = null;
  route = LoginPageRoute;
  setupLocator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green[900],
        ),
        initialRoute: route,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
