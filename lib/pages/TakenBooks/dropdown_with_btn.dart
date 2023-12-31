import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_books_management/components/expanded_elevated_btn.dart';
import 'package:library_books_management/modals/reading_log.dart';
import 'package:library_books_management/notifiers/taken_books_from_firestore_notifer.dart';
import 'package:library_books_management/providers/get_book_details_future_provider.dart';
import 'package:library_books_management/providers/is_loading_state_provider.dart';
import 'package:library_books_management/providers/select_book_from_dropdown.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';

class DropDownWithBtn extends ConsumerWidget {
  const DropDownWithBtn({
    super.key,
    required this.list,
  });

  final List<ReadingLogEntry> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final userId = FirebaseAuth.instance.currentUser;
    ref.watch(selectBookFromDropdownProvider);
    final isLoading = ref.watch(isLoadingStateProvider);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: screenSizeUtils.screenWidth(context) * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Colors.red, style: BorderStyle.solid, width: 0.80),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: const Text("Select book for Borrow"),
              value: ref.watch(selectBookFromDropdownProvider),
              onChanged: (val) {
                ref.read(selectBookFromDropdownProvider.notifier).state = val;
              },
              items: list.map<DropdownMenuItem<ReadingLogEntry>>(
                  (ReadingLogEntry value) {
                return DropdownMenuItem<ReadingLogEntry>(
                  value: value,
                  child: isLoading
                      ? Center(child: Text("Please wait"))
                      : value.work?.title != null
                          ? SizedBox(
                              width:
                                  screenSizeUtils.screenWidth(context) * 0.78,
                              child: Text(
                                value.work?.title ?? '',
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : const Text("No Title"),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ExpandedElevatedBtn(
          isLoading: ref.watch(isLoadingStateProvider),
          btnName: 'Borrow',
          onTap: () {
            if (!ref.watch(isLoadingStateProvider)) {
              if (ref.watch(selectBookFromDropdownProvider) != null) {
                users
                    .doc(userId?.uid)
                    .collection("Taken")
                    .add(ref.watch(selectBookFromDropdownProvider)?.toJson() ??
                        {})
                    .whenComplete(() {
                  ref.invalidate(getDetailsFutureProvider);
                });

                ref.invalidate(takenBooksFutureProvider);
                Fluttertoast.showToast(msg: "Successfull Added");
              } else {}
            }
          },
        )
      ],
    );
  }
}
