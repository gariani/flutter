import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/services/api.dart';
import 'package:carimbinho/helpers/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Contact> contacts;

  Future<List<Contact>> fetchContacts() async {
    var result = await _api.getDataCollection();
    contacts = result.documents
        .map((doc) => Contact.fromMap(doc.data, doc.documentID))
        .toList();

    return contacts;
  }

  Stream<QuerySnapshot> fetchContactsAsStream() {
    return _api.streamDataCollection();
  }

    Future<Contact> getContactById(String id) async {
    var doc = await _api.getDocumentoById(id);
    if (doc.data == null) return null;
    return Contact.fromMap(doc.data, doc.documentID);
  }

  Future removeContact(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateContact(Contact data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future<DocumentSnapshot> addContact(String id, Contact data) async {
    return await _api.addDocument(id, data.toJson());
  }
 
}