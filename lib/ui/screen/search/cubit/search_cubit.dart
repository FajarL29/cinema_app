//import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:cinema_app/data/repositories/movie_repository.dart';
import 'package:cinema_app/domain/entities/movies.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final repository = MovieRepository();

    Future<void> searchMovie(String query) async{
    emit(SearchLoading());
    try{
      final result = await repository.searchMovie(query);
      (e.toString());
      emit(SearchLoaded (movie: result));
    }catch(e){
      (e.toString());

      emit(SearchFailed(message: e.toString()));
    }
  }
}


