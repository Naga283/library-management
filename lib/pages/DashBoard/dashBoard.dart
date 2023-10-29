import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/notifiers/return_books_future_notifier.dart';
import 'package:library_books_management/notifiers/taken_books_from_firestore_notifer.dart';
import 'package:library_books_management/pages/DashBoard/books_count.dart';
import 'package:library_books_management/pages/DashBoard/recently_added.dart';
import 'package:library_books_management/pages/DashBoard/welcome_card.dart';
import 'package:library_books_management/pages/splash_screen.dart';
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
  void initState() {
    // TODO: implement initState
    ref.read(takenBooksFutureProvider);
    ref.read(returnBooksFutureProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalBooks = ref.watch(getDetailsFutureProvider);
    return totalBooks.when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.primary,
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await logoutUser().whenComplete(() => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(builder: (builder) {
                        return const SplashScreen();
                      }), (route) => false));
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
      return const Text("Something went wrong");
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(
          color: appColors.primary,
        ),
      );
    });
  }
}
