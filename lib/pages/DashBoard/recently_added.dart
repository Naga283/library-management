import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/modals/get_book_details.dart';
import 'package:library_books_management/providers/bottom_navbar_current_index_provider.dart';
import 'package:library_books_management/providers/get_book_details_future_provider.dart';
import 'package:library_books_management/utils/colors.dart';

class RecentlyAdded extends ConsumerWidget {
  const RecentlyAdded({
    super.key,
    required this.getBookDetails,
  });
  final GetBookDetails getBookDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recently Added",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                ref.read(currentIndexStateProvider.notifier).state = 1;
              },
              child: Text(
                "See All",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: appColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          "https://covers.openlibrary.org/b/id/${getBookDetails.readingLogEntries[index].work?.coverId}-M.jpg",
                          height: 120,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 95,
                        child: Text(
                          getBookDetails.readingLogEntries[index].work?.title ??
                              '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 95,
                        child: Text(
                          getBookDetails.readingLogEntries[index].work
                                  ?.authorNames?[0] ??
                              '',
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
