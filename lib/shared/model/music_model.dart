import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class MusicModel {
  final String? img;
  final String title;
  final String url;
  final int duration;
  MusicModel({
    this.img,
    required this.title,
    required this.url,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'title': title,
      'url': url,
      'duration': duration,
    };
  }

  factory MusicModel.fromMap(Map<String, dynamic> map) {
    return MusicModel(
      img: map['img'],
      title: map['title'] ?? '',
      url: map['path'] ?? '',
      duration: map['duration'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicModel.fromJson(String source) =>
      MusicModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
