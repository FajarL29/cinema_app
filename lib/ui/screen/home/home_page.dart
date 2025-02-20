import 'package:cinema_app/ui/screen/user/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/ui/screen/home/home_screen.dart';
import 'package:cinema_app/ui/screen/home/section/categories/cubit/categories_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_app/ui/screen/home/section/now_playing/cubit/now_playing_cubit.dart';
import 'package:cinema_app/ui/screen/home/section/upcoming/cubit/upcoming_cubit.dart';

class HomePage extends StatelessWidget {
  final Function (int index) onChangePage;
  const HomePage({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoriesCubit()..getGenres(),
        ),
        BlocProvider(
          create: (_) => NowPlayingCubit()..getNowPlaying(),
        ),
        BlocProvider(
          create: (_) => UpcomingCubit()..getUpcoming(),
        ),
        BlocProvider(
          create: (_) => UserCubit()..getUser(),
        ),
      ],
      child: HomeScreen(
        onChangePage: onChangePage,
    ),
    );
  }
}