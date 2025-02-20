part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Movies>movie;

  SearchLoaded({required this.movie});
  
}

final class SearchFailed extends SearchState {
  final String message;

  SearchFailed({required this.message});

}
