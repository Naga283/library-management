import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/dailoge.dart';

class ReturnBookBtn extends ConsumerWidget {
  const ReturnBookBtn({
    super.key,
    required this.title,
    required this.onTapOk,
  });
  final String title;
  final Function() onTapOk;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 26,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            alertDailogue(
              context,
              title,
              onTapOk,
              "Please Click on OK to return book",
            );
          },
          child: const Text(
            "Return",
            style: TextStyle(fontSize: 13),
          )),
    );
  }
}
