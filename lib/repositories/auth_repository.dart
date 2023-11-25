import 'package:firebase_auth/firebase_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Future<String?> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    }on FirebaseException catch(e) {
      return e.code;
    }catch(e) {
      return e.toString();
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  String getCurrentUserEmail() {
    return _firebaseAuth.currentUser!.email!;
  }

  Future<void> signOut() async {
    Future.wait([
      _firebaseAuth.signOut(),
    ]);
    OneSignal.logout();
  }
}
