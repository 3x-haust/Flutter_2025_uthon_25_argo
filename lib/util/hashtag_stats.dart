import 'package:uthon_2025_argo/pages/main/video_page.dart';

class HashtagStats {
  final String hashtag;
  final int totalLikes;
  final int totalViews;
  final int videoCount;

  HashtagStats({
    required this.hashtag,
    required this.totalLikes,
    required this.totalViews,
    required this.videoCount,
  });

  String get formattedLikes => _formatNumber(totalLikes);
  String get formattedViews => _formatNumber(totalViews);

  static String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}m';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }

  static int _parseNumberString(String numberStr) {
    final cleanStr = numberStr.toLowerCase().replaceAll(',', '');
    
    if (cleanStr.endsWith('k')) {
      final num = double.parse(cleanStr.substring(0, cleanStr.length - 1));
      return (num * 1000).round();
    } else if (cleanStr.endsWith('m')) {
      final num = double.parse(cleanStr.substring(0, cleanStr.length - 1));
      return (num * 1000000).round();
    } else {
      return int.parse(cleanStr);
    }
  }

  static Map<String, HashtagStats> calculateHashtagStats(List<VideoData> videos) {
    final Map<String, List<int>> hashtagLikes = {};
    final Map<String, List<int>> hashtagViews = {};

    for (final video in videos) {
      final hashtags = video.hashtags
          .split(' ')
          .where((tag) => tag.startsWith('#') && tag.length > 1)
          .map((tag) => tag.trim())
          .toList();

      final likes = _parseNumberString(video.likes);
      // 조회수는 좋아요 수의 1.2-2배로 추정
      final views = (likes * (1.2 + (likes % 100) / 100 * 0.8)).round();

      for (final hashtag in hashtags) {
        hashtagLikes.putIfAbsent(hashtag, () => []).add(likes);
        hashtagViews.putIfAbsent(hashtag, () => []).add(views);
      }
    }

    final Map<String, HashtagStats> stats = {};
    
    for (final hashtag in hashtagLikes.keys) {
      final likes = hashtagLikes[hashtag]!;
      final views = hashtagViews[hashtag]!;
      
      stats[hashtag] = HashtagStats(
        hashtag: hashtag,
        totalLikes: likes.reduce((a, b) => a + b),
        totalViews: views.reduce((a, b) => a + b),
        videoCount: likes.length,
      );
    }

    return stats;
  }
}
