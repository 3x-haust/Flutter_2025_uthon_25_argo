import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/pages/main/video_page.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';
import 'package:uthon_2025_argo/util/hashtag_stats.dart';

class TrendData {
  final String hashtag;
  final String viewCount;
  final String likeCount;
  final String ranking;
  final List<Color> gradientColors;
  final Color borderColor;
  final double titleSize;
  final double statSize;

  const TrendData({
    required this.hashtag,
    required this.viewCount,
    required this.likeCount,
    required this.ranking,
    required this.gradientColors,
    required this.borderColor,
    this.titleSize = 16,
    this.statSize = 14,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<TrendData> trendData;

  @override
  void initState() {
    super.initState();
    _initializeTrendData();
  }

  void _initializeTrendData() {
    final originalVideos = [
      VideoData(
        userName: '유성윤',
        hashtags: '#쉐이칸샹 #부승샹',
        likes: '823.3K',
        comments: '729.6K',
        shares: '322.1K',
        videoPath: 'assets/videos/s.mp4',
      ),
      VideoData(
        userName: '진우',
        hashtags: '#케이팝데몬헌터스 #사자보이즈',
        likes: '1.2K',
        comments: '243',
        shares: '89',
        videoPath: 'assets/videos/saza.mp4',
      ),
      VideoData(
        userName: '지수민',
        hashtags: '#쉐이칸샹 #부승샹',
        likes: '3K',
        comments: '195',
        shares: '4.2K',
        videoPath: 'assets/videos/s2.mp4',
      ),
      VideoData(
        userName: '지수민',
        hashtags: '#쉐이칸샹 #부승샹',
        likes: '1.2K',
        comments: '800',
        shares: '302',
        videoPath: 'assets/videos/s3.mp4',
      ),
      VideoData(
        userName: '전유림',
        hashtags: '#락유바디 #여자놀이',
        likes: '52K',
        comments: '23.2K',
        shares: '21K',
        videoPath: 'assets/videos/rock.mp4',
      ),
      VideoData(
        userName: '이남진',
        hashtags: '#아라아라 #여고생',
        likes: '100',
        comments: '23',
        shares: '309',
        videoPath: 'assets/videos/ira.mp4',
      ),
      VideoData(
        userName: '윤건우',
        hashtags: '#대나무행주 #금강산수세미',
        likes: '23K',
        comments: '8.2K',
        shares: '19K',
        videoPath: 'assets/videos/bam.mp4',
      ),
      VideoData(
        userName: '지수민',
        hashtags: '#유톤 #나ㅇㅇ인데 #운영진',
        likes: '203.5K',
        comments: '135.3K',
        shares: '239.9K',
        videoPath: 'assets/videos/im.mp4',
      ),
      VideoData(
        userName: '지디',
        hashtags: '#뤼튼 #지디',
        likes: '1.5K',
        comments: '25K',
        shares: '18.9K',
        videoPath: 'assets/videos/wrtn.mp4',
      ),
      VideoData(
        userName: '이현우',
        hashtags: '#이안챌린지',
        likes: '582',
        comments: '923',
        shares: '10',
        videoPath: 'assets/videos/ian.mp4',
      ),
    ];

    final hashtagStats = HashtagStats.calculateHashtagStats(originalVideos);

    trendData = [
      TrendData(
        hashtag: '#쉐이칸샹',
        viewCount: hashtagStats['#쉐이칸샹']?.formattedViews ?? '1.3m',
        likeCount: hashtagStats['#쉐이칸샹']?.formattedLikes ?? '987.7k',
        ranking: '1st',
        gradientColors: [Color(0xFFFFADAD), Color(0xFFF15959)],
        borderColor: Color(0xFFB81C1C),
        titleSize: 32,
        statSize: 16,
      ),
      TrendData(
        hashtag: '#케이팝데몬헌터스',
        viewCount: hashtagStats['#케이팝데몬헌터스']?.formattedViews ?? '1.3m',
        likeCount: hashtagStats['#케이팝데몬헌터스']?.formattedLikes ?? '987.7k',
        ranking: '2nd',
        gradientColors: [Color(0xFFFED7AF), Color(0xFFFFB973)],
        borderColor: Color(0xFFFF9A35),
        titleSize: 24,
        statSize: 16,
      ),
      TrendData(
        hashtag: '#락유바디',
        viewCount: hashtagStats['#락유바디']?.formattedViews ?? '1.3m',
        likeCount: hashtagStats['#락유바디']?.formattedLikes ?? '987.7k',
        ranking: '3rd',
        gradientColors: [Color(0xFFB6FEAF), Color(0xFF73FF66)],
        borderColor: Color(0xFF33C724),
        titleSize: 20,
        statSize: 16,
      ),
      TrendData(
        hashtag: '#대나무행주',
        viewCount: hashtagStats['#대나무행주']?.formattedViews ?? '1.3m',
        likeCount: hashtagStats['#대나무행주']?.formattedLikes ?? '987.7k',
        ranking: '4th',
        gradientColors: [Color(0xFFD1AFFE), Color(0xFFAC6EFE)],
        borderColor: Colors.black,
        titleSize: 16,
        statSize: 16,
      ),
      TrendData(
        hashtag: '#이안챌린지',
        viewCount: hashtagStats['#이안챌린지']?.formattedViews ?? '1.3m',
        likeCount: hashtagStats['#이안챌린지']?.formattedLikes ?? '987.7k',
        ranking: '5th',
        gradientColors: [Color(0xFFD1AFFE), Color(0xFFAC6EFE)],
        borderColor: Colors.black,
        titleSize: 16,
        statSize: 16,
      ),
      TrendData(
        hashtag: '#뤼튼',
        viewCount: hashtagStats['#뤼튼']?.formattedViews ?? '1.3m',
        likeCount: hashtagStats['#뤼튼']?.formattedLikes ?? '987.7k',
        ranking: '',
        gradientColors: [Color(0xFF8FA3FA), Color(0xFF637FFB)],
        borderColor: Color(0xFF3354E8),
        titleSize: 16,
        statSize: 12,
      ),
      TrendData(
        hashtag: '#아라아라',
        viewCount: hashtagStats['#아라아라']?.formattedViews ?? '1.3m',
        likeCount: hashtagStats['#아라아라']?.formattedLikes ?? '987.7k',
        ranking: '',
        gradientColors: [Color(0xFF8FA3FA), Color(0xFF637FFB)],
        borderColor: Color(0xFF3354E8),
        titleSize: 16,
        statSize: 12,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = 20.0;
    final cardSpacing = 10.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildTitleSection(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  children: [
                    _buildTrendLayout(
                      context,
                      colors,
                      screenWidth,
                      padding,
                      cardSpacing,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF666666), size: 20),
            const SizedBox(width: 10),
            Text(
              '검색',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '요즘 뜨고 있는 트렌드',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTrendLayout(
    BuildContext context,
    ThemeColors colors,
    double screenWidth,
    double padding,
    double spacing,
  ) {
    final availableWidth = screenWidth - (padding * 2);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPage(
                  filterHashtag: trendData[0].hashtag,
                  showBackButton: true,
                ),
              ),
            );
          },
          child: _buildTrendCard(
            data: trendData[0],
            width: availableWidth,
            height: 150,
            colors: colors,
            statsLayout: StatsLayout.horizontal,
          ),
        ),
        SizedBox(height: spacing),

        Row(
          children: [
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPage(
                        filterHashtag: trendData[1].hashtag,
                        showBackButton: true,
                      ),
                    ),
                  );
                },
                child: _buildTrendCard(
                  data: trendData[1],
                  width: double.infinity,
                  height: 161,
                  colors: colors,
                  statsLayout: StatsLayout.horizontal,
                ),
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPage(
                        filterHashtag: trendData[2].hashtag,
                        showBackButton: true,
                      ),
                    ),
                  );
                },
                child: _buildTrendCard(
                  data: trendData[2],
                  width: double.infinity,
                  height: 161,
                  colors: colors,
                  statsLayout: StatsLayout.vertical,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),

        Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPage(
                              filterHashtag: trendData[3].hashtag,
                              showBackButton: true,
                            ),
                          ),
                        );
                      },
                      child: _buildTrendCard(
                        data: trendData[3],
                        width: double.infinity,
                        height: 182,
                        colors: colors,
                        statsLayout: StatsLayout.vertical,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPage(
                              filterHashtag: trendData[4].hashtag,
                              showBackButton: true,
                            ),
                          ),
                        );
                      },
                      child: _buildTrendCard(
                        data: trendData[4],
                        width: double.infinity,
                        height: 181,
                        colors: colors,
                        statsLayout: StatsLayout.vertical,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spacing),

            Expanded(
              flex: 1,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPage(
                            filterHashtag: trendData[5].hashtag,
                            showBackButton: true,
                          ),
                        ),
                      );
                    },
                    child: _buildTrendCard(
                      data: trendData[5],
                      width: double.infinity,
                      height: 92,
                      colors: colors,
                      statsLayout: StatsLayout.vhorizontal,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPage(
                            filterHashtag: trendData[6].hashtag,
                            showBackButton: true,
                          ),
                        ),
                      );
                    },
                    child: _buildTrendCard(
                      data: trendData[6],
                      width: double.infinity,
                      height: 92,
                      colors: colors,
                      statsLayout: StatsLayout.vhorizontal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendCard({
    required TrendData data,
    required double width,
    required double height,
    required ThemeColors colors,
    required StatsLayout statsLayout,
    double borderRadius = 20,
  }) {
    return Container(
      width: width == double.infinity ? null : width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: data.borderColor, width: 1),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: data.gradientColors,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                data.hashtag,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: data.titleSize,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildStatsSection(
                  colors: colors,
                  data: data,
                  layout: statsLayout,
                ),
              ),
            ),
            if (data.ranking.isNotEmpty)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  data.ranking,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection({
    required ThemeColors colors,
    required TrendData data,
    required StatsLayout layout,
  }) {
    switch (layout) {
      case StatsLayout.horizontal:
        return Row(
          children: [
            Flexible(
              child: _buildStatItem(
                Assets.icons.eye.path,
                data.viewCount,
                fontSize: data.statSize,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: _buildStatItem(
                Assets.icons.filledHeart.path,
                data.likeCount,
                fontSize: data.statSize,
              ),
            ),
          ],
        );
      case StatsLayout.vertical:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatItem(
              Assets.icons.eye.path,
              data.viewCount,
              fontSize: data.statSize,
            ),
            _buildStatItem(
              Assets.icons.filledHeart.path,
              data.likeCount,
              fontSize: data.statSize,
            ),
          ],
        );
      case StatsLayout.horizontalSmall:
        return Row(
          children: [
            Flexible(
              child: _buildStatItem(
                Assets.icons.eye.path,
                data.viewCount,
                fontSize: data.statSize,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: _buildStatItem(
                Assets.icons.filledHeart.path,
                data.likeCount,
                fontSize: data.statSize,
              ),
            ),
          ],
        );
      case StatsLayout.vhorizontal:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatItem(
              Assets.icons.eye.path,
              data.viewCount,
              fontSize: data.statSize,
            ),
            _buildStatItem(
              Assets.icons.filledHeart.path,
              data.likeCount,
              fontSize: data.statSize,
              isSmall: true,
            ),
          ],
        );
    }
  }

  Widget _buildStatItem(
    String iconPath,
    String value, {
    double fontSize = 14,
    bool isSmall = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconPath,
          width: isSmall ? 13 : 18,
          height: isSmall ? 14 : 18,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        isSmall ? const SizedBox(width: 2) : const SizedBox(width: 5),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

enum StatsLayout { horizontal, vertical, horizontalSmall, vhorizontal }
