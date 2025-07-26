import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Stack(
      children: [
        Positioned(
          child: SafeArea(
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: colors.gray04, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNavItem(
                    iconPath: Assets.icons.home.path,
                    index: 0,
                    colors: colors,
                  ),
                  _buildNavItem(
                    iconPath: Assets.icons.profile.path,
                    index: 1,
                    colors: colors,
                  ),
                  _buildNavItem(
                    iconPath: Assets.icons.plus.path,
                    index: 2,
                    colors: colors,
                  ),
                  _buildNavItem(
                    iconPath: Assets.icons.video.path,
                    index: 3,
                    colors: colors,
                  ),
                  _buildNavItem(
                    iconPath: Assets.icons.chat.path,
                    index: 4,
                    colors: colors,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required int index,
    required ThemeColors colors,
  }) {
    final isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isSelected ? colors.primaryPurple01 : colors.gray04,
                BlendMode.srcIn,
              ),
              height: iconPath == Assets.icons.plus.path ? 44 : 44,
              width: iconPath == Assets.icons.plus.path ? 44 : 44,
            ),
          ],
        ),
      ),
    );
  }
}
