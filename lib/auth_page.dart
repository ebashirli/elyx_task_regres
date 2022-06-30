import 'package:elyx_task_regres/sign_in_sign_up_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      LoginSignUpPage(isLogin: isLogin, onClickedSignUp: toggle);
  // : SignUpPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
