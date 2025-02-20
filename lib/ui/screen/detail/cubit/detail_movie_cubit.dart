import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/domain/entities/movie_detail.dart';

part 'detail_movie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  DetailMovieCubit() : super(DetailMovieInitial());

  final repository = MovieRepository();

  void getDetailMovie(int id) async{
    emit(DetailMovieLoading());
    try {
      final result = await repository.getDetailMovie(id);
      emit(DetailMovieLoaded(data: result));
    } catch (e) {
      emit(DetailMovieFailed(message: e.toString()));
    }
  }
}
