import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth =FirebaseAuth.instance;
  Stream<FirebaseUser> get currentUser => _auth.onAuthStateChanged;
  Future<AuthResult> signInWithCredential(AuthCredential credential) => _auth.signInWithCredential(credential);
  Future logout() => _auth.signOut();
}