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
import 'package:library_books_management/utils/apis.dart';

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

        print("inside outside loop 1");
        // convertVal.readingLogEntries.map((e) => print("inside loop"));
        for (int i = 0; i < myDataList.length; i++) {
          print("inside loop");
          for (int j = 0; j < convertVal.readingLogEntries.length; j++) {
            print("valuess i value " +
                (convertVal.readingLogEntries[j].work?.title ?? ''));
            print("valuess " + (myDataList[i].work?.title ?? ''));
            if (convertVal.readingLogEntries[j].work?.title ==
                (myDataList[i].work?.title ?? '')) {
              convertVal.readingLogEntries.removeAt(j);
            }
          }
        }

        return convertVal;
      } catch (e, sT) {
        print("errr " + e.toString());
        print("statk trce " + sT.toString());
        throw Exception();
      }
    } catch (e, sT) {
      print("Error" + e.toString());
      print("stach trace" + sT.toString());
      throw Exception(e);
    }
  }
}

final getBookDetailsProvider = Provider<GetBooksDetailsNotifier>((ref) {
  return GetBooksDetailsNotifier(ref);
});
