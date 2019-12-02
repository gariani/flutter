import 'package:carimbinho/core/enum/viewstate.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/services/authentication_service.dart';
import 'package:carimbinho/core/viewmodels/base_login.dart';
import 'package:carimbinho/core/viewmodels/google_login_model.dart';
import 'package:carimbinho/helpers/locator.dart';
import 'package:carimbinho/views/list/list_page.dart';
import 'package:carimbinho/views/profiles/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'map/map_page.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {

  AuthenticationService _auth;

  TabController _tabController;
  List<Widget> myTabs;

  bool _isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  bool _shouldHaveElevation = false;

  @override
  void initState() {

    myTabs = <Widget>[
      ListPage(),
      MapPage(),
      ProfilePage(),
    ];

    _tabController = TabController(length: myTabs.length, vsync: this);

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  void animate() {
    if (!_isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _isOpened = !_isOpened;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();

    super.dispose();
  }

  Widget listButton() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          _tabController.animateTo(0);
          animate();
        },
        tooltip: 'Lista',
        heroTag: 'lista',
        child: Icon(Icons.list),
        elevation: _shouldHaveElevation ? 6.0 : 0,
      ),
    );
  }

  Widget mapButton() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          _tabController.animateTo(1);
          animate();
          googleSignIn.signOut();
        },
        tooltip: 'Mapa',
        heroTag: 'mapa',
        child: Icon(Icons.map),
        elevation: _shouldHaveElevation ? 6.0 : 0,
      ),
    );
  }

  Widget profileButton() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          _tabController.animateTo(2);
          animate();
        },
        tooltip: 'Profile',
        heroTag: 'profile',
        child: Icon(Icons.person),
        elevation: _shouldHaveElevation ? 6.0 : 0,
      ),
    );
  }

  Widget exitButton() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          _auth.logoff().then((value){
            Navigator.pop(context);
          });
        },
        tooltip: 'Exit',
        heroTag: 'Exit',
        child: Icon(Icons.exit_to_app),
        elevation: _shouldHaveElevation ? 6.0 : 0,
      ),
    );
  }

  Widget expandedButton() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle menu',
        heroTag: 'teste4',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  Widget menuButton2() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        tooltip: 'Reposicionar',
        heroTag: 'button_reposicionar',
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }

  Widget _tabs() {
    return TabBarView(
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
      children: myTabs,
    );
  }

  List<Widget> _createSpecificFloatingButtons() {
    return _tabController.index == 1
        ? _createFloatingButtons2()
        : _createFloatingButtons();
  }

  List<Widget> _createFloatingButtons2() {
    var newList = _createFloatingButtons();
    return newList;
  }

  List<Widget> _createFloatingButtons() {
    return [
      Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translateButton.value * 4.0,
          0.0,
        ),
        child: listButton(),
      ),
      Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translateButton.value * 3.0,
          0.0,
        ),
        child: mapButton(),
      ),
      Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translateButton.value * 2.0,
          0.0,
        ),
        child: profileButton(),
      ),
      Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translateButton.value,
          0.0,
        ),
        child: exitButton(),
      ),
      expandedButton(),
      SizedBox(
        height: 10.0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    _auth = Provider.of<AuthenticationService>(context);

    return DefaultTabController(
      length: myTabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: _tabs(),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: _createSpecificFloatingButtons(),
        ),
      ),
    );
  }
}
