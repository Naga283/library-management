import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/pages/home_page.dart';
import 'package:library_books_management/pages/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library app Management',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const SplashScreen(),
      // home: const HomePage(),
    );
  }
}
