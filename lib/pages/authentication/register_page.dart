import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/expanded_elevated_btn.dart';
import 'package:library_books_management/pages/authentication/icon_with_heading_subheading.dart';
import 'package:library_books_management/pages/authentication/login_page.dart';
import 'package:library_books_management/pages/authentication/login_textform_field.dart';
import 'package:library_books_management/pages/authentication/password_text_form_field.dart';
import 'package:library_books_management/services/firebase_authentication.dart';
import 'package:library_books_management/utils/colors.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appColors.whiteColor.withOpacity(0.4),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IconWithHeadingAndSubHeading(heading: "Sign Up"),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  LoginTextFormField(
                    hintText: "Full name",
                    textEditingController: fullNameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LoginTextFormField(
                    hintText: "Your e-mail",
                    textEditingController: emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PasswordTextFormField(
                      isPasswordVisible: isPasswordVisible,
                      passwordController: passwordController,
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (builder) {
                      return LoginPage();
                    },
                  ),
                );
              },
              child: Text(
                "Already Have an account?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16,
          right: 16,
        ),
        child: ExpandedElevatedBtn(
          btnName: "Register",
          onTap: () async {
            if (_formKey.currentState?.validate() ?? false) {
              await registerWithEmailAndPassword(
                fullNameController.text,
                emailController.text,
                passwordController.text,
                context,
                ref,
              );
            }
          },
        ),
      ),
    );
  }
}
