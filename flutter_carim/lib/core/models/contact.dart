class Contact {
  String id;
  String foto;
  String nome;
  String nomeCompleto;
  String sobrenome;
  String email;
  String fone;
  String membroDesde;
  String codigoId;

  Contact(
      {this.id,
      this.foto,
      this.nome,
      this.nomeCompleto,
      this.sobrenome,
      this.email,
      this.fone,
      this.membroDesde,
      this.codigoId});

  Contact.fromMap(Map snapshot, String id)
      : id = id ?? '',
        foto = snapshot['foto'] ?? '',
        nome = snapshot['nome'] ?? '',
        email = snapshot['email'] ?? '',
        fone = snapshot['fone'] ?? '',
        membroDesde = snapshot['membroDesde'] ?? '',
        codigoId = snapshot['codigoId'] ?? '';

  factory Contact.fromJson(Map<String, dynamic> data) {
    return Contact(
        id: data['id'],
        foto: data['foto'],
        nome: data['nome'],
        email: data['email'],
        fone: data['fone'],
        membroDesde: data['membroDesde'],
        codigoId: data['codigoId']);
  }

  toJson() {
    return {
      "foto": foto,
      "nome": nome,
      "email": email,
      "fone": fone,
      "membroDesde": membroDesde,
      "codigoId": codigoId
    };
  }
}
