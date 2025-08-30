import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/ui/styles/styles.dart';

class SvgAssetOnPress extends StatelessWidget {
  final String? iconString;
  final Color? color;
  final double? size;
  final void Function()? onTapIcon;

  const SvgAssetOnPress({
    super.key,
    this.iconString,
    this.color,
    this.size,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapIcon,
      child: SvgPicture.asset(
        iconString!,
        height: size ?? AppSizes.h_16,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
