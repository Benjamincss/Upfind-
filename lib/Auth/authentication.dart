import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUpWithEmail({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future<User> signInWithEmail(String email, String password) async {


    UserCredential result =
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    final User user = result.user!;

    return user;
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}