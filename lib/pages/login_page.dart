import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/pages/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;


  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(
              height: 4,
            ),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: signIn,
              icon: Icon(Icons.lock_open),
              label: Text(
                'Sign in',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              child: Text('Forgot password?', style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .background
              ),),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
            ),
            SizedBox(height: 20,),
            RichText(text: TextSpan(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
                text: "No Account? ",
                children: [

                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Sign up',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme
                            .of(context)
                            .primaryColor,
                      )
                  ),
                ]
            )),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      // print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
