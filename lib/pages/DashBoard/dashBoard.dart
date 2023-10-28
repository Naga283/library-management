import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/pages/DashBoard/books_count.dart';
import 'package:library_books_management/pages/DashBoard/books_count_list_tile.dart';
import 'package:library_books_management/pages/DashBoard/recently_added.dart';
import 'package:library_books_management/pages/DashBoard/welcome_card.dart';
import 'package:library_books_management/utils/colors.dart';

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
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
