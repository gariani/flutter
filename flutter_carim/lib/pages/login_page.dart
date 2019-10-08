import 'package:carimbinho/pages/tab_page.dart';
import 'package:carimbinho/utils/google_login.dart' as google;
import 'package:flutter/material.dart';
import '../login_icons_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40.0),
        child: Stack(children: [
          Container(
            alignment: Alignment.topCenter,
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset('icon/stamp.jpg'),
                  Text(
                    'CARIMBINHO',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'J U N T O U   T R O C O U',
                    style: TextStyle(fontSize: 10, color: Colors.red[900]),
                  )
                ],
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(vertical: 100.0),
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
                          _loginButton('Conectar com o Google', Colors.red[800],
                              LoginIcons.gplus, google.googleLogin),
                          const SizedBox(
                            height: 20,
                          ),
                          _loginButton(
                              'Conectar com o Facebook',
                              Colors.blue[900],
                              LoginIcons.facebook_squared,
                              () {}),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            '- ou -',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                            width: 20.0,
                          ),
                          _internalForm(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _loginButton(
      String label, Color color, IconData icon, google.Login login) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color,
      onPressed: () {
        login().then((value) {
          if (value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabPage()));
          }
        }, onError: (e) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
      },
      child: Row(
        children: <Widget>[
          Icon(
            icon,
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
            label,
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _internalForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'e-mail',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor, informe o login';
              } else
                return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'senha',
            ),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor, informe uma senha';
              } else
                return null;
            },
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.red[800],
                child: Text('Login'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Processando dados!'),
                    ));
                  }
                },
              ),
            ),
          ),
          Center(
            child: Text(
              'Esqueci minha senha!',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
