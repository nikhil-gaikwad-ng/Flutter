import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

registratrion({required String emailAddress, required String password}) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return 200;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      // print('The password provided is too weak.');
      return const SnackBar(
          content: Text("The password provided is too weak."));
    } else if (e.code == 'email-already-in-use') {
      // print('The account already exists for that email.');
      return const SnackBar(
          content: Text("The account already exists for that email."));
    }
  } catch (e) {
    print(e);
  }
}

login({required String emailAddress, required String password}) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    return 200;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // print('No user found for that email.');
      return const SnackBar(content: Text("No user found for that email."));
    } else if (e.code == 'wrong-password') {
      // print('Wrong password provided for that user.');
      return const SnackBar(
          content: Text("Wrong password provided for that user."));
    }
  }
}

signOut() async {
  await FirebaseAuth.instance.signOut();
}
