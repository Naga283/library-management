import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_books_management/pages/authentication/login_page.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return userId == null ? const LoginPage() : const HomePage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSizeUtils.screenHeight(context) * 0.1,
            ),
            SizedBox(
              width: 350,
              child: const Text(
                "Library App Management",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: screenSizeUtils.screenHeight(context) * 0.05,
            ),
            Image.asset("assets/images/splashScreen/splash_screen.jpg"),
            const Expanded(
              child: Text(''),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: appColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text("v1.0.0")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
