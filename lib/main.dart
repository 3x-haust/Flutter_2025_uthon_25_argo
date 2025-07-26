import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:uthon_2025_argo/firebase_options.dart';
import 'package:uthon_2025_argo/pages/login/login_page.dart';
import 'package:uthon_2025_argo/pages/main.dart';
import 'package:uthon_2025_argo/util/style/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const MainPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
      ],
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/',
      debugShowCheckedModeBanner: false,
      theme: initThemeData(brightness: Brightness.light),
      darkTheme: initThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}
