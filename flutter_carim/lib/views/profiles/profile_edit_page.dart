import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/viewmodels/ContactCrud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
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
  void dispose(){
    fotoController.dispose();
    nomeController.dispose();
    emailController.dispose();
    foneController.dispose();
    membroDesdeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactCrud>(context);

    fotoController.text = Provider.of<Contact>(context).foto ?? "";
    nomeController.text = Provider.of<Contact>(context).nome ?? "";
    emailController.text = Provider.of<Contact>(context).email ?? "";
    foneController.text = Provider.of<Contact>(context).fone ?? "";
    membroDesdeController.text = Provider.of<Contact>(context).membroDesde ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('alterar perfil...'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Center(
          heightFactor: 10.0,
          widthFactor: 10.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.person),
                  title: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'nome completo',
                    ),
                    controller: nomeController,
                  )),
              ListTile(
                  leading: Icon(Icons.email),
                  title: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'email',
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  )),
              ListTile(
                  leading: Icon(Icons.phone),
                  title: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'fone',
                    ),
                    controller: foneController,
                    keyboardType: TextInputType.phone,
                  )),
              ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: TextFormField(
                    enabled: false,
                    controller: membroDesdeController,
                    keyboardType: TextInputType.datetime,
                  )),
              Center(
                child: FlatButton(
                  color: Colors.grey[200],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.save_alt),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Salvar'),
                    ],
                  ),
                  onPressed: () async {
                    final result = await _saveData(contactProvider);
                    Navigator.pop(context, result);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Contact> _saveData(ContactCrud provider) async {
    final contact = Contact(
        nome: nomeController.text,
        email: emailController.text,
        foto: fotoController.text,
        fone: foneController.text,
        membroDesde: membroDesdeController.text);

    await provider.updateContact(contact, emailController.text);
    return contact;
  }
}
