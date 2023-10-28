import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/modals/reading_log.dart';
import 'package:library_books_management/providers/firestore_providers/firestore_provider.dart';
import 'package:library_books_management/providers/firestore_providers/taken_document_ids.dart';
import 'package:library_books_management/providers/home_page_providers/taken_books_count_state_provider.dart';

final takenBooksFutureProvider =
    FutureProvider<List<ReadingLogEntry>>((ref) async {
  final firestore = ref.read(firestoreProvider);

  final userId = FirebaseAuth.instance.currentUser;
  QuerySnapshot query = await firestore
      .collection('users')
      .doc(userId?.uid)
      .collection("Taken")
      .get();
  final List<ReadingLogEntry> myDataList = query.docs.map((doc) {
    ref.read(takenDocumentIdStateProvider.notifier).state.add(doc.id);
    return ReadingLogEntry.fromJson(doc.data() as Map<String, dynamic>);
  }).toList();
  ref.read(takenBooksCountValueStateProvider.notifier).state =
      myDataList.length;
  return myDataList;
});
