import 'dart:convert';

class NowPlayingEntity {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  NowPlayingEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  NowPlayingEntity copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      NowPlayingEntity(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory NowPlayingEntity.fromJson(String str) => NowPlayingEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NowPlayingEntity.fromMap(Map<String, dynamic> json) => NowPlayingEntity(
        adult: json["adult"] ?? false, // Handle null for boolean values
        backdropPath: json["backdrop_path"] ?? '', // Default to empty string if null
        genreIds: List<int>.from(json["genre_ids"]?.map((x) => x) ?? []), // Handle null for genreIds
        id: json["id"] ?? 0, // Default to 0 if null
        originalLanguage: json["original_language"] ?? '', // Default to empty string if null
        originalTitle: json["original_title"] ?? '', // Default to empty string if null
        overview: json["overview"] ?? '', // Default to empty string if null
        popularity: (json["popularity"]?.toDouble()) ?? 0.0, // Default to 0.0 if null
        posterPath: json["poster_path"] ?? '', // Default to empty string if null
        title: json["title"] ?? '', // Default to empty string if null
        video: json["video"] ?? false, // Handle null for boolean values
        voteAverage: (json["vote_average"]?.toDouble()) ?? 0.0, // Default to 0.0 if null
        voteCount: json["vote_count"] ?? 0, // Default to 0 if null
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}