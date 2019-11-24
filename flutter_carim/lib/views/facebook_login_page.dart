import 'package:carimbinho/core/viewmodels/google_login_model.dart';
import 'package:carimbinho/views/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:carimbinho/login_icons_icons.dart';

class FacebookLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<GoogleLoginModel>(
      builder: (context, model, child) => FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.blue[900],
        onPressed: () {
          model.login();
        },
        child: Row(
          children: <Widget>[
            Icon(
              LoginIcons.facebook_squared,
              color: Colors.white,
              size: 30.0,
            ),
            const SizedBox(
              height: 20.0,
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 30,
            ),
            Text(
              'Conectar com o Facebook',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
