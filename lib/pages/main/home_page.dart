import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        backgroundColor: colors.white,
        centerTitle: false,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: colors.gray02,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.icons.search.path,
                colorFilter: ColorFilter.mode(colors.gray05, BlendMode.srcIn),
              ),
              const SizedBox(width: 10),
              Text(
                '검색',
                style: TextStyle(
                  color: colors.gray05,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(child: Text('Main Page')),
    );
  }
}
