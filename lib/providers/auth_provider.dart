import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/db/collections/user_collection.dart';
import 'package:todo_flutter/db/models/app_user.dart';

class AppAuthProvider extends ChangeNotifier {
  User? firebaseUser;
  UserCollection userCollection = UserCollection();
  AppUser? appUser;

  AppAuthProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      signInWithUid(firebaseUser!.uid);
    }
  }

  void signInWithUid(String uid) async {
    appUser = await userCollection.readUser(uid);
    notifyListeners();
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void login(User newUser) {
    firebaseUser = newUser;
  }

  void logout() {
    firebaseUser = null;
    FirebaseAuth.instance.signOut();
  }

  Future<AppUser?> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      login(credential.user!);

      appUser = AppUser(
        authId: credential.user?.uid,
        email: email,
        fullName: fullName,
      );
      var result = await userCollection.createUser(appUser!);
      return appUser!;
    }
    return null;
  }

  Future<AppUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      login(credential.user!);
      appUser = await userCollection.readUser(credential.user!.uid);
    }
    return appUser;
  }
}
