import 'package:elyx_task_regres/auth_page.dart';
import 'package:elyx_task_regres/cache_manager.dart';
import 'package:elyx_task_regres/controller.dart';
import 'package:elyx_task_regres/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => Controller(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue.shade300,
        ),
        home: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    String? token = CacheManager.getToken();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: token == null ? const AuthPage() : const UsersPage(),
    );
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
      (route) => false,
    );
    CacheManager.removeToken();
    CacheManager.removeEmail();
  }
}
