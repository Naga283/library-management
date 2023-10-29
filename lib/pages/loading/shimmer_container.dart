import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/utils/colors.dart';

class ShimmerContainerWidget extends ConsumerWidget {
  const ShimmerContainerWidget({
    super.key,
    this.height,
    this.width,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      color: appColors.whiteColor,
    );
  }
}
