// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:music_app/core/app/music_app_text_style.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  const TextWidget(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
  }) : super(key: key);
  TextWidget.bold(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getNormalBoldStyle;

  TextWidget.title(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getTitleStyle;

  TextWidget.normal(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getNormalStyle;
  TextWidget.small(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getSmallSyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}
