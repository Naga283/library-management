import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/styles.dart';

class ErrorImageWidget extends ConsumerWidget {
  const ErrorImageWidget({
    super.key,
    required this.getBookDetails,
  });

  final String getBookDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          color: appColors.whiteColor,
          boxShadow: appStyles.boxShadow,
          borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: Text(
          getBookDetails,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
