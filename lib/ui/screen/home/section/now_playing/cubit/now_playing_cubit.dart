import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/domain/entities/now_playing.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingInitial());

  final repository = MovieRepository();

  Future<void> getNowPlaying() async {
    emit(NowPlayingLoading());
    try {
      final result = await repository.getNowPlaying();
      emit(NowPlayingLoaded(data: result));
    } catch (e) {
      emit(NowPlayingFailed(message: e.toString()));
    }
  }
}
