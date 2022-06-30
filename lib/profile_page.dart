import 'package:elyx_task_regres/profile_widget.dart';
import 'package:elyx_task_regres/user.dart';
import 'package:elyx_task_regres/user_update_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final User user = widget.user;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            urlAvatar: user.urlAvatar,
            onClicked: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserUpdatePage(user: user),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          buildName(user: user),
        ],
      ),
    );
  }

  buildName({required User user}) => Column(
        children: <Widget>[
          Text(
            user.fullName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );
}
