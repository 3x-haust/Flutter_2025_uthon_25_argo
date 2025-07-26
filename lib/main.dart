import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uthon_2025_argo/firebase_options.dart';
import 'package:uthon_2025_argo/pages/camera/camera_page.dart';
import 'package:uthon_2025_argo/pages/login/login_page.dart';
import 'package:uthon_2025_argo/pages/main.dart';
import 'package:uthon_2025_argo/pages/main/chat_page.dart';
import 'package:uthon_2025_argo/pages/main/plus_page.dart';
import 'package:uthon_2025_argo/pages/main/profile_page.dart';
import 'package:uthon_2025_argo/pages/main/video_page.dart';
import 'package:uthon_2025_argo/pages/reel/upload_reel_page.dart';
import 'package:uthon_2025_argo/util/style/theme.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  try {
    cameras = await availableCameras();
  } catch (e) {
    print('Error initializing cameras: $e');
  }
  
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
        GetPage(name: '/video', page: () => const VideoPage()),
        GetPage(name: '/chat', page: () => const ChatPage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
        GetPage(name: '/plus', page: () => const PlusPage()),
        GetPage(name: '/camera', page: () => const CameraPage()),
        GetPage(name: '/upload', page: () => const UploadReelPage()),
      ],
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/',
      debugShowCheckedModeBanner: false,
      theme: initThemeData(brightness: Brightness.light),
      darkTheme: initThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}
