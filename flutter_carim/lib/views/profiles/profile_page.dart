import 'package:carimbinho/views/profiles/profile_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/views/qr_code_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool _hasChanged = false;

  final fotoController = TextEditingController();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final foneController = TextEditingController();
  final membroDesdeController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    fotoController.dispose();
    nomeController.dispose();
    emailController.dispose();
    foneController.dispose();
    membroDesdeController.dispose();

    super.dispose();
  }

  StorageReference storage;
  String photo;
  final _avatar =
      "https://cdn2.iconfinder.com/data/icons/solid-glyphs-volume-2/256/user-unisex-512.png";

  @override
  Widget build(BuildContext context) {

    if (!_hasChanged) {
      fotoController.text = Provider.of<Contact>(context).foto ?? "";
      nomeController.text = Provider.of<Contact>(context).nome ?? "";
      emailController.text = Provider.of<Contact>(context).email ?? "";
      foneController.text = Provider.of<Contact>(context).fone ?? "";
      membroDesdeController.text = Provider.of<Contact>(context).membroDesde ?? "";
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      reverse: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Provider.of<Contact>(context).foto != null
                          ? NetworkImage(Provider.of<Contact>(context).foto)
                          : NetworkImage(_avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(Provider.of<Contact>(context).nome,
                  style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Membro desde ${Provider.of<Contact>(context).membroDesde}',
                style: TextStyle(color: Colors.green[900]),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                Provider.of<Contact>(context).email,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.green[900]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                foneController.text,
                style: TextStyle(fontSize: 15.0, color: Colors.green[900]),
              ),
              const SizedBox(
                height: 30.0,
              ),
              QrCodePage(data: Provider.of<Contact>(context).email),
              const SizedBox(
                height: 15.0,
              ),
              InkWell(
                child: Text('editar', style: TextStyle(color: Colors.lightBlueAccent),),
                onTap: () {
                  _gettingProfileUpdated(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _gettingProfileUpdated(BuildContext context) async {
    _hasChanged = true;
    Contact result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileEditPage()));
    setState(() {
      foneController.text = result.fone;
    });
  }
}
