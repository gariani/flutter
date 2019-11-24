import 'dart:async';
import 'package:carimbinho/core/models/contact.dart';
import 'package:carimbinho/core/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'base_login.dart';
import 'base_model.dart';
import 'email_login_model.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser user;

class GoogleLoginModel extends BaseModel implements BaseLogin {
  final AuthenticationService authenticationService;

  GoogleLoginModel({this.authenticationService});

  @override
  Future<bool> login({String contactId}) async {

    GoogleSignInAccount _googleUser = googleSignIn.currentUser;
    if (_googleUser == null) _googleUser = await googleSignIn.signInSilently();
    if (_googleUser == null) _googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication _googleAuth =
        await _googleUser.authentication;

    if (_googleAuth == null) return false;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );

    await auth.signInWithCredential(credential);
    user = await auth.currentUser();

    var foundUser = await authenticationService.getContactById(user.email);

    if (foundUser == null) {
      Contact contact = new Contact(
          email: user.email,
          nome: _googleUser.displayName,
          foto: _googleUser.photoUrl);
      bool added = await authenticationService.addContact(user.email, contact);
      if (!added) {
        throw Exception('error to add a new user');
      }
    }

    return googleSignIn.isSignedIn();
  }

  @override
  Future<bool> logoff({String contactId}) async {
    await FirebaseAuth.instance.signOut();
    return googleSignIn.isSignedIn();
  }
}
