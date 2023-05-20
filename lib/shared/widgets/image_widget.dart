// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? img;
  final double widht;
  final double height;
  const ImageWidget({
    Key? key,
    this.img,
    required this.widht,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return img != null
        ? FadeInImage(
            placeholder:
                const AssetImage('assets/images/music_placeholder.png'),
            image: AssetImage(img!),
            fit: BoxFit.cover,
            width: widht,
            height: height,
          )
        : Image.asset(
            'assets/images/music_placeholder.png',
            width: widht,
            height: height,
            fit: BoxFit.cover,
          );
  }
}
