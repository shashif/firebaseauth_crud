import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/auth/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../auth/my_button.dart';
import '../auth/my_textfield.dart';
import '../auth/square_tile.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(child: Column(
                children: [
                  const SizedBox(height: 25),
                  // logo
                  const Icon(
                    Icons.lock,
                    size: 90,
                  ),
                  const SizedBox(height: 50),

                  //welcome back, you've been missed
                  Text(
                    'Check Mail for password reset',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // email textfield
                  // MyTextField(
                  //   controller: emailController,
                  //   hintText: 'Email',
                  //   obscureText: false,
                  // ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter valied Email'
                          : null,
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),

                    ),
                  ),
                  const SizedBox(height: 10),





                  //sign in button
                  MyButton(
                    text: 'Submit',
                    onTap: resetPassword,
                  ),
                  const SizedBox(height: 50),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),

                ],
              )))),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
