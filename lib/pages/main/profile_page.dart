import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/gen/fonts.gen.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(colors, user),
            Container(
              height: 1,
              width: double.infinity,
              color: colors.gray04,
            ),
            Expanded(child: _buildPostGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeColors colors, User? user) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileImage(colors, user),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: _buildProfileInfo(colors, user),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(ThemeColors colors, User? user) {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colors.gray11, width: 3),
        image: user?.photoURL != null
            ? DecorationImage(
                image: NetworkImage(user!.photoURL!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: user?.photoURL == null
          ? Icon(Icons.person, size: 50, color: colors.gray11)
          : null,
    );
  }

  Widget _buildProfileInfo(ThemeColors colors, User? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildUserName(colors, user),
        const SizedBox(height: 16),
        _buildStatsRow(colors),
      ],
    );
  }

  Widget _buildUserName(ThemeColors colors, User? user) {
    return Text(
      user?.displayName ?? '사용자',
      style: TextStyle(
        color: colors.gray11,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildStatsRow(ThemeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatColumn('0', '게시물', colors),
        _buildStatColumn('532', '팔로잉', colors),
        _buildStatColumn('443', '팔로워', colors),
      ],
    );
  }

  Widget _buildStatColumn(String number, String label, ThemeColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number,
          style: TextStyle(
            color: colors.gray11,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: colors.gray11,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPostGrid() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 130 / 227,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          // color: const Color(0xFFD9D9D9),
          // TODO: 실제 게시물 이미지나 콘텐츠로 교체
        );
      },
    );
  }
}
