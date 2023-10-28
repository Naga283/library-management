import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/utils/colors.dart';

class ExpandedElevatedBtn extends ConsumerWidget {
  const ExpandedElevatedBtn({
    super.key,
    required this.btnName,
    required this.onTap,
  });
  final String btnName;
  final Function() onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
              color: appColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
