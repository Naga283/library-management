import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginTextFormField extends ConsumerWidget {
  const LoginTextFormField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.suffixIcon,
    this.obscureText,
  });
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final bool? obscureText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 20,
          ),
          suffixIcon: suffixIcon,
          hintText: hintText,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          fillColor: Colors.grey.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
