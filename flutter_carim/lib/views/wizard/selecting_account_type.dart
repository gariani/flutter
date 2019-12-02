import 'package:carimbinho/core/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:page_slider/page_slider.dart';
import 'package:provider/provider.dart';

class SelectingAccountTypePage extends StatefulWidget {
  @override
  _SelectingAccountTypePageState createState() =>
      _SelectingAccountTypePageState();
}

class _SelectingAccountTypePageState extends State<SelectingAccountTypePage> {
  GlobalKey<PageSliderState> _sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PageSlider(
            duration: Duration(seconds: 10),
            initialPage: 0,
            key: _sliderKey,
            pages: <Widget>[
              CreateTypeContact(),
              CreateContact(),
              Text('3'),
            ],
            onFinished: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                backgroundColor: Colors.green[900],
                child: Text('Back'),
                onPressed: () {
                  _sliderKey.currentState.previous();
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.green[900],
                child: Text('Next'),
                onPressed: () {
                  _sliderKey.currentState.next();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateContact extends StatefulWidget {
  @override
  _CreateContactState createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CreateTypeContact extends StatefulWidget {
  @override
  _CreateTypeContactState createState() => _CreateTypeContactState();
}

class _CreateTypeContactState extends State<CreateTypeContact> {
  int _radioValue1 = 1;

  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<Contact>(context);

    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Radio(value: 0, groupValue: _radioValue1, onChanged: null),
              Text('Regular user'),
              Radio(value: 0, groupValue: _radioValue1, onChanged: null),
              Text('Estabilishment user'),
            ],
          ),
        ],
      ),
    );
  }
}
