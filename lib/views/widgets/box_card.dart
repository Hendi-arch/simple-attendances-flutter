import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final Widget? child;
  final double? boxWidth;
  final double? boxHeight;
  final BoxDecoration? decoration;
  final BoxConstraints? boxConstraints;

  const BoxCard({
    Key? key,
    this.child,
    this.boxWidth,
    this.boxHeight,
    this.decoration,
    this.boxConstraints,
  }) : super(key: key);

  BoxCard.image({
    Key? key,
    this.boxWidth,
    this.boxHeight,
    double radius = 6,
    this.boxConstraints,
    BoxFit fit = BoxFit.cover,
    List<BoxShadow>? boxShadow,
    required ImageProvider image,
    FilterQuality filterQuality = FilterQuality.low,
  })  : child = null,
        decoration = BoxDecoration(
          image: DecorationImage(
            fit: fit,
            image: image,
            filterQuality: filterQuality,
          ),
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(radius),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: decoration,
      constraints: boxConstraints,
      width: boxWidth != null ? boxWidth! : null,
      height: boxHeight != null ? boxHeight! : null,
    );
  }
}
