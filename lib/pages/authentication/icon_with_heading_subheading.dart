import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWithHeadingAndSubHeading extends ConsumerWidget {
  const IconWithHeadingAndSubHeading({
    super.key,
    required this.heading,
    this.subHeading,
  });
  final String heading;
  final String? subHeading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/images/login/book-4986.svg",
              width: 50,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            bottom: 10.0,
          ),
          child: Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 26,
            ),
          ),
        ),
        SizedBox(
            width: 350,
            child: Text(
              subHeading ??
                  "Just step away from exploring our collection of books",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            )),
      ],
    );
  }
}
