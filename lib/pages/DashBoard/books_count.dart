import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/pages/DashBoard/books_count_list_tile.dart';
import 'package:library_books_management/utils/colors.dart';

class BooksCount extends ConsumerWidget {
  const BooksCount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Book Details",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 19,
              color: appColors.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: BooksCountListTile(
              borderColor: appColors.primary,
              count: '200',
              heading: 'Available Books',
              subHeading: 'Available books in library',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: BooksCountListTile(
              borderColor: Colors.green,
              count: '20',
              heading: 'Taken',
              subHeading: 'Books with you',
            ),
          ),
          BooksCountListTile(
            borderColor: Colors.orange,
            count: '10',
            heading: 'Return',
            subHeading: 'Returned Books',
          ),
        ],
      ),
    );
  }
}
