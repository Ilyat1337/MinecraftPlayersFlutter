import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<String> signInWithEmail(String email, String password) async {
    var credentials = await auth
        .signInWithEmailAndPassword(email: email, password: password);
    return credentials.user.uid;
  }

  Future<String> signUpWithEmail(String email, String password) async {
    var credentials = await auth
        .createUserWithEmailAndPassword(email: email, password: password);
    return credentials.user.uid;
  }
}
