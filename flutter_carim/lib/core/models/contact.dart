import 'package:carimbinho/core/enum/viewstate.dart';

class Contact {
  String foto;
  String nome;
  String email;
  String fone;
  String membroDesde;
  ContactType type;

  Contact(
      {this.foto,
      this.nome,
      this.email,
      this.fone,
      this.membroDesde,
      this.type = ContactType.undefined});

  Contact.fromMap(Map snapshot)
      : foto = snapshot['foto'] ?? '',
        nome = snapshot['nome'] ?? '',
        email = snapshot['email'] ?? '',
        fone = snapshot['fone'] ?? '',
        membroDesde = snapshot['membroDesde'] ?? '',
        type = ContactType.undefined;

  factory Contact.fromJson(Map<String, dynamic> data) {
    return Contact(
      foto: data['foto'],
      nome: data['nome'],
      email: data['email'],
      fone: data['fone'],
      membroDesde: data['membroDesde'],
      type: data['type'],
    );
  }

  toJson() {
    return {
      "foto": foto,
      "nome": nome,
      "email": email,
      "fone": fone,
      "membroDesde": membroDesde,
      "type": type.toString(),
    };
  }
}
