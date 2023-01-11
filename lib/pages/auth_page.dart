import 'package:firebaseauth/pages/login_page.dart';
import 'package:firebaseauth/pages/signup_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin=true;
  @override
  Widget build(BuildContext context)=>
    isLogin ? LoginPage(onClickedSignUp: toggle,)
        : SignUpPage(onClickedSignIn: toggle);
    void toggle()=> setState(() {
      isLogin = !isLogin;
    });

}
