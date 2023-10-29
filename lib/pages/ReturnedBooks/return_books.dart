import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/appbar_widget.dart';
import 'package:library_books_management/notifiers/return_books_future_notifier.dart';
import 'package:library_books_management/pages/loading/loading_widget.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';
import 'package:library_books_management/utils/styles.dart';

class ReturnBooks extends ConsumerStatefulWidget {
  const ReturnBooks({super.key});

  @override
  ConsumerState<ReturnBooks> createState() => _ReturnBooksState();
}

class _ReturnBooksState extends ConsumerState<ReturnBooks> {
  @override
  Widget build(BuildContext context) {
    final returnedBooks = ref.watch(returnBooksFutureProvider);
    return Scaffold(
        appBar: PreferredSize(
          child: AppBarWidget(
            appbarName: "Return Books",
          ),
          preferredSize: Size(screenSizeUtils.screenWidth(context), 50),
        ),
        body: returnedBooks.when(data: (data) {
          return data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: appColors.whiteColor,
                          boxShadow: appStyles.boxShadow,
                          borderRadius: BorderRadius.circular(6)),
                      child: ListTile(
                        title: Text(data[index].work?.title ?? ''),
                        subtitle: Row(
                          children: [
                            Text(data[index].work?.authorNames?[0] ?? ''),
                          ],
                        ),
                        trailing: Text("Returned on \n 12/03/1023"),
                      ),
                    );
                  })
              : Center(child: Text("No Books Returned"));
        }, error: (error, sT) {
          return Text("Something went wrong");
        }, loading: () {
          return const LoadingWidget();
        }));
  }
}
