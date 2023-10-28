import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/utils/colors.dart';

class RecentlyAdded extends ConsumerWidget {
  const RecentlyAdded({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recently Added",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "See All",
                style: TextStyle(
                  color: appColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
              itemCount: 10,
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
                          "https://covers.openlibrary.org/b/id/240726-M.jpg",
                          height: 120,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "title",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Author name",
                        style: TextStyle(color: Colors.grey),
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
