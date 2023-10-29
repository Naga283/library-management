import 'package:flutter/material.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/styles.dart';

class BooksCountListTile extends StatelessWidget {
  const BooksCountListTile({
    super.key,
    required this.borderColor,
    required this.heading,
    required this.subHeading,
    required this.count,
  });
  final Color borderColor;
  final String heading;
  final String subHeading;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.whiteColor,
        border: Border(
          left: BorderSide(
            width: 2,
            color: borderColor,
          ),
        ),
        boxShadow: appStyles.boxShadow,
      ),
      child: ListTile(
        title: Text(
          heading,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: Text(subHeading),
        trailing: Text(
          count,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
