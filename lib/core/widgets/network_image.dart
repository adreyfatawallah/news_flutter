import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;

  const MyNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    required this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,

        // 🌟 RAHASIA SENIOR: Mencegah Out of Memory (OOM)
        // Memaksa gambar besar di-resize di RAM (misal maksimal lebar 400px).
        // Sangat krusial jika gambar ini berada di dalam ListView!
        memCacheWidth: 400,

        // 🌟 UX PREMIUM: Efek Shimmer saat loading
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        ),

        // 🌟 ERROR HANDLING: Tampilan rapi jika link mati
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, color: Colors.grey, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
