import 'package:elyx_task_regres/api_manager.dart';
import 'package:elyx_task_regres/cache_manager.dart';
import 'package:elyx_task_regres/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginSignUpPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  final bool isLogin;

  const LoginSignUpPage({
    Key? key,
    required this.onClickedSignUp,
    this.isLogin = true,
  }) : super(key: key);

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLogin = widget.isLogin;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter a valid email"
                        : null,
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: passwordController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? "Enter a min. 6 characters"
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: signInUp,
                icon: const Icon(
                  Icons.lock_open,
                  size: 34,
                ),
                label: Text(
                  isLogin ? "Sign in" : "Sign Up",
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    text: isLogin
                        ? "No account?  "
                        : "Already have an account?  ",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: isLogin ? "Sign up" : "Sign in",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _api = ApiManager();

  Future signInUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final response_body = await _api.registerLogin(
      email: email,
      password: password,
      isLogin: widget.isLogin,
    );

    if (response_body.containsKey("token")) {
      CacheManager.setToken(response_body["token"]!);
      CacheManager.setEmail(email);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
        (route) => false,
      );
    } else {
      final error = response_body["error"];
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(('$error'))));
    }
  }
}
