import 'package:flutter/material.dart';

class ImageCacheManager {
  static Future<void> cacheImages(
      BuildContext context, List<String> imageUrls) async {
    for (String imageUrl in imageUrls) {
      await precacheImage(AssetImage(imageUrl), context);
    }
  }
}
