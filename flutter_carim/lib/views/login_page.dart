import 'package:carimbinho/core/viewmodels/email_login_model.dart';
import 'package:carimbinho/views/base_widget.dart';
import 'package:carimbinho/views/login_oauth_page.dart';
import 'package:flutter/material.dart';
import 'login_form_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                _header(),
                LoginOauth(),
                LoginFormPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Column(
      children: <Widget>[
        Image.asset('icon/stamp.jpg'),
        Text(
          'CARIMBINHO',
          style: TextStyle(
              fontSize: 25, fontFamily: 'Oswald', fontWeight: FontWeight.bold),
        ),
        Text(
          'J U N T O U   T R O C O U',
          style: TextStyle(fontSize: 10, color: Colors.red[900]),
        ),
      ],
    );
  }
}
