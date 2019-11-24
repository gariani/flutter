import 'package:flutter/material.dart';

ScaffoldFeatureController connectioFailedMessage(context) {
  return Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color.fromRGBO(255, 255, 0, 0),
      content: Text('Falha no loggin, verifiquei a conexão com a internet.'),
      duration: Duration(seconds: 5),
    ),
  );
}
