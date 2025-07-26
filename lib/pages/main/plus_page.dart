import 'package:flutter/material.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';

class PlusPage extends StatelessWidget {
  const PlusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      body: Center(
        child: Text('Plus Page'),
      ),
    );
  }
}

