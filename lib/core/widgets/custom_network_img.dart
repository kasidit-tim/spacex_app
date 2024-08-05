import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImg extends StatelessWidget {
  const CustomNetworkImg({
    super.key,
    required this.url,
    required this.fit,
  });

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (context, url, progress) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
