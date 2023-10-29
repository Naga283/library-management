import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:library_books_management/providers/user_name_state_provider.dart';
import 'package:library_books_management/utils/colors.dart';

class WelcomeCard extends ConsumerWidget {
  const WelcomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            // color: appColors.primary,
            gradient: LinearGradient(colors: [
              appColors.primary,
              appColors.primary.withOpacity(0.75)
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome ${ref.watch(userNameStateProvider)}!",
                  style: TextStyle(
                    color: appColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Let's organise your library with us!",
                  style: TextStyle(
                    color: appColors.whiteColor,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/images/splashScreen/welcome_image.svg",
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
