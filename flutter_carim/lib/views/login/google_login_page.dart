import 'package:carimbinho/core/enum/viewstate.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/services/authentication_service.dart';
import 'package:carimbinho/core/viewmodels/base_login.dart';
import 'package:carimbinho/core/viewmodels/base_model.dart';
import 'package:carimbinho/core/viewmodels/google_login_model.dart';
import 'package:carimbinho/views/base_widget.dart';
import 'package:carimbinho/views/tab_page.dart';
import 'package:carimbinho/views/wizard/selecting_account_type.dart';
import 'package:flutter/material.dart';
import 'package:carimbinho/login_icons_icons.dart';
import 'package:provider/provider.dart';

import '../connection_failed_message_page.dart';

class GoogleLoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseWidget<GoogleLoginModel>(
      model: GoogleLoginModel(
          authenticationService: Provider.of<AuthenticationService>(context)),
      builder: (context, model, child) => FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.red[900],
        onPressed: () {
          _routeLogged(context, model);
        },
        child: Row(
          children: <Widget>[
            Icon(
              LoginIcons.gplus,
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
              'Conectar com o Google',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _routeLogged(BuildContext context, BaseLogin model) async {
    model.login().then((value) {
      if (value) {
          switch (Provider.of<Contact>(context).type) {
            case ContactType.undefined:
              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectingAccountTypePage()));
              break;
            case ContactType.regular:
              Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()));
              break;
            case ContactType.estabelishment:
              // TODO: Handle this case.
              break;
          }

        }
      }, onError: (e) {
      connectioFailedMessage(context);
    });
  }

}
