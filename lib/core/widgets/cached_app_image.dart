import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Cached remote image with placeholder and error fallback for banking avatars/banners.
class CachedAppImage extends StatelessWidget {
  const CachedAppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.memCacheWidth,
    this.memCacheHeight,
    this.placeholder,
    this.errorWidget,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Widget? placeholder;
  final Widget? errorWidget;

  /// Prefetches an image into the disk/memory cache before it is displayed.
  static Future<void> prefetch(BuildContext context, String url) =>
      precacheImage(CachedNetworkImageProvider(url), context);

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      placeholder: (context, url) =>
          placeholder ??
          const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Icon(
            Icons.broken_image_outlined,
            size: (width != null && height != null)
                ? (width! < height! ? width! : height!) * 0.4
                : 32,
            color: Theme.of(context).hintColor,
          ),
    );

    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
