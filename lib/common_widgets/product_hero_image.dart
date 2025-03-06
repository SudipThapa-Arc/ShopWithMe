import 'package:flutter/material.dart';

class ProductHeroImage extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ProductHeroImage({
    super.key,
    required this.imageUrl,
    required this.tag,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: const Icon(
                Icons.error_outline,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
} 