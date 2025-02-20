

import 'package:cinema_app/domain/entities/favorite.dart';
import 'package:meta/meta.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}
final class FavoriteActLoaded extends FavoriteState {
  final bool isFavorite;
FavoriteActLoaded(this.isFavorite);

}

final class FavoriteLoaded extends FavoriteState {
  final List<FavoriteEntity> favorites;

  FavoriteLoaded({required this.favorites});
}