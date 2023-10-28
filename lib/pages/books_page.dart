import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/providers/get_book_details_future_provider.dart';
import 'package:library_books_management/utils/colors.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksDetails = ref.watch(getDetailsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          "Available books",
          style: TextStyle(
            color: appColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: appColors.primary,
              ))
        ],
        centerTitle: true,
        backgroundColor: appColors.whiteColor,
      ),
      body: booksDetails.when(data: (data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                // child: Text(
                //   "Available Books",
                //   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                // ),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Book',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: data.readingLogEntries.length,
                    shrinkWrap: true,
                    itemBuilder: (builder, index) {
                      final book = data.readingLogEntries[index].work;
                      return book?.title != null
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: appColors.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 4.0, // soften the shadow
                                          spreadRadius: 2.0, //extend the shadow
                                          offset: Offset(
                                            0.0, // Move to right 5  horizontally
                                            0.0, // Move to bottom 5 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(4)),
                                  child: ListTile(
                                    leading: Image.network(
                                      'https://covers.openlibrary.org/b/id/${data.readingLogEntries[index].work?.coverId}.jpg',
                                      height: 100,
                                    ),
                                    title: Row(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Text(book?.title ?? '')),
                                        Icon(
                                          Icons.favorite_border,
                                          size: 20,
                                        ),
                                        // Icon(
                                        //   Icons.favorite,
                                        //   color: appColors.primary,
                                        //   size: 20,
                                        // ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(book!.authorNames!.isNotEmpty
                                            ? (book.authorNames?[0] ?? '')
                                            : ''),
                                        Text(book.firstPublishYear.toString())
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox.shrink();
                    }),
              ),
            ],
          ),
        );
      }, error: (error, st) {
        return Text(error.toString());
      }, loading: () {
        return const CircularProgressIndicator();
      }),
    );
  }
}
