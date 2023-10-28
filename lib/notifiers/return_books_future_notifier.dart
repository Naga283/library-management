import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/modals/reading_log.dart';
import 'package:library_books_management/providers/firestore_providers/firestore_provider.dart';

final returnBooksFutureProvider =
    FutureProvider<List<ReadingLogEntry>>((ref) async {
  final firestore = ref.read(firestoreProvider);

  final userId = FirebaseAuth.instance.currentUser;
  QuerySnapshot query = await firestore
      .collection('users')
      .doc(userId?.uid)
      .collection("Return")
      .get();
  final List<ReadingLogEntry> myDataList = query.docs.map((doc) {
    return ReadingLogEntry.fromJson(doc.data() as Map<String, dynamic>);
  }).toList();

  return myDataList;
});
