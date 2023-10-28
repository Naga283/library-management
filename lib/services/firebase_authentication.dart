import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_books_management/pages/DashBoard/dashboard.dart';
import 'package:library_books_management/providers/textformfield_error_text_state_provider.dart';
import 'package:library_books_management/services/get_current_user_name.dart';

Future<void> registerWithEmailAndPassword(String fullName, String email,
    String password, BuildContext context, WidgetRef ref) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Once the user is registered, you can save the full name to a database, Firestore, or any other storage method.
    // Example using Firebase Firestore:
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user?.uid)
        .set({
      'full_name': fullName,
      'email': email,
    });
    await getCurrentUserFullName(ref);
    // Handle success or navigate to the next screen.
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (builder) {
      return const DashBoard();
    }), (route) => false);
  } catch (e) {
    // Handle registration errors (e.g., email already exists, weak password, etc.).
  }
}

//Logout
Future<void> logoutUser() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print("Error in Logging out");
    throw Exception();
  }
}

//Login With Email and Password
Future<void> loginWithEmailAndPassword(
    String email, String password, BuildContext context, WidgetRef ref) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await getCurrentUserFullName(ref);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (builder) {
      return const DashBoard();
    }), (route) => false);
  } catch (e) {
    if (e is FirebaseAuthException) {
      // Fluttertoast.showToast(msg: e.code);
      ref.read(errorTextFormProvider.notifier).state = e.code;
      // Handle the error based on the code or show a user-friendly message.
    } else {
      // Handle other types of exceptions or errors here.
    }
  }
}
