//import 'package:cinema_app/domain/entities/movies.dart';
import 'package:cinema_app/ui/screen/Favorit/cubit/favorit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_app/ui/screen/detail/cubit/detail_movie_cubit.dart';
import 'package:cinema_app/ui/screen/detail/detail_screen.dart';

class DetailMoviePage extends StatelessWidget {
  final int id;
  
  const DetailMoviePage({super.key, required this.id,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DetailMovieCubit()..getDetailMovie(id),
        ),
        BlocProvider(
          create: (_) => FavoriteCubit(),
        ),
      ],
      child:  DetailMovieScreen(),
    );
  }
}