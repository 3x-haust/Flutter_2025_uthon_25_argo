import 'package:flutter/material.dart';
import 'package:uthon_2025_argo/pages/main/chat_page.dart';
import 'package:uthon_2025_argo/pages/main/home_page.dart';
import 'package:uthon_2025_argo/pages/main/plus_page.dart';
import 'package:uthon_2025_argo/pages/main/profile_page.dart';
import 'package:uthon_2025_argo/pages/main/video_page.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';
import 'package:uthon_2025_argo/widgets/my_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomePage(),
      const ProfilePage(),
      const PlusPage(),
      const VideoPage(),
      const ChatPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeColors colors = ThemeColors.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          'ARGO',
          style: TextStyle(
            color: colors.gray11,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: colors.white,
      body: pages[_currentIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
