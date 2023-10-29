import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/utils/colors.dart';

class ExpandedElevatedBtn extends ConsumerWidget {
  const ExpandedElevatedBtn({
    super.key,
    required this.btnName,
    required this.onTap,
    this.isLoading,
  });
  final String btnName;
  final Function() onTap;
  final bool? isLoading;
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
          child: (isLoading ?? false)
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: appColors.whiteColor,
                  ),
                )
              : Text(
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
