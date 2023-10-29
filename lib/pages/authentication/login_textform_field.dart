import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginTextFormField extends ConsumerWidget {
  const LoginTextFormField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.suffixIcon,
    this.obscureText,
    this.errorText,
  });
  final String hintText;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? errorText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 72,
      child: TextFormField(
        validator: (v) {
          if (v!.isEmpty) {
            return "Please enter $hintText";
          } else {
            return null;
          }
        },
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
          ),
          errorText: errorText,
          fillColor: Colors.grey.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
