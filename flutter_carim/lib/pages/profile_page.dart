import 'dart:math';

import 'package:carimbinho/utils/google_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text(
                      'Editar',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: user?.photoUrl != null
                  ? NetworkImage(user.photoUrl)
                  : NetworkImage(
                      "https://cdn2.iconfinder.com/data/icons/solid-glyphs-volume-2/256/user-unisex-512.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Text(user.displayName,
                  style: TextStyle(fontSize: 25.0, color: Colors.green[900])),
              const SizedBox(
                height: 10,
              ),
              Text('Membro desde ', style: TextStyle(color: Colors.green[900]),),
              const SizedBox(
                height: 20,
              ),
              Text(
                user.email,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.green[900]),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(user.phoneNumber ?? ""),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        Chip(
          backgroundColor: Colors.green[900],
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          label: Text('21313', style: TextStyle(color: Colors.white, fontSize: 45),),
        ),
        Expanded(
            flex: 1,
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    padding: EdgeInsets.only(bottom: 10.0),
                    icon: Icon(FontAwesomeIcons.stamp),
                    iconSize: 40.0,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.star),
                    iconSize: 40.0,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.search),
                    iconSize: 40.0,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.userEdit),
                    iconSize: 40.0,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}
