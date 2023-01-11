import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/pages/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey=GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter valied Email'
                        : null,
              ),
              SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                value != null && value.length<6
                    ? 'Enter minimum 6 characters'
                    : null,
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: signUp,
                icon: Icon(Icons.lock_open),
                label: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      text: "Already have an Account? ",
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Log in',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor,
                        )),
                  ])),
            ],
          ),
        ),
      ),
    );

  }

  Future signUp() async {
    final isValid=formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      // print(e);
      Utils.showSnackBar(e.message);




    }

  }
}
