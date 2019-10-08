import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carimbinho/utils/google_login.dart' as google;

import 'login_page.dart';

class AppBarPage extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppBarPageState createState() => _AppBarPageState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarPageState extends State<AppBarPage>
    with SingleTickerProviderStateMixin {
  CustomPopupMenu _selectedChoices = choices[0];
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

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
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
            icon: Icon(Icons.menu),
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
      bottom: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.list),
          ),
          Tab(
            icon: Icon(Icons.map),
          ),
          Tab(icon: Icon(Icons.settings)),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        indicatorPadding: EdgeInsets.all(10.0),
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
    );
  }

  void _select(CustomPopupMenu choice) {
    print("teste");
    _selectedChoices = choice;
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
