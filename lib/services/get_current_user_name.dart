import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/providers/user_name_state_provider.dart';

Future<String?> getCurrentUserFullName(WidgetRef ref) async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (docSnapshot.exists) {
      final name = docSnapshot.data()?['full_name'] as String?;
      ref.read(userNameStateProvider.notifier).state = name;
      return name;
    }
  }

  return null; // No authenticated user or full name not found
}
