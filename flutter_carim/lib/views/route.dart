import 'package:carimbinho/views/login_page.dart';
import 'package:carimbinho/views/tab_page.dart';
import 'package:flutter/material.dart';

const String HomePageRoute = '/';
const String TabPageRoute = 'tabpage';
const String LoginPageRoute = 'login';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => TabPage());
    case TabPageRoute:
      return MaterialPageRoute(builder: (context) => TabPage());
    case LoginPageRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
