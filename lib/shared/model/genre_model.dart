import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class GenreModel {
  final String? img;
  final String title;
final String searchString;
  GenreModel({
    this.img,
    required this.title,
    required this.searchString,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img': img,
      'title': title,
      'searchString': searchString,
    };
  }

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      img: map['img'],
      title: map['title'] ?? '',
      searchString: map['searchString'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GenreModel.fromJson(String source) => GenreModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
