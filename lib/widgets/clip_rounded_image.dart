import 'dart:convert';

import 'package:flutter/material.dart';

class ClipRoundedImage extends StatelessWidget {
  final String imageUrl; // Can be a URL or Base64 string
  final double height;
  final double width;
  final String assetFallback; // Path to asset fallback image

  const ClipRoundedImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.assetFallback = 'assets/images/default_fallback.png', // Default fallback asset
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (_isBase64(imageUrl)) {
      // Handle Base64 image
      try {
        final bytes = base64Decode(imageUrl);
        return Image.memory(
          bytes,
          height: height,
          width: width,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _fallbackImage();
          },
        );
      } catch (e) {
        // If Base64 decoding fails, fallback to asset
        return _fallbackImage();
      }
    } else {
      // Handle network image
      return Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _fallbackImage();
        },
      );
    }
  }

  Widget _fallbackImage() {
    return Image.asset(
      assetFallback,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }

  bool _isBase64(String input) {
    // Check if the string is Base64 encoded
    final base64Pattern = RegExp(r'^[A-Za-z0-9+/]+={0,2}$');
    return base64Pattern.hasMatch(input.replaceAll('\n', '').replaceAll(' ', ''));
  }
}