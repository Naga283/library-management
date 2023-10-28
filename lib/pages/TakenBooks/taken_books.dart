import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/appbar_widget.dart';
import 'package:library_books_management/pages/TakenBooks/dropdown_with_btn.dart';
import 'package:library_books_management/pages/TakenBooks/return_book_btn.dart';
import 'package:library_books_management/providers/get_book_details_future_provider.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';
import 'package:library_books_management/utils/styles.dart';

class TakenBooks extends ConsumerStatefulWidget {
  const TakenBooks({super.key});

  @override
  ConsumerState<TakenBooks> createState() => _TakenBooksState();
}

class _TakenBooksState extends ConsumerState<TakenBooks> {
  @override
  Widget build(BuildContext context) {
    final bookDetails = ref.watch(getDetailsFutureProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            screenSizeUtils.screenWidth(context),
            50,
          ),
          child: AppBarWidget(
            appbarName: "Take Books",
          ),
        ),
        body: bookDetails.when(data: (data) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDownWithBtn(
                  list: data.readingLogEntries,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                  child: Text(
                    "Your Books",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (builder, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: appColors.whiteColor,
                            boxShadow: appStyles.boxShadow,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 5,
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                "https://covers.openlibrary.org/b/id/240726-M.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Text("Book title"),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Author"),
                                ReturnBookBtn(
                                  title: 'Book 1',
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        }, error: (error, sT) {
          return Text("something went wrong");
        }, loading: () {
          return CircularProgressIndicator();
        }));
  }
}
