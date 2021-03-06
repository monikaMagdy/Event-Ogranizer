import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_project/models/userModel.dart';
import 'package:mobile_project/provider/userAddNotifier.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//? Signup
  Future<User> register(
      context, UserModel newuser, String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(userCredential.user.uid);
      newuser.userID = userCredential.user.uid;

      await Provider.of<UserAddNotifer>(context, listen: false)
          .signuprealtime(newuser);
    } catch (e) {
      print(e);
    }
  }

//? Sign in
  Future<User> signIn(String email, String pass) async {
    UserCredential authResult;
    try {
      authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } catch (e) {
      debugPrint('aaa : $e');
    }
    final User user = authResult?.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');
      return user;
    }

    return null;
  }

//? Sign Out

  Future<bool> signOut() async {
    await _auth.signOut();
    print('User Signed Out');
  }

  Stream<User> getUser() {
    return _auth.userChanges();
  }

  Stream<User> authState() {
    return _auth.authStateChanges();
  }
}
