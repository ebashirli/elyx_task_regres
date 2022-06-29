import 'package:elyx_task_regres/auth_page.dart';
import 'package:elyx_task_regres/cache_manager.dart';
import 'package:elyx_task_regres/users_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.se
  await CacheManager.init();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue.shade300,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final token = CacheManager.getToken();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Task"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: logout,
            ),
          ],
        ),
        body: FutureBuilder(
          future: token,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const AuthPage();
            } else {
              return const UsersPage();
            }
          },
        ),
      );

  void logout() => setState(() => CacheManager.removeToken());
}
