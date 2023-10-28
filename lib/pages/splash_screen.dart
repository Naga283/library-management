import 'package:flutter/material.dart';
import 'package:library_books_management/components/button_widget.dart';
import 'package:library_books_management/pages/authentication/login_page.dart';
import 'package:library_books_management/pages/home_page.dart';
import 'package:library_books_management/utils/colors.dart';
import 'package:library_books_management/utils/screen_size_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSizeUtils.screenHeight(context) * 0.1,
            ),
            const Text(
              "Library App Management",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: screenSizeUtils.screenHeight(context) * 0.05,
            ),
            Image.asset("assets/images/splashScreen/splash_screen.jpg"),
            const Expanded(
              child: Text(''),
            ),
            Column(
              children: [
                ButtonWidget(
                  bgColor: appColors.whiteColor,
                  btnName: 'Register',
                  textColor: appColors.primary,
                  onTap: () {},
                ),
                SizedBox(
                  height: screenSizeUtils.screenHeight(context) * 0.0123,
                ),
                ButtonWidget(
                  bgColor: appColors.primary,
                  btnName: 'Login',
                  textColor: appColors.whiteColor,
                  onTap: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (context) => const HomePage()));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
