import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_books_management/components/expanded_elevated_btn.dart';
import 'package:library_books_management/modals/reading_log.dart';
import 'package:library_books_management/notifiers/taken_books_from_firestore_notifer.dart';
import 'package:library_books_management/providers/get_book_details_future_provider.dart';
import 'package:library_books_management/providers/select_book_from_dropdown.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';

class DropDownWithBtn extends ConsumerStatefulWidget {
  const DropDownWithBtn({
    super.key,
    required this.list,
  });

  final List<ReadingLogEntry> list;

  @override
  ConsumerState<DropDownWithBtn> createState() => _DropDownWithBtnState();
}

class _DropDownWithBtnState extends ConsumerState<DropDownWithBtn> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    ref.watch(selectBookFromDropdownProvider);
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
              items: widget.list.map<DropdownMenuItem<ReadingLogEntry>>(
                  (ReadingLogEntry value) {
                return DropdownMenuItem<ReadingLogEntry>(
                  value: value,
                  child: value.work?.title != null
                      ? SizedBox(
                          width: screenSizeUtils.screenWidth(context) * 0.78,
                          child: Text(
                            value.work?.title ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ExpandedElevatedBtn(
          // isLoading: ,
          btnName: 'Borrow',
          onTap: () {
            if (ref.watch(selectBookFromDropdownProvider) != null) {
              users.doc(userId?.uid).collection("Taken").add(
                  ref.watch(selectBookFromDropdownProvider)?.toJson() ?? {});
              ref.read(selectBookFromDropdownProvider.notifier).state = null;
              ref.invalidate(takenBooksFutureProvider);
              ref.invalidate(getDetailsFutureProvider);
              Fluttertoast.showToast(msg: "Successfull Added");
            } else {}
          },
        )
      ],
    );
  }
}
