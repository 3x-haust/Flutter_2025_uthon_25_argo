import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';
import 'package:uthon_2025_argo/widgets/circle_tag.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          
          return SingleChildScrollView(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight < 800 ? 800 : screenHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleTag(
                    size: 239,
                    position: Offset(screenWidth * 0.35, 160),
                    text: '#쉐이칸샹',
                    textSize: 22,
                  ),

                  CircleTag(
                    size: 183,
                    position: Offset(screenWidth * 0.05, 365),
                    text: '#케이팝데몬\n헌터즈',
                    textSize: 22,
                  ),

                  CircleTag(
                    size: 159,
                    position: Offset(screenWidth * 0.57, 404),
                    text: '#벽돌초콜릿',
                    textSize: 22,
                  ),

                  CircleTag(
                    size: 140,
                    position: Offset(screenWidth * 0.32, 535),
                    text: '#ThankU',
                    textSize: 22,
                  ),

                  CircleTag(
                    size: 115, 
                    position: Offset(screenWidth * 0.72, 570),
                  ),

                  CircleTag(
                    size: 90, 
                    position: Offset(screenWidth * 0.1, 618),
                  ),

                  CircleTag(
                    size: 90, 
                    position: Offset(screenWidth * 0.55, 665),
                  ),

                  CircleTag(
                    size: 90, 
                    position: Offset(screenWidth * 0.29, 683),
                  ),

                  CircleTag(
                    size: 61, 
                    position: Offset(screenWidth * 0.13, 552),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
