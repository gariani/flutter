import 'package:carimbinho/helpers/google_login.dart' as google;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_page.dart';

class AppBarPage extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppBarPageState createState() => _AppBarPageState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarPageState extends State<AppBarPage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: choices.length)
      ..addListener(() {
        setState(() {
          _tabController.index = 0;
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 10.0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green[900],
      actions: <Widget>[
        PopupMenuButton<CustomPopupMenu>(
            elevation: 3.2,
            initialValue: choices[0],
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Configuração',
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((CustomPopupMenu choice) {
                return PopupMenuItem<CustomPopupMenu>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Text('loggout'),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Icon(Icons.exit_to_app),
                    ],
                  ),
                );
              }).toList();
            }),
      ],
    );
  }

  void _select(CustomPopupMenu choice) {
    if (choice.event.contains("logout")) {
      google.logoff();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon, this.event});
  String title;
  IconData icon;
  String event;
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(
      title: 'Logoff', icon: FontAwesomeIcons.signOutAlt, event: 'logout'),
];
