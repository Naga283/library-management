import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_books_management/components/expanded_elevated_btn.dart';
import 'package:library_books_management/pages/authentication/icon_with_heading_subheading.dart';
import 'package:library_books_management/pages/authentication/login_textform_field.dart';
import 'package:library_books_management/pages/authentication/password_text_form_field.dart';
import 'package:library_books_management/pages/authentication/register_page.dart';
import 'package:library_books_management/providers/textformfield_error_text_state_provider.dart';
import 'package:library_books_management/services/firebase_authentication.dart';
import 'package:library_books_management/utils/colors.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.whiteColor.withOpacity(0.4),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconWithHeadingAndSubHeading(
              heading: 'Login',
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  LoginTextFormField(
                    hintText: 'Your e-mail',
                    textEditingController: emailController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PasswordTextFormField(
                    isPasswordVisible: isPasswordVisible,
                    passwordController: passwordController,
                    errorText: ref.watch(errorTextFormProvider),
                    onTap: () {
                      setState(() {
                        if (isPasswordVisible) {
                          isPasswordVisible = false;
                        } else {
                          isPasswordVisible = true;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (builder) {
                          return RegisterPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an Account?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
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
          btnName: "Login",
          onTap: () async {
            if (_formKey.currentState?.validate() ?? false) {
              await loginWithEmailAndPassword(
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
