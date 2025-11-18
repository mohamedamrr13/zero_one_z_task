import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageAsset extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  const CustomImageAsset({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    String extension = imagePath.split('.').last.toLowerCase();

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: extension == 'svg'
            ? SvgPicture.asset(
                imagePath,
                color: color,
                width: width,
                height: height,
                fit: fit,
              )
            : Image.asset(
                imagePath,
                color: color,
                width: width,
                height: height,
                fit: fit,
              ),
      ),
    );
  }
}
