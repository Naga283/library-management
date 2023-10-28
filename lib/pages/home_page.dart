import 'package:flutter/material.dart';
import 'package:library_books_management/pages/DashBoard/dashBoard.dart';
import 'package:library_books_management/pages/books_page.dart';
import 'package:library_books_management/pages/ReturnedBooks/return_books.dart';
import 'package:library_books_management/pages/TakenBooks/taken_books.dart';
import 'package:library_books_management/providers/bottom_navbar_current_index_provider.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Widget> widgetsPages = [
    const DashBoard(),
    const BooksPage(),
    const TakenBooks(),
    const ReturnBooks(),
  ];
  @override
  Widget build(BuildContext context) {
    int currentIndex = ref.watch(currentIndexStateProvider);
    return Scaffold(
      body: widgetsPages[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (p0) {
          ref.read(currentIndexStateProvider.notifier).state = p0;
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: appColors.primary,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.menu_book_sharp),
            title: const Text("Books"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_to_photos_sharp),
            title: const Text("Take"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.task_alt_rounded),
            title: const Text("Return"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
