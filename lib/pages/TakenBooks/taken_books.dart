import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/appbar_widget.dart';
import 'package:library_books_management/notifiers/return_books_future_notifier.dart';
import 'package:library_books_management/notifiers/taken_books_from_firestore_notifer.dart';
import 'package:library_books_management/pages/TakenBooks/dropdown_with_btn.dart';
import 'package:library_books_management/pages/TakenBooks/return_book_btn.dart';
import 'package:library_books_management/providers/firestore_providers/taken_document_ids.dart';
import 'package:library_books_management/providers/get_book_details_future_provider.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';
import 'package:library_books_management/utils/styles.dart';

class TakenBooks extends ConsumerStatefulWidget {
  const TakenBooks({super.key});

  @override
  ConsumerState<TakenBooks> createState() => _TakenBooksState();
}

class _TakenBooksState extends ConsumerState<TakenBooks> {
  @override
  Widget build(BuildContext context) {
    final firebaseDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final takenDocIds = ref.watch(takenDocumentIdStateProvider);
    final bookDetails = ref.watch(getDetailsFutureProvider);
    final myTakenBooks = ref.watch(takenBooksFutureProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            screenSizeUtils.screenWidth(context),
            50,
          ),
          child: const AppBarWidget(
            appbarName: "Take Books",
          ),
        ),
        body: bookDetails.when(data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDownWithBtn(
                  list: data.readingLogEntries,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                  child: Text(
                    "Your Books",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                const Divider(),
                myTakenBooks.when(data: (data) {
                  return data.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (builder, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: appColors.whiteColor,
                                    boxShadow: appStyles.boxShadow,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 5,
                                  ),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        "https://covers.openlibrary.org/b/id/${data[index].work?.coverId}-M.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child:
                                          Text(data[index].work?.title ?? ''),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            data[index].work?.authorNames?[0] ??
                                                ''),
                                        ReturnBookBtn(
                                          title: data[index].work?.title ?? '',
                                          onTapOk: () {
                                            firebaseDoc
                                                .collection("Taken")
                                                .doc(takenDocIds[index])
                                                .delete()
                                                .whenComplete(() {
                                              ref
                                                  .read(
                                                      takenDocumentIdStateProvider
                                                          .notifier)
                                                  .state = [];
                                            });
                                            firebaseDoc
                                                .collection("Return")
                                                .add(
                                                  data[index].toJson(),
                                                )
                                                .whenComplete(() {
                                              ref.invalidate(
                                                  takenBooksFutureProvider);
                                              ref.invalidate(
                                                  returnBooksFutureProvider);
                                              ref.invalidate(
                                                  getDetailsFutureProvider);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Center(child: Text("No Books Taken"));
                }, error: (error, sT) {
                  return const Text("something went wrong");
                }, loading: () {
                  return CircularProgressIndicator();
                })
              ],
            ),
          );
        }, error: (error, sT) {
          return const Text("something went wrong");
        }, loading: () {
          return const CircularProgressIndicator();
        }));
  }
}
