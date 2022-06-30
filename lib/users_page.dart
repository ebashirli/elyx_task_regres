import 'package:dio/dio.dart';
import 'package:elyx_task_regres/profile_page.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final controller = ScrollController();
  List<User?> users = [];
  bool hasMore = true;
  int pageCount = 1;

  @override
  void initState() {
    super.initState();
    fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    final url = "https://reqres.in/api/users?page=$pageCount";
    final Response response = await Dio().get(url);
    int limit = response.data["per_page"];

    if (response.statusCode == 200) {
      final List<User> newUsers =
          response.data["data"].map<User>(User.fromMap).toList();
      setState(() {
        pageCount++;
        if (newUsers.length < limit) {
          hasMore = false;
        }
        users.addAll(newUsers);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildUserCard(users.first),
        const Divider(),
        Expanded(
          child: buildUsersList(),
        ),
      ],
    );
  }

  buildUserCard(User? user) => user == null
      ? const CircularProgressIndicator()
      : SizedBox(
          height: 150,
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.urlAvatar),
              ),
              title: Text(user.fullName),
              subtitle: Text(user.email),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: user),
                  ),
                );
              },
            ),
          ),
        );

  Widget buildUsersList() => ListView.builder(
        controller: controller,
        padding: const EdgeInsets.all(8),
        itemCount: users.length + 1,
        itemBuilder: (context, index) {
          if (index < users.length) {
            final User? user = users[index];
            return buildUserCard(user);
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 34),
              child: Center(
                child: hasMore
                    ? const CircularProgressIndicator()
                    : const Text("No more user to load"),
              ),
            );
          }
        },
      );
}
