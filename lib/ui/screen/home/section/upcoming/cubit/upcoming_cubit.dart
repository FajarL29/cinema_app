import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/domain/entities/upcoming.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(UpcomingInitial());

  final repository = MovieRepository();

  Future<void> getUpcoming() async {
    emit(UpcomingLoading());
    try {
      final result = await repository.getUpcoming();
      emit(UpcomingLoaded(data: result));
    } catch (e) {
      emit(UpcomingFailed(message: e.toString()));
    }
  } 
}
