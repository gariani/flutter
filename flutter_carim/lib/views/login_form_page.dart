import 'package:flutter/material.dart';

class LoginFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Center(
              child: const Text(
                '- ou -',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
              width: 20.0,
            ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(String label, Color color, IconData icon) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color,
//      onPressed: _login,
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
}
