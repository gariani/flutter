import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          //'/login': (context) => LoginPage(),
        },
      ),
    );

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: null,
      ),
    );
  }
}
