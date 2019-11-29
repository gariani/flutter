import 'dart:async';
import 'dart:core';

import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/viewmodels/CRUDModel.dart';
import 'package:carimbinho/core/viewmodels/google_login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../helpers/locator.dart';

import 'api.dart';

class AuthenticationService {
  final CRUDModel _crud;

  AuthenticationService({CRUDModel crud}) : _crud = crud;

  StreamController _userController = StreamController<Contact>.broadcast();

  Stream<Contact> get contact => _userController.stream;

  @protected
  @mustCallSuper
  void dispose() {
    _userController.close();
  }

  Future<bool> getContactById(String contactId) async {
    var contact = await _crud.getContactById(contactId);
    var hasUser = contact != null;
    if (hasUser) {
      _userController.add(contact);
    }
    return hasUser;
  }

  Future<bool> addContact(String id, Contact data) async {
    await _crud.addContact(id, data);
    _userController.add(data);
    return true;
  }

  Future<void> logoff() async {
    var isLogged = await googleSignIn.isSignedIn();
    if (isLogged) {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
    }
  }
}
