import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int selectedTabIndex = 0;
  final tabs = ['Messages', 'Channels', 'Requests'];

  final chatItems = [
    ChatItem(
      name: '지수민',
      message: '이거 추실??? 추면 여친 생긴대',
      profileColor: Colors.grey[300]!,
      hasUnread: true,
      photoUrl: Assets.images.soo.path,
    ),
    ChatItem(
      name: '윤건우',
      message: '아니 이사람 피드 봐봐 너무 웃김 ㅠㅠ',
      profileColor: Colors.grey[300]!,
      hasUnread: true,
      photoUrl: Assets.images.soo.path, //
    ),
    ChatItem(
      name: '유성윤',
      message: '쉐이칸샹쉐이칸샹',
      profileColor: Colors.grey[300]!,
      hasUnread: false,
      photoUrl: Assets.images.sung.path,
    ),
    ChatItem(
      name: '전유림',
      message: '아 이거 레알 웃ㄱ겨',
      profileColor: Colors.grey[300]!,
      hasUnread: false,
      photoUrl: Assets.images.jeon.path,
    ),
    ChatItem(
      name: '이남진',
      message: '이거 너 아님?',
      profileColor: Colors.grey[300]!,
      hasUnread: false,
      photoUrl: Assets.images.nam.path,
    ),
    ChatItem(
      name: '앙기모띠',
      message: '릴을 보냈습니다.',
      profileColor: Colors.grey[300]!,
      hasUnread: false,
      photoUrl: Assets.images.song.path,
    ),
    ChatItem(
      name: '릴러말즈사랑해나의남자야',
      message: 'ㅗㅜㅑ',
      profileColor: Colors.grey[300]!,
      hasUnread: false,
      photoUrl: Assets.images.reel.path,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.white,
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: _buildSearchBar(colors),
      ),
      backgroundColor: colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTabBar(colors),
            Expanded(child: _buildChatList(colors)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ThemeColors colors) {
    return Container(
      padding: const EdgeInsets.all(10),
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
    );
  }

  Widget _buildTabBar(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: tabs
            .asMap()
            .entries
            .map((entry) => _buildTabItem(entry.key, colors))
            .toList(),
      ),
    );
  }

  Widget _buildTabItem(int index, ThemeColors colors) {
    final isSelected = selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = index),
        child: Container(
          margin: EdgeInsets.only(right: index < tabs.length - 1 ? 10 : 0),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
          decoration: BoxDecoration(
            color: isSelected ? colors.gray11.withOpacity(0.3) : colors.gray02,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected && index == 0) ...[
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colors.gray11,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
              ],
              Flexible(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? colors.gray11 : colors.gray05,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatList(ThemeColors colors) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      itemCount: chatItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 18),
      itemBuilder: (context, index) => _buildChatItem(chatItems[index], colors),
    );
  }

  Widget _buildChatItem(ChatItem item, ThemeColors colors) {
    return Row(
      children: [
        _buildProfileImage(item),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: TextStyle(
                color: colors.gray11,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 180,
              child: Text(
                item.message,
                style: TextStyle(
                  color: item.hasUnread ? colors.gray11 : colors.gray06,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
              width: 10,
              child: item.hasUnread
                  ? Container(
                      decoration: BoxDecoration(
                        color: colors.gray11,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 21),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                Assets.icons.camera.path,
                colorFilter: ColorFilter.mode(
                  item.hasUnread ? colors.gray11 : colors.gray06,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage(ChatItem item) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: item.profileColor,
      child: item.photoUrl != null
          ? ClipOval(child: _buildProfileImageByType(item))
          : null,
    );
  }

  Widget _buildProfileImageByType(ChatItem item) {
    final isNetwork = item.photoUrl!.startsWith('http');

    final imageWidget = isNetwork
        ? Image.network(
            item.photoUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(width: 60, height: 60, color: item.profileColor);
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: 60,
                height: 60,
                color: item.profileColor,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              );
            },
          )
        : Image.asset(item.photoUrl!, width: 60, height: 60, fit: BoxFit.cover);

    return imageWidget;
  }
}

class ChatItem {
  final String name;
  final String message;
  final Color profileColor;
  final bool hasUnread;
  final String? photoUrl;

  ChatItem({
    required this.name,
    required this.message,
    required this.profileColor,
    required this.hasUnread,
    this.photoUrl,
  });
}
