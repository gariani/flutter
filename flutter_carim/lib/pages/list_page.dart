import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<ItemPlace> items = List<ItemPlace>.generate(
    _listViewData.length,
    (i) => ItemPlace(body: _listViewData[i], sender: _listViewData[i]),
  );

  static final List<String> _listViewData = [
    "Restaurante do Podrão",
    "Restaurante Barió",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listViewData.length,
      padding: EdgeInsets.only(top: 10.0),
      itemBuilder: (context, index) {
        final item = items[index];
        return _createCard(sender: item.sender, body: item.body);
      },
    );
  }

  Widget _createCard({String sender, String body}) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.fastfood),
            title: Text(sender),
            subtitle: Text(body),
          ),
          Row(
            children: <Widget>[
              Icon(Icons.star),
              Icon(Icons.star),
              Icon(Icons.star_border),
              Icon(Icons.star_border),
              Icon(Icons.star_border),
            ],
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Localizar no mapa'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemPlace {
  final String sender;
  final String body;

  ItemPlace({this.sender, this.body});
}
