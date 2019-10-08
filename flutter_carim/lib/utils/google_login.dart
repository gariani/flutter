import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser user;

typedef Future<bool> Login();

Future<bool> googleLogin() async {
  bool _isLogged = await googleSignIn.isSignedIn();
  if (_isLogged) return true;

  GoogleSignInAccount _googleUser = googleSignIn.currentUser;
  if (_googleUser == null) _googleUser = await googleSignIn.signInSilently();
  if (_googleUser == null) _googleUser = await googleSignIn.signIn();

  final GoogleSignInAuthentication _googleAuth =
      await _googleUser?.authentication;

  if (_googleAuth == null) return false;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: _googleAuth.accessToken,
    idToken: _googleAuth.idToken,
  );

  await auth.signInWithCredential(credential);
  user = await auth.currentUser();
  return googleSignIn.isSignedIn();
}

void logoff() async {
  await auth.signOut();
  await googleSignIn.signOut();
}