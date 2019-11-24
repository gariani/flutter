import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/viewmodels/CRUDModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  final Contact contact;

  ProfileEditPage({@required this.contact});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final fotoController = TextEditingController();
  final nomeController = TextEditingController();
  final sobrenomeController = TextEditingController();
  final emailController = TextEditingController();
  final foneController = TextEditingController();
  final membroDesdeController = TextEditingController();
  final codigoIdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fotoController.text = widget.contact.foto ?? "";
    nomeController.text = widget.contact.nome ?? "";
    sobrenomeController.text = widget.contact.sobrenome ?? "";
    emailController.text = widget.contact.email ?? "";
    foneController.text = widget.contact.fone ?? "";
    membroDesdeController.text = widget.contact.membroDesde ?? "";
    codigoIdController.text = widget.contact.codigoId ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<CRUDModel>(context);

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
            Navigator.pop(context, widget.contact);
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
                    var result = await _saveData(contactProvider);
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

  Future<Contact> _saveData(CRUDModel provider) async {
    final contact = Contact(
        id: emailController.text,
        nome: nomeController.text,
        email: emailController.text,
        foto: fotoController.text,
        fone: foneController.text,
        membroDesde: membroDesdeController.text,
        codigoId: codigoIdController.text);

    await provider.updateContact(contact, contact.id);
    return contact;
  }
}
