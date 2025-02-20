import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cinema_app/domain/entities/favorite.dart';
import 'package:cinema_app/ui/screen/Favorit/cubit/favorit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  Future<void> loadFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataFavorite = prefs.getStringList('favorite') ?? [];

    List<FavoriteEntity> favorites = dataFavorite
        .map((fav) => FavoriteEntity.fromJson(json.decode(fav)))
        .toList();

    emit(FavoriteLoaded(favorites: favorites));
  }

  Future<void> checkFavorite(int movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataFavorite = prefs.getStringList('favorite') ?? [];

    List<FavoriteEntity> favorites = dataFavorite
        .map((fav) => FavoriteEntity.fromJson(json.decode(fav)))
        .toList();
    bool isFavorite =
        favorites.any((FavoriteEntity element) => element.data.id == movieId);
        print(isFavorite);
    emit(FavoriteActLoaded(isFavorite));
  }

  Future<void> actFavorite(FavoriteEntity favorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataFavorite = prefs.getStringList('favorite') ?? [];
    // List<FavoriteEntity> favorites = dataFavorite
    //     .map((fav) => FavoriteEntity.fromJson(json.decode(fav)))
    //     .toList();
List<FavoriteEntity> favorites = dataFavorite.map((fav) {
  try {
    // Validasi apakah fav berupa string
    return FavoriteEntity.fromJson(json.decode(fav));
    } catch (e) {
    print('Error decoding favorite: $e');
    return null;
  }
}).whereType<FavoriteEntity>().toList();
    bool isFavorite =
        favorites.any((element) => element.data.id == favorite.data.id);

    if (isFavorite) {
      favorites.removeWhere((element) => element.data.id == favorite.data.id);
    } else {
      favorites.add(favorite);
    }
    List<String> updateFavorites =
        favorites.map((fav) => json.encode(fav.toJson())).toList();
    await prefs.setStringList('favorite', updateFavorites);
    await checkFavorite(favorite.data.id!);
  }
}