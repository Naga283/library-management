import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/modals/reading_log.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';

class DropDownWithBtn extends ConsumerWidget {
  const DropDownWithBtn({
    super.key,
    required this.dropDownValue,
    required this.list,
  });

  final String dropDownValue;
  final List<ReadingLogEntry> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: screenSizeUtils.screenWidth(context) * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Colors.red, style: BorderStyle.solid, width: 0.80),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: list.first,
              onChanged: (val) {},
              items: list.map<DropdownMenuItem<ReadingLogEntry>>(
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
        SizedBox(height: 10),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: double.infinity,
          decoration: BoxDecoration(
            color: appColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              "Borrow",
              style: TextStyle(
                color: appColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
