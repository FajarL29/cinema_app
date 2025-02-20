import 'dart:convert';

class UpcomingEntity {
  final bool adult;
  final String? backdropPath; // Bisa null
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath; // Bisa null
  final DateTime? releaseDate; // Bisa null
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  UpcomingEntity({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  UpcomingEntity copyWith({
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
      UpcomingEntity(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory UpcomingEntity.fromJson(String str) =>
      UpcomingEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpcomingEntity.fromMap(Map<String, dynamic> json) {
    return UpcomingEntity(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] as String?,
      genreIds: (json["genre_ids"] as List<dynamic>? ?? []).map((x) => x as int).toList(),
      id: json["id"] ?? 0,
      originalLanguage: json["original_language"] ?? 'unknown',
      originalTitle: json["original_title"] ?? '',
      overview: json["overview"] ?? '',
      popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
      posterPath: json["poster_path"] as String?,
      releaseDate: json["release_date"] != null && json["release_date"] != ""
          ? DateTime.tryParse(json["release_date"])
          : null,
      title: json["title"] ?? 'Untitled',
      video: json["video"] ?? false,
      voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate?.toIso8601String(),
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}