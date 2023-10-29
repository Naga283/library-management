import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/appbar_widget.dart';
import 'package:library_books_management/components/error_widget.dart';
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
          preferredSize: Size(screenSizeUtils.screenWidth(context), 50),
          child: const AppBarWidget(
            appbarName: "Returned Books",
          ),
        ),
        body: returnedBooks.when(data: (data) {
          return data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: appColors.whiteColor,
                          boxShadow: appStyles.boxShadow,
                          borderRadius: BorderRadius.circular(6)),
                      child: ListTile(
                        title: Text(data[index].work?.title ?? 'No Title'),
                        subtitle: Row(
                          children: [
                            Text(data[index].work!.authorNames!.isNotEmpty
                                ? (data[index].work?.authorNames?[0] ?? '')
                                : 'No Author'),
                          ],
                        ),
                        trailing: const Text("Returned on \n 12/03/1023"),
                      ),
                    );
                  })
              : const Center(child: Text("No Books Returned"));
        }, error: (error, sT) {
          return const AppErrorWidget();
        }, loading: () {
          return const LoadingWidget();
        }));
  }
}
