import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/pages/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey=GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Container(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Check Mail for password reset'),
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

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  onPressed: resetPassword,
                  icon: Icon(Icons.lock_open),
                  label: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            )
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
   try{
     await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
   }
   on FirebaseAuthException catch(e){
     Utils.showSnackBar(e.message);
     Navigator.of(context).pop();
   }
  }
}
