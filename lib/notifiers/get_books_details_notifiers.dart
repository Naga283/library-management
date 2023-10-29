// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:library_books_management/modals/get_book_details.dart';
import 'package:library_books_management/modals/reading_log.dart';
import 'package:library_books_management/providers/firestore_providers/firestore_provider.dart';
import 'package:library_books_management/providers/firestore_providers/taken_document_ids.dart';
import 'package:library_books_management/providers/is_loading_state_provider.dart';
import 'package:library_books_management/utils/apis.dart';

import '../providers/select_book_from_dropdown.dart';

class GetBooksDetailsNotifier {
  Ref ref;
  GetBooksDetailsNotifier(
    this.ref,
  );
  Future<GetBookDetails> getDetails() async {
    try {
      final response = await http.get(Uri.parse(apis.apiUrl));
      final jsonVal = json.decode(response.body);
      final convertVal = GetBookDetails.fromJson(jsonVal);
      print("inside try block 1");
      // return GetBookDetails.fromJson(jsonVal);
      try {
        ref.read(isLoadingStateProvider.notifier).state = true;
        print("inside try block 2");
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

        // convertVal.readingLogEntries.map((e) => print("inside loop"));
        // for (int i = 0; i < myDataList.length; i++) {
        //   for (int j = 0; j < convertVal.readingLogEntries.length; j++) {
        //     if (convertVal.readingLogEntries[j].work?.title ==
        //         (myDataList[i].work?.title ?? '')) {
        //       convertVal.readingLogEntries.removeAt(j);
        //     }
        //   }
        // }
        // Create a Set of unique titles from myDataList
        Set<String> myDataTitles =
            Set<String>.from(myDataList.map((item) => item.work?.title ?? ''));

// Filter convertVal.readingLogEntries to keep only the items whose title is not in myDataTitles
        convertVal.readingLogEntries.removeWhere(
            (entry) => myDataTitles.contains(entry.work?.title ?? ''));
        ref.read(selectBookFromDropdownProvider.notifier).state = null;
        ref.read(isLoadingStateProvider.notifier).state = false;
        return convertVal;
      } catch (e, sT) {
        ref.read(isLoadingStateProvider.notifier).state = false;
        throw Exception();
      }
    } catch (e, sT) {
      ref.read(isLoadingStateProvider.notifier).state = false;
      throw Exception(e);
    }
  }
}

final getBookDetailsProvider = Provider<GetBooksDetailsNotifier>((ref) {
  return GetBooksDetailsNotifier(ref);
});
