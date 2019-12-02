import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/viewmodels/ContactCrud.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CarimboPage extends StatefulWidget {
  @override
  _CarimboPageState createState() => _CarimboPageState();
}

class _CarimboPageState extends State<CarimboPage> {
  String barcode;
  ContactCrud contactProvider;
  Contact contact;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    contactProvider = Provider.of<ContactCrud>(context);

    return Scaffold(
      key: globalKey,
      appBar: null,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[900],
        tooltip: 'capturar QRCode do cliente',
        focusColor: Colors.lightGreen,
        heroTag: "qr_code",
        child: Icon(FontAwesomeIcons.camera),
        onPressed: () {
          scan(context);
        },
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: contact != null && contact.foto != null
                        ? FileImage(File(contact.foto))
                        : NetworkImage(
                            "https://cdn2.iconfinder.com/data/icons/solid-glyphs-volume-2/256/user-unisex-512.png"),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text(
                  contact != null && contact.nome != null ? contact.nome : "",
                  style: TextStyle()),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.stamp),
              title: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'quantidade de carimbinhos',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void scan(BuildContext context) {
    try {
      BarcodeScanner.scan().then((onValue) {
        if (onValue != null && onValue != "") {
          contactProvider.getContactById(onValue).then((onContactValue) {
            setState(() => this.contact = onContactValue);
          });
        } else {
          final snack = SnackBar(content: Text('usuário não encontrado'));
          globalKey.currentState.showSnackBar(snack);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
