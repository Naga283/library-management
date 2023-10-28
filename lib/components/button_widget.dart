import 'package:flutter/material.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.onTap,
    required this.btnName,
    required this.bgColor,
    required this.textColor,
  });
  final Function()? onTap;
  final String btnName;
  final Color bgColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: bgColor,
        width: screenSizeUtils.screenWidth(context),
        padding: EdgeInsets.symmetric(
          vertical: screenSizeUtils.screenHeight(context) * 0.025,
        ),
        child: Text(
          btnName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
