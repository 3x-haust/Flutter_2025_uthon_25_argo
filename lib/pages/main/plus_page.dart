import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uthon_2025_argo/gen/assets.gen.dart';
import 'package:uthon_2025_argo/util/style/colors.dart';
import 'package:uthon_2025_argo/pages/camera/camera_page.dart';

class PlusPage extends StatefulWidget {
  const PlusPage({super.key});

  @override
  State<PlusPage> createState() => _PlusPageState();
}

class _PlusPageState extends State<PlusPage> {
  List<AssetEntity> assets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      if (albums.isNotEmpty) {
        List<AssetEntity> media = await albums[0].getAssetListPaged(
          page: 0,
          size: 100,
        );
        setState(() {
          assets = media;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Widget> _buildImageWidget(AssetEntity asset) async {
    final bytes = await asset.thumbnailDataWithSize(
      const ThumbnailSize(200, 200),
    );
    if (bytes != null) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: MemoryImage(bytes), fit: BoxFit.cover),
        ),
      );
    }
    return Container(color: const Color(0xFFD9D9D9));
  }

  Future<void> _openCamera() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.white,
      appBar: _buildAppBar(colors),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  _buildActionButtons(colors),
                  const SizedBox(height: 20),
                  _buildSectionHeader(colors),
                  const SizedBox(height: 10),
                  _buildPhotoGrid(),
                ],
              ),
            ),
          ),
          _buildBottomSection(colors),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeColors colors) {
    return AppBar(
      backgroundColor: colors.white,
      centerTitle: true,
      scrolledUnderElevation: 0,
      title: Text(
        'NEW RILL',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: colors.gray11,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          Assets.icons.arrowLeft.path,
          colorFilter: ColorFilter.mode(colors.gray11, BlendMode.srcIn),
        ),
        onPressed: () => Get.offAllNamed('/'),
      ),
    );
  }

  Widget _buildActionButtons(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCameraButton(colors),
          const SizedBox(width: 10),
          _buildTemplateButton(colors),
        ],
      ),
    );
  }

  Widget _buildCameraButton(ThemeColors colors) {
    return GestureDetector(
      onTap: _openCamera,
      child: Container(
        width: 47,
        height: 47,
        decoration: BoxDecoration(
          color: colors.gray02,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: colors.gray04),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.icons.camera.path,
            colorFilter: ColorFilter.mode(colors.gray11, BlendMode.srcIn),
            width: 19,
            height: 17,
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateButton(ThemeColors colors) {
    return Container(
      width: 90,
      height: 47,
      decoration: BoxDecoration(
        color: colors.gray02,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: colors.gray04),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.icons.plusTemplate.path,
              width: 25,
              height: 24,
            ),
            const SizedBox(width: 4),
            Text(
              '템플릿',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: colors.gray11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '최근 항목',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colors.gray11,
            ),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(
            Assets.icons.arrowDown.path,
            colorFilter: ColorFilter.mode(colors.gray11, BlendMode.srcIn),
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 130 / 227,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: assets.length,
              itemBuilder: (context, index) {
                return FutureBuilder<Widget>(
                  future: _buildImageWidget(assets[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    }
                    return Container(color: const Color(0xFFD9D9D9));
                  },
                );
              },
            ),
    );
  }

  Widget _buildBottomSection(ThemeColors colors) {
    return Column(
      children: [
        Container(
          height: 75,
          color: colors.gray03,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 68,
                  height: 47,
                  decoration: BoxDecoration(
                    color: colors.gray11,
                    borderRadius: BorderRadius.circular(23.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '다음',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colors.gray01,
                        ),
                      ),
                      SizedBox(width: 11),
                      SvgPicture.asset(
                        Assets.icons.arrowRight.path,
                        width: 13,
                        height: 13,
                        colorFilter: ColorFilter.mode(
                          colors.gray01,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
