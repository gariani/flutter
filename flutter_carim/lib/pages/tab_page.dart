import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/pages/list_page.dart';
import 'package:carimbinho/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'app_bar_page.dart';
import 'map_page.dart';

class TabPage extends StatefulWidget {

  final Contact contact;

  TabPage({this.contact});

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBarPage(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ListPage(),
              MapPage(),
              ProfilePage(contact: widget.contact),
            ],
          )),
    );
  }
}
