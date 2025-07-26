import 'package:flutter/material.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      body: Center(
        child: Text('Chat Page'),
      ),
    );
  }
}

