import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';

class VideoPage extends StatefulWidget {
  final String? filterHashtag;
  final bool showBackButton;

  const VideoPage({super.key, this.filterHashtag, this.showBackButton = false});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  late List<VideoData> _videos;
  late List<VideoData> _originalVideos;
  Map<int, VideoPlayerController> _videoControllers = {};
  Map<int, bool> _initializationAttempts = {};
  int _currentIndex = 0;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    print('VideoPage 초기화 시작');
    WidgetsBinding.instance.addObserver(this);
    _initializeVideos();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('PostFrameCallback 실행');
      _safeInitializeVideoControllers();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeAllControllers();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        _pauseAllVideos();
        break;
      case AppLifecycleState.resumed:
        _resumeCurrentVideo();
        break;
      case AppLifecycleState.detached:
        _disposeAllControllers();
        break;
      default:
        break;
    }
  }

  void _initializeVideos() {
    print('비디오 데이터 초기화 시작');
    final random = Random();

    _originalVideos = [
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

    if (widget.filterHashtag != null) {
      _videos = _originalVideos
          .where((video) => video.hashtags.contains(widget.filterHashtag!))
          .toList();

      final sVideo = _videos.firstWhere(
        (video) => video.videoPath == Assets.videos.s,
        orElse: () => _videos.first,
      );

      final otherVideos = _videos
          .where((video) => video.videoPath != Assets.videos.s)
          .toList();

      _videos = [sVideo, ...otherVideos];
    } else {
      _videos = List.from(_originalVideos);
      _videos.shuffle(random);
    }

    print('비디오 데이터 생성 및 필터링/랜덤 섞기 완료: ${_videos.length}개');
  }

  Future<void> _initializeVideoControllers() async {
    for (int i = 0; i < _videos.length; i++) {
      await _initializeVideoController(i);
    }
  }

  Future<void> _initializeVideoController(int index) async {
    if (_initializationAttempts[index] == true) return;

    try {
      print('비디오 초기화 시작 (인덱스 $index): ${_videos[index].videoPath}');
      _initializationAttempts[index] = true;

      if (_videoControllers.containsKey(index)) {
        await _videoControllers[index]?.dispose();
        _videoControllers.remove(index);
      }

      await Future.delayed(const Duration(milliseconds: 100));

      final controller = VideoPlayerController.asset(_videos[index].videoPath);
      _videoControllers[index] = controller;

      controller.addListener(() {
        if (controller.value.hasError) {
          print(
            '비디오 재생 중 오류 발생 (인덱스 $index): ${controller.value.errorDescription}',
          );
          _handleVideoError(index);
        }
      });

      await controller.initialize().timeout(
        const Duration(seconds: 20),
        onTimeout: () => throw TimeoutException(
          'Video initialization timeout',
          const Duration(seconds: 20),
        ),
      );

      print('비디오 초기화 완료 (인덱스 $index)');

      if (mounted) {
        setState(() {});

        if (index == _currentIndex) {
          await controller.play();
          await controller.setLooping(true);
          print('비디오 재생 시작 (인덱스 $index)');
        }
      }
    } on PlatformException catch (e) {
      print('플랫폼 예외 (인덱스 $index): ${e.code} - ${e.message}');
      await _handlePlatformError(index, e);
    } catch (error) {
      print('비디오 초기화 오류 (인덱스 $index): $error');
      await _cleanupFailedController(index);
    }
  }

  Future<void> _handlePlatformError(int index, PlatformException e) async {
    await _cleanupFailedController(index);

    if (e.code == 'channel-error' && !_isRetryLimitReached(index)) {
      print('플랫폼 채널 오류로 인한 재시도 (인덱스 $index)');
      await Future.delayed(const Duration(seconds: 2));
      _initializationAttempts[index] = false;
      await _retryVideoInitialization(index, 1);
    }
  }

  Future<void> _handleVideoError(int index) async {
    print('비디오 오류 처리 중 (인덱스 $index)');
    await _cleanupFailedController(index);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _cleanupFailedController(int index) async {
    if (_videoControllers.containsKey(index)) {
      try {
        await _videoControllers[index]?.dispose();
      } catch (e) {
        print('컨트롤러 정리 오류: $e');
      }
      _videoControllers.remove(index);
    }
  }

  bool _isRetryLimitReached(int index) {
    return false;
  }

  Future<void> _retryVideoInitialization(int index, int retryCount) async {
    if (retryCount > 2 || !mounted) return;

    try {
      print('비디오 재시도 중... (인덱스 $index, 시도 $retryCount)');

      final controller = VideoPlayerController.asset(_videos[index].videoPath);
      _videoControllers[index] = controller;

      await controller.initialize().timeout(
        const Duration(seconds: 15),
        onTimeout: () =>
            throw Exception('Video initialization timeout on retry'),
      );

      if (mounted) {
        setState(() {});

        if (index == _currentIndex) {
          await controller.play();
          await controller.setLooping(true);
        }
      }

      print('비디오 재시도 성공 (인덱스 $index)');
    } catch (error) {
      print('비디오 재시도 실패 (인덱스 $index, 시도 $retryCount): $error');

      if (_videoControllers.containsKey(index)) {
        try {
          await _videoControllers[index]?.dispose();
        } catch (e) {
          print('재시도 컨트롤러 정리 오류: $e');
        }
        _videoControllers.remove(index);
      }

      if (retryCount < 2) {
        await Future.delayed(Duration(seconds: retryCount * 2));
        await _retryVideoInitialization(index, retryCount + 1);
      }
    }
  }

  Future<void> _handlePageChange(int index) async {
    if (widget.filterHashtag != null && index == 2 && _videos.length > 1) {
      _shuffleRemainingVideos();
    }

    if (index >= _videos.length - 2) {
      await _addMoreVideos();
    }

    for (int i = 0; i < _videoControllers.length; i++) {
      try {
        if (_videoControllers.containsKey(i) &&
            _videoControllers[i]?.value.isInitialized == true) {
          await _videoControllers[i]!.pause();
        }
      } catch (e) {
        print('비디오 정지 오류 (인덱스 $i): $e');
      }
    }

    if (_videoControllers.containsKey(index)) {
      try {
        if (_videoControllers[index]?.value.isInitialized == true) {
          await _videoControllers[index]!.play();
          await _videoControllers[index]!.setLooping(true);
        }
      } catch (e) {
        print('비디오 재생 오류 (인덱스 $index): $e');
      }
    } else {
      print('비디오 컨트롤러가 없습니다. 재초기화 시도 중... (인덱스 $index)');
      await _initializeVideoController(index);
    }
  }

  void _shuffleRemainingVideos() {
    print('3개 지난 후 나머지 비디오들 셔플 시작...');
    final random = Random();

    if (_videos.length > 1) {
      final firstVideo = _videos[0];
      final remainingVideos = _videos.sublist(1);
      remainingVideos.shuffle(random);

      _videos = [firstVideo, ...remainingVideos];

      if (mounted) {
        setState(() {});
      }

      print('나머지 비디오들 셔플 완료');
    }
  }

  Future<void> _addMoreVideos() async {
    print('새로운 비디오들 추가 중...');
    final random = Random();

    List<VideoData> newVideos;

    if (widget.filterHashtag != null) {
      newVideos = _originalVideos
          .where((video) => video.hashtags.contains(widget.filterHashtag!))
          .toList();
      newVideos.shuffle(random);
    } else {
      newVideos = List<VideoData>.from(_originalVideos);
      newVideos.shuffle(random);
    }

    final startIndex = _videos.length;
    _videos.addAll(newVideos);

    print('새로운 비디오 ${newVideos.length}개 추가됨. 총 ${_videos.length}개');

    for (int i = startIndex; i < _videos.length; i++) {
      _initializeVideoController(i).catchError((error) {
        print('새 비디오 초기화 실패 (인덱스 $i): $error');
      });
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _safeInitializeVideoControllers() async {
    if (_isInitializing) return;

    _isInitializing = true;
    try {
      await _initializeVideoControllers();
    } catch (e) {
      print('비디오 컨트롤러 안전 초기화 오류: $e');
    } finally {
      _isInitializing = false;
    }
  }

  void _pauseAllVideos() {
    for (var controller in _videoControllers.values) {
      try {
        if (controller.value.isInitialized && controller.value.isPlaying) {
          controller.pause();
        }
      } catch (e) {
        print('비디오 일시정지 오류: $e');
      }
    }
  }

  void _resumeCurrentVideo() {
    try {
      final controller = _videoControllers[_currentIndex];
      if (controller != null &&
          controller.value.isInitialized &&
          !controller.value.isPlaying) {
        controller.play();
      }
    } catch (e) {
      print('비디오 재개 오류: $e');
    }
  }

  Future<void> _disposeAllControllers() async {
    final controllers = List.from(_videoControllers.values);
    _videoControllers.clear();

    for (var controller in controllers) {
      try {
        await controller.dispose();
      } catch (e) {
        print('비디오 컨트롤러 해제 오류: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (index) async {
              setState(() {
                _currentIndex = index;
              });

              await _handlePageChange(index);
            },
            itemCount: null,
            itemBuilder: (context, index) {
              if (index >= _videos.length) {
                return _buildLoadingPage();
              }
              return _buildVideoPage(colors, _videos[index], index);
            },
          ),
          SafeArea(bottom: false, child: _buildHeader(colors)),
        ],
      ),
    );
  }

  Widget _buildLoadingPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1C1C1E),
            const Color(0xFF2C2C2E),
            const Color(0xFF1C1C1E),
          ],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 20),
            Text(
              '새로운 비디오 로딩 중...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoFallback(int index) {
    final isLoading = _videoControllers.containsKey(index);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1C1C1E),
            const Color(0xFF2C2C2E),
            const Color(0xFF1C1C1E),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator(color: Colors.white)
            else
              Icon(
                Icons.videocam_off,
                size: 60,
                color: Colors.white.withOpacity(0.7),
              ),
            const SizedBox(height: 10),
            Text(
              isLoading ? '비디오 로딩 중...' : '비디오를 불러올 수 없습니다',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            if (!isLoading) ...[
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _initializationAttempts[index] = false;
                      await _initializeVideoController(index);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text('다시 시도'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await _retryAllVideos();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text('전체 재시도'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _retryAllVideos() async {
    print('모든 비디오 재시도 시작...');

    await _disposeAllControllers();
    _initializationAttempts.clear();

    await _safeInitializeVideoControllers();

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildVideoPage(ThemeColors colors, VideoData videoData, int index) {
    final user = FirebaseAuth.instance.currentUser;
    final isVideoReady =
        _videoControllers.containsKey(index) &&
        _videoControllers[index]?.value.isInitialized == true;

    return Stack(
      children: [
        Positioned.fill(
          child: isVideoReady
              ? AspectRatio(
                  aspectRatio: _videoControllers[index]!.value.aspectRatio,
                  child: VideoPlayer(_videoControllers[index]!),
                )
              : _buildVideoFallback(index),
        ),

        Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildProfileImage(colors, user),
                              const SizedBox(width: 10),
                              _buildUserName(colors, videoData.userName),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildHashtags(colors, videoData.hashtags),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildActionButton(
                          'assets/icons/heart.svg',
                          videoData.likes,
                          colors,
                        ),
                        const SizedBox(height: 21),
                        _buildActionButton(
                          'assets/icons/chatting.svg',
                          videoData.comments,
                          colors,
                        ),
                        const SizedBox(height: 21),
                        _buildActionButton(
                          'assets/icons/send.svg',
                          videoData.shares,
                          colors,
                        ),
                        const SizedBox(height: 50),
                        _buildMoreDotsIndicator(),
                        const SizedBox(height: 21),
                        _buildMusicButton(),
                      ],
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

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF1C1C1E)),
    );
  }

  Widget _buildHeader(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          if (widget.showBackButton) ...[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                Assets.icons.arrowLeft.path,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Row(
            children: [
              Text(
                widget.filterHashtag?.replaceAll('#', '') ?? 'Reel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.filterHashtag != null ? 24 : 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!widget.showBackButton) ...[
                const SizedBox(width: 5),
                SvgPicture.asset(
                  Assets.icons.arrowDown.path,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 17,
                  height: 17,
                ),
              ],
            ],
          ),
          if (!widget.showBackButton) const Spacer(),
        ],
      ),
    );
  }

  Widget _buildActionButton(String iconPath, String count, ThemeColors colors) {
    return Column(
      children: [
        SizedBox(
          width: 26,
          height: 26,
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(colors.gray11, BlendMode.srcIn),
            width: 16,
            height: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          count,
          style: TextStyle(
            color: colors.gray11,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMoreDotsIndicator() {
    return Row(
      children: List.generate(
        3,
        (index) => Row(
          children: [
            Container(
              width: 3,
              height: 3,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            if (index < 2) const SizedBox(width: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicButton() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Center(
        child: Text(
          '음원',
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildUserName(ThemeColors colors, String userName) {
    return Text(
      userName,
      style: TextStyle(
        color: colors.gray11,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildHashtags(ThemeColors colors, String hashtags) {
    return Text(
      hashtags,
      style: TextStyle(
        color: colors.gray09,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildProfileImage(ThemeColors colors, User? user) {
    return Container(
      width: 43,
      height: 43,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.white, width: 2),
        ),
        margin: const EdgeInsets.all(2),
        child: ClipOval(
          child: Container(
            color: colors.gray02,
            child: Icon(Icons.person, size: 30, color: colors.gray11),
          ),
        ),
      ),
    );
  }
}

class VideoData {
  final String userName;
  final String hashtags;
  final String likes;
  final String comments;
  final String shares;
  final String videoPath;

  VideoData({
    required this.userName,
    required this.hashtags,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.videoPath,
  });
}
