import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/styles/styles.dart';

class H1 extends StatelessWidget {
  final String? text;
  final Color? colors;
  final double? appSizes, height;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final List<Shadow>? shadows;

  const H1({
    super.key,
    this.overflow,
    this.letterSpacing,
    required this.text,
    this.colors,
    this.appSizes,
    this.fontWeight,
    this.align,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overflow,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
      style: TextStyle(
        shadows: shadows,
        fontFamily: 'EuclidCircularA',
        decoration: decoration ?? TextDecoration.none,
        letterSpacing: letterSpacing ?? 0.0,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontSize: appSizes ?? AppSizes.h_20,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: colors ?? AppColors.bgDark,
        height: height ?? 1.5,
      ),
    );
  }
}
