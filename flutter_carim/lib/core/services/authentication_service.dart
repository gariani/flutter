import 'dart:async';
import 'dart:core';

import 'package:carimbinho/core/enum/viewstate.dart';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/viewmodels/ContactCrud.dart';
import 'package:carimbinho/core/viewmodels/google_login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../helpers/locator.dart';

import 'api.dart';

class AuthenticationService {
  final ContactCrud _crud;

  AuthenticationService({ContactCrud crud}) : _crud = crud;

  StreamController _userController = StreamController<Contact>.broadcast();

  Stream<Contact> get contact => _userController.stream;

  LoggedWith loggedWith;

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

  Future<void> loggin() async {
    //TODO
    //Needs refactor loggin
  }

  Future<void> logoff() async {

    if (this.loggedWith == LoggedWith.google) {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
    }
  }
}
