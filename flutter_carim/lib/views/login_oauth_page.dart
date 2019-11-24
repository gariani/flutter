import 'package:flutter/material.dart';
import 'facebook_login_page.dart';
import 'google_login_page.dart';

class LoginOauth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: 305.0,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Text(
            'Fazer Login',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GoogleLoginPage(),
          const SizedBox(
            height: 20,
          ),
          FacebookLoginPage(),
        ],
      ),
    );
  }
}
