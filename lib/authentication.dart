import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class appUser {
  final String username;
  final String email;
  final String password;

  appUser({required this.username, required this.email, required this.password});
}

class Authentication extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late appUser? loggedIn;

  appUser? get loggedInUser {
    return loggedIn;
  }

  bool get isLoggedIn {
    return firebaseAuth.currentUser != null;
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      appUser appuser = appUser(username: username, email: email, password: password);

      loggedIn = appUser(username: username, email: email, password: password);
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loggedIn = appUser(username: "", email: email, password: password);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
