import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final int? maxLines;
  final double? fontSize;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  /// The text to be displayed.
  final String? text;

  const CustomTextWidget({
    Key? key,
    this.fontSize,
    this.maxLines,
    this.textAlign,
    this.textStyle,
    required this.text,
    this.textOverflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      maxLines: maxLines,
      textAlign: textAlign,
      style: textStyle?.copyWith(fontSize: fontSize),
      overflow: maxLines == null ? TextOverflow.visible : textOverflow,
    );
  }
}
