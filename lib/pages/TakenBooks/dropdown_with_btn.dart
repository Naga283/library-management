import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/expanded_elevated_btn.dart';
import 'package:library_books_management/modals/reading_log.dart';
import 'package:library_books_management/providers/select_book_from_dropdown.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';

class DropDownWithBtn extends ConsumerWidget {
  const DropDownWithBtn({
    super.key,
    required this.list,
  });

  final List<ReadingLogEntry> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectBookFromDropdownProvider);
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
              hint: Text("Select book for Borrow"),
              value: ref.watch(selectBookFromDropdownProvider),
              onChanged: (val) {
                ref.read(selectBookFromDropdownProvider.notifier).state = val;
              },
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
        ExpandedElevatedBtn(
          btnName: 'Borrow',
          onTap: () {},
        )
      ],
    );
  }
}
