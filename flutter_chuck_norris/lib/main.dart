import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPostClass(),
    );
  }
}

class MyPostClass extends StatefulWidget {
  @override
  _MyPostClassState createState() => _MyPostClassState();
}

class _MyPostClassState extends State<MyPostClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My first flutter post!'),
        backgroundColor: Colors.blue,
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  var _iconUrlController = TextEditingController();
  var _idController = TextEditingController();
  var _urlController = TextEditingController();
  var _valueController = TextEditingController();
  bool _isClicked = false;

  @override
  void initState() {
    super.initState();

    // _iconUrlController.addListener();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: FutureBuilder(
        future: fetchPost(),
        initialData: "Loading fetching data",
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
            case ConnectionState.done:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    onChanged: (text) {
                      print("Teste $text");
                    },
                  ),
                  TextFormField(
                    controller: _iconUrlController,
                  ),
                  TextFormField(
                    controller: _valueController,
                  ),
                  TextFormField(
                    controller: _urlController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        fetchPost();
                        
                        setState(() {
                          _isClicked == false
                              ? _isClicked = true
                              : _isClicked = false;

                          if (_isClicked) {
                             _idController.text = snapshot.data.id;
                             _urlController.text = snapshot.data.url;
                             _valueController.text = snapshot.data.value;
                             _iconUrlController.text = snapshot.data.iconUrl;
                          }
                        });
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }

  Future<Post> fetchPost() async {
    final response = await http.get(
        'https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com/jokes/random',
        headers: {
          'X-RapidAPI-Host': 'matchilling-chuck-norris-jokes-v1.p.rapidapi.com',
          'X-RapidAPI-Key':
              '2608bbf2d9msh8ba26c9dd2761c4p1028eajsnc29fa84f7c3c',
          'accept': 'application/json',
        });
    final retorno = json.decode(response.body);
    var post = Post.fromJson(retorno);
    print(post.toString());
    return post;
  }
}

class Post {
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  Post({this.iconUrl, this.id, this.url, this.value});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      iconUrl: json['icon_url'],
      id: json['id'],
      url: json['url'],
      value: json['value'],
    );
  }

  @override
  String toString() {
    return "$iconUrl + $id + $url + $value";
  }
}

/*
{4 items
"icon_url":"https://assets.chucknorris.host/img/avatar/chuck-norris.png"
"id":"Jim0jIOySUmV7Bbz5TFyXQ"
"url":"http://api.chucknorris.io/jokes/Jim0jIOySUmV7Bbz5TFyXQ"
"value":"Chuck Norris cornrows his crotch hair."
}*/

/*

 */
