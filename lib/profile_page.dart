import 'package:dio/dio.dart';
import 'package:elyx_task_regres/profile_widget.dart';
import 'package:elyx_task_regres/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final int index;
  const ProfilePage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final int index = widget.index;

    final User user = getUser(index: index);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            urlAvatar: user.urlAvatar,
            onClicked: () async {},
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
      
        User getUser({required int index}) {
          final url = "https://reqres.in/api/users/$index";
    final Response response = await Dio().get(url);
    if (response.statusCode == 200) {
      return 
          User.fromMap(response.data["data"]);
        }
}
