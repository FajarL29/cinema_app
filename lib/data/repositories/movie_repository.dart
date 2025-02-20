import 'package:cinema_app/domain/entities/movies.dart';
import 'package:dio/dio.dart';
import 'package:cinema_app/domain/entities/genre.dart';
import 'package:cinema_app/domain/entities/movie_detail.dart';
import 'package:cinema_app/domain/entities/now_playing.dart';
import 'package:cinema_app/domain/entities/upcoming.dart';

class MovieRepository {
  final dio = Dio();

  final genreUrl = 'https://api.themoviedb.org/3/genre/movie/list?language=id';
  final nowPlayingUrl =
      'https://api.themoviedb.org/3/movie/now_playing?language=id-ID&page=1&region=ID';
  searchMovieUrl(String query) =>
      'https://api.themoviedb.org/3/search/movie?query=$query&include_adult=true&language=id-ID&page=1';
  final upcomingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?language=id-ID&page=1&region=ID';
  final accessToken =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NGI3YTQyOWRlZDQzOTBmMjYwZDAyYjIxNGJhNzg1ZiIsIm5iZiI6MTU3MjYxODg3NS43ODMsInN1YiI6IjVkYmM0MjdiNTRmNmViMDAxODRlYzhkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YYhrlqbEUiZWdsOhRRv5faIyfCgOb7jCQvSZBy18cyc';
  detailMovieUrl(int id) =>
      'https://api.themoviedb.org/3/movie/$id?language=id-ID';

  Future<List<GenreEntity>> getGenres() async {
    final result = await dio.get(
      genreUrl,
      options: Options(
        headers: {
          'Authorization': accessToken,

        },
      ),
    );

    return (result.data['genres'] as List)
        .map((e) => GenreEntity.fromMap(e))
        .toList();
  }

  Future<List<NowPlayingEntity>> getNowPlaying() async {
    final result = await dio.get(
      nowPlayingUrl,
      options: Options(
        headers: {
          'Authorization': accessToken,

        },
      ),
    );

    return (result.data['results'] as List)
        .map((e) => NowPlayingEntity.fromMap(e))
        .toList();
  }

  Future<List<UpcomingEntity>> getUpcoming() async {
    final result = await dio.get(
      upcomingUrl,
      options: Options(
        headers: {
          'Authorization': accessToken,

        },
      ),
    );

    return (result.data['results'] as List)
        .map((e) => UpcomingEntity.fromMap(e))
        .toList();
  }

    Future<DetailMovieEntity> getDetailMovie(int id) async {
      final result = await dio.get(
        detailMovieUrl(id),
        options: Options(
          headers: {
            'Authorization' : accessToken,
            'Content-Type' : 'application/json'
          },
        ),
      );

      return DetailMovieEntity.fromJson(result.data);
    }

  Future<List<Movies>> searchMovie(String query) async{
    final result = await dio.get(
      searchMovieUrl(query),
      options: Options(
        headers: {'Authorization': accessToken},
      ),
    );
    return (result.data['results'] as List)
        .map((e) => Movies.fromMap(e))
        .toList();    
  }
}