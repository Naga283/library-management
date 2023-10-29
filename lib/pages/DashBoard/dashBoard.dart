import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/dailoge.dart';
import 'package:library_books_management/components/error_widget.dart';
import 'package:library_books_management/notifiers/return_books_future_notifier.dart';
import 'package:library_books_management/notifiers/taken_books_from_firestore_notifer.dart';
import 'package:library_books_management/pages/DashBoard/books_count.dart';
import 'package:library_books_management/pages/DashBoard/recently_added.dart';
import 'package:library_books_management/pages/DashBoard/welcome_card.dart';
import 'package:library_books_management/pages/loading/loading_widget.dart';
import 'package:library_books_management/providers/get_book_details_future_provider.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/services/firebase_authentication.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final totalBooks = ref.watch(getDetailsFutureProvider);
    ref.watch(takenBooksFutureProvider);
    ref.watch(returnBooksFutureProvider);
    return totalBooks.when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.primary,
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  alertDailogue(context, "Logout", () async {
                    await logoutUser(context, ref);
                  }, "Please Click on Ok to Logout");
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Column(
              children: [
                const WelcomeCard(),
                RecentlyAdded(
                  getBookDetails: data,
                ),
                BooksCount(
                  overallBooksCount: data.readingLogEntries.length,
                ),
              ],
            ),
          ),
        ),
      );
    }, error: (error, sT) {
      return const AppErrorWidget();
    }, loading: () {
      return const LoadingWidget();
    });
  }
}
