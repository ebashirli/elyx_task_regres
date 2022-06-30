import 'package:elyx_task_regres/api_manager.dart';
import 'package:elyx_task_regres/main.dart';
import 'package:elyx_task_regres/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class UserUpdatePage extends StatefulWidget {
  final User user;

  const UserUpdatePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.text = widget.user.email;
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              TextFormField(
                controller: firstNameController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'First name'),
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (email) =>
                //     email != null && !EmailValidator.validate(email)
                //         ? "Enter a valid email"
                //         : null,
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: lastNameController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Last name'),
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (email) =>
                //     email != null && !EmailValidator.validate(email)
                //         ? "Enter a valid email"
                //         : null,
              ),
              const SizedBox(height: 4),
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
                label: const Text(
                  "Save",
                  style: TextStyle(fontSize: 24),
                ),
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
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final responseBody = await _api.updateUser(id: widget.user.id!, data: {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
    });

    if (responseBody.containsKey("updatedAt")) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Updated at ${responseBody['updatedAt']}")));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
        (route) => false,
      );
    } else {
      final error = responseBody["error"];
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(('$error'))));
    }
  }
}
