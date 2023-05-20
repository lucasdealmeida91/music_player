// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:music_app/shared/model/genre_model.dart';
import 'package:music_app/shared/model/music_model.dart';

class GenreDetailModel extends GenreModel {
  List<MusicModel> listMusic;

  GenreDetailModel({
    required this.listMusic,
    required super.title,
    super.img,
    required super.searchString,
  });
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listMusic': listMusic.map((x) => x.toMap()).toList(),
    };
  }

  factory GenreDetailModel.fromMap(Map<String, dynamic> map) {
    return GenreDetailModel(
      listMusic: List<MusicModel>.from(
          map['musics'].map<MusicModel>((x) => MusicModel.fromMap(x)).toList()),
      searchString: map['searchString'] ?? '',
      title: map['title'] ?? '',
      img: map['img'] ?? '',
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory GenreDetailModel.fromJson(String source) =>
      GenreDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
