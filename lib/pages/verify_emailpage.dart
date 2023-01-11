import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/pages/home_page.dart';
import 'package:firebaseauth/pages/utils.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool cancelResendEmail = false;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationmail();
    }
    timer = Timer.periodic(
      Duration(seconds: 3),
      (_) => checkEmailverified(),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('A verification email has been sent to your mail'),
                SizedBox(height: 8,),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50)
                  ),
                    onPressed:cancelResendEmail ? sendVerificationmail: null,
                    icon: Icon(Icons.email,size: 32,),
                    label: Text('Resend Email')),
                SizedBox(height: 8,),
                TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text('Cancel'))
              ],
            ),
          ),
        );

  Future sendVerificationmail() async {
    try {

      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(()=> cancelResendEmail=false);
      await Future.delayed(Duration(seconds: 5));
      setState(()=> cancelResendEmail=true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}
