import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UISvg extends StatelessWidget {
  const UISvg({
    super.key,
    required this.svg,
    this.width,
    this.color,
    this.height,
    this.onTap,
    this.fit = BoxFit.contain,
  });

  final String svg;
  final double? width;
  final double? height;
  final Color? color;
  final void Function()? onTap;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        svg,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(
                color!,
                BlendMode.srcIn,
              )
            : null,
      ),
    );
  }
}