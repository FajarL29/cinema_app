import 'dart:convert';

import 'package:cinema_app/domain/entities/movie_detail.dart';
//import 'package:flutter/foundation.dart';
//import 'package:movie/domain/entities/movie_detail.dart';

class FavoriteEntity {
  DetailMovieEntity data;

  FavoriteEntity({required this.data});

  Map<String, dynamic> toMap() {
    return {'data': data.toJson()};
  }

  factory FavoriteEntity.fromMap(Map<String, dynamic> map) {
    return FavoriteEntity(
      data: DetailMovieEntity.fromJson(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteEntity.fromJson(String source) =>
      FavoriteEntity.fromMap(json.decode(source));
}