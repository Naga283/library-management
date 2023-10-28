import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/pages/DashBoard/books_count.dart';
import 'package:library_books_management/pages/DashBoard/recently_added.dart';
import 'package:library_books_management/pages/DashBoard/welcome_card.dart';
import 'package:library_books_management/pages/splash_screen.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/services/firebase_authentication.dart';

class DashBoard extends ConsumerWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      return SplashScreen();
                    }), (route) => false));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
          child: Column(
            children: [
              WelcomeCard(),
              RecentlyAdded(),
              BooksCount(),
            ],
          ),
        ),
      ),
    );
  }
}
