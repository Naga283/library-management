import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/utils/colors.dart';

class AppBarWidget extends ConsumerWidget {
  const AppBarWidget({
    super.key,
    required this.appbarName,
  });
  final String appbarName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0.6,
      title: Text(
        appbarName,
        style: TextStyle(
          color: appColors.primary,
        ),
      ),
      centerTitle: true,
      backgroundColor: appColors.whiteColor,
    );
  }
}
