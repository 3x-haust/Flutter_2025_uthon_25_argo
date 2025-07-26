import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class UploadReelPage extends StatefulWidget {
  final String? videoPath;

  const UploadReelPage({super.key, this.videoPath});

  @override
  State<UploadReelPage> createState() => _UploadReelPageState();
}

class _UploadReelPageState extends State<UploadReelPage> {
  bool isPrivateAccount = false;
  bool showAdSettings = false;
  double adDays = 32;
  final double maxDays = 365;
  final double dailyRate = 50000;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _hasVideoError = false;
  String? videoPath;

  @override
  void initState() {
    super.initState();
    
    videoPath = widget.videoPath ?? Get.arguments as String?;
    
    if (videoPath != null && videoPath!.isNotEmpty) {
      _initializeVideo();
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    if (videoPath == null || videoPath!.isEmpty) {
      print('비디오 경로가 null이거나 비어있습니다');
      return;
    }

    try {
      print('비디오 초기화 시작: $videoPath');
      
      final file = File(videoPath!);
      if (!await file.exists()) {
        print('비디오 파일이 존재하지 않습니다: $videoPath');
        setState(() {
          _hasVideoError = true;
        });
        return;
      }

      _videoController = VideoPlayerController.file(file);
      
      await _videoController!.initialize();
      
      if (!mounted) return;
      
      print('비디오 초기화 완료. 크기: ${_videoController!.value.size}');
      print('비디오 재생 시간: ${_videoController!.value.duration}');
      
      await _videoController!.seekTo(Duration.zero);
      await _videoController!.pause();
      
      setState(() {
        _isVideoInitialized = true;
        _hasVideoError = false;
      });
      
      print('비디오 썸네일 설정 완료');
      
    } catch (e) {
      print('비디오 초기화 오류: $e');
      if (mounted) {
        setState(() {
          _hasVideoError = true;
          _isVideoInitialized = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.icons.arrowLeft.path,
            color: colors.gray11,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'NEW RILL',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: colors.gray11,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildVideoPreview(colors),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            '캡션 추가...',
                            style: TextStyle(
                              color: const Color(0xFFC7C7CC),
                              fontSize: 14,
                              fontFamily: 'Arial Rounded MT Bold',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _buildFeatureButtons(colors),
                    const SizedBox(height: 30),
                    _buildSettingsSection(colors),
                    const SizedBox(height: 60),
                    _buildBottomButtons(colors),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPreview(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: 110,
        height: 192,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(33),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(33),
          child: _buildVideoContent(),
        ),
      ),
    );
  }

  Widget _buildVideoContent() {
    if (videoPath == null || videoPath!.isEmpty) {
      return Container(
        color: const Color(0xFFD9D9D9),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.video_library,
                color: Colors.grey,
                size: 40,
              ),
              SizedBox(height: 8),
              Text(
                '비디오 없음',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_hasVideoError) {
      return Container(
        color: const Color(0xFFD9D9D9),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 40,
              ),
              SizedBox(height: 8),
              Text(
                '비디오 로드 실패',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (!_isVideoInitialized) {
      return Container(
        color: const Color(0xFFD9D9D9),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.grey,
                strokeWidth: 2,
              ),
              SizedBox(height: 8),
              Text(
                '로딩 중...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_videoController != null && _videoController!.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
      );
    }

    return Container(
      color: const Color(0xFFD9D9D9),
      child: const Center(
        child: Icon(
          Icons.video_library,
          color: Colors.grey,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildFeatureButtons(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildFeatureButton('해시태그', _buildHashtagIcon()),
          const SizedBox(width: 10),
          _buildFeatureButton('설문', _buildPollIcon()),
          const SizedBox(width: 10),
          _buildFeatureButton('콜라보 게시물', _buildCollabIcon()),
        ],
      ),
    );
  }

  Widget _buildFeatureButton(String text, Widget icon) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2F),
        border: Border.all(color: const Color(0xFF48494A)),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF2F2F7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHashtagIcon() {
    return SvgPicture.asset(
      Assets.icons.hashtag.path,
      width: 13,
      height: 14,
      colorFilter: ColorFilter.mode(const Color(0xFFF2F2F7), BlendMode.srcIn),
    );
  }

  Widget _buildPollIcon() {
    return SvgPicture.asset(
      Assets.icons.survey.path,
      width: 13,
      height: 10,
      colorFilter: ColorFilter.mode(const Color(0xFFF2F2F7), BlendMode.srcIn),
    );
  }

  Widget _buildCollabIcon() {
    return SvgPicture.asset(
      Assets.icons.cola.path,
      width: 13,
      height: 13,
      colorFilter: ColorFilter.mode(const Color(0xFFF2F2F7), BlendMode.srcIn),
    );
  }

  Widget _buildSettingsSection(ThemeColors colors) {
    return Column(
      children: [
        Container(height: 1, color: const Color(0xFF3A3A3C)),
        const SizedBox(height: 25),
        _buildAdSettingsToggle(colors),
        if (showAdSettings) ...[
          const SizedBox(height: 25),
          _buildAdSettings(colors),
        ],
        const SizedBox(height: 30),
        Container(height: 1, color: const Color(0xFF3A3A3C)),
        const SizedBox(height: 25),
        _buildSettingsRow('사람 태그'),
        const SizedBox(height: 25),
        _buildSettingsRow('위치 추가'),
        const SizedBox(height: 25),
        _buildSettingsRow('오디오 이름 변경'),
        const SizedBox(height: 25),
        Container(height: 6, color: const Color(0xFF3A3A3C)),
        const SizedBox(height: 25),
        _buildSettingsRow('공개 대상'),
        const SizedBox(height: 25),
        _buildPrivateAccountToggle(colors),
        const SizedBox(height: 25),
        _buildSettingsRow('테스트'),
      ],
    );
  }

  Widget _buildAdSettingsToggle(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SvgPicture.asset(Assets.icons.ad.path, width: 26, height: 26),
          const SizedBox(width: 18),
          const Text(
            '광고 설정',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFFF2F2F7),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                showAdSettings = !showAdSettings;
              });
            },
            child: Container(
              width: 52,
              height: 32,
              decoration: BoxDecoration(
                color: showAdSettings
                    ? const Color(0xFFF2F2F7)
                    : const Color(0xFF48494A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: showAdSettings ? 24 : 4,
                    top: 4,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1C1C1E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsRow(String title, {bool showAdIcon = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (showAdIcon) ...[
            SvgPicture.asset(Assets.icons.ad.path, width: 26, height: 26),
            const SizedBox(width: 18),
          ],
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFFF2F2F7),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xFFF2F2F7),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildAdSettings(ThemeColors colors) {
    final totalCost = (adDays * dailyRate).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '광고 시작일',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFC7C7CC),
                ),
              ),
              Text(
                '+ ${adDays.toInt()}일',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFF2F2F7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFFF2F2F7),
                  inactiveTrackColor: const Color(0xFF636367),
                  thumbColor: const Color(0xFFF2F2F7),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                  trackHeight: 2,
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  value: adDays,
                  min: 1,
                  max: maxDays,
                  onChanged: (value) {
                    setState(() {
                      adDays = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '₩ ${totalCost.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFC7C7CC),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivateAccountToggle(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isPrivateAccount = !isPrivateAccount;
              });
            },
            child: Container(
              width: 52,
              height: 32,
              decoration: BoxDecoration(
                color: isPrivateAccount
                    ? const Color(0xFF1C1C1E)
                    : const Color(0xFF48494A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: isPrivateAccount ? 24 : 4,
                    top: 4,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPrivateAccount
                            ? const Color(0xFFF2F2F7)
                            : const Color(0xFF1C1C1E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.offAllNamed('/'),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF48494A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '임시저장',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE4E5E9),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => Get.offAllNamed('/'),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '공유하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}