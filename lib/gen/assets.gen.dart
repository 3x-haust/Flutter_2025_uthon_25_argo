// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsConfigGen {
  const $AssetsConfigGen();

  /// File path: assets/config/.env
  String get aEnv => 'assets/config/.env';

  /// List of all assets
  List<String> get values => [aEnv];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ad.svg
  SvgGenImage get ad => const SvgGenImage('assets/icons/ad.svg');

  /// File path: assets/icons/arrow_down.svg
  SvgGenImage get arrowDown => const SvgGenImage('assets/icons/arrow_down.svg');

  /// File path: assets/icons/arrow_left.svg
  SvgGenImage get arrowLeft => const SvgGenImage('assets/icons/arrow_left.svg');

  /// File path: assets/icons/arrow_right.svg
  SvgGenImage get arrowRight =>
      const SvgGenImage('assets/icons/arrow_right.svg');

  /// File path: assets/icons/camera.svg
  SvgGenImage get camera => const SvgGenImage('assets/icons/camera.svg');

  /// File path: assets/icons/chat.svg
  SvgGenImage get chat => const SvgGenImage('assets/icons/chat.svg');

  /// File path: assets/icons/chatting.svg
  SvgGenImage get chatting => const SvgGenImage('assets/icons/chatting.svg');

  /// File path: assets/icons/cola.svg
  SvgGenImage get cola => const SvgGenImage('assets/icons/cola.svg');

  /// File path: assets/icons/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/eye.svg');

  /// File path: assets/icons/filled_heart.svg
  SvgGenImage get filledHeart =>
      const SvgGenImage('assets/icons/filled_heart.svg');

  /// File path: assets/icons/google_logo.svg
  SvgGenImage get googleLogo =>
      const SvgGenImage('assets/icons/google_logo.svg');

  /// File path: assets/icons/hashtag.svg
  SvgGenImage get hashtag => const SvgGenImage('assets/icons/hashtag.svg');

  /// File path: assets/icons/heart.svg
  SvgGenImage get heart => const SvgGenImage('assets/icons/heart.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/plus.svg
  SvgGenImage get plus => const SvgGenImage('assets/icons/plus.svg');

  /// File path: assets/icons/plus_template.svg
  SvgGenImage get plusTemplate =>
      const SvgGenImage('assets/icons/plus_template.svg');

  /// File path: assets/icons/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/icons/profile.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/send.svg
  SvgGenImage get send => const SvgGenImage('assets/icons/send.svg');

  /// File path: assets/icons/survey.svg
  SvgGenImage get survey => const SvgGenImage('assets/icons/survey.svg');

  /// File path: assets/icons/video.svg
  SvgGenImage get video => const SvgGenImage('assets/icons/video.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    ad,
    arrowDown,
    arrowLeft,
    arrowRight,
    camera,
    chat,
    chatting,
    cola,
    eye,
    filledHeart,
    googleLogo,
    hashtag,
    heart,
    home,
    plus,
    plusTemplate,
    profile,
    search,
    send,
    survey,
    video,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/jeon.png
  AssetGenImage get jeon => const AssetGenImage('assets/images/jeon.png');

  /// File path: assets/images/nam.jpg
  AssetGenImage get nam => const AssetGenImage('assets/images/nam.jpg');

  /// File path: assets/images/reel.png
  AssetGenImage get reel => const AssetGenImage('assets/images/reel.png');

  /// File path: assets/images/song.png
  AssetGenImage get song => const AssetGenImage('assets/images/song.png');

  /// File path: assets/images/soo.png
  AssetGenImage get soo => const AssetGenImage('assets/images/soo.png');

  /// File path: assets/images/sung.png
  AssetGenImage get sung => const AssetGenImage('assets/images/sung.png');

  /// File path: assets/images/view.svg
  SvgGenImage get view => const SvgGenImage('assets/images/view.svg');

  /// List of all assets
  List<dynamic> get values => [jeon, nam, reel, song, soo, sung, view];
}

class $AssetsVideosGen {
  const $AssetsVideosGen();

  /// File path: assets/videos/bam.mp4
  String get bam => 'assets/videos/bam.mp4';

  /// File path: assets/videos/ian.mp4
  String get ian => 'assets/videos/ian.mp4';

  /// File path: assets/videos/im.mp4
  String get im => 'assets/videos/im.mp4';

  /// File path: assets/videos/ira.mp4
  String get ira => 'assets/videos/ira.mp4';

  /// File path: assets/videos/rock.mp4
  String get rock => 'assets/videos/rock.mp4';

  /// File path: assets/videos/s.mp4
  String get s => 'assets/videos/s.mp4';

  /// File path: assets/videos/s2.mp4
  String get s2 => 'assets/videos/s2.mp4';

  /// File path: assets/videos/s3.mp4
  String get s3 => 'assets/videos/s3.mp4';

  /// File path: assets/videos/saza.mp4
  String get saza => 'assets/videos/saza.mp4';

  /// File path: assets/videos/wrtn.mp4
  String get wrtn => 'assets/videos/wrtn.mp4';

  /// List of all assets
  List<String> get values => [bam, ian, im, ira, rock, s, s2, s3, saza, wrtn];
}

class Assets {
  const Assets._();

  static const $AssetsConfigGen config = $AssetsConfigGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVideosGen videos = $AssetsVideosGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
